import 'package:cafeitalia/services/ImportService.dart';
import 'package:flutter/material.dart';

import '../models/Products.dart';

class MyDialog extends StatefulWidget {
  final double total;
  final int mesa;
  final List<Product> products;
  //ejecutar metodo de padre
  final VoidCallback? callback;
  const MyDialog({
    Key? key,
    required this.total,
    required this.mesa,
    required this.products,
    this.callback,
  }) : super(key: key);

  @override
  State<MyDialog> createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  bool _isLoading = false;
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
                      onPressed: _isLoading ? null : submitOrder,
                      style: ElevatedButton.styleFrom(
                        primary: Colors.greenAccent,
                      ),
                      child: _isLoading ? CircularProgressIndicator() :
                      Row(
                        children: [
                          Icon(
                            Icons.payment,
                            color: Colors.white,
                          ),
                          const SizedBox(width: 10),
                          Text(
                              'Pagar',
                              style: TextStyle(
                                fontSize: 24,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              )
                          ),
                        ],
                      ),
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

  Future<void> submitOrder() async {
    setState(() {
      _isLoading = true;
    });

    BuildContext localContext = context; // Almacena una referencia local al contexto

    try {
      var result = await ImportService().order(widget.mesa, widget.total, widget.products);
      if (result != null) {
        ScaffoldMessenger.of(localContext).showSnackBar(
          SnackBar(
            content: Text('Pedido realizado con éxito'),
            backgroundColor: Colors.greenAccent,
          ),
        );
        Navigator.of(localContext).pop(); // Cierra el diálogo
        widget.callback!(); // Ejecuta el método del padre
      } else {
        ScaffoldMessenger.of(localContext).showSnackBar(
          SnackBar(
            content: Text('Error al realizar el pedido'),
            backgroundColor: Colors.redAccent,
          ),
        );
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
}
