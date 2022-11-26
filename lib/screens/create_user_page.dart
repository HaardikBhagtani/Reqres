import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import '../constants.dart';

class CreateUserPage extends StatefulWidget {
  const CreateUserPage({Key? key}) : super(key: key);

  @override
  State<CreateUserPage> createState() => _CreateUserPageState();
}

class _CreateUserPageState extends State<CreateUserPage> {
  bool sending = false;
  final GlobalKey<FormState> _formKey = GlobalKey();
  TextEditingController nameController = TextEditingController();
  TextEditingController jobController = TextEditingController();

  Future<int> sendUserData(String name, String job) async {
    http.Response response = await http.post(Uri.parse("https://reqres.in/api/users"), body: '''
     {
        "name": "$name",
        "job": "$job"
     }
    ''');
    return response.statusCode;
  }

  @override
  Widget build(BuildContext context) {
    return ModalProgressHUD(
      inAsyncCall: sending,
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Create Reqres User"),
          centerTitle: true,
        ),
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: [
                  TextFormField(
                    validator: (value) {
                      if (value == "") {
                        return 'Enter a valid name';
                      }
                      return null;
                    },
                    controller: nameController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Name',
                      border: buildOutlineInputBorder(),
                      disabledBorder: buildOutlineInputBorder(),
                      focusedBorder: buildOutlineInputBorder(),
                      enabledBorder: buildOutlineInputBorder(),
                      errorBorder: buildOutlineInputBorder(),
                      focusedErrorBorder: buildOutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                    validator: (value) {
                      if (value == "") {
                        return 'Enter a valid Job';
                      }
                      return null;
                    },
                    controller: jobController,
                    keyboardType: TextInputType.emailAddress,
                    textInputAction: TextInputAction.next,
                    decoration: InputDecoration(
                      labelText: 'Job',
                      border: buildOutlineInputBorder(),
                      disabledBorder: buildOutlineInputBorder(),
                      focusedBorder: buildOutlineInputBorder(),
                      enabledBorder: buildOutlineInputBorder(),
                      errorBorder: buildOutlineInputBorder(),
                      focusedErrorBorder: buildOutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2,
                    child: ElevatedButton(
                      onPressed: () async {
                        if (_formKey.currentState!.validate()) {
                          setState(() {
                            sending = true;
                          });
                          int code = await sendUserData(nameController.text, jobController.text);
                          setState(() {
                            sending = false;
                          });
                          if (code == 201) {
                            Fluttertoast.showToast(
                              msg: "Create User Successful",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                            setState(() {
                              nameController.clear();
                              jobController.clear();
                            });
                          } else {
                            Fluttertoast.showToast(
                              msg: "Create User Unsuccessful",
                              toastLength: Toast.LENGTH_LONG,
                              gravity: ToastGravity.CENTER,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.grey,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          }
                        }
                      },
                      style: ButtonStyle(
                        shape: MaterialStateProperty.all<OutlinedBorder>(
                          const RoundedRectangleBorder(
                            //side: BorderSide(color: kMainColor, width: 2),
                            borderRadius: BorderRadius.all(
                              Radius.circular(5),
                            ),
                          ),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(Colors.blueAccent),
                      ),
                      child: const Text(
                        "Create User",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
