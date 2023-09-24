import 'package:flutter/material.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';

import 'pages/dashboard.dart';

void main() {
  runApp(const MaterialApp(home: Masuk()));
}

class Masuk extends StatefulWidget {
  const Masuk({super.key});

  @override
  State<Masuk> createState() => _MasukState();
}

class _MasukState extends State<Masuk> {
  final _formKey = GlobalKey<FormState>();
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  bool _obscureText = true;
  // Toggles the password show status
  void _toggle() {
    setState(() {
      _obscureText = !_obscureText;
    });
  }

  @override
  void initState() {
    super.initState();
  }

  Future<void> login() async {
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
              height: 150,
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 11),
              child: Image(
                image: AssetImage("assets/logo-full.png"),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Form(
              key: _formKey,
              child: Column(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 11),
                    child: TextFormField(
                      style: GoogleFonts.rubik(
                        textStyle:
                            const TextStyle(fontWeight: FontWeight.normal),
                      ),
                      enableSuggestions: false,
                      autocorrect: false,
                      controller: usernameController,
                      decoration: const InputDecoration(
                        border: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(
                                255, 0, 170, 19), // Set border color
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide: BorderSide(
                            color: Color.fromARGB(
                                255, 0, 170, 19), // Set focused border color
                          ),
                        ),
                        hintText: 'Username',
                        filled: true,
                        fillColor: Color.fromARGB(
                            255, 255, 255, 255), // Set fill color
                        labelText: 'Username',
                        labelStyle: TextStyle(
                          color: Color.fromARGB(
                              255, 0, 170, 19), // Set label color
                        ),
                      ),
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please fill the username.';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 11),
                    child: TextFormField(
                      style: GoogleFonts.rubik(
                        textStyle:
                            const TextStyle(fontWeight: FontWeight.normal),
                      ),
                      obscureText: _obscureText,
                      enableSuggestions: false,
                      autocorrect: false,
                      controller: passwordController,
                      decoration: InputDecoration(
                        suffixIcon: IconButton(
                          onPressed: () {
                            _toggle();
                          },
                          icon: Icon(
                            _obscureText
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
                            color: Color.fromARGB(
                                255, 0, 170, 19), // Set focused border color
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
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Please fill the password.';
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 16.0),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(255, 0, 170, 19),
                        minimumSize: const Size.fromHeight(50), // NEW
                      ),
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          // context.loaderOverlay.show();
                          await login();
                          // context.loaderOverlay.hide();
                        }
                      },
                      child: Text(
                        'Log In',
                        style: GoogleFonts.rubik(
                          textStyle: const TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 20,
                            color: Colors.white,
                          ),
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
    );
  }
}
