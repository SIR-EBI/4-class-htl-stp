import 'package:shop_app/pages/modules/default/product.dart';

class CartManager {
  List<Product> productList;

  CartManager({required this.productList});

  void addProduct(Product product) {
    productList.add(product);
  }

  void removeProduct(String name) {
    productList.removeWhere((product) => product.name == name);
  }

  double getPriceOfOrder() {
    double price = 0;
    for (int index = 0; index < productList.length; index++) {
      price += productList[index].price;
    }
    return price;
  }

  List<String> getAllDifferentNamesInOrder() {
    List<String> productNames = <String>[];

    for (int index = 0; index < productList.length; index++) {
      if (!productNames.contains(productList[index].name)) {
        productNames.add(productList[index].name);
      }
    }
    return productNames;
  }

  double getPriceOfProductWithSameName(String name) {
    for (int index = 0; index < productList.length; index++) {
      if (productList[index].name == name) {
        return productList[index].price;
      }
    }
    return 0;
  }

  int getCountOfProducts(String name) {
    int count = 0;
    for (int index = 0; index < productList.length; index++) {
      if (productList[index].name == name) {
        count++;
      }
    }
    return count;
  }

  double getSumPriceOfProductsWithSameName(String name) {
    double sum = 0;
    for (int index = 0; index < productList.length; index++) {
      if (productList[index].name == name) {
        sum += productList[index].price;
      }
    }
    return sum;
  }
}