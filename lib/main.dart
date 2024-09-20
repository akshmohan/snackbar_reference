import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test_practice/config/route/routes.dart';
import 'package:machine_test_practice/core/bloc/logged_in_cubit/logged_in_cubit.dart';
import 'package:machine_test_practice/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:machine_test_practice/features/auth/presentation/pages/sign_in_page.dart';
import 'package:machine_test_practice/features/home/presentation/pages/home_page.dart';
import 'package:machine_test_practice/init_dependencies.dart';
import 'core/bloc/providers/bloc_providers.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initDependencies();
  runApp(MultiBlocProvider(
    providers: BlocProviders.providers,
    child: const MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    super.initState();

    context.read<AuthBloc>().add(IsLoggedIn());
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      routes: Routes.route,
      home: BlocSelector<LoggedInCubit, LoggedInState, bool>(
        selector: (state) {
          return state is UserLoggedIn;
        },
        builder: (context, state) {
          if (state) {
            return HomePage();
          }
          return const SignInPage(fromSplash: true);
        },
      ),
    );
  }
}
