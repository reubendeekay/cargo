import 'package:cargo/helpers/cached_image.dart';
import 'package:cargo/models/user_model.dart';
import 'package:cargo/screens/agent/users/add_agent_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:get/route_manager.dart';
import 'package:http/http.dart' as http;

class AgentsManagement extends StatelessWidget {
  const AgentsManagement({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 18,
          ),
        ),
        title: FxText.titleMedium("Agents Management", fontWeight: 600),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance
              .collection('users')
              .orderBy(
                'createdAt',
              )
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasError) {
              return Center(
                child: FxText.titleMedium(
                  'Error: ${snapshot.error}',
                  color: Colors.red,
                ),
              );
            }

            if (!snapshot.hasData) {
              return Center(
                child: FxText.titleMedium(
                  'No Agents yet',
                  color: Colors.grey,
                ),
              );
            }
            List<DocumentSnapshot> docs = snapshot.data!.docs;
            if (docs.isEmpty) {
              return Center(
                child: FxText.titleMedium(
                  'No Agents yet',
                  color: Colors.grey,
                ),
              );
            }

            return ListView(
              physics: const BouncingScrollPhysics(),
              children: List.generate(docs.length,
                  (index) => AgentCard(user: UserModel.fromJson(docs[index]))),
            );
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(() => const AddAgentScreen());
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}

class AgentCard extends StatelessWidget {
  const AgentCard({Key? key, required this.user}) : super(key: key);
  final UserModel user;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 10),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: size.width * 0.25,
            height: 100,
            child: cachedImage(
              user.profilePic!,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                detail(Icons.person_outline, user.fullName!),
                const SizedBox(
                  height: 5,
                ),
                detail(Icons.email_outlined, user.email!),
                const SizedBox(
                  height: 5,
                ),
                detail(Icons.phone, user.phoneNumber!),
                const SizedBox(
                  height: 5,
                ),
                detail(Icons.apartment_outlined, user.branch!),
                const SizedBox(
                  height: 5,
                ),
              ],
            ),
          ),
          PopupMenuButton(
            icon: const Icon(Icons.more_vert),
            onSelected: (i) async {
              if (i == 0) {
                final res = await http.post(
                    Uri.parse(
                        'https://us-central1-cargo-9420a.cloudfunctions.net/deleteUser'),
                    body: {
                      'uid': user.userId,
                    });

                if (res.statusCode == 200) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.green,
                      content: FxText.titleMedium(
                        'User deleted successfully',
                        color: Colors.white,
                      )));
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      backgroundColor: Colors.red,
                      content: FxText.titleMedium(
                        'Error deleting user',
                        color: Colors.white,
                      )));
                }
              }
            },
            itemBuilder: (i) {
              return [
                PopupMenuItem(
                  value: 0,
                  child: FxText.titleMedium(
                    'Delete',
                    color: Colors.red,
                  ),
                ),
              ];
            },
          )
        ],
      ),
    );
  }

  Widget detail(IconData icon, String value) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
        ),
        const SizedBox(
          width: 5,
        ),
        Text(
          value,
        )
      ],
    );
  }
}
