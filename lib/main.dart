import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tujuane_app/SCREENS/home/home.dart';
import 'package:tujuane_app/SCREENS/matches/matches.dart';
import 'package:tujuane_app/repositories/auth/auth_repository.dart';
import 'package:tujuane_app/repositories/database/database_repository.dart';
import 'package:tujuane_app/repositories/storage/storage_repository.dart';

import 'SCREENS/landingScreen.dart';
import 'blocs/auth/auth_bloc.dart';
import 'blocs/onboarding/onboarding_bloc.dart';
import 'blocs/profile/profile_bloc.dart';
import 'blocs/swipe/swipe_bloc.dart';
import 'config/app_router.dart';
import 'config/theme.dart';
import 'cubits/signup/signup_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiRepositoryProvider(
      providers: [
        RepositoryProvider(
          create: (context) => AuthRepository(),
        ),
        RepositoryProvider(
          create: (context) => DatabaseRepository(),
        ),
        RepositoryProvider(
          create: (context) => StorageRepository(),
        ),
      ],
      child: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => AuthBloc(
              authRepository: context.read<AuthRepository>(),
            ),
          ),
          BlocProvider<SignupCubit>(
            create: (context) =>
                SignupCubit(authRepository: context.read<AuthRepository>()),
          ),
          BlocProvider<OnboardingBloc>(
            create: (context) => OnboardingBloc(
              databaseRepository: context.read<DatabaseRepository>(),
              storageRepository: context.read<StorageRepository>(),
            ),
          ),
          BlocProvider(
              create: (context) => SwipeBloc(
                authBloc: BlocProvider.of<AuthBloc>(context),
                databaseRepository: context.read<DatabaseRepository>(),
              )
            //BlocProvider.of<AuthBloc>(context).state.user!.uid),
          ),
          BlocProvider(
            create: (context) => ProfileBloc(
              authBloc: BlocProvider.of<AuthBloc>(context),
              databaseRepository: context.read<DatabaseRepository>(),
            )..add(
              LoadProfile(
                  userId: BlocProvider.of<AuthBloc>(context).state.user!.uid),
            ),
          ),
        ],
        child: MaterialApp(
          title: 'TUJUANE',
          debugShowCheckedModeBanner: false,
          theme: theme(),
          onGenerateRoute: AppRouter.onGenerateRoute,
          initialRoute: SplashScreen.routeName,
        ),
      ),
    );
  }
}
