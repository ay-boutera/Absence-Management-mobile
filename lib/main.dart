import 'package:abs/config/theme/theme_cubit.dart';
import 'package:abs/features/auth/cubit/auth_cubit.dart';
import 'package:abs/features/home/cubit/home_cubit.dart';
import 'package:abs/injection/injection_container.dart';
import 'package:abs/l10n/locale_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:abs/features/notifications/cubit/notification_cubit.dart';
import 'app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await newMethod();

  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(create: (_) => sl<AuthCubit>()..initApp()),
        BlocProvider<LocaleCubit>(create: (_) => sl<LocaleCubit>()),
        BlocProvider<ThemeCubit>(create: (_) => sl<ThemeCubit>()),
        BlocProvider(
          create: (context) => sl<HomeCubit>()..fetchMySessions(),
          child: const MyApp(),
        ),
        BlocProvider<NotificationCubit>(
          create: (_) => sl<NotificationCubit>()..loadNotifications(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

Future<void> newMethod() => init();
