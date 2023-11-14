import 'dart:io';

import './product.dart';

class Order {
  List<Product> products;
  DateTime date;

  Order(this.products, this.date);
}
