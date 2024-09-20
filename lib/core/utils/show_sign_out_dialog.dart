import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../config/route/routes.dart';
import '../../features/auth/presentation/bloc/auth_bloc.dart';

void showSignoutDialog(BuildContext context) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        title: Text("Signout"),
        content: Text("Are you sure you want to signout?"),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("No"),
          ),
          TextButton(
            onPressed: () async {
              SharedPreferences prefs = await SharedPreferences.getInstance();
              await prefs.setBool('isSnackbarShown', false);

              context.read<AuthBloc>().add(SignOutButtonPressed());
              Navigator.pushNamedAndRemoveUntil(
                context,
                Routes.signInPage,
                (route) => false,
                arguments: true,
              );
            },
            child: Text("Yes"),
          )
        ],
      );
    },
  );
}
