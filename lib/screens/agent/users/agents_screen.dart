import 'package:cached_network_image/cached_network_image.dart';
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
        elevation: 0.5,
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(
            Icons.arrow_back_ios,
            size: 18,
          ),
        ),
        title: FxText.titleMedium("Agents Management", fontWeight: 600),
      ),
      backgroundColor: Colors.grey[100],
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
      margin: const EdgeInsets.symmetric(vertical: 1, horizontal: 5),
      padding: EdgeInsets.all(10),
      color: Colors.white,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            radius: 30,
            backgroundImage: CachedNetworkImageProvider(
              user.profilePic!,
            ),
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                detail(Icons.person_outline, user.fullName!,
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                    )),
                const SizedBox(
                  height: 5,
                ),
                detail(Icons.email_outlined, user.email!,
                    textStyle:
                        TextStyle(fontSize: 12, color: Colors.grey[800])),
                const SizedBox(
                  height: 2,
                ),
                detail(Icons.location_on_rounded, user.branch!,
                    textStyle:
                        const TextStyle(fontSize: 10, color: Colors.grey)),
              ],
            ),
          ),
          Column(
            children: [
              Container(
                width: 70,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                    color: Colors.green[100],
                    borderRadius: BorderRadius.circular(30)),
                child: const Center(
                  child: Text(
                    'Call',
                    style: TextStyle(color: Colors.green, fontSize: 10),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Container(
                width: 70,
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                decoration: BoxDecoration(
                    color: Colors.red[100],
                    borderRadius: BorderRadius.circular(30)),
                child: const Center(
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Colors.red, fontSize: 10),
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }

  Widget detail(IconData icon, String value, {textStyle = const TextStyle()}) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color: Colors.grey,
        ),
        const SizedBox(
          width: 10,
        ),
        Text(
          value,
          style: textStyle,
        )
      ],
    );
  }
}
