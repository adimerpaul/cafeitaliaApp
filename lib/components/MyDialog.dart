import 'package:flutter/material.dart';

class MyDialog extends StatefulWidget {
  final double total;
  const MyDialog({
    super.key,
    required this.total,
  });

  @override
  State<MyDialog> createState() => _MyDialogState();
}

class _MyDialogState extends State<MyDialog> {
  @override
  Widget build(BuildContext context) {
    // TextButton(
    //   onPressed: () {},
    //   child: Text(
    //     'Total: Bs ${total}',
    //     style: TextStyle(
    //       fontSize: 18,
    //       color: Colors.redAccent,
    //       fontWeight: FontWeight.bold,
    //     ),
    //   ),
    // ),
    return TextButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Título del diálogo'),
              content: Text('Contenido del diálogo'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop(); // Cierra el diálogo
                  },
                  child: Text('Cerrar'),
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
