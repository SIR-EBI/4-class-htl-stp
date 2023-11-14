import 'order.dart';

class OrderManager {
  List<Order> orderList;

  OrderManager({required this.orderList});

  void addOrder(Order order) {
    orderList.add(order);
  }

  void removeProduct(String name) {
    for (int index = 0; index < orderList.length; index++) {
      orderList[index].products.removeWhere((product) => product.name == name);
    }
  }
}