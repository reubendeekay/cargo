import 'package:cached_network_image/cached_network_image.dart';
import 'package:cargo/models/branch_model.dart';
import 'package:cargo/screens/branches/add_branch_screen.dart';
import 'package:cargo/screens/branches/edit_branch_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/route_manager.dart';

class AgentBranches extends StatelessWidget {
  const AgentBranches({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: FxText.titleMedium('Branches', color: Colors.black),
        leading: InkWell(
            onTap: () {
              Get.back();
            },
            child: const Icon(Icons.arrow_back_ios,
                size: 18, color: Colors.black)),
        elevation: 0.5,
        automaticallyImplyLeading: false,
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('branches').snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: Text('No Branches yet'));
            }
            List<DocumentSnapshot> docs = snapshot.data!.docs;
            return ListView(
              children: docs
                  .map((e) => AgentBranchTile(branch: BranchModel.fromJson(e)))
                  .toList(),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddBranchScreen());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AgentBranchTile extends StatelessWidget {
  const AgentBranchTile({Key? key, required this.branch}) : super(key: key);
  final BranchModel branch;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(branch.name!),
      onTap: () {
        Get.to(() => EditBranchScreen(branch: branch));
      },
      subtitle: Text('Manager: ' + branch.managerName!),
      leading: CircleAvatar(
        backgroundColor: Colors.blue,
        backgroundImage: CachedNetworkImageProvider(branch.imageUrl!),
      ),
      trailing: InkWell(
          onTap: () {
            Get.to(() => EditBranchScreen(branch: branch));
          },
          child: const Icon(Icons.edit, size: 18)),
    );
  }
}
