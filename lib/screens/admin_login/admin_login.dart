import 'package:flutter/material.dart';
import 'package:lalakidukaan_app/appbar.dart';
import 'package:http/http.dart' as http;
import 'package:lalakidukaan_app/screens/authconfirmed/auth_confirmed.dart';

class AdminLogin extends StatefulWidget {
  const AdminLogin({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AdminLoginState createState() => _AdminLoginState();
}

class _AdminLoginState extends State<AdminLogin> {
  late String loginID;
  final loginIDcontroller = TextEditingController();

  late String email;
  final emailController = TextEditingController();

  late String passwd;
  final passwdController = TextEditingController();

  bool authenticate = false;

  void setAuthenticate(bool auth) {
    setState(() {
      authenticate = auth;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topAppBar(),
      body: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const SizedBox(
            height: 1000,
            width: 400,
            child: DecoratedBox(
                decoration: BoxDecoration(
              color: Colors.grey,
            )),
          ),
          const SizedBox(
            width: 100,
          ),
          Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            const Text(
              'Welcome Admin',
              style: TextStyle(color: Colors.black, fontSize: 40),
            ),
            const SizedBox(height: 40),
            const Text(
              '''This app provides limited functionality.
          Thus, the option of adding another admin/user/agent is not available.''',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 16,
                color: Colors.black,
              ),
            ),
            const SizedBox(height: 40),
            SizedBox(
              width: 500,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextField(
                      controller: loginIDcontroller,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Login ID'),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      controller: emailController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Email address'),
                    ),
                    const SizedBox(height: 10),
                    TextField(
                      obscureText: true,
                      controller: passwdController,
                      decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Enter Password'),
                    ),
                  ]),
            ),
            const SizedBox(height: 40),
            SizedBox(
                width: 150,
                child: FloatingActionButton.extended(
                    label: const Text(
                      'Verify',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                      ),
                    ), // <-- Text
                    backgroundColor: Colors.orange[400],
                    onPressed: () async {
                      loginID = loginIDcontroller.text;
                      email = emailController.text;
                      passwd = passwdController.text;
                      var context = this.context;
                      var authenticate =
                          await _authenticateAdmin(loginID, email, passwd);
                      if (context.mounted && authenticate) {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const AuthenticationConfirmed()));
                      } else if (!authenticate) {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Authentication Error'),
                            content: const Text('Invalid login credentials'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      } else {
                        showDialog(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Authentication Error'),
                            content: const Text('context.mounted = false'),
                            actions: [
                              TextButton(
                                onPressed: () => Navigator.pop(context),
                                child: const Text('OK'),
                              ),
                            ],
                          ),
                        );
                      }
                    }))
          ]),
          const SizedBox(
            width: 100,
          ),
          const SizedBox(
            height: 1000,
            width: 400,
            child: DecoratedBox(
                decoration: BoxDecoration(
              color: Colors.grey,
            )),
          ),
        ],
      ),
    );
  }

  Future<bool> _authenticateAdmin(
      String id, String email, String passwd) async {
    final url = 'http://localhost:5000/authenticateAdmin/$id/$email/$passwd';
    var response = await http.get(Uri.parse(url));
    if (response.body == 'valid') {
      return Future<bool>.value(true);
    } else {
      return Future<bool>.value(false);
    }
  }
}
