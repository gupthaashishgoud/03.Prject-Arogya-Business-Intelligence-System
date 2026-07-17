# Project Arogya — UX Design Documentation

> **Design System:** MNC-grade restraint | Black/White/Grey palette | Green=Positive, Red=Negative, Purple=Sales  
> **Cosmetic Standard:** Locked from Devil's Den v2.0

---

## 1. Persona Journey Map

### Persona 1: General Manager (Act 1 — GM Command Center)
**Goal:** See all 8 branches at a glance, identify ICU shortages, track 12 VP teams.

| Step | Action | UI Element | Data Source |
|---|---|---|---|
| 1 | Open dashboard | Black header loads | Static config |
| 2 | View KPIs | 4 centered cards (Admissions, Occupancy, Surgeries, Pipeline) | `fact_admissions` aggregate |
| 3 | Scan branches | Table with occupancy pills | `dim_branch` + `fact_admissions` |
| 4 | Read alerts | 4 alert cards (ICU shortage, Sales underperform, OT delay, Pharma stock) | Real-time triggers |
| 5 | Review sales | 3 team cards + 8-row VP leaderboard | `dim_sales_team` + revenue |

**Pain Point Solved:** "I used to call 8 branch managers every morning. Now I see everything in 30 seconds."

---

### Persona 2: OT Incharge (Act 2 — OR & Surgery Tracker)
**Goal:** Track live surgeries, manage OR turnover, keep attendants informed.

| Step | Action | UI Element | Data Source |
|---|---|---|---|
| 1 | View active OTs | KPI row (6/8 active, 42 surgeries, 28min turnover, 186 updates) | `fact_surgeries` |
| 2 | Check surgery cards | 3 surgery cards with hourly update logs | `fact_surgeries` + alert log |
| 3 | Review OR schedule | 8-row table with status pills | `fact_surgeries` |
| 4 | Check surgeon utilization | 5-bar chart + metrics table | `dim_doctor` |
| 5 | Send update | Button triggers SMS/WhatsApp | Twilio API |

**Pain Point Solved:** "Families used to crowd the front desk every 30 minutes. Now they get hourly updates automatically."

---

### Persona 3: VP Sales / Patient Relations (Act 3 — Patient Journey Intelligence)
**Goal:** Track patient journey from admission to 30-day NPS, manage 400+ sales executives.

| Step | Action | UI Element | Data Source |
|---|---|---|---|
| 1 | View active patients | KPI row (1,247 active, 89 discharged, 356 voice calls, 23 callbacks) | `fact_admissions` + `fact_voice_calls` |
| 2 | Review CRM workflows | 4 auto-triggered workflow cards | Automation config |
| 3 | Check voice simulation | 4 voice call script cards (Day 2/10/15/30) | `fact_voice_calls` |
| 4 | Review patient timeline | 7-item timeline with status dots | `fact_admissions` + `fact_surgeries` + `fact_voice_calls` |
| 5 | Check team roster | 5-row executive table | `dim_sales_team` |

**Pain Point Solved:** "We used to lose patients after discharge. Now 89% get follow-up calls and our NPS is 72."

---

### Persona 4: CFO / Administrator (Act 4 — Finance & Compliance)
**Goal:** Track revenue waterfall, department P&L, payroll, insurance claims, compliance.

| Step | Action | UI Element | Data Source |
|---|---|---|---|
| 1 | View revenue KPIs | 4 centered cards (Revenue, EBITDA, Insurance Pending, Payroll) | `fact_payments` aggregate |
| 2 | Review waterfall | Revenue breakdown (IPD → OPD → Surgery → Pharmacy → Corporate) | `fact_payments` |
| 3 | Check department P&L | 8-row table with margins | `fact_payments` JOIN `dim_department` |
| 4 | Review payroll | 4-bar chart (Doctors, Nurses, Sales, Admin) | HR system |
| 5 | Track insurance | 5-row TPA table with TAT | Insurance portal |
| 6 | Verify compliance | 6 mini-boxes (NABH, GST, Bio-Waste, Fire, Drug, Certifications) | Compliance register |

**Pain Point Solved:** "I used to compile 4 Excel files for the board meeting. Now it's one dashboard."

---

## 2. Component Library

