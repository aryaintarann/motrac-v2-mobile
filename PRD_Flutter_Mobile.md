Product Requirements Document (PRD): Motrac v2 - Mobile App (Flutter)

1. Product Overview

This is the companion mobile application for "Motrac v2", a sleek, AI-powered personal finance tracker.
Crucial Architectural Note for AI Co-pilot: This app uses a Polyrepo / Decoupled Architecture. The backend (Supabase PostgreSQL, Auth, Storage) and the database schema already exist and are shared with the Next.js Web App. This Flutter app serves strictly as a mobile client connecting to the existing Supabase instance.

Target Vibe/UI: Sleek, modern, minimalist, feels native to iOS and Android. Light color scheme with sophisticated blue undertones. High contrast for readability, utilizing generous whitespace. Bottom Navigation pattern is preferred.

2. Repositories & Tech Stack

2.1. Repository Links

Web & Backend Repository (Source of Truth): https://github.com/aryaintarann/motrac-v2.git
(Contains Next.js code, Zod schemas, and Supabase SQL migrations)

2.2. Architecture (Mobile)

Framework: Flutter (Dart)

Backend as a Service (BaaS): Supabase (using supabase_flutter package)

State Management: Riverpod (flutter_riverpod) - Highly recommended for robust data fetching and caching alongside Supabase.

Routing: go_router (for declarative routing and deep-linking)

Data Classes/Serialization: freezed & json_annotation (to strictly map the existing Supabase database schema to Dart objects, mirroring the web's Zod schemas).

Charting: fl_chart (for monthly financial visual reports).

3. Core App Structure & Navigation

The app will primarily use a Bottom Navigation Bar with a prominent Floating Action Button (FAB) for quick additions.

Bottom Nav Tabs:

Home (Smart Dashboard)

Accounts (Wallets & Reconciliation)

Reports (Charts & Calendar)

Profile (Settings & Security)

FAB (Center): Opens the Quick Add Transaction / Template modal.

4. Core Features & Specifications

4.1. Auth Flow

Connects to existing Supabase Auth.

Login using Email/Password.

MFA/2FA support (if enabled on the user's account).

4.2. Smart Dashboard & AI Pacing (Home Tab)

Global Header: Displays net worth/total consolidated balance across all active accounts.

AI Pacing Widget (Weekly): Visual indicator calculating remaining disposable income for the week (Green/Yellow/Red).

Recent Activity: Short list of the most recent transactions.

Quick Add Templates (Horizontal Scroll): Row of quick-action buttons (e.g., ☕ Coffee, ⛽ Gas) that immediately trigger a pre-filled transaction modal.

4.3. Financial Tracking & Accounts (Accounts Tab)

Account List: View balances for Cash, Bank (e.g., BCA), and E-Wallets (e.g., GoPay).

Transaction Types: Income, Expense, Transfer (moving funds without affecting net worth).

Reconciliation Flow: A UI to input the "Actual Bank Balance". If it differs from the app's balance, generate an auto-adjustment transaction.

Debt & Receivable Manager: Dedicated section to track "Who owes me" and "Who I owe", including installment schedules.

4.4. Reports & AI Insights (Reports Tab)

Charts: Pie charts for category breakdowns, Bar charts for income vs. expense using fl_chart.

AI Insights Card: A card displaying textual AI insights fetched from the database or API (e.g., "Your GoFood expenses increased by 15%...").

Calendar View: Monthly grid highlighting days with transactions.

4.5. User Settings & Security (Profile Tab)

Uses a TabBar or nested list view to separate Identity and Security.

Section A: My Profile (Preferences)

View/Edit Profile Picture, Full Name, Nickname.

Base Currency selector (e.g., IDR, USD).

Date Format selector.

AI Tone preference (Professional, Friendly).

App Theme (Light/Dark/System).

Section B: Security

Change Password.

Two-Factor Authentication (MFA) setup via Supabase.

Session Management (View active devices, "Logout everywhere" button).

Data Export (Trigger CSV download).

Danger Zone: "Delete Account" button with explicit confirmation.

5. Dart Data Models Mapping (For AI Co-pilot)

AI Co-pilot: Generate freezed classes for the following entities that match the existing Supabase schema.

UserModel: id, email, full_name, nickname, avatar_url, base_currency, date_format, ai_tone.

AccountModel: id, user_id, name, type, balance, currency.

CategoryModel: id, user_id, name, type, icon, color.

TransactionModel: id, user_id, account_id, category_id, amount, type, date, notes, is_reconciliation.

DebtModel: id, user_id, type, counterparty_name, total_amount, remaining_amount, due_date, status.

6. AI Prompting Strategy (Development Phases)

Phase 1: Scaffolding & BaaS Connection: Initialize Flutter, set up supabase_flutter with .env credentials, and configure go_router. Build the Login/Auth screen.

Phase 2: Data Layer (Models & Repositories): Use freezed to create data models. Build Riverpod providers/repositories to perform CRUD operations directly to Supabase tables.

Phase 3: Core UI & Navigation: Build the main Scaffold with the Bottom Navigation Bar. Implement the Accounts list and Transaction history UI.

Phase 4: Input & Logic: Build the complex forms (Add Transaction, Add Debt, Reconciliation Flow) with proper validation.

Phase 5: Dashboard & Visuals: Implement the AI Pacing Widget, fl_chart for reports, and the My Profile / Security pages.