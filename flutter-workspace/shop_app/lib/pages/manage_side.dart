import 'package:flutter/material.dart';
import 'package:shop_app/pages/modules/default/cart_manager.dart';
import 'package:shop_app/pages/modules/default/order_manager.dart';
import 'package:shop_app/pages/modules/default/product_manager.dart';

import './modules/default/nav_drawer.dart';
import 'modules/default/product.dart';

class ManageSide extends StatefulWidget {
  final ProductManager productManager;
  final OrderManager orderManager;
  final CartManager cartManager;

  const ManageSide({
    Key? key,
    required this.productManager,
    required this.orderManager,
    required this.cartManager,
  }) : super(key: key);

  @override
  State<ManageSide> createState() => _ManageSideState();
}

class _ManageSideState extends State<ManageSide> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text("My products"),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => {
              Navigator.pushNamed(context, "/addSide"),
            },
          )
        ],
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: widget.productManager.productList.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            leading: Image.network(
              widget.productManager.productList[index].imgURL,
              fit: BoxFit.cover,
            ),
            title: Text(
              widget.productManager.productList[index].name,
            ),
            trailing: IconButton(
              onPressed: () => {
                setState(() {
                  String name = widget.productManager.productList[index].name;
                  widget.productManager.removeProduct(name);
                  widget.orderManager.removeProduct(name);
                  widget.cartManager.removeProduct(name);
                })
              },
              icon: Icon(Icons.delete),
            ),
          );
        },
      ),
    );
  }
}
