import 'package:cargo/constants.dart';
import 'package:cargo/helpers/my_loader.dart';
import 'package:cargo/providers/auth_provider.dart';
import 'package:cargo/screens/agent/admin_dashboard.dart';
import 'package:cargo/screens/agent/dashboard/agent_dashboard.dart';
import 'package:cargo/screens/auth/tracking_text_input.dart';
import 'package:cargo/theme/app_theme.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/route_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'login_controller.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  _LogInScreenState createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen>
    with TickerProviderStateMixin {
  late ThemeData theme;
  late LogInController controller;
  late OutlineInputBorder outlineInputBorder;
  bool isLoading = false;
  bool isShown = false;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.theme;

    controller = FxControllerStore.putOrFind(LogInController());
    outlineInputBorder = const OutlineInputBorder(
      borderRadius: BorderRadius.all(Radius.circular(4)),
      borderSide: BorderSide(
        color: Colors.transparent,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return FxBuilder<LogInController>(
        controller: controller,
        builder: (controller) {
          return Scaffold(
            appBar: AppBar(
              elevation: 0,
              backgroundColor: kPrimaryColor,
              leading: InkWell(
                onTap: () => Navigator.of(context).pop(),
                child: const Icon(
                  Icons.arrow_back_ios,
                  size: 20,
                  color: Colors.white,
                ),
              ),
            ),
            body: Container(
              decoration: const BoxDecoration(
                  gradient: LinearGradient(
                      colors: [Colors.black, kPrimaryColor],
                      begin: Alignment.bottomCenter,
                      end: Alignment.topCenter)),
              child: Form(
                key: controller.formKey,
                child: ListView(
                  padding: FxSpacing.fromLTRB(
                      20, FxSpacing.safeAreaTop(context), 20, 20),
                  children: [
                    SizedBox(
                      height: size.height * 0.1,
                    ),
                    Image.asset(
                      'assets/images/logo.png',
                      height: 80,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Center(
                      child: Text(
                        "Agent/Admin Login",
                        style: GoogleFonts.notoSans(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    Center(
                      child: Text('Please enter your credentials to continue',
                          style: GoogleFonts.notoSans(
                              color: Colors.white,
                              fontSize: 12,
                              fontWeight: FontWeight.w400)),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    FxSpacing.height(20),
                    TrackingTextInput(
                      style: FxTextStyle.bodyMedium(),
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: true,
                          isDense: true,
                          fillColor: theme.cardTheme.color,
                          prefixIcon: Icon(
                            Icons.mail_outline,
                            color: theme.colorScheme.onBackground,
                          ),
                          hintText: "Email Address",
                          enabledBorder: outlineInputBorder,
                          focusedBorder: outlineInputBorder,
                          border: outlineInputBorder,
                          contentPadding: FxSpacing.all(16),
                          hintStyle: FxTextStyle.bodyMedium(),
                          isCollapsed: true),
                      controller: controller.emailTE,
                      validator: controller.validateEmail,
                      cursorColor: theme.colorScheme.onBackground,
                      focusNode: controller.emailNode,
                      onCaretMoved: (offset) {
                        controller.onCaretMoved(offset);
                      },
                    ),
                    FxSpacing.height(20),
                    TrackingTextInput(
                      style: FxTextStyle.bodyMedium(),
                      isObscured: !isShown,
                      decoration: InputDecoration(
                          floatingLabelBehavior: FloatingLabelBehavior.never,
                          filled: true,
                          isDense: true,
                          fillColor: theme.cardTheme.color,
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: theme.colorScheme.onBackground,
                          ),
                          suffixIcon: InkWell(
                              onTap: () {
                                setState(() {
                                  isShown = !isShown;
                                });
                              },
                              child: Icon(
                                isShown
                                    ? Icons.visibility_off_outlined
                                    : Icons.remove_red_eye_outlined,
                              )),
                          hintText: "Password",
                          enabledBorder: outlineInputBorder,
                          focusedBorder: outlineInputBorder,
                          border: outlineInputBorder,
                          contentPadding: FxSpacing.all(16),
                          hintStyle: FxTextStyle.bodyMedium(),
                          isCollapsed: true),
                      controller: controller.passwordTE,
                      focusNode: controller.passwordNode,
                      validator: controller.validatePassword,
                      cursorColor: theme.colorScheme.onBackground,
                    ),
                    FxSpacing.height(20),
                    FxButton.block(
                      elevation: 0,
                      borderRadiusAll: 4,
                      style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 15),
                          backgroundColor: kPrimaryColor),
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        try {
                          await controller.login();
                          await Provider.of<AuthProvider>(context,
                                  listen: false)
                              .getUser(uid);
                          Get.off(() => const AdminDashboard());
                        } catch (e) {
                          setState(() {
                            isLoading = false;
                          });
                          Get.snackbar('Error', e.toString(),
                              backgroundColor: theme.colorScheme.error,
                              colorText: theme.colorScheme.onError);
                        }
                      },
                      splashColor: theme.colorScheme.onPrimary.withAlpha(28),
                      backgroundColor: theme.colorScheme.primary,
                      child: isLoading
                          ? const MyLoader()
                          : FxText.labelMedium(
                              "Sign In",
                              fontWeight: 600,
                              color: theme.colorScheme.onPrimary,
                              letterSpacing: 0.4,
                            ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
