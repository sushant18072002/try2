import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';

class forgotpassword extends StatefulWidget {
  const forgotpassword({Key? key}) : super(key: key);

  @override
  State<forgotpassword> createState() => _forgotpassword();
}

enum Gender { Male, Female }

class _forgotpassword extends State<forgotpassword> {
  TextEditingController _name_keyInputController = TextEditingController();
  TextEditingController _email_keyInputController = TextEditingController();
  TextEditingController _password_keyInputController = TextEditingController();
  TextEditingController _mobile_keyInputController = TextEditingController();
  final _Key = GlobalKey<FormState>();
  Gender? _character = Gender.Male;
  TextEditingController dateInput = TextEditingController();
  late File jsonFile;
  late Directory directory;
  bool fileExists = false;
  late Map<String, dynamic>  fileContent;


  @override
  void initState() {
    super.initState();
    dateInput.text = "";
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
          fileContent = jsonDecode(await jsonFile.readAsString());
          print("initail json");
          print(fileContent.toString());
        }
        setState(() {});
      }
    });
  }

  read() {
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
          fileContent = jsonDecode(await jsonFile.readAsString());
          print("updated json");
          print(fileContent.toString());
        }
        setState(() {});
      }
    });
  }

  createFile() async {
    jsonFile = File('${directory.path}/local.json');
    await jsonFile.create();
  }
  void readdata(String name_value,String email_value, String password_value,
      String mobile_value, String date_value) {
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
          if (parsedjson[email_value] == null || parsedjson[email_value].isEmpty) {
            return  Fluttertoast.showToast(
                msg: "Invalid user name",
                toastLength: Toast.LENGTH_SHORT,
                gravity: ToastGravity.BOTTOM,
                timeInSecForIosWeb: 1,
                backgroundColor: Colors.redAccent.shade400,
                textColor: Colors.white,
                fontSize: 16.0);
          } else {
            if (parsedjson[email_value]["name"].toString() == name_value && parsedjson[email_value]["mobile"].toString() == mobile_value&& parsedjson[email_value]["date"].toString() == date_value) {
              writeToFile(email_value, password_value);
              return Fluttertoast.showToast(
                  msg: "Password change Successfully",
                  toastLength: Toast.LENGTH_SHORT,
                  gravity: ToastGravity.BOTTOM,
                  timeInSecForIosWeb: 1,
                  backgroundColor: Colors.lightGreenAccent.shade400,
                  textColor: Colors.white,
                  fontSize: 16.0);
            } else {
              Fluttertoast.showToast(
                  msg: "Invalid Credentail",
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
  writeToFile(String email_value, String password_value) async {
    if (fileExists) {
      if (fileContent.containsKey(email_value)) {
        print("kuch nahi pagal hua para hu");
        //(data["quotes"] as List<dynamic>)[position]['favorite'] = true;
        fileContent[email_value]["password"] = password_value;
      }
      jsonFile.writeAsString(jsonEncode(fileContent));
    } else {
      createFile();
    }
    fileContent = jsonDecode(await jsonFile.readAsString());
  }


  @override
  void dispose() {
    _email_keyInputController.dispose();
    _password_keyInputController.dispose();
    _mobile_keyInputController.dispose();
    _name_keyInputController.dispose();
    dateInput.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: Container(
        padding: EdgeInsets.fromLTRB(0, 0, 0, 40),
        decoration: BoxDecoration(
          color: Color(0xFFE9BDF2),
        ),
        child: Stack(
          children: [
            Container(
              margin: EdgeInsets.fromLTRB(0, 0, 0, 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      bottomRight: Radius.circular(40.0),
                      bottomLeft: Radius.circular(40.0)),
                  border: Border.all(
                    color: Color(0xFFE9BDF2),
                    width: 3,
                  )),
              child: Form(
                key: _Key,
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(40, 10, 40, 0),
                  child: Column(
                    children: <Widget>[
                      Container(
                          padding: EdgeInsets.all(50),
                          alignment: Alignment.center,

                          child: Text(
                            "LOGO",
                            style: TextStyle(color: Color(0xFFE9BDF2),
                                fontSize: 20),
                          )
                      ),
                      TextFormField(
                        controller: _name_keyInputController,
                        decoration: InputDecoration(
                          labelText: "Name",
                          labelStyle: TextStyle(
                              color: Color(0xFFE9BDF2),
                              fontWeight: FontWeight.bold),
                          hintText: 'Enter your name',
                          hintStyle: TextStyle(color: Color(0xFFE9BDF2),
                              height: 0.5),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFE9BDF2),
                              width: 2.0,
                            ),
                          ),
                          suffixIcon:
                          Icon(Icons.verified_user, color: Color(0xFFE9BDF2)),
                        ),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _email_keyInputController,
                        decoration: InputDecoration(
                          labelText: "Email",
                          labelStyle: TextStyle(
                              color: Color(0xFFE9BDF2),
                              fontWeight: FontWeight.bold),
                          hintText: 'Enter your email',
                          hintStyle: TextStyle(color: Color(0xFFE9BDF2)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFE9BDF2),
                              width: 2.0,
                            ),
                          ),
                          suffixIcon: Icon(Icons.email,
                              color: Color(0xFFE9BDF2)),
                        ),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _password_keyInputController,
                        decoration: InputDecoration(
                          labelText: "Password",
                          labelStyle: TextStyle(
                              color: Color(0xFFE9BDF2),
                              fontWeight: FontWeight.bold),
                          hintText: 'Enter your password',
                          hintStyle: TextStyle(color: Color(0xFFE9BDF2)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFE9BDF2),
                              width: 2.0,
                            ),
                          ),
                          suffixIcon:
                          Icon(Icons.vpn_key_outlined,
                              color: Color(0xFFE9BDF2)),
                        ),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      TextFormField(
                        controller: _mobile_keyInputController,
                        decoration: InputDecoration(
                          labelText: "Mobile Number",
                          labelStyle: TextStyle(
                              color: Color(0xFFE9BDF2),
                              fontWeight: FontWeight.bold),
                          hintText: 'Enter your mobile number',
                          hintStyle: TextStyle(color: Color(0xFFE9BDF2)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFE9BDF2),
                              width: 2.0,
                            ),
                          ),
                          suffixIcon:
                          Icon(Icons.mobile_friendly, color: Color(0xFFE9BDF2)),
                        ),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
                      //gender(Radio button(Male/Female/Others)), address, dob(Date picker)
                      Container(
                          child: Center(
                              child: TextField(
                                style: TextStyle(color: Color(0xFFE9BDF2)),
                                controller: dateInput,
                                //editing controller of this TextField
                                decoration: InputDecoration(
                                  icon: Icon(Icons.calendar_today,
                                      color: Color(0xFFE9BDF2)),
                                  //icon of text field
                                  labelText: "Enter DOB",
                                  labelStyle: TextStyle(
                                      color: Color(0xFFE9BDF2)),
                                  enabledBorder: UnderlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Color(0xFFE9BDF2),
                                      width: 2.0,
                                    ),), //,label text of field
                                ),
                                readOnly: true,
                                //set it true, so that user will not able to edit text
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime(1950),
                                      //DateTime.now() - not to allow to choose before today.
                                      lastDate: DateTime(2100));

                                  if (pickedDate != null) {
                                    print(
                                        pickedDate); //pickedDate output format => 2021-03-10 00:00:00.000
                                    String formattedDate = DateFormat(
                                        'yyyy-MM-dd').format(pickedDate);
                                    print(
                                        formattedDate); //formatted date output using intl package =>  2021-03-16
                                    setState(() {
                                      dateInput.text =
                                          formattedDate; //set output date to TextField value.
                                    });
                                  } else {}
                                },
                              ))),

                    ],
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color(0xFFE9BDF2), fixedSize: const Size(300, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  //if (_Key.currentState!.validate()) {
                  if (true) {
                    print("Email " + _email_keyInputController.text);
                    print(_character);
                    //writeToFile(String name_value,String email_value,String password_value,String mobile_value,String gender_value,String address_value,String date_value) async {
                    readdata(_name_keyInputController.text,
                        _email_keyInputController.text,
                        _password_keyInputController.text,
                        _mobile_keyInputController.text, dateInput.text);

                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                  }
                },
                child: Text(
                  "Reset Password",
                  style: TextStyle(fontSize: 24, color: Colors.white),
                ),
              ),
            )

          ],
        ),
      ),
    );
  }
}
