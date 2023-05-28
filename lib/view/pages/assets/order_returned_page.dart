import 'package:flutter/material.dart';
import 'package:gh_app/view/pages/assets/home_page.dart';

class OrderReturnedPage extends StatefulWidget {
  const OrderReturnedPage({super.key});

  @override
  State<OrderReturnedPage> createState() => _OrderReturnedPageState();
}

class _OrderReturnedPageState extends State<OrderReturnedPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Center(
              child: Column(
        children: [
          Align(
            alignment: Alignment.topLeft,
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: IconButton(
                  onPressed: () => Navigator.push(context,
                      MaterialPageRoute(builder: (context) => HomePage())),
                  icon: Icon(
                    Icons.close,
                    size: 30,
                  )),
            ),
          ),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  size: 120,
                  Icons.restart_alt_rounded,
                  color: Colors.amberAccent[400],
                ),
                SizedBox(height: 30),
                Text(
                  'Order returned',
                  style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
                )
              ],
            ),
          ),
        ],
      ))),
    );
  }
}
