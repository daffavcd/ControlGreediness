import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'dashboard.dart';

class Setting extends StatefulWidget {
  const Setting({super.key});

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final _formKey = GlobalKey<FormState>();
  final oldPasswordController = TextEditingController();
  final newPasswordController = TextEditingController();

  bool _obscureTextOld = true;
  bool _obscureTextNew = true;

  // Toggles the password show status
  void _toggleOld() {
    setState(() {
      _obscureTextOld = !_obscureTextOld;
    });
  }

  void _toggleNew() {
    setState(() {
      _obscureTextNew = !_obscureTextNew;
    });
  }

  Future<void> changePassword() async {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(
        builder: (context) => const Dashboard(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return LoaderOverlay(
      overlayColor: Color.fromARGB(73, 0, 170, 20),
      useDefaultLoading: false,
      overlayOpacity: 0.4,
      overlayWidget: const Center(
        child: SpinKitWanderingCubes(
          color: Color.fromARGB(255, 0, 170, 19),
          size: 50.0,
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        resizeToAvoidBottomInset: false,
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 70,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
              child: Align(
                alignment: Alignment.center,
                child: Text(
                  "Settings",
                  style: GoogleFonts.rubik(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w700,
                      fontSize: 30,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 2),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  "Change Password",
                  style: GoogleFonts.rubik(
                    textStyle: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
            ),
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 16.0),
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      Form(
                        key: _formKey,
                        child: Column(
                          children: <Widget>[
                            TextFormField(
                              style: GoogleFonts.rubik(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.normal),
                              ),
                              obscureText: _obscureTextOld,
                              enableSuggestions: false,
                              autocorrect: false,
                              controller: oldPasswordController,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    _toggleOld();
                                  },
                                  icon: Icon(
                                    _obscureTextOld
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: const Color.fromARGB(
                                        255, 0, 170, 19), // Set icon color
                                  ),
                                ),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(
                                        255, 0, 170, 19), // Set border color
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 170,
                                        19), // Set focused border color
                                  ),
                                ),
                                hintText: 'Old Password',
                                filled: true,
                                fillColor: const Color.fromARGB(
                                    255, 255, 255, 255), // Set fill color
                                labelText: 'Old Password',
                                labelStyle: const TextStyle(
                                  color: Color.fromARGB(
                                      255, 0, 170, 19), // Set label color
                                ),
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please fill the password.';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            TextFormField(
                              style: GoogleFonts.rubik(
                                textStyle: const TextStyle(
                                    fontWeight: FontWeight.normal),
                              ),
                              obscureText: _obscureTextNew,
                              enableSuggestions: false,
                              autocorrect: false,
                              controller: newPasswordController,
                              decoration: InputDecoration(
                                suffixIcon: IconButton(
                                  onPressed: () {
                                    _toggleNew();
                                  },
                                  icon: Icon(
                                    _obscureTextNew
                                        ? Icons.visibility
                                        : Icons.visibility_off,
                                    color: const Color.fromARGB(
                                        255, 0, 170, 19), // Set icon color
                                  ),
                                ),
                                border: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(
                                        255, 0, 170, 19), // Set border color
                                  ),
                                ),
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Color.fromARGB(255, 0, 170,
                                        19), // Set focused border color
                                  ),
                                ),
                                hintText: 'Password',
                                filled: true,
                                fillColor: const Color.fromARGB(
                                    255, 255, 255, 255), // Set fill color
                                labelText: 'Password',
                                labelStyle: const TextStyle(
                                  color: Color.fromARGB(
                                      255, 0, 170, 19), // Set label color
                                ),
                              ),
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please fill the password.';
                                }
                                return null;
                              },
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 65, 131, 255),
                                minimumSize: const Size.fromHeight(50), // NEW
                              ),
                              onPressed: () async {
                                if (_formKey.currentState!.validate()) {
                                  // context.loaderOverlay.show();
                                  await changePassword();
                                  // context.loaderOverlay.hide();
                                }
                              },
                              child: Text(
                                'Save',
                                style: GoogleFonts.rubik(
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            ElevatedButton(
                              style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 0, 170, 19),
                                minimumSize: const Size.fromHeight(50), // NEW
                              ),
                              onPressed: () async {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const Dashboard(),
                                  ),
                                );
                              },
                              child: Text(
                                '<< Back',
                                style: GoogleFonts.rubik(
                                  textStyle: const TextStyle(
                                    fontWeight: FontWeight.w600,
                                    fontSize: 20,
                                    color: Colors.white,
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
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15, vertical: 16.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage("assets/formalme.jpg"),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          "About This App",
                          style: GoogleFonts.rubik(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 22,
                            ),
                          ),
                        ),
                        Text(
                          "This app created by:",
                          style: GoogleFonts.rubik(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 19,
                            ),
                          ),
                        ),
                        Text(
                          "Name: Daffa' Athallah",
                          style: GoogleFonts.rubik(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 19,
                            ),
                          ),
                        ),
                        Text(
                          "NIM: 2241727025",
                          style: GoogleFonts.rubik(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 19,
                            ),
                          ),
                        ),
                        Text(
                          "Date: 24 September 2023",
                          style: GoogleFonts.rubik(
                            textStyle: const TextStyle(
                              fontWeight: FontWeight.w400,
                              fontSize: 19,
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
    );
  }
}
