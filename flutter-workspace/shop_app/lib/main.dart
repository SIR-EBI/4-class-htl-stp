import 'package:flutter/material.dart';
import 'package:shop_app/pages/add_side.dart';
import 'package:shop_app/pages/modules/default/cart_manager.dart';
import 'package:shop_app/pages/modules/default/order_manager.dart';
import 'package:shop_app/pages/modules/default/product_manager.dart';

import './pages/cart_side.dart';
import './pages/manage_side.dart';
import './pages/order_side.dart';
import './pages/shop_side.dart';

import './pages/modules/default/product.dart';
import './pages/modules/default/order.dart';

void main() => runApp(const MyApp());

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  ProductManager productManager = ProductManager(
    productList: <Product>[
  Product(
  "test",
    "https://microsites.pearl.de/i/76/sd2208_8.jpg",
    9.83,
  ),
      Product

  (

  "test1",
  "https://microsites.pearl.de/i/76/sd2208_8.jpg",
  10.83,
  ),

  Product(
  "test2",
  "https://microsites.pearl.de/i/76/sd2208_8.jpg",
  15.83,
  ),
  ],);

  CartManager cartManager = CartManager(productList: <Product>[
  Product(
  "ProdcutName",
  "",
  4,
  ),
  Product(
  "ProdcutName",
  "",
  4,
  ),
  Product(
  "Testproduct",
  "",
  10.3,
  ),
  ],);

  OrderManager orderManager = OrderManager(orderList: <Order>[
  Order(<Product>[
  Product(
  "ProdcutName",
  "",
  4,
  ),
  Product(
  "ProdcutName",
  "",
  4,
  ),
  Product(
  "Testproduct",
  "",
  10.3,
  ),
  ], DateTime.now())
  ],);


  @override
  Widget build(BuildContext context) {
  return MaterialApp(
  title: "Shop App",
  initialRoute: "/shopSide",
  routes: {
  '/shopSide': (context) => ShopSide(
  productManager: productManager,
  cartManager: cartManager,
  ),
  '/manageSide': (context) => ManageSide(
  productManager: productManager,
  orderManager: orderManager,
  cartManager: cartManager,
  ),
  '/orderSide': (context) => OrderSide(
  orders: orderManager.orderList,
  ),
  '/cartSide': (context) => CartSide(
  cartManager: cartManager,
  orderManager: orderManager,
  ),
  '/addSide': (context) => AddSide(
  productManager: productManager,
  )
  },
  );
  }
}
