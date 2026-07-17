-- ============================================================
-- Project Arogya — Healthcare Operations Database Schema
-- Star schema for multi-branch hospital analytics
-- Rs.200Cr+ Revenue | 8 Branches | 800+ Beds | 300+ Staff | 400+ Sales
-- ============================================================

DROP TABLE IF EXISTS fact_admissions;
DROP TABLE IF EXISTS fact_surgeries;
DROP TABLE IF EXISTS fact_voice_calls;
DROP TABLE IF EXISTS fact_payments;
DROP TABLE IF EXISTS dim_branch;
DROP TABLE IF EXISTS dim_patient;
DROP TABLE IF EXISTS dim_doctor;
DROP TABLE IF EXISTS dim_department;
DROP TABLE IF EXISTS dim_sales_team;

-- ============================================================
-- DIMENSION TABLES
-- ============================================================

CREATE TABLE dim_branch (
    branch_id       SERIAL PRIMARY KEY,
    branch_name     VARCHAR(50) NOT NULL,
    city            VARCHAR(50),
    state           VARCHAR(50) DEFAULT 'Telangana',
    total_beds      INT,
    icu_beds        INT,
    ot_count        INT,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE dim_department (
    department_id   SERIAL PRIMARY KEY,
    department_name VARCHAR(50) NOT NULL,
    branch_id       INT REFERENCES dim_branch(branch_id),
    bed_count       INT,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE dim_doctor (
    doctor_id       SERIAL PRIMARY KEY,
    doctor_name     VARCHAR(100) NOT NULL,
    specialty       VARCHAR(50),
    branch_id       INT REFERENCES dim_branch(branch_id),
    utilization_pct DECIMAL(5,2),
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE dim_patient (
    patient_id      SERIAL PRIMARY KEY,
    patient_name    VARCHAR(100) NOT NULL,
    age             INT,
    gender          VARCHAR(10),
    contact_phone   VARCHAR(15),
    attendant_name  VARCHAR(100),
    attendant_phone VARCHAR(15),
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE dim_sales_team (
    team_id         SERIAL PRIMARY KEY,
    team_name       VARCHAR(20) NOT NULL,
    vp_name         VARCHAR(100),
    branch_id       INT REFERENCES dim_branch(branch_id),
    exec_count      INT,
    monthly_target  DECIMAL(12,2),
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- FACT TABLES
-- ============================================================

CREATE TABLE fact_admissions (
    admission_id    SERIAL PRIMARY KEY,
    patient_id      INT REFERENCES dim_patient(patient_id),
    branch_id       INT REFERENCES dim_branch(branch_id),
    department_id   INT REFERENCES dim_department(department_id),
    admission_date  DATE,
    discharge_date  DATE,
    bed_type        VARCHAR(20) CHECK (bed_type IN ('General', 'Semi-Private', 'Private', 'ICU')),
    status          VARCHAR(20) CHECK (status IN ('Admitted', 'Discharged', 'Transferred')),
    revenue         DECIMAL(12,2),
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE fact_surgeries (
    surgery_id      SERIAL PRIMARY KEY,
    patient_id      INT REFERENCES dim_patient(patient_id),
    branch_id       INT REFERENCES dim_branch(branch_id),
    doctor_id       INT REFERENCES dim_doctor(doctor_id),
    ot_number       VARCHAR(10),
    procedure_name  VARCHAR(100),
    scheduled_start TIMESTAMP,
    actual_start    TIMESTAMP,
    actual_end      TIMESTAMP,
    status          VARCHAR(20) CHECK (status IN ('Scheduled', 'In Progress', 'Completed', 'Delayed', 'Cancelled')),
    delay_minutes   INT DEFAULT 0,
    attendant_notified BOOLEAN DEFAULT FALSE,
    hourly_updates_sent INT DEFAULT 0,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE fact_voice_calls (
    call_id         SERIAL PRIMARY KEY,
    patient_id      INT REFERENCES dim_patient(patient_id),
    call_day        INT CHECK (call_day IN (2, 10, 15, 30)),
    call_date       DATE,
    call_time       TIME,
    duration_seconds INT,
    answered        BOOLEAN,
    pain_score      INT,
    meds_on_time    BOOLEAN,
    callback_requested BOOLEAN,
    nps_score       INT,
    transcript      TEXT,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE fact_payments (
    payment_id      SERIAL PRIMARY KEY,
    branch_id       INT REFERENCES dim_branch(branch_id),
    department_id   INT REFERENCES dim_department(department_id),
    payment_type    VARCHAR(30) CHECK (payment_type IN ('IPD', 'OPD', 'Surgery', 'Pharmacy', 'Diagnostics', 'Corporate')),
    amount          DECIMAL(12,2),
    discount        DECIMAL(12,2) DEFAULT 0,
    insurance_deduction DECIMAL(12,2) DEFAULT 0,
    payment_date    DATE,
    created_at      TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- ============================================================
-- SAMPLE DATA
-- ============================================================

INSERT INTO dim_branch (branch_name, city, total_beds, icu_beds, ot_count) VALUES
('Begumpet (HQ)', 'Hyderabad', 200, 20, 8),
('Ameerpet', 'Hyderabad', 150, 15, 6),
('Kukatpally', 'Hyderabad', 120, 12, 5),
('Secunderabad', 'Hyderabad', 100, 10, 4),
('LB Nagar', 'Hyderabad', 100, 10, 4),
('Madhapur', 'Hyderabad', 80, 8, 3),
('Nizamabad', 'Nizamabad', 50, 5, 2),
('Warangal', 'Warangal', 50, 5, 2);

INSERT INTO dim_department (department_name, branch_id, bed_count) VALUES
('Cardiology', 1, 45),
('Orthopedics', 1, 60),
('General Surgery', 1, 50),
('Obstetrics', 1, 40),
('Neurology', 1, 30),
('Oncology', 1, 25),
('Diagnostics', 1, 0),
('Pharmacy', 1, 0);

INSERT INTO dim_doctor (doctor_name, specialty, branch_id, utilization_pct) VALUES
('Dr. Sharma', 'Cardiothoracic', 1, 92.0),
('Dr. Reddy', 'Orthopedics', 1, 88.0),
('Dr. Patel', 'General Surgery', 1, 85.0),
('Dr. Kaur', 'Obstetrics', 1, 90.0),
('Dr. Iyer', 'Neurology', 1, 78.0);

INSERT INTO dim_patient (patient_name, age, gender, contact_phone, attendant_name, attendant_phone) VALUES
('Mr. Venkatesh Rao', 64, 'Male', '9876543210', 'Mrs. Rao', '9876543211'),
('Mrs. Lakshmi Devi', 58, 'Female', '9876543220', 'Mr. Devi', '9876543221'),
('Mr. Arjun Nair', 45, 'Male', '9876543230', 'Mrs. Nair', '9876543231');

INSERT INTO dim_sales_team (team_name, vp_name, branch_id, exec_count, monthly_target) VALUES
('Team 1', 'VP Ramesh', 1, 40, 2800000.00),
('Team 2', 'VP Suresh', 2, 38, 2500000.00),
('Team 3', 'VP Priya', 5, 35, 2200000.00),
('Team 4', 'VP Karthik', 3, 32, 2000000.00),
('Team 5', 'VP Anjali', 6, 30, 1800000.00),
('Team 6', 'VP Rajesh', 4, 28, 1600000.00),
('Team 7', 'VP Deepa', 7, 25, 1200000.00),
('Team 8', 'VP Arun', 8, 22, 1000000.00);

INSERT INTO fact_surgeries (patient_id, branch_id, doctor_id, ot_number, procedure_name, scheduled_start, actual_start, actual_end, status, delay_minutes, attendant_notified, hourly_updates_sent) VALUES
(1, 1, 1, 'OT-1', 'Cardiac Bypass (CABG)', '2026-07-15 09:15:00', '2026-07-15 09:15:00', NULL, 'In Progress', 0, TRUE, 3),
(2, 1, 2, 'OT-2', 'Total Knee Replacement (TKR)', '2026-07-15 09:30:00', '2026-07-15 09:30:00', '2026-07-15 11:45:00', 'Completed', 0, TRUE, 3),
(3, 1, 3, 'OT-3', 'Laparoscopic Cholecystectomy', '2026-07-15 10:00:00', '2026-07-15 11:30:00', NULL, 'Delayed', 90, TRUE, 2);

INSERT INTO fact_voice_calls (patient_id, call_day, call_date, call_time, duration_seconds, answered, pain_score, meds_on_time, callback_requested, nps_score, transcript) VALUES
(2, 2, '2026-07-17', '10:00:00', 134, TRUE, 3, TRUE, FALSE, NULL, 'Patient doing well. Pain 3/10. Medicines on time. No fever. Advised to continue physio.'),
(2, 10, '2026-07-25', '10:00:00', NULL, NULL, NULL, NULL, NULL, NULL, 'Scheduled');

INSERT INTO fact_payments (branch_id, department_id, payment_type, amount, discount, insurance_deduction, payment_date) VALUES
(1, 1, 'IPD', 98000000.00, 5000000.00, 3000000.00, '2026-07-01'),
(1, 2, 'Surgery', 32000000.00, 1500000.00, 2000000.00, '2026-07-01'),
(1, 3, 'OPD', 42000000.00, 2000000.00, 1000000.00, '2026-07-01'),
(1, 7, 'Pharmacy', 14000000.00, 500000.00, 0.00, '2026-07-01'),
(1, 8, 'Diagnostics', 14000000.00, 0.00, 0.00, '2026-07-01');
