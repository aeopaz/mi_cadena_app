import 'package:go_router/go_router.dart';
import 'package:mi_cadena_app/screens/auth/forgot_password_screen.dart';
import 'package:mi_cadena_app/screens/auth/login_screen.dart';
import 'package:mi_cadena_app/screens/auth/register_screen.dart';
import 'package:mi_cadena_app/screens/auth/reset_password_screen.dart';
import 'package:mi_cadena_app/screens/auth/verify_email_screen.dart';
import 'package:mi_cadena_app/screens/chains/chain_detail.dart';
import 'package:mi_cadena_app/screens/chains/create_chain_screen.dart';
import 'package:mi_cadena_app/screens/chains/dashboard_screen.dart';
import 'package:mi_cadena_app/screens/notifications/notifications.dart';
import 'package:mi_cadena_app/screens/profile/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';

// GoRouter configuration
final router = GoRouter(
  routes: [
    GoRoute(
        name: 'login',
        path: '/',
        builder: (context, state) => LoginScreen(),
        redirect: (context, state) async {
          try {
            SharedPreferences prefs = await SharedPreferences.getInstance();
            if (prefs.getString('token') != null) {
              return '/chain';
            }
            return null;
          } catch (e) {
            return null;
          }
        },
        routes: [
          GoRoute(
            name: 'register',
            path: 'register',
            builder: (context, state) => RegisterScreen(),
          ),
          GoRoute(
              name: 'forgot_password',
              path: 'forgot_password',
              builder: (context, state) => ForgotPasswordScreen(),
              routes: [
                GoRoute(
                  name: 'reset_password',
                  path: 'reset_password',
                  builder: (context, state) => ResetPasswordScreen(),
                ),
              ]),
        ]),
    GoRoute(
      name: 'verify_email',
      path: '/verify_email',
      builder: (context, state) => VerifyEmailScreen(),
    ),
    GoRoute(
        path: '/chain',
        name: 'dashboard',
        builder: (context, state) => DashboardScreen(),
        routes: [
          GoRoute(
            path: 'create_chain',
            name: 'create_chain',
            builder: (context, state) => CreateChainScreen(),
          ),
          GoRoute(
            path: 'chain_detail',
            name: 'chain_detail',
            builder: (context, state) => SavingsChainDetailsScreen(),
          ),
          GoRoute(
            path: 'notifications',
            name: 'notifications',
            builder: (context, state) => NotificationsScreen(),
          ),
          GoRoute(
            path: 'profile',
            name: 'profile',
            builder: (context, state) => ProfileScreen(),
          )
        ])
  ],
);
