import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:path_provider/path_provider.dart';
import 'package:task1/screen/login.dart';

class signup extends StatefulWidget {
  const signup({Key? key}) : super(key: key);

  @override
  State<signup> createState() => _signupState();
}

enum Gender { Male, Female }

class _signupState extends State<signup> {
  TextEditingController _name_keyInputController = TextEditingController();
  TextEditingController _email_keyInputController = TextEditingController();
  TextEditingController _password_keyInputController = TextEditingController();
  TextEditingController _mobile_keyInputController = TextEditingController();
  TextEditingController _address_keyInputController = TextEditingController();
  final _Key = GlobalKey<FormState>();
  Gender? _character = Gender.Male;
  TextEditingController dateInput = TextEditingController();
  late File jsonFile;
  late Directory directory;
  bool fileExists = false;
  late Map fileContent;

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
          final parsedjson = jsonDecode(jsonFile.readAsStringSync());
          print("sssssssssssssss");
          print(fileContent.toString());
        }
        setState(() {});
      }
    });
  }

  void read() {
    final parsedjson = jsonDecode(jsonFile.readAsStringSync());
    print("sssssssssssssss");
    print(parsedjson['kkk']);
    /*
    final jsonData = '{ "name": "Pizza da Mario", "cuisine": "Italian" }';
// 2. decode the json
final parsedJson = jsonDecode(jsonData);
// 3. print the type and value
print('${parsedJson.runtimeType} : $parsedJson');
    Map<String, dynamic> user = fileContent;

    print('Howdy, ${user['name']}!');
    print('We sent the verification link to ${user['email']}.');

     */
  }

  createFile() async {
    jsonFile = File('${directory.path}/local.json');
    await jsonFile.create();
  }

  writeToFile(
      String name_value,
      String email_value,
      String password_value,
      String mobile_value,
      String gender_value,
      String address_value,
      String date_value) async {
    Map<String, dynamic> content = {
      "name": name_value,
      "email": email_value,
      "password": password_value,
      "mobile": mobile_value,
      "gender": gender_value,
      "address": address_value,
      "date": date_value
    };
    if (fileExists) {
      if (fileContent.containsKey(email_value)) {
        fileContent.update(email_value, (v) => v = content);
      } else {
        fileContent.putIfAbsent(email_value, () => content);
      }
      jsonFile.writeAsString(jsonEncode(fileContent));
    } else {
      createFile();
    }
    fileContent = jsonDecode(await jsonFile.readAsString());
  }

  @override
  void dispose() {
    _name_keyInputController.dispose();
    _email_keyInputController.dispose();
    _password_keyInputController.dispose();
    _mobile_keyInputController.dispose();
    _address_keyInputController.dispose();
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
                            style: TextStyle(
                                color: Color(0xFFE9BDF2), fontSize: 20),
                          )),

                      TextFormField(
                        controller: _name_keyInputController,
                        decoration: InputDecoration(
                          labelText: "Name",
                          labelStyle: TextStyle(
                              color: Color(0xFFE9BDF2),
                              fontWeight: FontWeight.bold),
                          hintText: 'Enter your name',
                          hintStyle:
                              TextStyle(color: Color(0xFFE9BDF2), height: 0.5),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFE9BDF2),
                              width: 2.0,
                            ),
                          ),
                          suffixIcon: Icon(Icons.verified_user,
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
                          suffixIcon:
                              Icon(Icons.email, color: Color(0xFFE9BDF2)),
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
                          suffixIcon: Icon(Icons.vpn_key_outlined,
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
                          suffixIcon: Icon(Icons.mobile_friendly,
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
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                "Gender",
                                style: TextStyle(
                                    fontSize: 18, color: Color(0xFFE9BDF2)),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  ListTile(
                                    title: const Text(
                                      'Male',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Color(0xFFE9BDF2)),
                                    ),
                                    leading: Radio<Gender>(
                                      value: Gender.Male,
                                      groupValue: _character,
                                      focusColor: Color(0xFFE9BDF2),
                                      activeColor: Color(0xFFE9BDF2),
                                      onChanged: (Gender? value) {
                                        setState(() {
                                          _character = value;
                                        });
                                      },
                                    ),
                                  ),
                                  ListTile(
                                    title: const Text(
                                      'Female',
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: Color(0xFFE9BDF2)),
                                    ),
                                    leading: Radio<Gender>(
                                      value: Gender.Female,
                                      focusColor: Color(0xFFE9BDF2),
                                      activeColor: Color(0xFFE9BDF2),
                                      groupValue: _character,
                                      onChanged: (Gender? value) {
                                        setState(() {
                                          _character = value;
                                        });
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      //gender(Radio button(Male/Female/Others)), address, dob(Date picker)
                      TextFormField(
                        controller: _address_keyInputController,
                        decoration: InputDecoration(
                          labelText: "Address",
                          labelStyle: TextStyle(
                              color: Color(0xFFE9BDF2),
                              fontWeight: FontWeight.bold),
                          hintText: 'Enter your address',
                          hintStyle: TextStyle(color: Color(0xFFE9BDF2)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFE9BDF2),
                              width: 2.0,
                            ),
                          ),
                          suffixIcon:
                              Icon(Icons.mobile_friendly, color: Colors.white),
                        ),
                        // The validator receives the text that the user has entered.
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter some text';
                          }
                          return null;
                        },
                      ),
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
                          labelStyle: TextStyle(color: Color(0xFFE9BDF2)),
                          enabledBorder: UnderlineInputBorder(
                            borderSide: BorderSide(
                              color: Color(0xFFE9BDF2),
                              width: 2.0,
                            ),
                          ), //,label text of field
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
                            String formattedDate =
                                DateFormat('yyyy-MM-dd').format(pickedDate);
                            print(
                                formattedDate); //formatted date output using intl package =>  2021-03-16
                            setState(() {
                              dateInput.text =
                                  formattedDate; //set output date to TextField value.
                            });
                          } else {}
                        },
                      )))
                    ],
                  ),
                ),
              ),
            ),
            Container(
              alignment: Alignment.bottomCenter,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                    primary: Color(0xFFE9BDF2),
                    fixedSize: const Size(200, 50),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10))),
                onPressed: () {
                  // Validate returns true if the form is valid, or false otherwise.
                  if (_Key.currentState!.validate()) {
                    print("Name " + _name_keyInputController.text);
                    print("Email " + _email_keyInputController.text);
                    print(_character);
                    //writeToFile(String name_value,String email_value,String password_value,String mobile_value,String gender_value,String address_value,String date_value) async {
                    writeToFile(
                        _name_keyInputController.text,
                        _email_keyInputController.text,
                        _password_keyInputController.text,
                        _mobile_keyInputController.text,
                        _character.toString().replaceAll("Gender.", ""),
                        _address_keyInputController.text,
                        dateInput.text);

                    // If the form is valid, display a snackbar. In the real world,
                    // you'd often call a server or save the information in a database.
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text('Processing Data')),
                    );
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const login()),
                    );
                  }
                },
                child: Text(
                  "Sign Up",
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
