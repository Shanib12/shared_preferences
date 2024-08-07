import 'package:auto_login_app/main.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class SuccessPage extends StatefulWidget {
  @override
  _SuccessPageState createState() => _SuccessPageState();
}

class _SuccessPageState extends State<SuccessPage> {
  Map<String, String>? _loggedInUser;

  @override
  void initState() {
    super.initState();
    _loadLoggedInUser();
  }

  void _loadLoggedInUser() async {
    final prefs = await SharedPreferences.getInstance();
    String? loggedInUser = prefs.getString('loggedInUser');
    if (loggedInUser != null) {
      setState(() {
        _loggedInUser = Map<String, String>.from(json.decode(loggedInUser));
      });
    }
  }

  Future<void> _signOut(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => MyApp()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topRight,
          end: Alignment.bottomLeft,
          colors: [
            Colors.blue,
            Colors.purple,
            Colors.green,
          ],
        ),
      ),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          actions: [
            IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                _signOut(context);
              },
            ),
          ],
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Login Successful!',
                style: TextStyle(fontSize: 30),
              ),
              SizedBox(height: 16),
              if (_loggedInUser != null) ...[
                Text(
                  'Username: ${_loggedInUser!['username']}',
                  style: TextStyle(fontSize: 18),
                ),
                Text(
                  'Password: ${_loggedInUser!['password']}',
                  style: TextStyle(fontSize: 18),
                ),
                SizedBox(height: 16),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
