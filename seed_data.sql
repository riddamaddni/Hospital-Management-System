-- Seed Data for Hospital Database

USE HospitalDB;

-- Insert Departments
INSERT INTO Departments (department_name, head_of_department, location) VALUES
('Cardiology', 'Dr. Sarah Smith', 'Building A, Floor 3'),
('Neurology', 'Dr. James Wilson', 'Building A, Floor 4'),
('Pediatrics', 'Dr. Emily Chen', 'Building B, Floor 1'),
('Orthopedics', 'Dr. Michael Brown', 'Building B, Floor 2'),
('Emergency', 'Dr. David Lee', 'Building A, Ground Floor');

-- Insert Staff
INSERT INTO Staff (first_name, last_name, role, department_id, phone, email, hire_date, salary) VALUES
('Alice', 'Johnson', 'Nurse', 1, '555-0101', 'alice.j@hospital.com', '2020-01-15', 55000.00),
('Bob', 'Williams', 'Receptionist', 5, '555-0102', 'bob.w@hospital.com', '2019-05-20', 40000.00),
('Charlie', 'Davis', 'Technician', 2, '555-0103', 'charlie.d@hospital.com', '2021-03-10', 48000.00),
('Diana', 'Miller', 'Nurse', 3, '555-0104', 'diana.m@hospital.com', '2022-07-01', 56000.00),
('Evan', 'Garcia', 'Nurse', 5, '555-0105', 'evan.g@hospital.com', '2018-11-11', 60000.00);

-- Insert Doctors
INSERT INTO Doctors (first_name, last_name, specialization, department_id, phone, email, schedule, consultation_fee) VALUES
('Sarah', 'Smith', 'Cardiologist', 1, '555-0201', 'sarah.smith@hospital.com', 'Mon-Thu 9am-4pm', 150.00),
('James', 'Wilson', 'Neurologist', 2, '555-0202', 'james.wilson@hospital.com', 'Tue-Fri 10am-6pm', 200.00),
('Emily', 'Chen', 'Pediatrician', 3, '555-0203', 'emily.chen@hospital.com', 'Mon-Fri 8am-3pm', 120.00),
('Michael', 'Brown', 'Orthopedic Surgeon', 4, '555-0204', 'michael.brown@hospital.com', 'Mon-Wed 1pm-8pm', 180.00),
('David', 'Lee', 'ER Physician', 5, '555-0205', 'david.lee@hospital.com', 'Shift Work', 100.00);

-- Insert Patients
INSERT INTO Patients (first_name, last_name, dob, gender, address, phone, emergency_contact_name, emergency_contact_phone, insurance_provider, insurance_policy_no) VALUES
('John', 'Doe', '1985-04-12', 'Male', '123 Maple St', '555-0301', 'Jane Doe', '555-0302', 'BlueCross', 'BC123456'),
('Jane', 'Roe', '1990-08-25', 'Female', '456 Oak Ave', '555-0303', 'John Roe', '555-0304', 'Aetna', 'AE789012'),
('Sam', 'Green', '2015-12-05', 'Male', '789 Pine Ln', '555-0305', 'Mary Green', '555-0306', 'Cigna', 'CI345678'),
('Lisa', 'White', '1978-02-14', 'Female', '321 Elm St', '555-0307', 'Tom White', '555-0308', 'UnitedHealth', 'UH901234'),
('Mark', 'Black', '1965-11-30', 'Male', '654 Cedar Dr', '555-0309', 'Susan Black', '555-0310', 'Medicare', 'MC567890');

-- Insert Visits
INSERT INTO Visits (patient_id, doctor_id, visit_date, visit_type, diagnosis, prescription, status) VALUES
(1, 1, '2023-10-01 09:30:00', 'Consultation', 'Hypertension', 'Lisinopril 10mg', 'Completed'),
(2, 3, '2023-10-02 10:15:00', 'Consultation', 'Common Cold', 'Rest and Fluids', 'Completed'),
(3, 4, '2023-10-03 14:00:00', 'Emergency', 'Fractured Arm', 'Cast applied, Painkillers', 'Admitted'),
(4, 2, '2023-10-04 11:00:00', 'Follow-up', 'Migraine', 'Sumatriptan', 'Scheduled'),
(5, 5, '2023-10-05 08:45:00', 'Consultation', 'Chest Pain', 'ECG recommended', 'Completed');

-- Insert Rooms
INSERT INTO Rooms (room_number, room_type, daily_charge, is_occupied) VALUES
('101', 'General', 100.00, FALSE),
('102', 'General', 100.00, TRUE),
('201', 'Private', 250.00, FALSE),
('202', 'Private', 250.00, FALSE),
('301', 'ICU', 500.00, FALSE);

-- Insert Admissions
INSERT INTO Admissions (visit_id, room_id, admission_date, discharge_date) VALUES
(3, 2, '2023-10-03 15:00:00', NULL); -- Still admitted

-- Insert Bills
INSERT INTO Bills (visit_id, bill_date, total_amount, payment_status) VALUES
(1, '2023-10-01', 150.00, 'Paid'),
(2, '2023-10-02', 120.00, 'Pending'),
(3, '2023-10-03', 1500.00, 'Partially Paid'), -- Includes room charges estimated
(5, '2023-10-05', 100.00, 'Paid');

-- Insert Payments
INSERT INTO Payments (bill_id, amount_paid, payment_method) VALUES
(1, 150.00, 'Card'),
(3, 500.00, 'Insurance'),
(4, 100.00, 'Cash');
