import 'package:flutter/material.dart';
import 'package:shop_app/pages/modules/default/cart_manager.dart';
import 'package:shop_app/pages/modules/default/order_manager.dart';

import './modules/default/nav_drawer.dart';
import './modules/default/product.dart';
import './modules/default/order.dart';

class CartSide extends StatefulWidget {
  final CartManager cartManager;
  final OrderManager orderManager;

  const CartSide({
    Key? key,
    required this.cartManager,
    required this.orderManager,
  }) : super(key: key);

  @override
  State<CartSide> createState() => _CartSideState();
}

class _CartSideState extends State<CartSide> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        drawer: const NavDrawer(),
        appBar: AppBar(
          title: const Text("Cart"),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Total"),
                  Row(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 20),
                        child: Text("${widget.cartManager.getPriceOfOrder()}"),
                      ),
                      ElevatedButton(
                        onPressed: () => {
                          widget.orderManager.addOrder(
                            Order(widget.cartManager.productList.map((element)=>element).toList(), DateTime.now()),
                          ),
                          setState(() {
                              widget.cartManager.productList.clear();
                            },
                          ),
                        },
                        child: Text("Order now"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: widget.cartManager.getAllDifferentNamesInOrder().length,
                itemBuilder: (BuildContext context, int index) {
                  String name = widget.cartManager.getAllDifferentNamesInOrder()[index];
                  return ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text(
                        "€${widget.cartManager.getPriceOfProductWithSameName(name)}",
                        style:
                            const TextStyle(color: Colors.white, fontSize: 12),
                      ),
                    ),
                    title: Text(
                      name,
                    ),
                    subtitle: Text(
                      "Total: €${widget.cartManager.getSumPriceOfProductsWithSameName(name)}",
                    ),
                    trailing: Text(
                      "${widget.cartManager.getCountOfProducts(name)} x",
                    ),
                  );
                }),
          ],
        ));
  }
}
