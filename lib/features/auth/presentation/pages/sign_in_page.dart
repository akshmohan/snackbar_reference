import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test_practice/core/internet/connection_checker.dart';
import 'package:machine_test_practice/core/utils/show_snackbar.dart';
import 'package:machine_test_practice/core/widgets/loader.dart';
import 'package:machine_test_practice/features/auth/presentation/widgets/auth_button.dart';
import 'package:machine_test_practice/features/auth/presentation/widgets/auth_field.dart';
import 'package:machine_test_practice/init_dependencies.dart';
import '../../../../config/route/routes.dart';
import '../bloc/auth_bloc.dart';

class SignInPage extends StatefulWidget {
  final bool fromSplash;

  const SignInPage({
    super.key,
    required this.fromSplash,
  });

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  late final ConnectionChecker _connectionChecker;

  @override
  void initState() {
    super.initState();
    _connectionChecker = serviceLocator<ConnectionChecker>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      final fromSignout = ModalRoute.of(context)?.settings.arguments as bool?;
      if (fromSignout == true) {
        showSnackbar(context, "You have been signed out!");
      }
    });
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthBloc, AuthState>(
      listener: (context, state) {
        if (state is AuthFailure && widget.fromSplash != true) {
          showSnackbar(context, state.message);
        }
        if (state is AuthSuccess) {
          Navigator.pushNamedAndRemoveUntil(
              context, Routes.homePage, (route) => false);
        }
      },
      builder: (context, state) {
        if (state is AuthLoading) {
          return const Loader();
        }
        return Scaffold(
          appBar: AppBar(
            title: Text("Sign In Page"),
            centerTitle: true,
          ),
          body: Center(
            child: Padding(
              padding: const EdgeInsets.all(40.0),
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AuthField(
                        hintText: "Enter email", controller: emailController),
                    SizedBox(height: 40),
                    AuthField(
                        hintText: "Enter password",
                        controller: passwordController),
                    SizedBox(height: 80),
                    AuthButton(
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            bool isConnected =
                                await _connectionChecker.isInternetConnected;
                            if (!isConnected) {
                              showSnackbar(context, "NO INTERNET CONNECTION!");
                              return;
                            }
                            context.read<AuthBloc>().add(SignInButtonPressed(
                                  email: emailController.text.trim(),
                                  password: passwordController.text.trim(),
                                ));
                          }
                        },
                        buttonText: "Sign In")
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
