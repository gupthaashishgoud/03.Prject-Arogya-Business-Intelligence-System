# Project Arogya — Healthcare Operations Dashboard

> **Senior PM/PO Portfolio Piece** | Patient Journey Intelligence & Hospital Operations System  
> **Real Data Model:** Rs.200Cr+ Annual Revenue | 8 Branches | 800+ Beds | 300+ Clinical Staff | 400+ Sales Executives  
> **Built by:** Guptha Ashish Goud

---

## Problem Statement

A multi-branch hospital chain in Telangana was operating 8 branches with 800+ beds but had:

- **No real-time cross-branch visibility** — GM couldn't see bed occupancy, admissions, or OR status across all 8 locations
- **Surgery waiting anxiety** — families waited 3-6 hours with zero updates, causing front-desk chaos and complaint escalations
- **Post-discharge black hole** — patients were lost after discharge, no follow-up, no NPS tracking, no referral pipeline
- **Sales team opacity** — 400+ executives across 12 VP teams had no unified performance dashboard
- **Financial fragmentation** — revenue, payroll, insurance claims, and GST tracked in separate systems

## Solution

A **4-tab persona-driven analytics dashboard** with:

| Tab | Persona | Key Features |
|---|---|---|
| Act 1 | General Manager | Branch performance matrix, critical alerts, 12 VP team leaderboard |
| Act 2 | OT Incharge | Live surgery status, hourly attendant updates, OR schedule, surgeon utilization |
| Act 3 | VP Sales / Relations | Patient journey timeline, automated voice call simulation, CRM workflows |
| Act 4 | CFO / Administrator | Revenue waterfall, department P&L, payroll breakdown, insurance claims, compliance |

## Unique Differentiators

1. **Hourly Surgery Updates** — Automated SMS/WhatsApp to attendants every 60 min during surgery
2. **Voice Call Simulation** — Post-discharge Day 2/10/15/30 automated voice calls with IVR
3. **On-Demand Status Query** — Attendants reply "STATUS" for instant live OT update
4. **Penalty Auto-Calculation** — Not applicable (healthcare), replaced with compliance scoring

## Tech Stack

- **Frontend:** Vanilla HTML/CSS/JS (widget-ready, zero dependencies)
- **Data Model:** Star schema (see `data/arogya_schema.sql`)
- **Analytics:** 5 SQL queries covering admissions, surgery throughput, revenue, voice analytics
- **API:** OpenAPI 3.0 spec with JWT auth (see `api/arogya_api_spec.yaml`)
- **Automation:** n8n flow for hourly surgery alerts + Twilio voice call sequences
- **Design:** Persona-driven UX with MNC-grade cosmetic standard (black header, centered KPIs)

## Business Impact

| Metric | Before | After (Projected) |
|---|---|---|
| Front-desk query volume | 400/day | 120/day (-70%) |
| Patient satisfaction (OT) | 3.2/5 | 4.6/5 |
| Post-discharge follow-up rate | 12% | 89% |
| NPS score | 45 | 72 |
| Sales team visibility | None | Real-time leaderboard |
| Cross-branch GM visibility | Phone calls | 30-second dashboard |

## Repository Structure

```
project-arogya/
├── README.md                          # This file
├── dashboard/
│   └── Project_Arogya_MNC_Widget.html  # Locked cosmetics, all original data
├── data/
│   └── arogya_schema.sql              # Star schema + sample data
├── analytics/
│   └── arogya_queries.sql             # 5 business queries with sample outputs
├── automation/
│   ├── hourly_surgery_alert.json      # n8n flow for hourly attendant updates
│   └── voice_call_sequence.json       # Twilio voice call Day 2/10/15/30 flow
├── api/
│   └── arogya_api_spec.yaml           # OpenAPI 3.0 — 5 endpoints, JWT auth
├── design/
│   └── wireframes.figjam.md           # 4 persona journeys + component library
└── project/
    └── sprint_board.md                # 48 stories, 3 sprints, risk register
```

## How to Run

1. Open `dashboard/Project_Arogya_MNC_Widget.html` in any modern browser
2. No build step required — pure HTML/CSS/JS
3. For backend integration, reference `api/arogya_api_spec.yaml`

## License

Portfolio demonstration. All data is modeled on real hospital operations, anonymized.

---

*"Transforming anxiety into advocacy — one hourly update at a time."*  
— Guptha Ashish Goud
