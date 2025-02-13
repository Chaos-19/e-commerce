import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pro_ecommerce/src/constants/strings.dart';
import 'package:pro_ecommerce/src/routing/app_router.dart';

class SharedScaffold extends StatelessWidget {
  final Widget body;
  final String title;

  const SharedScaffold({Key? key, required this.body, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            Strings.ecommerce,
            overflow: TextOverflow.visible,
            style: TextStyle(
              color: Colors.white,
              fontSize: 19,
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            //onPressed: () {},
            onPressed: () => context.goNamed(AppRoute.searchProduct.name),
          ),
          Stack(
            children: [
              IconButton(
                icon:
                    const Icon(Icons.notifications_active, color: Colors.white),
                onPressed: () {},
                //onPressed: () => context.goNamed(AppRoute.addJob.name),
              ),
              Positioned(
                top: 0,
                left: 30,
                child: Container(
                  padding: const EdgeInsets.all(4.0),
                  decoration: BoxDecoration(
                    color: Colors.red,
                    shape: BoxShape.circle,
                  ),
                  child: const Text(
                    '3',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: body,
    );
  }
}
