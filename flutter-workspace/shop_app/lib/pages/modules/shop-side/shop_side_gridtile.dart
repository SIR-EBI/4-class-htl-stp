import 'package:flutter/material.dart';

import '../default/product.dart';

class ShopSideGridTile extends StatefulWidget {
  final Product product;
  final Function changeFavourite;
  final Function addProductToShoppingCart;

  const ShopSideGridTile({
    Key? key,
    required this.product,
    required this.changeFavourite,
    required this.addProductToShoppingCart,
  }) : super(key: key);

  @override
  State<ShopSideGridTile> createState() => _ShopSideGridTileState();
}

class _ShopSideGridTileState extends State<ShopSideGridTile> {
  @override
  Widget build(BuildContext context) {
    return GridTile(
      child: Image.network(widget.product.imgURL),
      footer: Container(
        color: Colors.white38,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              onPressed: () => {
                setState(() {
                  widget.changeFavourite(widget.product.name);
                })
              },
              icon: Icon(widget.product.favourite ? Icons.ac_unit : Icons.heart_broken),
            ),
            Text(
              widget.product.name,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
            IconButton(
              onPressed: () => {
                widget.addProductToShoppingCart(widget.product),
              },
              icon: Icon(Icons.shopping_cart),
            )
          ],
        ),
      ),
    );
  }
}
