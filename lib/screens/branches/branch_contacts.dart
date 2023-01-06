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
  const BranchContactsScreen({Key? key, required this.branches})
      : super(key: key);
  final List<BranchModel> branches;

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
            children: widget.branches
                .map((e) => BranchContactWidget(branch: e))
                .toList(),
          ),
        ),
        Container(
          padding: FxSpacing.all(16),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: _buildPageIndicatorStatic(widget.branches.length),
          ),
        ),
      ],
    );
  }
}

class BranchContactWidget extends StatelessWidget {
  final BranchModel branch;
  const BranchContactWidget({Key? key, required this.branch}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData themeData = Theme.of(context);

    return Container(
      padding: FxSpacing.fromLTRB(16, 0, 16, 8),
      child: Card(
        elevation: 2,
        clipBehavior: Clip.hardEdge,
        margin: FxSpacing.all(0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image(
                image: CachedNetworkImageProvider(branch.imageUrl!),
                fit: BoxFit.cover,
                width: double.infinity,
              ),
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
                  FxText.titleSmall('Manager: ${branch.managerName!}',
                      fontWeight: 500),
                  FxSpacing.height(24),
                  Center(
                    child: FxButton(
                        elevation: 0,
                        borderRadiusAll: 4,
                        onPressed: () async {
                          final phone = branch.phoneNumber!
                              .replaceAll(' ', '')
                              .replaceAll('+', '');

                          await launchUrl(Uri.parse(
                              'whatsapp://send?phone="+$phone+"&text=hello;'));
                        },
                        child: FxText.bodyMedium(("Contact ${branch.name!}"),
                            color: themeData.colorScheme.onSecondary,
                            letterSpacing: 0.2)),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
