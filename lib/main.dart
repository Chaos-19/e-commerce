import 'package:flutter/material.dart';

void main() => runApp(new Ecommerce());

class Ecommerce extends StatelessWidget {
  const Ecommerce({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData.light(),
      home: Container(
        color: Colors.blue,
      ),
    );
  }
}
