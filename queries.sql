-- Queries for Hospital Database Management System

USE HospitalDB;

-- 1. List all scheduled appointments for a specific doctor (e.g., Doctor ID 1)
SELECT
    v.visit_id,
    p.first_name AS patient_first_name,
    p.last_name AS patient_last_name,
    v.visit_date,
    v.visit_type
FROM Visits v
JOIN Patients p ON v.patient_id = p.patient_id
WHERE v.doctor_id = 1 AND v.status = 'Scheduled';

-- 2. Get total revenue generated from bills
SELECT SUM(total_amount) AS total_revenue FROM Bills;

-- 3. Get outstanding payments (Unpaid or Partially Paid bills)
SELECT
    b.bill_id,
    p.first_name,
    p.last_name,
    b.total_amount,
    b.payment_status
FROM Bills b
JOIN Visits v ON b.visit_id = v.visit_id
JOIN Patients p ON v.patient_id = p.patient_id
WHERE b.payment_status IN ('Pending', 'Partially Paid');

-- 4. Patient Visit History (e.g., Patient ID 1)
SELECT
    v.visit_date,
    d.first_name AS doctor_first_name,
    d.last_name AS doctor_last_name,
    v.diagnosis,
    v.prescription
FROM Visits v
JOIN Doctors d ON v.doctor_id = d.doctor_id
WHERE v.patient_id = 1
ORDER BY v.visit_date DESC;

-- 5. List of Staff in a specific department (e.g., Department ID 5 - Emergency)
SELECT
    first_name,
    last_name,
    role,
    phone
FROM Staff
WHERE department_id = 5;

-- 6. Count of patients by gender
SELECT gender, COUNT(*) as count FROM Patients GROUP BY gender;

-- 7. Find doctors with the most visits
SELECT
    d.first_name,
    d.last_name,
    COUNT(v.visit_id) AS visit_count
FROM Doctors d
JOIN Visits v ON d.doctor_id = v.doctor_id
GROUP BY d.doctor_id
ORDER BY visit_count DESC;

-- 8. Get details of admitted patients and their room numbers
SELECT
    p.first_name,
    p.last_name,
    r.room_number,
    r.room_type,
    a.admission_date
FROM Admissions a
JOIN Visits v ON a.visit_id = v.visit_id
JOIN Patients p ON v.patient_id = p.patient_id
JOIN Rooms r ON a.room_id = r.room_id
WHERE a.discharge_date IS NULL;
