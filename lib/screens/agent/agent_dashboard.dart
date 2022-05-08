import 'package:cached_network_image/cached_network_image.dart';
import 'package:cargo/providers/auth_provider.dart';
import 'package:cargo/screens/agent/dashboard/widgets/dashboard_data.dart';
import 'package:cargo/screens/agent/dashboard/widgets/dashboard_tile_model.dart';
import 'package:cargo/screens/agent/users/agent_profile.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:cargo/screens/agent/dashboard/widgets/Db4Widget.dart';
import 'package:cargo/screens/agent/dashboard/widgets/DbColors.dart';
import 'package:cargo/screens/agent/dashboard/widgets/DbConstant.dart';
import 'package:get/route_manager.dart';
import 'package:provider/provider.dart';

class AgentDashboard extends StatefulWidget {
  const AgentDashboard({Key? key}) : super(key: key);

  @override
  AgentDashboardState createState() => AgentDashboardState();
}

class AgentDashboardState extends State<AgentDashboard> {
  bool passwordVisible = false;
  bool isRemember = false;
  var currentIndexPage = 0;
  List<DashboardTileModel>? dashboardTiles;
  List<Db4Slider>? mSliderList;

  @override
  void initState() {
    super.initState();
    passwordVisible = false;
    dashboardTiles = getDashboardTiles();
    mSliderList = [];
  }

  void changeSldier(int index) {
    setState(() {
      currentIndexPage = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    width = width - 50;
    final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
    Provider.of<AuthProvider>(context).getUser(uid);

    final user = Provider.of<AuthProvider>(context, listen: false).user;
    return Scaffold(
      backgroundColor: db4_colorPrimary,
      key: _scaffoldKey,
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              height: 70,
              margin: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  GestureDetector(
                    onTap: () {
                      Get.to(() => const AgentProfile());
                    },
                    child: Row(
                      children: <Widget>[
                        CircleAvatar(
                          backgroundImage:
                              CachedNetworkImageProvider(user!.profilePic!),
                          radius: 25,
                        ),
                        const SizedBox(width: 16),
                        text(user.fullName!,
                            textColor: db4_white,
                            fontSize: textSizeNormal,
                            fontFamily: fontMedium)
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              padding: const EdgeInsets.only(top: 100),
              child: Container(
                padding: const EdgeInsets.only(top: 28),
                alignment: Alignment.topLeft,
                height: MediaQuery.of(context).size.height - 100,
                decoration: const BoxDecoration(
                    color: db4_LayoutBackgroundWhite,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(24),
                        topRight: Radius.circular(24))),
                child: Column(
                  children: <Widget>[
                    const SizedBox(height: 20),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(24.0),
                        child: MyGridView(dashboardTiles!, false),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ignore: must_be_immutable
class MyGridView extends StatelessWidget {
  List<DashboardTileModel> dashboardList;
  var isScrollable = false;

  MyGridView(this.dashboardList, this.isScrollable, {Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var width = MediaQuery.of(context).size.width;
    final user = Provider.of<AuthProvider>(context, listen: false).user;
    return GridView.builder(
        scrollDirection: Axis.vertical,
        physics: isScrollable
            ? const ScrollPhysics()
            : const NeverScrollableScrollPhysics(),
        itemCount: dashboardList.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3, crossAxisSpacing: 16, mainAxisSpacing: 16),
        itemBuilder: (BuildContext context, int index) {
          return InkWell(
            onTap: () {
              if (user!.role?.toLowerCase() != 'agent') {
                dashboardList[index].onTap!();
              }

              if (user.role?.toLowerCase() == 'agent' && index == 1) {
                dashboardList[index].onTap!();
              }
            },
            child: Container(
              alignment: Alignment.center,
              decoration: boxDecoration(
                  radius: 10, showShadow: true, bgColor: db4_white),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Container(
                    height: width / 7.5,
                    width: width / 7.5,
                    margin: const EdgeInsets.only(bottom: 4, top: 8),
                    padding: EdgeInsets.all(width / 30),
                    decoration: boxDecoration(
                        bgColor:
                            user!.role?.toLowerCase() == 'agent' && index != 1
                                ? Colors.grey
                                : dashboardList[index].color!,
                        radius: 10),
                    child: SvgPicture.asset(
                      dashboardList[index].icon,
                      color: db4_white,
                    ),
                  ),
                  text(dashboardList[index].name, fontSize: textSizeSMedium)
                ],
              ),
            ),
          );
        });
  }
}
