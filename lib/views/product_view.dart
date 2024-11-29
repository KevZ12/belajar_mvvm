import 'package:belajar_mvvm/viewModel/product_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ProductView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productModel = Provider.of<ProductViewModel>(context);
    return Scaffold(
        appBar: AppBar(
          title: Text("products"),
        ),
        body: productModel.products.isEmpty
            ? TextButton(
                onPressed: () => {
                      productModel.fetchProduct(),
                    },
                child: Text("see all products",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    )))
            : productModel.isloading == true
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: productModel.products.length +
                        1, // +1 for the TextButton
                    itemBuilder: (context, index) {
                      return index == productModel.products.length
                          ? Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: TextButton(
                                onPressed: () {
                                  // Handle button press
                                  productModel.removeProduct();
                                },
                                child: Text('remove',
                                    style: TextStyle(fontSize: 16)),
                              ),
                            )
                          : ListTile(
                              title: Text(productModel.products[index].title),
                              subtitle: Text(
                                  productModel.products[index].description),
                            );
                    },
                  ));
  }
}
