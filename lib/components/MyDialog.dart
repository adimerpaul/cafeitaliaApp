import 'package:flutter/material.dart';

import '../models/Products.dart';

class MyDialog extends StatefulWidget {
  final double total;
  final int mesa;
  final List<Product> products;

  const MyDialog({
    Key? key,
    required this.total,
    required this.mesa,
    required this.products,
  }) : super(key: key);

  @override
  State<MyDialog> createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: () {
        print(widget.products.length);
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Mesa',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    '#${widget.mesa}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.deepPurple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    'Bs ${widget.total}',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.redAccent,
                      fontWeight: FontWeight.bold,
                    ),
                  )
                ],
              ),
              content: Container(
                width: double.maxFinite,
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: widget.products.length,
                  itemBuilder: (BuildContext context, int index) {
                    Product product = widget.products[index];
                    return ListTile(
                      title: Text(product.name+' - '+product.price.toString()+ ' Bs'),
                      subtitle: Text('Cantidad: ${product.cantidadCarrito}'),
                      trailing: Text(
                          'Bs ${product.price * product.cantidadCarrito}',
                          style: TextStyle(
                            fontSize: 18,
                            color: Colors.redAccent,
                            fontWeight: FontWeight.bold,
                          )
                      ),
                    );
                  },
                ),
              ),
              actions: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: (){},
                      child: Text('Pagar'),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop(); // Cierra el diálogo
                      },
                      child: Text('Cerrar'),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
      child: Text(
        'Total: Bs ${widget.total}',
        style: TextStyle(
          fontSize: 18,
          color: Colors.redAccent,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
