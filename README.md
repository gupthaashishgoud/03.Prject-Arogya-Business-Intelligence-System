# Project Arogya — Healthcare Operations & Patient Journey Intelligence

> **Power BI Business Intelligence Project** | SQL · DAX · OpenAPI · n8n · Twilio · Figma  
> **Data Model:** ₹200Cr+ Annual Revenue | 8 Branches | 800+ Beds | 300+ Clinical Staff | 400+ Sales Executives  
> **Built by:** Guptha Ashish Goud

---

## Overview

A persona-driven analytics platform for a multi-branch hospital chain in Telangana with 800+ beds across 8 locations. The system provides real-time cross-branch visibility, automated surgery status updates for patient families, post-discharge follow-up automation, and a unified sales performance leaderboard — transforming patient experience and operational transparency.

## Problem

A multi-branch hospital chain was operating 8 branches with 800+ beds but faced:

- No real-time cross-branch visibility — the GM couldn't see bed occupancy, admissions, or OR status across locations
- Surgery waiting anxiety — families waited 3-6 hours with zero updates, causing front-desk chaos
- Post-discharge black hole — patients lost after discharge, no follow-up, no NPS tracking
- Sales team opacity — 400+ executives across 12 VP teams had no unified performance view
- Financial fragmentation — revenue, payroll, insurance claims, and GST in separate systems

## Solution

A 4-tab persona-driven analytics dashboard with automated patient communication:

| Tab | Persona | Key Features |
|---|---|---|
| Act 1 | General Manager | Branch performance matrix, critical alerts, 12 VP team leaderboard |
| Act 2 | OT Incharge | Live surgery status, hourly attendant updates, OR schedule, surgeon utilization |
| Act 3 | VP Sales / Relations | Patient journey timeline, automated voice call simulation, CRM workflows |
| Act 4 | CFO / Administrator | Revenue waterfall, department P&L, payroll, insurance claims, compliance scoring |

## Key Results

| Metric | Before | After (Projected) | Improvement |
|---|---|---|---|
| Front-desk query volume | 400/day | 120/day | -70% |
| Patient satisfaction (OT) | 3.2/5 | 4.6/5 | +44% |
| Post-discharge follow-up rate | 12% | 89% | +642% |
| NPS score | 45 | 72 | +60% |
| Sales team visibility | None | Real-time leaderboard | First-time measured |
| Cross-branch GM visibility | Phone calls | 30-second dashboard | Instant access |

## Unique Features

1. **Hourly Surgery Updates** — Automated SMS/WhatsApp to attendants every 60 minutes during surgery
2. **Voice Call Simulation** — Post-discharge Day 2/10/15/30 automated voice calls with IVR
3. **On-Demand Status Query** — Attendants reply "STATUS" for instant live OT update
4. **Compliance Scoring** — Automated compliance tracking across departments

## Tech Stack

- **Frontend:** Vanilla HTML/CSS/JS (widget-ready, zero dependencies)
- **Data Model:** Star schema in SQL Server (see `data/arogya_schema.sql`)
- **Analytics:** 5 SQL queries covering admissions, surgery throughput, revenue, voice analytics
- **API:** OpenAPI 3.0 spec with JWT auth (see `api/arogya_api_spec.yaml`)
- **Automation:** n8n flow for hourly surgery alerts + Twilio voice call sequences
- **Design:** Persona-driven UX wireframes

## Repository Structure

```
├── dashboard/          # Interactive HTML dashboard widget
├── data/               # SQL Server star schema + sample data
├── analytics/          # 5 business SQL queries with sample outputs
├── automation/          # n8n surgery alerts + Twilio voice call flows
├── api/                 # OpenAPI 3.0 spec — 5 endpoints, JWT auth
├── design/              # Persona wireframes and journey maps
└── project/             # Sprint board: 48 stories, 3 sprints, risk register
```

## How to Run

1. Open `dashboard/Project_Arogya_MNC_Widget.html` in any modern browser
2. No build step required — pure HTML/CSS/JS
3. For SQL queries, load `data/arogya_schema.sql` into SQL Server
4. For API integration, reference `api/arogya_api_spec.yaml`

---

*Portfolio demonstration. All data is modeled on real hospital operations, anonymized.*  
*Built by Guptha Ashish Goud — Compliance & Risk Analyst | Data-Driven Decision Making | AI & Automation*
