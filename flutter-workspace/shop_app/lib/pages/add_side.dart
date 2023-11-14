import 'package:flutter/material.dart';
import 'package:shop_app/pages/modules/default/product.dart';
import 'package:shop_app/pages/modules/default/product_manager.dart';

import 'modules/default/nav_drawer.dart';

class AddSide extends StatefulWidget {
  final ProductManager productManager;

  const AddSide({Key? key, required this.productManager,}) : super(key: key);

  @override
  State<AddSide> createState() => _AddSideState();
}

class _AddSideState extends State<AddSide> {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController priceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  final TextEditingController imgUrlController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const NavDrawer(),
      appBar: AppBar(
        title: const Text("Add Product"),
      ),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Name'
              ),
            ),
            TextField(
              controller: priceController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Price'
              ),
            ),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'Description'
              ),
            ),
            TextField(
              controller: imgUrlController,
              decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: 'img URL'
              ),
            ),
            ElevatedButton(
              onPressed: () => {
                widget.productManager.addProduct(
                  Product(
                    nameController.text,
                    imgUrlController.text,
                    double.parse(priceController.text),
                  ),
                ),
                Navigator.pushNamed(context, "/shopSide"),
              },
              child: Text("Add Product"),
            ),
          ],
        ),
      ),
    );
  }
}
