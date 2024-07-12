import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:trendflix/colors/myColors.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../../../widget_global/typesMovieWidget.dart';
import 'package:trendflix/source/auth/screen/login_screen.dart';
// ignore_for_file: use_build_context_synchronously



class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColor.cBlack,
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: MyColor.cWhite,
            size: 18,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        backgroundColor: MyColor.cBlack,
        title: tittletext("PROFILE"),
        actions: [
          PopupMenuButton(
            icon: Icon(
              Icons.settings,
              color: MyColor.cWhite,
            ),
            itemBuilder: (BuildContext context) {
              return [
                PopupMenuItem(
                  child: settingText("Edit Profile"),
                ),
                PopupMenuItem(
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                    Navigator.pushReplacement<void, void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => const LoginScreen(),
                      ),
                    );
                  },
                  child: settingText("Log out"),
                ),
              ];
            },
          ),
        ],
      ),
      body: StreamBuilder<DocumentSnapshot<Object?>>(
        stream: FirebaseFirestore.instance
            .collection("users")
            .doc(FirebaseAuth.instance.currentUser!.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return const Text("Error");
          if (!snapshot.hasData) return const Text("No Data");
          Map<String, dynamic> item =
              (snapshot.data!.data() as Map<String, dynamic>);
          item["id"] = snapshot.data!.id;
          return Container(
            padding: const EdgeInsets.all(20.0),
            child: Center(
              child: Column(
                children: [
                  Stack(
                    children: [
                      Container(
                        height: 100.0,
                        width: 100.0,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage(
                              item['profile'] ??
                                  "https://bookofachievers.com/img/default_dp.jpg",
                            ),
                            fit: BoxFit.cover,
                          ),
                          borderRadius: const BorderRadius.all(
                            Radius.circular(
                              100,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  tittletext(item['name']),
                  Container(
                    padding: const EdgeInsets.only(top: 20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            normaltext("Phone"),
                            normaltext(item['nomer'] ?? '+62'),
                          ],
                        ),
                        const SizedBox(
                          height: 10.0,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            normaltext("Email"),
                            normaltext(item['email'] ?? '-'),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
