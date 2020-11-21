import 'dart:convert';

import 'package:dragable/share_preference/user.dart';
import 'package:dragable/share_preference/user_preference.dart';
import 'package:flutter/material.dart';

//
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  TextEditingController idController = TextEditingController();
  TextEditingController loadController = TextEditingController();
  TextEditingController removeController = TextEditingController();
  User userSave;
  saveUser() async {
    userSave = User(
        id: int.parse(idController.text),
        name: loadController.text,
        age: int.parse(removeController.text));
    print(
        "json encode: ${json.encode(userSave)} ${json.encode(userSave) is String}");
    UserPreference.userPrf.save("user", json.encode(userSave));
  }

  loadUser(BuildContext context) async {
    try {
      String stringUser = await UserPreference.userPrf.read("user");
      print(
          "json decode: ${json.decode(stringUser)} ${json.decode(stringUser) is Map}");
      userSave = User.fromJson(json.decode(stringUser));
      setState(() {});
    } catch (error) {
      // ScaffoldMessenger.maybeOf(context).showSnackBar(SnackBar(
      //   content: Text("Nothing show"),
      //   duration: Duration(milliseconds: 500),
      // ));
    }
  }

  removeUser() async {
    UserPreference.userPrf.remove("user");
    userSave = User();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 20),
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width * .5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextField(
                    controller: idController,
                    decoration: InputDecoration(
                        hintText: "id",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: loadController,
                    decoration: InputDecoration(
                        hintText: "name",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1))),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  TextField(
                    controller: removeController,
                    decoration: InputDecoration(
                        hintText: "age",
                        border: OutlineInputBorder(
                            borderSide: BorderSide(width: 1))),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 100,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                RaisedButton(
                  color: Colors.blue,
                  child: Text(
                    "Save",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    saveUser();
                  },
                ),
                Builder(
                  builder: (context) => RaisedButton(
                    color: Colors.blue,
                    child: Text(
                      "Load",
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      loadUser(context);
                    },
                  ),
                ),
                RaisedButton(
                  color: Colors.blue,
                  child: Text(
                    "Remove",
                    style: TextStyle(color: Colors.white),
                  ),
                  onPressed: () {
                    removeUser();
                  },
                )
              ],
            ),
            SizedBox(
              height: 100,
            ),
            Text("id :${userSave?.id ?? ""}"),
            Text("name : ${userSave?.name ?? ""}"),
            Text("age : ${userSave?.age ?? ""}"),
          ],
        ),
      ),
    );
  }
}
