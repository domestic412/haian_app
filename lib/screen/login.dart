import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:haian_app/screen/second.dart';
import 'package:http/http.dart' as http;

class Login_Screen extends StatefulWidget {
  const Login_Screen({super.key});

  @override
  State<Login_Screen> createState() => _Login_ScreenState();
}

var UserNameController = TextEditingController();
var PasswordController = TextEditingController();

Widget _buildAppbarImage() {
  return Padding(
    padding: const EdgeInsets.only(top: 100),
    child: Image.asset(
      'lib/assets/images/hats_logo.png',
      height: 120,
      width: 240,
    ),
  );
}

Widget _buildAppbarName() {
  return Padding(
      padding: const EdgeInsets.only(top: 20),
      child: Text(
        'Welcome to HAI AN',
        style: TextStyle(
            fontSize: 30, fontWeight: FontWeight.bold, color: Colors.blue[900]),
      ));
}

Widget _buildInputUserName() {
  return Padding(
    padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
    child: TextField(
      controller: UserNameController,
      style: const TextStyle(fontSize: 18, color: Colors.black54),
      decoration: const InputDecoration(
          hintText: "UserName",
          hintStyle: TextStyle(fontSize: 16, color: Colors.white)),
    ),
  );
}

Widget _buildInputPassword() {
  return Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 20, 20),
      child: Stack(
        alignment: AlignmentDirectional.centerEnd,
        children: <Widget>[
          TextField(
              controller: PasswordController,
              obscureText: true,
              style: const TextStyle(fontSize: 16, color: Colors.black54),
              decoration: const InputDecoration(
                  hintText: "Password",
                  hintStyle: TextStyle(fontSize: 18, color: Colors.white))),
        ],
      ));
}

class _Login_ScreenState extends State<Login_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      constraints: const BoxConstraints.expand(),
      decoration: const BoxDecoration(
          gradient: LinearGradient(colors: [
        Colors.white,
        Colors.blue,
      ], begin: Alignment.topCenter, end: Alignment.bottomCenter)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          _buildAppbarImage(),
          _buildAppbarName(),
          _buildInputUserName(),
          _buildInputPassword(),
          Container(
              padding: EdgeInsets.fromLTRB(20, 10, 20, 20),
              width: double.infinity,
              height: 80,
              child: ElevatedButton(
                style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.white),
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                        RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(50.0),
                    ))),
                onPressed: () {
                  login(UserNameController.text.toString(),
                      PasswordController.text.toString());
                },
                child: const Text(
                  'Login',
                  style: TextStyle(fontSize: 16, color: Colors.blue),
                ),
              )),
        ],
      ),
    ));
  }

  Future<void> login(String shipperCode,String password) async {
    var url = 'http://192.168.7.198:1214/api/Login';
    Map data = {
      'shipperCode': UserNameController.text,
      'password': PasswordController.text
    };
    var body = json.encode(data);
    if (UserNameController.text.isNotEmpty &&
        PasswordController.text.isNotEmpty) {
      var response = await http.post(Uri.parse(url),
          headers: {"Content-Type": "application/json"}, body: body);
      if (response.statusCode == 200) {
        var body = response.body;
        var data = jsonDecode(body.toString());
        print('Login Success');
        print(data['token']);
        // ignore: use_build_context_synchronously
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const Second(),
            ));
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text("False")));
      }
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text("Invalid")));
    }
  }
}
