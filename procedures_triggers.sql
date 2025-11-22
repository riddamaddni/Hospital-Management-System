-- Stored Procedures and Triggers

USE HospitalDB;

DELIMITER //

-- 1. Stored Procedure: Calculate Total Bill for a Visit
-- This procedure calculates the bill based on consultation fee and room charges (if admitted).
CREATE PROCEDURE CalculateBill(IN p_visit_id INT)
BEGIN
    DECLARE v_doctor_fee DECIMAL(10, 2);
    DECLARE v_room_charge DECIMAL(10, 2);
    DECLARE v_days_admitted INT;
    DECLARE v_total DECIMAL(10, 2);

    -- Get Doctor's Consultation Fee
    SELECT d.consultation_fee INTO v_doctor_fee
    FROM Visits v
    JOIN Doctors d ON v.doctor_id = d.doctor_id
    WHERE v.visit_id = p_visit_id;

    -- Calculate Room Charges if admitted
    SET v_room_charge = 0;
    IF EXISTS (SELECT 1 FROM Admissions WHERE visit_id = p_visit_id) THEN
        SELECT
            DATEDIFF(IFNULL(discharge_date, NOW()), admission_date) * r.daily_charge
            INTO v_room_charge
        FROM Admissions a
        JOIN Rooms r ON a.room_id = r.room_id
        WHERE a.visit_id = p_visit_id;

        -- If admitted for less than a day, charge for 1 day
        IF v_room_charge = 0 THEN
            SELECT r.daily_charge INTO v_room_charge
            FROM Admissions a
            JOIN Rooms r ON a.room_id = r.room_id
            WHERE a.visit_id = p_visit_id;
        END IF;
    END IF;

    SET v_total = v_doctor_fee + IFNULL(v_room_charge, 0);

    -- Insert or Update Bill
    IF EXISTS (SELECT 1 FROM Bills WHERE visit_id = p_visit_id) THEN
        UPDATE Bills SET total_amount = v_total WHERE visit_id = p_visit_id;
    ELSE
        INSERT INTO Bills (visit_id, bill_date, total_amount, payment_status)
        VALUES (p_visit_id, CURDATE(), v_total, 'Pending');
    END IF;

    SELECT v_total AS Total_Bill_Amount;
END //

-- 2. Trigger: After Discharge Update Room Status
-- When a discharge date is set in Admissions, mark the room as unoccupied.
CREATE TRIGGER AfterDischarge
AFTER UPDATE ON Admissions
FOR EACH ROW
BEGIN
    IF NEW.discharge_date IS NOT NULL AND OLD.discharge_date IS NULL THEN
        UPDATE Rooms SET is_occupied = FALSE WHERE room_id = NEW.room_id;

        -- Also update Visit status to Discharged
        UPDATE Visits SET status = 'Discharged' WHERE visit_id = NEW.visit_id;
    END IF;
END //

-- 3. Trigger: Before Admission Check Room Availability
-- Prevent admission if the room is already occupied.
CREATE TRIGGER BeforeAdmission
BEFORE INSERT ON Admissions
FOR EACH ROW
BEGIN
    DECLARE v_is_occupied BOOLEAN;

    SELECT is_occupied INTO v_is_occupied FROM Rooms WHERE room_id = NEW.room_id;

    IF v_is_occupied THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Error: Room is already occupied.';
    ELSE
        -- Mark room as occupied upon admission
        UPDATE Rooms SET is_occupied = TRUE WHERE room_id = NEW.room_id;
    END IF;
END //

DELIMITER ;
