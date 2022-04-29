import 'package:cargo/screens/branches/agent_branches.dart';
import 'package:cargo/screens/agent/widgets/directory_screen.dart';
import 'package:cargo/screens/agent/dashboard/widgets/dashboard_tile_model.dart';
import 'package:cargo/screens/agent/dashboard/widgets/DbImages.dart';
import 'package:cargo/screens/agent/add_booking.dart';
import 'package:cargo/screens/agent/users/agents_screen.dart';
import 'package:cargo/screens/notifications/notifications_screen.dart';
import 'package:cargo/screens/tracking/cargo_tracking_screen.dart';
import 'package:get/route_manager.dart';

import 'DbColors.dart';

List<DashboardTileModel> getDashboardTiles() {
  List<DashboardTileModel> list = [];

  var category1 = DashboardTileModel();
  category1.name = "Post";
  category1.color = db4_cat_1;
  category1.icon = db4_paperplane;
  category1.onTap = () => Get.to(() => const AddBookingScreen());

  list.add(category1);
  var category2 = DashboardTileModel();
  category2.name = "Tracking";
  category2.color = db4_cat_2;
  category2.icon = db4_wallet;
  category2.onTap = () => Get.to(() => const CargoTrackingScreen(
        isAgent: true,
      ));

  list.add(category2);
  var category3 = DashboardTileModel();
  category3.name = "Agents";
  category3.color = db4_cat_3;
  category3.icon = db4_coupon;
  category3.onTap = () => Get.to(() => const AgentsManagement());

  list.add(category3);
  var category4 = DashboardTileModel();
  category4.name = "Directory";
  category4.color = db4_cat_4;
  category4.icon = db4_invoice;
  category4.onTap = () => Get.to(() => const CargoDirectory());

  list.add(category4);

  var category5 = DashboardTileModel();
  category5.name = "Notifications";
  category5.color = db4_cat_5;
  category5.icon = db4_dollar_exchange;
  category5.onTap = () => Get.to(() => const NotificationsScreen());

  list.add(category5);

  var category = DashboardTileModel();
  category.name = "Branches";
  category.color = db4_cat_6;
  category.icon = db4_circle;
  category.onTap = () => Get.to(() => const AgentBranches());

  list.add(category);
  return list;
}
