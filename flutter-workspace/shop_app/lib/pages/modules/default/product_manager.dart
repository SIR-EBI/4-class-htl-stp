import 'package:shop_app/pages/modules/default/product.dart';

class ProductManager {
  List<Product> productList;

  ProductManager({required this.productList});

  void addProduct(Product product) {
    productList.add(product);
  }

  void removeProduct(String name) {
    productList.removeWhere((product) => product.name == name);
  }

  int getCountOfProducts() {
    return productList.length;
  }

  void changeFavourite(String name) {
    for (int index = 0; index < productList.length; index++) {
      if (productList[index].name == name) {
        productList[index].favourite = !productList[index].favourite;
        break;
      }
    }
  }
}