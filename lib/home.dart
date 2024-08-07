import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SuccessPage extends StatelessWidget {
  final List<Map<String, String>> credentialsList;

  SuccessPage({required this.credentialsList});

  Future<void> _signOut(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', false);
    Navigator.popUntil(context, (route) => route.isFirst);
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
              ...credentialsList.map((credentials) {
                return Column(
                  children: [
                    Text(
                      'Username: ${credentials['username']}',
                      style: TextStyle(fontSize: 18),
                    ),
                    Text(
                      'Password: ${credentials['password']}',
                      style: TextStyle(fontSize: 18),
                    ),
                    SizedBox(height: 16),
                  ],
                );
              }).toList(),
            ],
          ),
        ),
      ),
    );
  }
}
