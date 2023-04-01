import 'package:flutter/material.dart';
import 'package:phoneauth/provider/auth_provider.dart';
import 'package:phoneauth/screens/welcome_screen.dart';
import 'package:phoneauth/widgets/backgroung_image.dart';
import 'package:phoneauth/widgets/custom_button.dart';
import 'package:provider/provider.dart';

import '../widgets/styles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final ap = Provider.of<AuthProvider>(context, listen: false);

    return Stack(
      children: [
        BackgroundImage(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.black,
            title: const Text("Profile"),
            actions: [
              IconButton(
                onPressed: () {
                  ap.userSignOut().then(
                        (value) => Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const WelcomeScreen(),
                          ),
                        ),
                      );
                },
                icon: const Icon(Icons.exit_to_app),
              ),
            ],
          ),
          body: Stack(
            children: [
              ListView(
                children: [
                  SizedBox(height: 30),
                  Stack(
                    children: [
                      Center(
                        child: Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                            border: Border.all(
                              width: 4,
                              color: Colors.black12,
                            ),
                            boxShadow: [
                              BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10),
                              ),
                            ],
                            shape: BoxShape.circle,
                          ),
                          child: CircleAvatar(
                            backgroundImage:
                                NetworkImage(ap.userModel.profilePic),
                            radius: 65,
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 15,
                        right: 145,
                        child: Container(
                          height: 35,
                          width: 35,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(width: 4, color: Colors.black12),
                            color: Colors.black,
                          ),
                          child: Icon(Icons.edit, color: Colors.white),
                        ),
                      )
                    ],
                  ),
                  SizedBox(height: 35),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          decoration: BoxDecoration(
                            color: Colors.white24,
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: TextField(
                            decoration: InputDecoration(
                              contentPadding:
                                  const EdgeInsets.symmetric(vertical: 18),
                              border: InputBorder.none,
                              hintText: ap.userModel.name,
                              prefixIcon: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: Icon(
                                  Icons.account_box,
                                  color: Colors.black,
                                  size: 30,
                                ),
                              ),
                              hintStyle: mainText,
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Column(
                            children: [
                              Container(
                                decoration: BoxDecoration(
                                  color: Colors.white24,
                                  borderRadius: BorderRadius.circular(16),
                                ),
                                child: TextField(
                                  decoration: InputDecoration(
                                    contentPadding: const EdgeInsets.symmetric(
                                        vertical: 20),
                                    border: InputBorder.none,
                                    hintText: ap.userModel.phoneNumber,
                                    prefixIcon: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: Icon(
                                        Icons.phone,
                                        color: Colors.black,
                                        size: 30,
                                      ),
                                    ),
                                    hintStyle: mainText,
                                  ),
                                ),
                              ),
                              Container(
                                margin: EdgeInsets.only(top: 10),
                                child: Column(
                                  children: [
                                    Container(
                                      decoration: BoxDecoration(
                                        color: Colors.white24,
                                        borderRadius: BorderRadius.circular(16),
                                      ),
                                      child: TextField(
                                        decoration: InputDecoration(
                                          contentPadding:
                                              const EdgeInsets.symmetric(
                                                  vertical: 20),
                                          border: InputBorder.none,
                                          hintText: ap.userModel.email,
                                          prefixIcon: Padding(
                                            padding: const EdgeInsets.symmetric(
                                                horizontal: 10),
                                            child: Icon(
                                              Icons.email_rounded,
                                              color: Colors.black,
                                              size: 30,
                                            ),
                                          ),
                                          hintStyle: mainText,
                                        ),
                                      ),
                                    ),
                                    Container(
                                      margin: EdgeInsets.only(top: 10),
                                      child: Column(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Colors.white24,
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                            ),
                                            child: SingleChildScrollView(
                                              child: TextField(
                                                decoration: InputDecoration(
                                                  contentPadding:
                                                      const EdgeInsets
                                                              .symmetric(
                                                          vertical: 20),
                                                  border: InputBorder.none,
                                                  hintText: ap.userModel.bio,
                                                  prefixIcon: Padding(
                                                    padding: const EdgeInsets
                                                            .symmetric(
                                                        horizontal: 10),
                                                    child: Icon(
                                                      Icons.book_online,
                                                      color: Colors.black,
                                                      size: 30,
                                                    ),
                                                  ),
                                                  hintStyle: mainText,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 30),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40),
                    child: SizedBox(
                      width: double.infinity,
                      height: 60,
                      child: CustomButton(
                        text: "Update your profile info",
                        onPressed: () {},
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )
      ],
    );
  }
}
