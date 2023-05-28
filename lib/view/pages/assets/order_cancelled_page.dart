import 'package:flutter/material.dart';
import 'package:gh_app/view/pages/assets/home_page.dart';

class OrderCancelledPage extends StatefulWidget {
  const OrderCancelledPage({super.key});

  @override
  State<OrderCancelledPage> createState() => _OrderCancelledPageState();
}

class _OrderCancelledPageState extends State<OrderCancelledPage> {
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
                  Icons.cancel_rounded,
                  color: const Color.fromARGB(255, 226, 82, 71),
                ),
                SizedBox(height: 30),
                Text(
                  'Order Cancelled',
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
