import 'package:flutter/material.dart';

import './modules/default/nav_drawer.dart';

import './modules/default/order.dart';
import 'modules/default/product.dart';

class OrderSide extends StatelessWidget {
  final List<Order> orders;

  const OrderSide({
    Key? key,
    required this.orders,
  }) : super(key: key);

  List<String> getAllProductsForOrder(int index) {
    List<String> names = <String>[];
    Order order = orders[index];
    for (int i = 0; i < order.products.length; i++) {
      if (!names.contains(order.products[i].name)) {
        names.add(order.products[i].name);
      }
    }
    return names;
  }

  double getPriceOfOrder(int index) {
    double price = 0;
    List<Product> products = orders[index].products;

    for (int i = 0; i < products.length; i++) {
      price += products[i].price;
    }
    print(price);
    return price;
  }

  String getDateOfOrder(int index) {
    DateTime date = orders[index].date;
    return "${date.day}.${date.month}.${date.year} ${date.hour}:${date.minute}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text("Orders"),
      ),
      body: ListView.builder(
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemCount: orders.length,
        itemBuilder: (BuildContext context, int index) {
          return ListTile(
            title: Text("€${getPriceOfOrder(index)}"),
            subtitle: Text("${getDateOfOrder(index)}"),
            trailing: Icon(Icons.arrow_drop_down_sharp),
            onTap: () => {
              print("Clicked")
            },
          );
        },
      ),
    );
  }
}
