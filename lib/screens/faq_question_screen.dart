import 'package:cargo/helpers/generator.dart';
import 'package:cargo/helpers/url_helper.dart';
import 'package:cargo/theme/app_theme.dart';
import 'package:cargo/theme/custom_theme.dart';

import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:url_launcher/url_launcher.dart';

class FAQQuestionScreen extends StatefulWidget {
  const FAQQuestionScreen({Key? key}) : super(key: key);

  @override
  _FAQQuestionScreenState createState() => _FAQQuestionScreenState();
}

class _FAQQuestionScreenState extends State<FAQQuestionScreen> {
  late CustomTheme customTheme;
  late ThemeData theme;

  final List<bool> _dataExpansionPanel = [false, true, false, false, false];

  late List<String> _content;

  @override
  initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
    _content = List.generate(
        5,
        (index) => Generator.getParagraphsText(
            paragraph: 2, words: 24, noOfNewLine: 2, withHyphen: true));
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
              size: 20,
            ),
          ),
          title: FxText.titleMedium("FAQ", fontWeight: 600),
        ),
        body: ListView(
          padding: const EdgeInsets.only(bottom: 20),
          children: <Widget>[
            ExpansionPanelList(
              expandedHeaderPadding: const EdgeInsets.all(0),
              expansionCallback: (int index, bool isExpanded) {
                setState(() {
                  _dataExpansionPanel[index] = !isExpanded;
                });
              },
              animationDuration: const Duration(milliseconds: 500),
              children: <ExpansionPanel>[
                ExpansionPanel(
                    canTapOnHeader: true,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: FxText.titleSmall(
                            "What is Fastgate Cargo services?",
                            color: isExpanded
                                ? theme.colorScheme.primary
                                : theme.colorScheme.onBackground,
                            fontWeight: isExpanded ? 600 : 500),
                      );
                    },
                    body: Container(
                      padding: const EdgeInsets.only(
                          bottom: 20, left: 20, right: 20),
                      child: Center(
                        child: FxText.bodyMedium(_content[0], fontWeight: 500),
                      ),
                    ),
                    isExpanded: _dataExpansionPanel[0]),
                ExpansionPanel(
                    canTapOnHeader: true,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: FxText.titleSmall("How do I track my cargo?",
                            color: isExpanded
                                ? theme.colorScheme.primary
                                : theme.colorScheme.onBackground,
                            fontWeight: isExpanded ? 600 : 500),
                      );
                    },
                    body: Container(
                      padding: const EdgeInsets.only(
                          bottom: 20, left: 20, right: 20),
                      child: Center(
                        child: FxText.bodyMedium(_content[1], fontWeight: 500),
                      ),
                    ),
                    isExpanded: _dataExpansionPanel[1]),
                ExpansionPanel(
                    canTapOnHeader: true,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: FxText.titleSmall(
                            "How can I request to be an admin?",
                            color: isExpanded
                                ? theme.colorScheme.primary
                                : theme.colorScheme.onBackground,
                            fontWeight: isExpanded ? 600 : 500),
                      );
                    },
                    body: Container(
                      padding: const EdgeInsets.only(
                          bottom: 20, left: 20, right: 20),
                      child: Center(
                        child: FxText.bodyMedium(_content[2], fontWeight: 500),
                      ),
                    ),
                    isExpanded: _dataExpansionPanel[2]),
                ExpansionPanel(
                    canTapOnHeader: true,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: FxText.titleSmall("How do i get help in app?",
                            color: isExpanded
                                ? theme.colorScheme.primary
                                : theme.colorScheme.onBackground,
                            fontWeight: isExpanded ? 600 : 500),
                      );
                    },
                    body: Container(
                      padding: const EdgeInsets.only(
                          bottom: 20, left: 20, right: 20),
                      child: Center(
                        child: FxText.titleSmall(_content[3], fontWeight: 500),
                      ),
                    ),
                    isExpanded: _dataExpansionPanel[3]),
                ExpansionPanel(
                    canTapOnHeader: true,
                    headerBuilder: (BuildContext context, bool isExpanded) {
                      return ListTile(
                        title: FxText.bodyLarge("Where is my cargo?",
                            color: isExpanded
                                ? theme.colorScheme.primary
                                : theme.colorScheme.onBackground,
                            fontWeight: isExpanded ? 600 : 500),
                      );
                    },
                    body: Container(
                      padding: const EdgeInsets.only(
                          bottom: 20, left: 20, right: 20),
                      child: Center(
                        child: FxText.bodyMedium(_content[4], fontWeight: 500),
                      ),
                    ),
                    isExpanded: _dataExpansionPanel[4]),
              ],
            ),
            Container(
              margin: const EdgeInsets.only(top: 20),
              child: InkWell(
                onTap: () async {
                  final Uri emailLaunchUri = Uri(
                    scheme: 'mailto',
                    path: 'mustafaibra643@gmail.com',
                    query: encodeQueryParameters(<String, String>{
                      'subject': 'FastGate Support Request'
                    }),
                  );
                  await launch(emailLaunchUri.toString());
                },
                child: Center(
                  child: FxText.bodyLarge("Still have questions?",
                      color: theme.colorScheme.primary, fontWeight: 600),
                ),
              ),
            )
          ],
        ));
  }
}
