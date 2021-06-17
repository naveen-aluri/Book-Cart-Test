import 'package:flutter/material.dart';

class BookWidget extends StatelessWidget {
  final String title;
  final int qty;
  final VoidCallback onRemovePressed;
  final VoidCallback onAddPressed;

  const BookWidget(
      {Key? key,
      required this.title,
      required this.qty,
      required this.onRemovePressed,
      required this.onAddPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        leading: Icon(
          Icons.book_outlined,
          size: 40,
          color: Colors.green,
        ),
        title: Text(
          '$title',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
                onPressed: onRemovePressed,
                icon: Icon(
                  Icons.remove_circle_outline_outlined,
                  size: 30,
                  color: Colors.red,
                )),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Text('$qty',
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey.shade800,
                      fontWeight: FontWeight.bold)),
            ),
            IconButton(
                onPressed: onAddPressed,
                icon: Icon(
                  Icons.add_circle_outline_outlined,
                  size: 30,
                  color: Colors.green,
                ))
          ],
        ),
      ),
    );
  }
}
