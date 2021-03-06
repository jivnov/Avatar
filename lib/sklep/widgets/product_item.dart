import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/product.dart';
import '../providers/cart.dart';


class ProductItem extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    final product = Provider.of<Product>(context, listen: false);
    final cart = Provider.of<Cart>(context, listen: false);

    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        child: GestureDetector(
          child: Image.asset(
            product.path,
          ),
        ),
        footer: GridTileBar(
          backgroundColor: Colors.orange,
          title: Text(
            product.price.toString(), //wyświetla cenę naklejki
            textAlign: TextAlign.center,
          ),
          trailing: IconButton(
            icon: Icon(
              Icons.shopping_cart, color: Colors.pink,

            ),
            onPressed: () {
              cart.addItem(product.id, product.price, product.title, product.path);
            },
            color: Theme.of(context).accentColor,
            highlightColor: Colors.black26,

          ),
        ),
      ),
    );
  }
}
