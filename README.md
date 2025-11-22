# Hospital Database Management System

## Overview
This project is a comprehensive Hospital Database Management System designed to manage the core operations of a hospital. It includes modules for managing patients, doctors, staff, appointments, admissions, and billing. The system is built using SQL and features advanced database components like Stored Procedures and Triggers to automate key processes.

## Project Structure
The project consists of the following SQL scripts and documentation files:

### SQL Scripts
- **`schema.sql`**: Defines the database structure, including tables for Departments, Staff, Doctors, Patients, Visits, Bills, Payments, Rooms, and Admissions. It also establishes Foreign Key relationships.
- **`seed_data.sql`**: Populates the database with sample data for testing and demonstration purposes. Includes records for all tables.
- **`queries.sql`**: Contains a collection of useful queries for data retrieval, such as listing appointments, calculating revenue, and generating patient history reports.
- **`procedures_triggers.sql`**:
    - **Procedure `CalculateBill`**: Automatically calculates the total bill for a visit, including doctor fees and room charges.
    - **Trigger `AfterDischarge`**: Updates room availability and visit status when a patient is discharged.
    - **Trigger `BeforeAdmission`**: Prevents double-booking of rooms.

### Documentation
- **`introduction.txt`**: An introduction to the project scope and objectives.
- **`abstract.txt`**: A high-level summary of the project's design and implementation.
- **`conclusion.txt`**: A summary of the project's achievements and future scope.

## How to Run
1.  **Create Database & Tables**: Run the `schema.sql` script to set up the database and tables.
2.  **Insert Data**: Run the `seed_data.sql` script to populate the tables with sample data.
3.  **Create Logic**: Run the `procedures_triggers.sql` script to create the stored procedures and triggers.
4.  **Execute Queries**: Use the queries in `queries.sql` to test the system and retrieve information.
5.  **Test Procedures**: Call the stored procedure (e.g., `CALL CalculateBill(1);`) to verify billing logic.

## Requirements
- A MySQL or MariaDB compatible database server.
- A SQL client (e.g., MySQL Workbench, DBeaver, or command line).

## Author
[Your Name/Organization]
