import 'package:flutter/material.dart';
import 'package:gh_app/view/pages/assets/home_page.dart';

class OrderConfirmedPage extends StatefulWidget {
  const OrderConfirmedPage({super.key});

  @override
  State<OrderConfirmedPage> createState() => _OrderConfirmedPageState();
}

class _OrderConfirmedPageState extends State<OrderConfirmedPage> {
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
                    Icons.check_circle_rounded,
                    color: Colors.green,
                  ),
                  SizedBox(height: 30),
                  Text(
                    'Order Picked Up',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.w500),
                  )
                ],
              ))
            ],
          ),
        ),
      ),
    );
  }
}
