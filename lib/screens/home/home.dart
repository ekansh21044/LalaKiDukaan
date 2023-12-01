import 'package:flutter/material.dart';
import 'package:lalakidukaan_app/screens/admin_login/admin_login.dart';
import 'package:lalakidukaan_app/appbar.dart';

import '../agent_login/agent_login.dart';
import '../care_login/care_login.dart';
import '../customer_login/customer_login.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: topAppBar(),
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        const Padding(
          padding: EdgeInsets.all(100.0),
          child: Text(
            'Welcome',
            style: TextStyle(
              fontSize: 40,
            ),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
                width: 300,
                height: 200,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AdminLogin()),
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.manage_accounts,
                        color: Colors.black,
                        size: 150,
                      ),
                      Text('Admin',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                          )),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                )),
            SizedBox(
                width: 300,
                height: 200,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CustomerLogin()),
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.shopping_cart,
                        color: Colors.black,
                        size: 150,
                      ),
                      Text('Customer',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                          )),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                )),
            SizedBox(
                width: 300,
                height: 200,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AgentLogin()),
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.delivery_dining,
                        color: Colors.black,
                        size: 150,
                      ),
                      Text('Delivery Agent',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                          )),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                )),
            SizedBox(
                width: 300,
                height: 200,
                child: OutlinedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const CareLogin()),
                    );
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: const [
                      Icon(
                        Icons.support_agent,
                        color: Colors.black,
                        size: 150,
                      ),
                      Text('Customer Support',
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.black,
                          )),
                      SizedBox(
                        width: 5,
                      ),
                    ],
                  ),
                )),
          ],
        ),
      ]),
    );
  }
}
