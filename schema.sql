-- Hospital Database Management System Schema

CREATE DATABASE IF NOT EXISTS HospitalDB;
USE HospitalDB;

-- 1. Departments Table
CREATE TABLE Departments (
    department_id INT PRIMARY KEY AUTO_INCREMENT,
    department_name VARCHAR(100) NOT NULL,
    head_of_department VARCHAR(100),
    location VARCHAR(50)
);

-- 2. Staff Table (Nurses, Receptionists, etc.)
CREATE TABLE Staff (
    staff_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    role VARCHAR(50) NOT NULL,
    department_id INT,
    phone VARCHAR(15),
    email VARCHAR(100),
    hire_date DATE,
    salary DECIMAL(10, 2),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- 3. Doctors Table
CREATE TABLE Doctors (
    doctor_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    specialization VARCHAR(100),
    department_id INT,
    phone VARCHAR(15),
    email VARCHAR(100),
    schedule VARCHAR(100), -- e.g., "Mon-Fri 9am-5pm"
    consultation_fee DECIMAL(10, 2),
    FOREIGN KEY (department_id) REFERENCES Departments(department_id)
);

-- 4. Patients Table
CREATE TABLE Patients (
    patient_id INT PRIMARY KEY AUTO_INCREMENT,
    first_name VARCHAR(50) NOT NULL,
    last_name VARCHAR(50) NOT NULL,
    dob DATE,
    gender ENUM('Male', 'Female', 'Other'),
    address TEXT,
    phone VARCHAR(15),
    emergency_contact_name VARCHAR(100),
    emergency_contact_phone VARCHAR(15),
    insurance_provider VARCHAR(100),
    insurance_policy_no VARCHAR(50)
);

-- 5. Visits/Appointments Table
CREATE TABLE Visits (
    visit_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_id INT,
    doctor_id INT,
    visit_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    visit_type ENUM('Consultation', 'Emergency', 'Follow-up', 'Surgery'),
    diagnosis TEXT,
    prescription TEXT,
    status ENUM('Scheduled', 'Completed', 'Cancelled', 'Admitted', 'Discharged') DEFAULT 'Scheduled',
    FOREIGN KEY (patient_id) REFERENCES Patients(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctors(doctor_id)
);

-- 6. Bills Table
CREATE TABLE Bills (
    bill_id INT PRIMARY KEY AUTO_INCREMENT,
    visit_id INT,
    bill_date DATE,
    total_amount DECIMAL(10, 2),
    payment_status ENUM('Pending', 'Paid', 'Partially Paid') DEFAULT 'Pending',
    FOREIGN KEY (visit_id) REFERENCES Visits(visit_id)
);

-- 7. Payments Table
CREATE TABLE Payments (
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    bill_id INT,
    payment_date DATETIME DEFAULT CURRENT_TIMESTAMP,
    amount_paid DECIMAL(10, 2),
    payment_method ENUM('Cash', 'Card', 'Insurance', 'Online'),
    FOREIGN KEY (bill_id) REFERENCES Bills(bill_id)
);

-- 8. Rooms Table (For In-patients)
CREATE TABLE Rooms (
    room_id INT PRIMARY KEY AUTO_INCREMENT,
    room_number VARCHAR(10) NOT NULL,
    room_type ENUM('General', 'Private', 'ICU'),
    daily_charge DECIMAL(10, 2),
    is_occupied BOOLEAN DEFAULT FALSE
);

-- 9. Admissions Table
CREATE TABLE Admissions (
    admission_id INT PRIMARY KEY AUTO_INCREMENT,
    visit_id INT,
    room_id INT,
    admission_date DATETIME,
    discharge_date DATETIME,
    FOREIGN KEY (visit_id) REFERENCES Visits(visit_id),
    FOREIGN KEY (room_id) REFERENCES Rooms(room_id)
);
