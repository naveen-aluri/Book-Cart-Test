import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:sales/screens/utils/config.dart';

import 'book_widget.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  double grandTotal = 0.0;
  Map<String, int> _booksMap = {
    'Book - 1': 0,
    'Book - 2': 0,
    'Book - 3': 0,
    'Book - 4': 0,
    'Book - 5': 0,
  };

  Map<String, int> _cartMap = new HashMap();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.all(20),
        child: Text(
          'Total Price = \$$grandTotal',
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500),
        ),
      ),
      body: ListView.builder(
        itemCount: _booksMap.keys.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          String title = _booksMap.keys.toList()[index];
          return BookWidget(
            title: '$title',
            qty: _booksMap[title] ?? 0,
            onAddPressed: () {
              _booksMap.update(title, (value) => value + 1);
              setState(() {});
              calculateCart();
            },
            onRemovePressed: () {
              ///Update the value only if the Qty is greater than Zero.
              _booksMap.update(title, (value) => value != 0 ? value - 1 : 0);
              setState(() {});
              calculateCart();
            },
          );
        },
      ),
    );
  }

  calculateCart() {
    grandTotal = 0.0;

    _cartMap.addAll(_booksMap);

    ///Remove the cart items that contains 0 qty,
    _cartMap.removeWhere((key, value) => value == 0);

    calculateTotal(_cartMap);
  }

  ///Using recursion to calculate the Total.
  Map<String, int> calculateTotal(Map<String, int> cartMap) {
    double total = 0.0;

    switch (cartMap.length) {
      case 1:
        cartMap.forEach((key, value) {
          total += (Config.EACH_BOOK_CONST * value).toDouble();
        });
        break;
      case 2:
        total += (Config.EACH_BOOK_CONST * 2).toDouble();
        double percentage = ((total * Config.TWO_DIFF_BOOKS_PERCENTAGE) / 100);
        total -= percentage;
        break;
      case 3:
        total += (Config.EACH_BOOK_CONST * 3).toDouble();
        double percentage =
            ((total * Config.THREE_DIFF_BOOKS_PERCENTAGE) / 100);
        total -= percentage;
        break;
      case 4:
        total += (Config.EACH_BOOK_CONST * 4).toDouble();
        double percentage = ((total * Config.FOUR_DIFF_BOOKS_PERCENTAGE) / 100);
        total -= percentage;
        break;
      case 5:
        total += (Config.EACH_BOOK_CONST * 5).toDouble();
        double percentage = ((total * Config.FIVE_DIFF_BOOKS_PERCENTAGE) / 100);
        total -= percentage;
        break;
      default:
    }

    ///For every recursion, decrease the Qty by 1.
    cartMap.updateAll((key, value) => value - 1);

    ///Remove the cart items that contains 0 qty,
    cartMap.removeWhere((key, value) => value == 0);

    ///Add the [total] to the [grandTotal]
    grandTotal += total;

    if (cartMap.isEmpty)
      return cartMap;
    else
      return calculateTotal(cartMap);
  }
}
