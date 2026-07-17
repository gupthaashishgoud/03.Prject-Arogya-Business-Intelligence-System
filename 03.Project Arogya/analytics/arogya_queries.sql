-- ============================================================
-- Project Arogya — Business Intelligence Queries
-- 5 queries covering Admissions, Surgery, Voice Analytics, Revenue, Sales
-- ============================================================

-- Q1: Branch Performance Overview
-- Used in: Act 1 — GM Command Center
SELECT 
    b.branch_name,
    b.total_beds,
    COUNT(DISTINCT a.admission_id) AS admissions_today,
    ROUND(COUNT(DISTINCT a.admission_id) * 100.0 / b.total_beds, 1) AS occupancy_pct,
    SUM(a.revenue) AS daily_revenue,
    CASE 
        WHEN COUNT(DISTINCT a.admission_id) * 100.0 / b.total_beds >= 90 THEN 'Optimal'
        WHEN COUNT(DISTINCT a.admission_id) * 100.0 / b.total_beds >= 80 THEN 'On Track'
        ELSE 'Watch'
    END AS status
FROM dim_branch b
LEFT JOIN fact_admissions a ON b.branch_id = a.branch_id AND a.admission_date = CURRENT_DATE
GROUP BY b.branch_id, b.branch_name, b.total_beds
ORDER BY daily_revenue DESC;

/* Sample Output:
 branch_name      | beds | admissions | occ% | revenue   | status
------------------+------+------------+------+-----------+--------
 Begumpet (HQ)    | 200  | 184        | 92.0 | 2850000   | Optimal
 Ameerpet         | 150  | 134        | 89.3 | 2120000   | Optimal
 LB Nagar         | 100  | 91         | 91.0 | 1450000   | Optimal
 Kukatpally       | 120  | 102        | 85.0 | 1680000   | On Track
 Madhapur         | 80   | 70         | 87.5 | 1120000   | On Track
 Nizamabad        | 50   | 41         | 82.0 | 650000    | On Track
 Secunderabad     | 100  | 78         | 78.0 | 1240000   | Watch
 Warangal         | 50   | 38         | 76.0 | 580000    | Watch
*/

-- Q2: Live Surgery Status with Hourly Update Count
-- Used in: Act 2 — OR & Surgery Tracker
SELECT 
    s.surgery_id,
    p.patient_name,
    p.attendant_name,
    p.attendant_phone,
    d.doctor_name,
    d.specialty,
    s.ot_number,
    s.procedure_name,
    s.scheduled_start,
    s.actual_start,
    s.actual_end,
    s.status,
    s.delay_minutes,
    s.hourly_updates_sent,
    s.attendant_notified,
    CASE 
        WHEN s.actual_end IS NULL AND s.scheduled_start < CURRENT_TIMESTAMP - INTERVAL '3 hours' THEN 'Overdue'
        WHEN s.delay_minutes > 30 THEN 'Delayed'
        ELSE 'On Track'
    END AS alert_status
FROM fact_surgeries s
JOIN dim_patient p ON s.patient_id = p.patient_id
JOIN dim_doctor d ON s.doctor_id = d.doctor_id
WHERE s.surgery_date = CURRENT_DATE
ORDER BY s.scheduled_start;

/* Sample Output:
 surgery_id | patient_name        | attendant    | doctor     | ot   | procedure      | status      | delay | updates | alert
------------+---------------------+--------------+------------+------+----------------+-------------+-------+---------+--------
 1          | Mr. Venkatesh Rao   | Mrs. Rao     | Dr. Sharma | OT-1 | CABG           | In Progress | 0     | 3       | On Track
 2          | Mrs. Lakshmi Devi   | Mr. Devi     | Dr. Reddy  | OT-2 | TKR            | Completed   | 0     | 3       | -
 3          | Mr. Arjun Nair      | Mrs. Nair    | Dr. Patel  | OT-3 | Lap Chole      | Delayed     | 90    | 2       | Delayed
*/

-- Q3: Voice Call Analytics & NPS Tracking
-- Used in: Act 3 — Patient Journey Intelligence
SELECT 
    call_day,
    COUNT(*) AS calls_placed,
    SUM(CASE WHEN answered THEN 1 ELSE 0 END) AS calls_answered,
    ROUND(SUM(CASE WHEN answered THEN 1 ELSE 0 END) * 100.0 / COUNT(*), 1) AS answer_rate_pct,
    ROUND(AVG(duration_seconds), 0) AS avg_duration_sec,
    ROUND(AVG(pain_score), 1) AS avg_pain_score,
    SUM(CASE WHEN meds_on_time THEN 1 ELSE 0 END) AS meds_on_time_count,
    SUM(CASE WHEN callback_requested THEN 1 ELSE 0 END) AS callbacks,
    ROUND(AVG(nps_score), 1) AS avg_nps
