import 'package:cargo/providers/auth_provider.dart';
import 'package:cargo/screens/agent/dashboard.dart';
import 'package:cargo/widgets/logo.dart';
import 'package:cargo/widgets/my_border_widget.dart';
import 'package:cargo/widgets/my_text_field.dart';
import 'package:cargo/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class AgentLogin extends StatefulWidget {
  const AgentLogin({Key? key}) : super(key: key);

  @override
  State<AgentLogin> createState() => _AgentLoginState();
}

class _AgentLoginState extends State<AgentLogin> {
  String? username;

  String? password;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Icon(Icons.person),
            SizedBox(width: 10),
            Text('Agent Login'),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: Column(
        children: [
          const Center(child: Logo()),
          MyBorderWidget(
            child: Column(
              children: [
                myTextField(
                    hint: 'Username',
                    onChanged: (val) {
                      setState(() {
                        username = val;
                      });
                    }),
                const SizedBox(
                  height: 20,
                ),
                myTextField(
                    hint: 'Password',
                    onChanged: (val) {
                      setState(() {
                        password = val;
                      });
                    }),
                const SizedBox(
                  height: 20,
                ),
                PrimaryButton(
                  onPressed: () async {
                    setState(() {
                      isLoading = true;
                    });
                    try {
                      await Provider.of<AuthProvider>(context, listen: false)
                          .signIn(username!, password!);

                      setState(() {
                        isLoading = false;
                      });
                      Get.to(() => const Dashboard());
                    } catch (e) {
                      setState(() {
                        isLoading = false;
                      });
                      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text('Invalid Credentials'),
                      ));
                    }
                  },
                  buttonText: isLoading ? '......' : 'Login',
                  hintText: 'Booking/Rate Request/ Track Your Cargo/Alerts',
                  icon: Icons.lock_open,
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
