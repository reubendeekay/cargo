import 'package:cargo/constants.dart';
import 'package:cargo/helpers/my_loader.dart';
import 'package:cargo/providers/auth_provider.dart';
import 'package:cargo/screens/agent/dashboard/agent_dashboard.dart';
import 'package:cargo/screens/auth/tracking_text_input.dart';
import 'package:cargo/theme/app_theme.dart';
import 'package:flare_flutter/flare_actor.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/route_manager.dart';
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
    return FxBuilder<LogInController>(
        controller: controller,
        builder: (controller) {
          return Scaffold(
            body: ListView(
              padding: FxSpacing.fromLTRB(
                  20, FxSpacing.safeAreaTop(context) + 64, 20, 20),
              children: [
                Container(
                    height: 200,
                    padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                    child: FlareActor(
                      "assets/teddy.flr",
                      shouldClip: false,
                      alignment: Alignment.bottomCenter,
                      fit: BoxFit.contain,
                      controller: controller.teddyController,
                    )),
                Form(
                  key: controller.formKey,
                  child: FxContainer.bordered(
                    color: theme.colorScheme.background,
                    child: Column(
                      children: [
                        FxText.headlineSmall(
                          'Hello Again!',
                          fontWeight: 700,
                          textAlign: TextAlign.center,
                        ),
                        FxSpacing.height(20),
                        TrackingTextInput(
                          style: FxTextStyle.bodyMedium(),
                          decoration: InputDecoration(
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
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
                              floatingLabelBehavior:
                                  FloatingLabelBehavior.never,
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
                              Get.off(() => const AgentDashboard());
                            } catch (e) {
                              setState(() {
                                isLoading = false;
                              });
                              Get.snackbar('Error', e.toString(),
                                  backgroundColor: theme.colorScheme.error,
                                  colorText: theme.colorScheme.onError);
                            }
                          },
                          splashColor:
                              theme.colorScheme.onPrimary.withAlpha(28),
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
              ],
            ),
          );
        });
  }
}
