import 'package:cargo/constants.dart';
import 'package:cargo/helpers/lists.dart';
import 'package:cargo/widgets/logo.dart';
import 'package:cargo/widgets/my_border_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class Dashboard extends StatelessWidget {
  const Dashboard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: const [
            Icon(Icons.laptop),
            SizedBox(width: 10),
            Text('Dashboard'),
          ],
        ),
        automaticallyImplyLeading: false,
      ),
      body: ListView(
        children: [
          const Center(child: Logo()),
          MyBorderWidget(
            child: GridView.count(
              padding: EdgeInsets.zero,
              shrinkWrap: true,
              crossAxisCount: 2,
              crossAxisSpacing: 30.0,
              mainAxisSpacing: 30.0,
              childAspectRatio: 1,
              physics: const NeverScrollableScrollPhysics(),
              children: List.generate(
                  5,
                  (i) => GestureDetector(
                        onTap: () {
                          Get.to(() => dashboardWidgets[i]);
                        },
                        child: Column(
                          children: [
                            Expanded(
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(8),
                                    gradient: LinearGradient(
                                        colors: [
                                          kPrimaryColor.withOpacity(0.9),
                                          kPrimaryColor,
                                        ],
                                        begin: Alignment.topRight,
                                        end: Alignment.bottomLeft)),
                                padding: const EdgeInsets.all(10),
                                child: Center(
                                    child: Icon(dashboardIcons[i],
                                        size: 50, color: Colors.white)),
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            Text(dashboardTitles[i]),
                          ],
                        ),
                      )),
            ),
          )
        ],
      ),
    );
  }
}
