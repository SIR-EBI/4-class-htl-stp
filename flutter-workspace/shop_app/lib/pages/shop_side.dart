import 'package:flutter/material.dart';
import 'package:shop_app/pages/modules/default/cart_manager.dart';
import 'package:shop_app/pages/modules/default/product_manager.dart';

import './modules/default/nav_drawer.dart';
import './modules/default/product.dart';
import 'modules/shop-side/shop_side_gridtile.dart';

class ShopSide extends StatefulWidget {
  final ProductManager productManager;
  final CartManager cartManager;

  const ShopSide({
    Key? key,
    required this.productManager,
    required this.cartManager,
  }) : super(key: key);

  @override
  State<ShopSide> createState() => _ShopSideState();
}

class _ShopSideState extends State<ShopSide> {
  bool showFav = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text("Products"),
        actions: [
          PopupMenuButton(
            itemBuilder: (context) {
              return [
                PopupMenuItem(
                  value: 0,
                  onTap: () => {
                    setState(() {
                        showFav = true;
                      },
                    ),
                  },
                  child: const Text("Only Favorites"),
                ),
                PopupMenuItem(
                  value: 1,
                  onTap: () => {
                    setState(() {
                        showFav = false;
                      },
                    ),                  },
                  child: const Text("Show All"),
                )
              ];
            },
            onSelected: (value) {
              print(value);
            },
          ),
          IconButton(
            icon: const Icon(Icons.shopping_cart),
            onPressed: () => {
              Navigator.pushNamed(context, "/cartSide"),
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, crossAxisSpacing: 10),
          itemCount: widget.productManager.getCountOfProducts(),
          itemBuilder: (BuildContext context, index) {
            if ((showFav && widget.productManager.productList[index].favourite) || !showFav) {
              return ShopSideGridTile(
                product: widget.productManager.productList[index],
                changeFavourite: widget.productManager.changeFavourite,
                addProductToShoppingCart: widget.cartManager.addProduct,
              );
            }
          },
        ),
      ),
    );
  }
}
