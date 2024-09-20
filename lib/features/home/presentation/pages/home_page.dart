import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:machine_test_practice/core/bloc/selected_cubit/selected_cubit.dart';
import 'package:machine_test_practice/features/home/presentation/pages/data_screen.dart';
import 'package:machine_test_practice/features/home/presentation/pages/profile_screen.dart';
import '../../../../core/utils/check_and_show_snackbar.dart';
import '../../../../core/utils/show_sign_out_dialog.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    signInSuccessSnackbar(context, "Sign in was successful");
    super.initState();
  }

  final List<Widget> _pages = [
    ProfileScreen(),
    DataScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Page"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                showSignoutDialog(context);
              },
              icon: Icon(Icons.logout))
        ],
      ),
      body: BlocConsumer<SelectedCubit, SelectedState>(
        listener: (context, state) {},
        builder: (context, state) {
          if (state is SelectedInitial) {
            return _pages[state.index];
          }
          return _pages[0];
        },
      ),
      bottomNavigationBar: BlocBuilder<SelectedCubit, SelectedState>(
        builder: (context, state) {
          int currentIndex = 0;
          if (state is SelectedInitial) {
            currentIndex = state.index;
          }
          return BottomNavigationBar(
            onTap: (index) => context.read<SelectedCubit>().onSelection(index),
            currentIndex: currentIndex,
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_circle), label: "Profile"),
              BottomNavigationBarItem(
                  icon: Icon(Icons.account_tree_outlined), label: "Data")
            ],
          );
        },
      ),
    );
  }
}
