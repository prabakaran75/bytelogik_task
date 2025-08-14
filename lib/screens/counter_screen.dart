import 'package:bytelogik_task/screens/auth/signin_screen.dart';
import 'package:bytelogik_task/services/auth_service.dart';
import 'package:bytelogik_task/services/counter_notifier.dart';
import 'package:bytelogik_task/common/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterScreen extends ConsumerWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef refs) {
    final ht = MediaQuery.of(context).size.height;
    final wd = MediaQuery.of(context).size.width;
    Future showLogoutDialog(BuildContext context) async {
      return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Confirm Logout'),
            content: const Text('Are you sure you want to log out?'),
            actions: <Widget>[
              TextButton(
                child: Text(
                  'No',
                  style: TextStyle(color: Color.fromARGB(255, 18, 63, 141)),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              TextButton(
                child: Text(
                  'Yes',
                  style: TextStyle(color: Color.fromARGB(255, 18, 63, 141)),
                ),
                onPressed: () async {
                  await AuthService().logout();
                  if (!context.mounted) return;
                  Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (_) => const SigninScreen()),
                    (route) => false,
                  );
                },
              ),
            ],
          );
        },
      );
    }

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 213, 224, 230),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 16, 73, 172),
        actions: [
          IconButton(
            onPressed: () {
              showLogoutDialog(context);
            },
            icon: Icon(Icons.logout, color: Colors.white),
          ),
        ],
        title: Text(
          "Counter Screen",
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        centerTitle: true,
      ),
      body: Stack(
        children: [
          Image.asset(
            "assets/images/bg.jpg",
            height: ht,
            width: wd,
            fit: BoxFit.cover,
          ),
          Center(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: wd * 0.035),
              child: SizedBox(
                height: ht * 0.4,
                child: Card(
                  elevation: 3.0,
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: wd * 0.02,
                      vertical: ht * 0.02,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Counter Value: ${refs.watch(initialCounterValue)}',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        SizedBox(height: ht * 0.04),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            customButton(ht, wd * 0.7, "Increment", () {
                              refs
                                  .read(initialCounterValue.notifier)
                                  .increment();
                            }),
                            SizedBox(width: wd * 0.02),
                            customButton(ht, wd * 0.7, "Decrement", () {
                              refs
                                  .read(initialCounterValue.notifier)
                                  .decrement();
                            }),
                          ],
                        ),
                        SizedBox(height: ht * 0.02),
                        customButton(ht, wd * 0.7, "Reset", () {
                          refs.read(initialCounterValue.notifier).reset();
                        }),
                        SizedBox(height: ht * 0.02),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
