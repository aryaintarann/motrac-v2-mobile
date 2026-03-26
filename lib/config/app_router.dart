import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../screens/auth/login_screen.dart';
import '../screens/main_shell.dart';
import '../screens/home/home_screen.dart';
import '../screens/accounts/accounts_screen.dart';
import '../screens/accounts/add_transaction_screen.dart';
import '../screens/accounts/reconciliation_screen.dart';
import '../screens/accounts/debt_manager_screen.dart';
import '../screens/reports/reports_screen.dart';
import '../screens/reports/calendar_screen.dart';
import '../screens/profile/profile_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/home',
    redirect: (context, state) {
      final session = Supabase.instance.client.auth.currentSession;
      final isLoggedIn = session != null;
      final isLoginRoute = state.matchedLocation == '/login';

      if (!isLoggedIn && !isLoginRoute) {
        return '/login';
      }
      if (isLoggedIn && isLoginRoute) {
        return '/home';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => MainShell(child: child),
        routes: [
          GoRoute(
            path: '/home',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: HomeScreen(),
            ),
          ),
          GoRoute(
            path: '/accounts',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: AccountsScreen(),
            ),
            routes: [
              GoRoute(
                path: 'add-transaction',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => const AddTransactionScreen(),
              ),
              GoRoute(
                path: 'reconcile',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => const ReconciliationScreen(),
              ),
              GoRoute(
                path: 'debts',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => const DebtManagerScreen(),
              ),
            ],
          ),
          GoRoute(
            path: '/reports',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ReportsScreen(),
            ),
            routes: [
              GoRoute(
                path: 'calendar',
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => const CalendarScreen(),
              ),
            ],
          ),
          GoRoute(
            path: '/profile',
            pageBuilder: (context, state) => const NoTransitionPage(
              child: ProfileScreen(),
            ),
          ),
        ],
      ),
    ],
  );
});
