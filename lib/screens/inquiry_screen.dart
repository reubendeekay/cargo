import 'dart:convert';

import 'package:cargo/constants.dart';
import 'package:cargo/helpers/my_loader.dart';
import 'package:cargo/helpers/url_helper.dart';
import 'package:cargo/theme/app_theme.dart';
import 'package:cargo/theme/custom_theme.dart';
import 'package:cargo/widgets/my_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:http/http.dart' as http;

class EnquiryScreen extends StatefulWidget {
  const EnquiryScreen({Key? key}) : super(key: key);

  @override
  State<EnquiryScreen> createState() => _EnquiryScreenState();
}

class _EnquiryScreenState extends State<EnquiryScreen> {
  late CustomTheme customTheme;
  late ThemeData theme;

  String? phoneNumber;
  String? email;
  String? contact;
  String? name;
  String? message;
  String? inquiryOption;
  final formKey = GlobalKey<FormState>();
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.learningTheme;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: InkWell(
          onTap: () => Navigator.of(context).pop(),
          child: const Icon(
            Icons.arrow_back_ios,
            size: 18,
          ),
        ),
        title: FxText.titleMedium("Enquiry", fontWeight: 600),
      ),
      body: Form(
        key: formKey,
        child: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          children: [
            FxText.bodyLarge("User Details", fontWeight: 600, letterSpacing: 0),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: TextFormField(
                onChanged: (val) {
                  setState(() {
                    name = val;
                  });
                },
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Please enter a name";
                  }
                  return null;
                },
                style: FxTextStyle.titleSmall(
                    letterSpacing: 0,
                    color: theme.colorScheme.onBackground,
                    fontWeight: 500),
                decoration: InputDecoration(
                  hintText: "Your Name",
                  hintStyle: FxTextStyle.titleSmall(
                      letterSpacing: 0,
                      color: theme.colorScheme.onBackground,
                      fontWeight: 500),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                      borderSide: BorderSide.none),
                  enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                      borderSide: BorderSide.none),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: customTheme.card,
                  prefixIcon: const Icon(
                    Icons.person_outline,
                    size: 22,
                  ),
                  isDense: true,
                  contentPadding: const EdgeInsets.all(0),
                ),
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: TextFormField(
                onChanged: (val) {
                  setState(() {
                    email = val;
                  });
                },
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Please enter an email";
                  }
                  return null;
                },
                style: FxTextStyle.titleSmall(
                    letterSpacing: 0,
                    color: theme.colorScheme.onBackground,
                    fontWeight: 500),
                decoration: InputDecoration(
                  hintText: "Your Email",
                  hintStyle: FxTextStyle.titleSmall(
                      letterSpacing: 0,
                      color: theme.colorScheme.onBackground,
                      fontWeight: 500),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                      borderSide: BorderSide.none),
                  enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                      borderSide: BorderSide.none),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: customTheme.card,
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    size: 22,
                  ),
                  isDense: true,
                  contentPadding: const EdgeInsets.all(0),
                ),
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 16),
              child: TextFormField(
                onChanged: (val) {
                  setState(() {
                    phoneNumber = val;
                  });
                },
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Please enter a phone number";
                  }
                  return null;
                },
                style: FxTextStyle.titleSmall(
                    letterSpacing: 0,
                    color: theme.colorScheme.onBackground,
                    fontWeight: 500),
                decoration: InputDecoration(
                  hintText: "Phone number",
                  hintStyle: FxTextStyle.titleSmall(
                      letterSpacing: 0,
                      color: theme.colorScheme.onBackground,
                      fontWeight: 500),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                      borderSide: BorderSide.none),
                  enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                      borderSide: BorderSide.none),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: customTheme.card,
                  prefixIcon: const Icon(
                    Icons.phone_outlined,
                    size: 22,
                  ),
                  isDense: true,
                  contentPadding: const EdgeInsets.all(0),
                ),
                keyboardType: TextInputType.phone,
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            FxText.bodyLarge("Enquiry information",
                fontWeight: 600, letterSpacing: 0),
            const SizedBox(
              height: 5,
            ),
            MyDropDown(
                selectedOption: (val) {
                  setState(() {
                    inquiryOption = val;
                  });
                },
                hintText: 'Enquiry Type',
                options: [
                  "Complaints",
                  "Compliments",
                  "General Enquiry",
                ]),
            Container(
              margin: const EdgeInsets.only(top: 10),
              child: TextFormField(
                onChanged: (val) {
                  setState(() {
                    message = val;
                  });
                },
                validator: (val) {
                  if (val!.isEmpty) {
                    return "Please enter your message";
                  }
                  return null;
                },
                maxLength: null,
                maxLines: null,
                style: FxTextStyle.titleSmall(
                    letterSpacing: 0,
                    color: theme.colorScheme.onBackground,
                    fontWeight: 500),
                decoration: InputDecoration(
                  hintText: "Message",
                  hintStyle: FxTextStyle.titleSmall(
                      letterSpacing: 0,
                      color: theme.colorScheme.onBackground,
                      fontWeight: 500),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                      borderSide: BorderSide.none),
                  enabledBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                      borderSide: BorderSide.none),
                  focusedBorder: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(4),
                      ),
                      borderSide: BorderSide.none),
                  filled: true,
                  fillColor: customTheme.card,
                  prefixIcon: const Icon(
                    Icons.person_outline,
                    size: 22,
                  ),
                  isDense: true,
                  contentPadding: const EdgeInsets.all(0),
                ),
                textCapitalization: TextCapitalization.sentences,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            AppButton(
              child: isLoading
                  ? const MyLoader()
                  : FxText.bodyMedium(
                      'Submit',
                      color: Colors.white,
                      fontWeight: 700,
                    ),
              color: kPrimaryColor,
              onTap: inquiryOption == null
                  ? () {}
                  : () async {
                      if (formKey.currentState!.validate()) {
                        setState(() {
                          isLoading = true;
                        });
                        final statusCode = await sendEmail(name!, email!,
                            message!, inquiryOption!, phoneNumber!);
                        setState(() {
                          isLoading = false;
                        });

                        if (statusCode == 200) {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              backgroundColor: Colors.green,
                              content: FxText.bodyMedium(
                                'Your enquiry has been sent successfully',
                                color: Colors.white,
                              )));
                          Future.delayed(const Duration(seconds: 5), () {
                            Navigator.pop(context);
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: FxText.bodyMedium(
                              'Something went wrong, please try again later',
                              color: Colors.white,
                            ),
                          ));
                        }
                      }
                    },
            )
          ],
        ),
      ),
    );
  }
}

Future sendEmail(String name, String email, String message, String enquiry,
    String phone) async {
  final url = Uri.parse('https://api.emailjs.com/api/v1.0/email/send');
  const serviceId = 'service_1fxydje';
  const templateId = 'template_bfsm85v';
  const userId = 'JJi0NRWGRPp85VXCK';
  final response = await http.post(url,
      headers: {
        'Content-Type': 'application/json'
      }, //This line makes sure it works for all platforms.
      body: json.encode({
        'service_id': serviceId,
        'template_id': templateId,
        'user_id': userId,
        'template_params': {
          'name': name,
          'inquiry_option': enquiry,
          'message': message,
          'phone': phone,
          'email': email
        }
      }));
  print(response.body);

  return response.statusCode;
}