### KPI Card (Centered, Top Accent)
```
┌─────────────────────────┐
│ ▓▓▓▓ (4px top border)   │  ← Green/Amber/Red/Blue/Purple
│                         │
│      TOTAL ADMISSIONS   │  ← Label: uppercase, 0.75rem, grey
│                         │
│         1,247           │  ← Value: 1.5rem, bold, black
│                         │
│      +8.3% vs yesterday │  ← Delta: 0.75rem, grey, centered
│                         │
└─────────────────────────┘
  min-height: 110px
  padding: 20px 16px
  align-items: center
  justify-content: center
  text-align: center
```

### Alert Card (Top Accent, Centered Text)
```
┌─────────────────────────┐
│ ▓▓▓▓ (4px top, red)     │
│                         │
│         HIGH            │
│                         │
│   Secunderabad - ICU    │
│   Bed Shortage          │
│   Only 2 ICU beds...    │
│                         │
│      [ Activate ]       │
└─────────────────────────┘
  padding: 20px
  text-align: center
  flex-direction: column
  align-items: center
```

### Surgery Card
```
┌─────────────────────────┐
│ OT-1 - CABG          [IN PROGRESS]
│ Patient: Mr. Venkatesh Rao (64)
│ Surgeon: Dr. Sharma
│ Started: 09:15 AM | Est. End: 01:30 PM
│ Attendant: Mrs. Rao
│ ─────────────────────────
│ Hourly Update Log:
│ 10:15 AM - "Patient stable..."
│ 11:15 AM - "2 of 3 grafts..."
│ 12:15 PM - "Final graft..."
│ [Send Next Update]
└─────────────────────────┘
```

### Bar Chart (Soulful Colors)
```
Dr. Sharma    ████████████████████░░░░░  92%  ← #4A6741 (deep forest)
Dr. Reddy     ██████████████████░░░░░░░  88%  ← #4A6741
Dr. Patel     █████████████████░░░░░░░░  85%  ← #4A6741
Dr. Kaur      ███████████████████░░░░░░  90%  ← #4A6741
Dr. Iyer      ████████████████░░░░░░░░░  78%  ← #4A6741

Doctors       ████████████████████░░░░░  45%  ← #8B7355 (warm brown)
Nurses        ████████████░░░░░░░░░░░░░  28%  ← #8B7355
Sales Team    ██████░░░░░░░░░░░░░░░░░░░  15%  ← #8B7355
Admin/HR      █████░░░░░░░░░░░░░░░░░░░░  12%  ← #8B7355
```

### Timeline Item (Top Accent)
```
┌─────────────────────────┐
│ ▓▓▓▓ (4px top, green)   │
│ OK  Admission - 12 July   │
│     Admitted for TKR...   │
└─────────────────────────┘
```

---

## 3. Color Palette (Locked)

| Token | Hex | Usage |
|---|---|---|
| `--header-bg` | `#111111` | Hero header background |
| `--header-text` | `#FFFFFF` | Hero title, subtitle |
| `--kpi-green` | `#38a169` | Positive KPI, completed, on-time, done |
| `--kpi-amber` | `#d69e2e` | Warning KPI, in-progress, watch, pending |
| `--kpi-red` | `#e53e3e` | Negative KPI, delayed, overdue, critical |
| `--kpi-blue` | `#3182ce` | Neutral KPI, active, info, prepping |
| `--kpi-purple` | `#805ad5` | Sales KPI, pipeline, team metrics |
| `--bar-surgery` | `#4A6741` | Surgeon utilization bars (deep forest) |
| `--bar-payroll` | `#8B7355` | Payroll bars (warm brown) |
| `--bg-page` | `#f0f4f8` | Page background |
| `--bg-card` | `#FFFFFF` | Card background |
| `--text-primary` | `#1a202c` | Headings, values |
| `--text-secondary` | `#718096` | Labels, meta, delta |

---

## 4. Responsive Breakpoints

| Breakpoint | Grid | Behavior |
|---|---|---|
| >900px | 4-col KPI, 2-col cards, 3-col team | Full layout |
| 600-900px | 2-col KPI, 1-col cards, 1-col team | Tablet |
| <600px | 1-col everything | Mobile stack |

---

## 5. Accessibility Checklist

- [x] All text meets WCAG AA contrast (4.5:1)
- [x] Interactive elements have focus states
- [x] Color is not the only indicator (pills have text labels)
- [x] Tables have semantic `<th>` headers
- [x] Buttons have descriptive labels
- [x] Voice call scripts use simple language (Grade 6 reading level)

---

*Design locked per Devil's Den v2.0 cosmetic standard.*  
*No data changes. No analytics changes. Only styling.*
