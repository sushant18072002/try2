import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task1/screen/signup.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'forgotpassword.dart';
import 'package:task1/screen/home.dart';

class login extends StatefulWidget {
  const login({Key? key}) : super(key: key);

  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  int flag=3;
  TextEditingController _email_keyInputController = TextEditingController();
  TextEditingController _password_keyInputController = TextEditingController();
  late File jsonFile;
  late Directory directory;
  bool fileExists = false;
  late Map fileContent;

  void readdata(String id, String password) {
    getApplicationDocumentsDirectory().then((dir) async {
      directory = dir;
      jsonFile = File('${directory.path}/local.json');
      await jsonFile.create();
      fileExists = await jsonFile.exists();
      print(fileExists);
      if (fileExists) {
        if (await jsonFile.readAsString() == '') {
          fileContent = {};
        } else {
          final parsedjson = jsonDecode(jsonFile.readAsStringSync());
          print(parsedjson.toString());
          if (parsedjson[id] == null || parsedjson[id].isEmpty) {
            return Fluttertoast.showToast(
                msg: "Invalid user name",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.redAccent.shade400,
                textColor: Colors.white,
                fontSize: 16.0);
          } else {
            if (parsedjson[id]["password"].toString() == password) {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const Home()),
              );
              return Fluttertoast.showToast(
                  msg: "Login Successfully",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.lightGreenAccent.shade400,
                  textColor: Colors.white,
                  fontSize: 16.0);

            } else {
              Fluttertoast.showToast(
                  msg: "Invalid password",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.redAccent.shade400,
                  textColor: Colors.white,
                  fontSize: 16.0);
            }
          }
        }
        setState(() {});
      }
    });
  }

  @override
  void dispose() {
    _email_keyInputController.dispose();
    _password_keyInputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Expanded(
            flex: 3,
            child: Stack(children: [
              Container(
                margin: EdgeInsets.fromLTRB(0, 0, 0, 25),
                padding: EdgeInsets.fromLTRB(0, 0, 0, 90),
                decoration: BoxDecoration(
                    color: Color(0xFFE9BDF2),
                    borderRadius: BorderRadius.only(
                        bottomRight: Radius.circular(40.0),
                        bottomLeft: Radius.circular(40.0)),
                    border: Border.all(
                      color: Color(0xFFE9BDF2),
                      width: 3,
                    )),
                child: Column(
                  children: [
                    Expanded(
                        child: Center(
                            child: Text(
                      "LOGO",
                      style: TextStyle(fontSize: 30, color: Colors.white),
                    ))),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(24.0, 0, 24.0, 0),
                        child: Center(
                            child: Column(
                          children: [
                            /*TextField(
                              decoration: InputDecoration(
                                enabledBorder: UnderlineInputBorder(
                                  borderRadius: BorderRadius.circular(5),
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 1.0,
                                  ),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(30),
                                  borderSide: BorderSide(
                                    color: Colors.purple,
                                    width: 2.0,
                                  ),
                                ),
                              ),
                            ),

                             */
                            Container(
                                alignment: Alignment.topLeft,
                                child: Text(
                                  "ID",
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 20),
                                )),
                            TextField(
                              controller: _email_keyInputController,
                              decoration: InputDecoration(
                                hintText: 'Enter your email',
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 2.0,
                                  ),
                                ),
                                suffixIcon:
                                    Icon(Icons.mail, color: Colors.white),
                              ),
                            ),
                            const SizedBox(height: 20),
                            Container(
                              alignment: Alignment.topLeft,
                              child: Text(
                                "Password",
                                style: TextStyle(
                                    color: Colors.white, fontSize: 18),
                              ),
                            ),
                            TextField(
                              controller: _password_keyInputController,
                              decoration: InputDecoration(
                                hintText: 'Enter your password',
                                hintStyle: TextStyle(color: Colors.white),
                                enabledBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.white,
                                    width: 2.0,
                                  ),
                                ),
                                suffixIcon:
                                    Icon(Icons.key, color: Colors.white),
                              ),
                            ),
                            const SizedBox(height: 16),
                            Container(
                              alignment: Alignment.bottomRight,
                              child: TextButton(
                                onPressed: (){
                                  Navigator.push(
                                    context,
                                      MaterialPageRoute(builder: (context) => const forgotpassword()),
                                  );
                                },
                                child: const Text(
                                  "Forgot your Password?",
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                          ],
                        )),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                alignment: Alignment.bottomCenter,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      primary: Colors.white,
                      fixedSize: const Size(200, 50),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10))),
                  onPressed: () {
                    print("kookokokokokokokokokoko");
                    readdata(_email_keyInputController.text,_password_keyInputController.text);

                  },
                  child: Text(
                    "Login",
                    style: TextStyle(fontSize: 24, color: Color(0xFFE9BDF2)),
                  ),
                ),
              )
            ]),
          ),
          Expanded(
              child: Center(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Don't have account?"),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const signup()),
                    );
                  },
                  child: Text(
                    "Sign Up",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Color(0xFFE9BDF2)),
                  ),
                )
              ],
            ),
          ))
        ],
      ),
    );
  }
}
