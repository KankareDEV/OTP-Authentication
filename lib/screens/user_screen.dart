import 'dart:io';

import 'package:flutter/material.dart';
import 'package:phoneauth/model/user_model.dart';
import 'package:phoneauth/provider/auth_provider.dart';
import 'package:phoneauth/screens/home_screen.dart';
import 'package:phoneauth/utils/utils.dart';
import 'package:phoneauth/widgets/backgroung_image.dart';
import 'package:phoneauth/widgets/custom_button.dart';
import 'package:provider/provider.dart';

class UserScreen extends StatefulWidget {
  const UserScreen({super.key});

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  File? image;
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final bioController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    nameController.dispose();
    emailController.dispose();
    bioController.dispose();
  }

  void selectImage() async {
    image = await pickImage(context);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isLoading =
        Provider.of<AuthProvider>(context, listen: true).isLoading;
    return Stack(
      alignment: Alignment.center,
      children: [
        BackgroundImage(),
        Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: isLoading == true
                ? const Center(
                    child: CircularProgressIndicator(
                      color: Colors.white70,
                    ),
                  )
                : SingleChildScrollView(
                    padding:
                        EdgeInsets.symmetric(vertical: 25.0, horizontal: 5.0),
                    child: Center(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: InkWell(
                              onTap: () => selectImage(),
                              child: image == null
                                  ? const CircleAvatar(
                                      backgroundImage:
                                          AssetImage('assets/profile.png'),
                                      radius: 65,
                                      backgroundColor: Colors.white60)
                                  : CircleAvatar(
                                      backgroundImage: FileImage(image!),
                                      radius: 65,
                                    ),
                            ),
                          ),
                          Container(
                            width: MediaQuery.of(context).size.width,
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 15),
                            margin: const EdgeInsets.only(top: 20),
                            child: Column(
                              children: [
                                textField(
                                  hintText: "John Smith",
                                  icon: Icons.account_circle,
                                  inputType: TextInputType.name,
                                  maxLines: 1,
                                  controller: nameController,
                                ),
                                textField(
                                  hintText: "abc@example.com",
                                  icon: Icons.email,
                                  inputType: TextInputType.emailAddress,
                                  maxLines: 1,
                                  controller: emailController,
                                ),
                                textField(
                                  hintText: "Enter your bio here...",
                                  icon: Icons.edit,
                                  inputType: TextInputType.name,
                                  maxLines: 2,
                                  controller: bioController,
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 20),
                          SizedBox(
                            height: 50,
                            width: MediaQuery.of(context).size.width * 0.90,
                            child: CustomButton(
                              text: "Continue",
                              onPressed: () => storeData(),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
          ),
        ),
      ],
    );
  }

  Widget textField({
    required String hintText,
    required IconData icon,
    required TextInputType inputType,
    required int maxLines,
    required TextEditingController controller,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: TextFormField(
        cursorColor: Colors.black,
        controller: controller,
        keyboardType: inputType,
        maxLines: maxLines,
        decoration: InputDecoration(
          prefixIcon: Container(
            margin: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: Colors.black,
            ),
            child: Icon(
              icon,
              size: 20,
              color: Colors.white,
            ),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.black,
            ),
          ),
          hintText: hintText,
          alignLabelWithHint: true,
          border: InputBorder.none,
          fillColor: Colors.white60,
          filled: true,
        ),
      ),
    );
  }

  void storeData() async {
    final ap = Provider.of<AuthProvider>(context, listen: false);
    UserModel userModel = UserModel(
      bio: bioController.text.trim(),
      profilePic: "",
      createdAt: "",
      phoneNumber: "",
      uid: "",
      name: nameController.text.trim(),
      email: emailController.text.trim(),
    );
    if (image != null) {
      ap.saveUserDataToFirebase(
        context: context,
        userModel: userModel,
        profilePic: image!,
        onSuccess: () {
          ap.saveUserDataToSP().then(
                (value) => ap.setSignIn().then(
                      (value) => Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const HomeScreen(),
                          ),
                          (route) => false),
                    ),
              );
        },
      );
    } else {
      showSnackBar(context, "Please update your profile pic");
    }
  }
}