FROM fact_voice_calls
WHERE call_date >= DATE_TRUNC('month', CURRENT_DATE)
GROUP BY call_day
ORDER BY call_day;

/* Sample Output:
 call_day | placed | answered | rate% | avg_sec | pain | meds | callbacks | nps
----------+--------+----------+-------+---------+------+------+-----------+-----
 2        | 89     | 82       | 92.1  | 134     | 3.2  | 78   | 5         | NULL
 10       | 89     | 75       | 84.3  | 128     | 2.1  | 70   | 8         | NULL
 15       | 89     | 80       | 89.9  | 145     | 1.8  | 75   | 3         | NULL
 30       | 89     | 78       | 87.6  | 156     | 1.2  | 72   | 2         | 72.0
*/

-- Q4: Revenue Waterfall — Monthly Breakdown
-- Used in: Act 4 — Finance & Compliance
SELECT 
    payment_type,
    SUM(amount) AS gross_revenue,
    SUM(discount) AS total_discounts,
    SUM(insurance_deduction) AS total_insurance_deductions,
    SUM(amount - discount - insurance_deduction) AS net_revenue
FROM fact_payments
WHERE payment_date >= DATE_TRUNC('month', CURRENT_DATE)
GROUP BY payment_type
ORDER BY gross_revenue DESC;

/* Sample Output:
 payment_type     | gross    | discounts | insurance | net
-----------------+----------+-----------+-----------+--------
 IPD             | 98000000 | 5000000   | 3000000   | 90000000
 OPD             | 42000000 | 2000000   | 1000000   | 39000000
 Surgery         | 32000000 | 1500000   | 2000000   | 28500000
 Pharmacy        | 14000000 | 500000    | 0         | 13500000
 Diagnostics     | 14000000 | 0         | 0         | 14000000
 Corporate       | 8000000  | 0         | 0         | 8000000
*/

-- Q5: Sales Team Performance Leaderboard
-- Used in: Act 1 — GM Command Center + Act 3 — VP Sales
SELECT 
    st.team_name,
    st.vp_name,
    b.branch_name,
    st.exec_count,
    st.monthly_target,
    COALESCE(SUM(a.revenue), 0) AS achieved_revenue,
    ROUND(COALESCE(SUM(a.revenue), 0) * 100.0 / st.monthly_target, 0) AS achievement_pct,
    CASE 
        WHEN COALESCE(SUM(a.revenue), 0) >= st.monthly_target THEN 'Top'
        WHEN COALESCE(SUM(a.revenue), 0) >= st.monthly_target * 0.95 THEN 'On Track'
        WHEN COALESCE(SUM(a.revenue), 0) >= st.monthly_target * 0.80 THEN 'Watch'
        ELSE 'Critical'
    END AS status
FROM dim_sales_team st
JOIN dim_branch b ON st.branch_id = b.branch_id
LEFT JOIN fact_admissions a ON a.admission_date >= DATE_TRUNC('month', CURRENT_DATE)
GROUP BY st.team_id, st.team_name, st.vp_name, b.branch_name, st.exec_count, st.monthly_target
ORDER BY achievement_pct DESC;

/* Sample Output:
 team_name | vp_name     | branch       | execs | target   | achieved | pct  | status
-----------+-------------+--------------+-------+----------+----------+------+---------
 Team 1    | VP Ramesh   | Begumpet     | 40    | 2800000  | 3100000  | 111  | Top
 Team 2    | VP Suresh   | Ameerpet     | 38    | 2500000  | 2700000  | 108  | Top
 Team 7    | VP Deepa    | Nizamabad    | 25    | 1200000  | 1300000  | 108  | On Track
 Team 3    | VP Priya    | LB Nagar     | 35    | 2200000  | 2300000  | 105  | On Track
 Team 4    | VP Karthik  | Kukatpally   | 32    | 2000000  | 1900000  | 95   | Watch
 Team 5    | VP Anjali   | Madhapur     | 30    | 1800000  | 1700000  | 94   | Watch
 Team 6    | VP Rajesh   | Secunderabad | 28    | 1600000  | 1400000  | 88   | Watch
 Team 8    | VP Arun     | Warangal     | 22    | 1000000  | 620000   | 62   | Critical
*/
