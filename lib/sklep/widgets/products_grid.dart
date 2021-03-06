import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import './product_item.dart';

class ProductsGrid extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final productsData = Provider.of<Products>(context);
    final products = productsData.items;
    return
      Expanded(
        child: GridView.builder(

      padding: const EdgeInsets.all(10.0),
      itemCount: products.length,
          itemBuilder: (ctx, i) => ChangeNotifierProvider.value(
            value: products[i],
            child:  ProductItem(),
          ),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        childAspectRatio: 3 / 4,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
      ),
    )
      );
  }
}
