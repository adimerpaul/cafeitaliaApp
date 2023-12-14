import 'package:flutter/material.dart';

class MyCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final String image;
  final String price;
  final String color;

  const MyCard({
    Key? key,
    required this.title,
    required this.subtitle,
    required this.image,
    required this.price,
    required this.color,
  }) : super(key: key);

  Color getColorFromString(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'red':
        return Colors.red[50] ?? Colors.white;
      case 'blue':
        return Colors.blue[50] ?? Colors.white;
      case 'green':
        return Colors.green[50] ?? Colors.white;
      case 'yellow':
        return Colors.yellow[50] ?? Colors.white;
      case 'purple':
        return Colors.purple[50] ?? Colors.white;
      default:
        return Colors.white; // Color predeterminado si el nombre no coincide con ninguno de los anteriores
    }
  }

  @override
  Widget build(BuildContext context) {
    Color cardColor = getColorFromString(color);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: cardColor,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(price),
              ],
            )
            // Agrega aquí los demás widgets que necesitas para tu tarjeta (título, subtítulo, imagen, etc.)
          ],
        ),
      ),
    );
  }
}
