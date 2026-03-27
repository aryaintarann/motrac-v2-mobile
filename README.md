# Motrac v2 — Mobile (Flutter)

**Motrac v2 Mobile** is the companion iOS/Android app for **Motrac v2**, a sleek, AI‑powered personal finance tracker built to make day‑to‑day money decisions feel clear, fast, and intentional.

This app is designed to feel *native* on both platforms: modern, minimalist, high‑contrast, and whitespace‑forward, with a bottom‑navigation layout and quick actions for logging transactions in seconds.

---

## What it is

Motrac v2 helps you track your financial life across accounts, transactions, and debts—then turns that activity into **insights and pacing** so you can understand where you stand *right now*, not just at the end of the month.

The mobile app focuses on:
- **Fast capture** (quick adds + templates)
- **At-a-glance clarity** (net worth / consolidated balance)
- **Behavioral guidance** (weekly pacing + AI insights)
- **Clean reporting** (charts + calendar-based views)

---

## Core experience

### Smart Dashboard (Home)
A high-signal overview of your finances:
- Consolidated balance / net worth header
- **Weekly “AI Pacing”** indicator (green / yellow / red) to show remaining spend room
- Recent activity feed
- Quick-add templates (e.g., Coffee, Gas) for near-zero friction logging

### Accounts & Tracking
Keep money organized across the places it lives:
- Multiple account types (cash, bank, e-wallets)
- Transaction types: **income**, **expense**, **transfer**
- **Reconciliation flow** to compare real bank balance vs app balance and auto-adjust cleanly

### Debt & Receivables
Track obligations with real-world structure:
- “Who owes me” / “Who I owe”
- Remaining balance and due dates
- Installment-style progress (planned)

### Reports & Insights
Understand patterns and trends:
- Category breakdowns and income vs expense charts
- Monthly calendar highlighting transaction days
- **AI Insights card** for narrative takeaways (e.g., spending shifts, trend callouts)

### Profile, Preferences & Security
Personalize the app and protect access:
- Profile and preference editing (currency, date format, AI tone, theme)
- Password + MFA/2FA support (if enabled)
- Session management (“logout everywhere”)
- Data export and account deletion controls

---

## Architecture note

This repository is intentionally **decoupled**: the mobile app is a client that connects to an **existing Supabase backend** shared with the Motrac v2 web app.

- **Source of truth (Web + Backend):** https://github.com/aryaintarann/motrac-v2.git  
  (Next.js app, schema, and Supabase migrations live there)

---

## Tech stack (at a glance)

- Flutter (Dart)
- Supabase
- Riverpod + go_router
- Freezed / JSON serialization
- Charts (fl_chart)
- AI capability hooks (Google Generative AI)

---
