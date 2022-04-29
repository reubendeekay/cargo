import 'package:cached_network_image/cached_network_image.dart';
import 'package:cargo/helpers/url_helper.dart';
import 'package:cargo/models/branch_model.dart';
import 'package:cargo/theme/app_theme.dart';
import 'package:cargo/theme/custom_theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:url_launcher/url_launcher.dart';

class BranchContactsScreen extends StatefulWidget {
  const BranchContactsScreen({Key? key}) : super(key: key);

  @override
  _BranchContactsScreenState createState() => _BranchContactsScreenState();
}

class _BranchContactsScreenState extends State<BranchContactsScreen> {
  late ThemeData theme;
  late CustomTheme customTheme;

  @override
  void initState() {
    super.initState();
    theme = AppTheme.theme;
    customTheme = AppTheme.customTheme;
  }

  final PageController _pageController = PageController(initialPage: 0);
  int _currentPage = 0;

  List<Widget> _buildPageIndicatorStatic(int _numPages) {
    List<Widget> list = [];
    for (int i = 0; i < _numPages; i++) {
      list.add(i == _currentPage ? _indicator(true) : _indicator(false));
    }
    return list;
  }

  Widget _indicator(bool isActive) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInToLinear,
      margin: FxSpacing.symmetric(horizontal: 4.0),
      height: 8.0,
      width: 8,
      decoration: BoxDecoration(
        color: isActive
            ? theme.colorScheme.primary
            : theme.colorScheme.primary.withAlpha(120),
        borderRadius: const BorderRadius.all(Radius.circular(4)),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    _pageController.dispose();
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
          title: FxText.titleMedium("Our Branches", fontWeight: 600),
        ),
        body: StreamBuilder<QuerySnapshot>(
            stream:
                FirebaseFirestore.instance.collection('branches').snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Container(
                    padding: FxSpacing.fromLTRB(16, 0, 16, 8),
                    height: double.infinity,
                    width: double.infinity,
                    child: Card(
                      elevation: 2,
                      color: Colors.grey[400],
                      clipBehavior: Clip.hardEdge,
                    ));
              }
              List<DocumentSnapshot> docs = snapshot.data!.docs;
              return Column(
                children: <Widget>[
                  Expanded(
                    child: PageView(
                      pageSnapping: true,
                      physics: const ClampingScrollPhysics(),
                      controller: _pageController,
                      onPageChanged: (int page) {
                        setState(() {
                          _currentPage = page;
                        });
                      },
                      children: docs
                          .map((e) => BranchContactWidget(
                              branch: BranchModel.fromJson(e)))
                          .toList(),
                    ),
                  ),
                  Container(
                    padding: FxSpacing.all(16),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: _buildPageIndicatorStatic(docs.length),
                    ),
                  ),
                ],
              );
            }));
  }
}

class BranchContactWidget extends StatelessWidget {
  final BranchModel branch;
  const BranchContactWidget({Key? key, required this.branch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);
    final Uri emailLaunchUri = Uri(
      scheme: 'mailto',
      path: branch.email,
      query: encodeQueryParameters(<String, String>{'subject': 'Hello, '}),
    );
    return Container(
      padding: FxSpacing.fromLTRB(16, 0, 16, 8),
      child: Card(
        elevation: 2,
        clipBehavior: Clip.hardEdge,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Expanded(
              child: Image(
                  image: CachedNetworkImageProvider(branch.imageUrl!),
                  fit: BoxFit.fill),
            ),
            Container(
              padding: FxSpacing.fromLTRB(24, 24, 16, 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FxText.headlineSmall(
                    branch.name!.toUpperCase(),
                    fontWeight: 700,
                  ),
                  FxSpacing.height(16),
                  FxText.bodyLarge(branch.address!, fontWeight: 500),
                  FxText.titleSmall(branch.email!, fontWeight: 500),
                  FxText.titleSmall('Manager: ' + branch.managerName!,
                      fontWeight: 500),
                  FxSpacing.height(24),
                  Center(
                    child: FxButton(
                        elevation: 0,
                        borderRadiusAll: 4,
                        onPressed: () async {
                          await launch(emailLaunchUri.toString());
                        },
                        child: FxText.bodyMedium(("Contact " + branch.name!),
                            color: themeData.colorScheme.onSecondary,
                            letterSpacing: 0.2)),
                  ),
                ],
              ),
            )
          ],
        ),
        margin: FxSpacing.all(0),
      ),
    );
  }
}
