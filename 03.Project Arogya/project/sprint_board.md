# Project Arogya — Sprint Board

> **Methodology:** Scrum | **Sprint Duration:** 2 weeks | **Team Size:** 5 (1 PM, 2 Devs, 1 Designer, 1 QA)  
> **Tool Reference:** Jira / Linear / ClickUp compatible

---

## Epic 1: GM Command Center (Act 1)
**Goal:** Give the General Manager a 30-second health check of all 8 branches.

| ID | Story | Points | Priority | Sprint | Status |
|---|---|---|---|---|---|
| ARO-101 | As a GM, I want to see total admissions today across all branches | 3 | High | Sprint 1 | Done |
| ARO-102 | As a GM, I want branch-wise bed occupancy with status pills | 5 | High | Sprint 1 | Done |
| ARO-103 | As a GM, I want critical alerts (ICU shortage, sales underperform, OT delay) | 5 | High | Sprint 1 | Done |
| ARO-104 | As a GM, I want 12 VP team performance leaderboard | 5 | High | Sprint 1 | Done |
| ARO-105 | As a GM, I want revenue run-rate vs monthly target | 3 | Medium | Sprint 2 | Done |

---

## Epic 2: OR & Surgery Tracker (Act 2)
**Goal:** Enable OT Incharge to track live surgeries and auto-update attendants hourly.

| ID | Story | Points | Priority | Sprint | Status |
|---|---|---|---|---|---|
| ARO-201 | As an OT Incharge, I want live surgery status for all OTs | 8 | High | Sprint 1 | Done |
| ARO-202 | As an OT Incharge, I want hourly SMS/WhatsApp updates to attendants | 8 | High | Sprint 1 | Done |
| ARO-203 | As an OT Incharge, I want on-demand status query (attendant replies "STATUS") | 5 | High | Sprint 2 | Done |
| ARO-204 | As an OT Incharge, I want delay auto-alerts when surgery exceeds ETA by 30 min | 5 | Medium | Sprint 2 | Done |
| ARO-205 | As an OT Incharge, I want surgeon utilization scorecard | 3 | Medium | Sprint 2 | Done |
| ARO-206 | As an OT Incharge, I want OR turnover time tracking | 3 | Low | Sprint 3 | Todo |

---

## Epic 3: Patient Journey Intelligence (Act 3)
**Goal:** Enable VP Sales to track full patient journey and automate post-discharge care.

| ID | Story | Points | Priority | Sprint | Status |
|---|---|---|---|---|---|
| ARO-301 | As a VP Sales, I want patient journey timeline (Admission → Surgery → Discharge → Follow-up) | 5 | High | Sprint 2 | Done |
| ARO-302 | As a VP Sales, I want automated voice calls on Day 2/10/15/30 post-discharge | 8 | High | Sprint 2 | Done |
| ARO-303 | As a VP Sales, I want voice call analytics (answer rate, NPS, callbacks) | 5 | High | Sprint 3 | Done |
| ARO-304 | As a VP Sales, I want sales executive performance by team | 3 | Medium | Sprint 3 | Done |
| ARO-305 | As a VP Sales, I want callback request routing to nearest branch | 5 | Medium | Sprint 3 | Todo |
| ARO-306 | As a VP Sales, I want referral tracking from voice call NPS | 3 | Low | Sprint 3 | Backlog |

---

## Epic 4: Finance & Compliance (Act 4)
**Goal:** Give the CFO real-time revenue waterfall, payroll, insurance claims, and compliance.

| ID | Story | Points | Priority | Sprint | Status |
|---|---|---|---|---|---|
| ARO-401 | As a CFO, I want monthly revenue waterfall by department | 5 | High | Sprint 2 | Done |
| ARO-402 | As a CFO, I want department-wise P&L with margins | 5 | High | Sprint 2 | Done |
| ARO-403 | As a CFO, I want payroll breakdown by staff category | 3 | Medium | Sprint 3 | Done |
| ARO-404 | As a CFO, I want insurance claims tracker with TPA TAT | 5 | Medium | Sprint 3 | Done |
| ARO-405 | As a CFO, I want compliance dashboard (NABH, GST, Fire, Bio-Waste) | 3 | Medium | Sprint 3 | Done |
| ARO-406 | As a CFO, I want GST auto-calculation and filing reminder | 3 | Low | Sprint 3 | Todo |
| ARO-407 | As a CFO, I want export to Tally/QuickBooks | 5 | Low | Sprint 3 | Backlog |

---

## Sprint Summary

| Sprint | Dates | Velocity | Stories | Points | Goal |
|---|---|---|---|---|---|
| Sprint 1 | Week 1-2 | 24 pts | 5 | 24 | Act 1 core + Act 2 live surgery + hourly alerts |
| Sprint 2 | Week 3-4 | 28 pts | 7 | 28 | Act 2 completion + Act 3 voice calls + Act 4 revenue |
| Sprint 3 | Week 5-6 | 20 pts | 5 | 20 | Act 3 completion + Act 4 payroll/insurance/compliance |

**Total:** 17 stories | 72 story points | 6 weeks | 4 epics

---

## Risk Register

| ID | Risk | Probability | Impact | Mitigation | Owner |
|---|---|---|---|---|---|
| R-01 | ICU bed shortage at Secunderabad extends >48 hours | High | Critical | Activate Begumpet HQ overflow + ambulance on standby | GM |
| R-02 | Twilio voice call answer rate drops below 80% | Medium | High | Add IVR retry logic + WhatsApp fallback | VP Sales |
| R-03 | VP Team 8 (Warangal) continues underperforming | High | High | HR intervention + territory reassignment + training | GM |
| R-04 | Insurance TPA (Apollo Munich) delays beyond 20 days | Medium | Medium | Escalate to TPA relationship manager + legal notice | CFO |
| R-05 | NABH audit finds major non-compliance | Low | Critical | Pre-audit internal review + documentation sprint | Administrator |
| R-06 | OT-3 delay pattern repeats (anesthesia shift change) | Medium | Medium | Overlap anesthesia shifts by 30 min | OT Incharge |

---

## Definition of Done

- [ ] Code reviewed and merged to `main`
- [ ] Unit tests pass (>80% coverage)
- [ ] QA sign-off on Chrome, Firefox, Safari, Mobile
- [ ] Accessibility audit passed (WCAG AA)
- [ ] Data accuracy verified against HIS (Hospital Information System)
- [ ] PM sign-off on UI/UX match to Figma
- [ ] Voice call scripts approved by clinical team
- [ ] Deployed to staging and smoke-tested

---

*Sprint board locked. No scope creep without stakeholder approval.*
