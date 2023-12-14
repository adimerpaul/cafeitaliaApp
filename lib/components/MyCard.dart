import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class MyCard extends StatelessWidget {
  final double radius = 12;
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

  Color getContainerColorFromString(String colorName) {
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

  Color getBadgeColorFromString(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'red':
        return Colors.red[200] ?? Colors.white;
      case 'blue':
        return Colors.blue[200] ?? Colors.white;
      case 'green':
        return Colors.green[200] ?? Colors.white;
      case 'yellow':
        return Colors.yellow[200] ?? Colors.white;
      case 'purple':
        return Colors.purple[200] ?? Colors.white;
      default:
        return Colors.white; // Color predeterminado si el nombre no coincide con ninguno de los anteriores
    }
  }
  Color getTextColorFromString(String colorName) {
    switch (colorName.toLowerCase()) {
      case 'red':
        return Colors.red[800] ?? Colors.white;
      case 'blue':
        return Colors.blue[800] ?? Colors.white;
      case 'green':
        return Colors.green[800] ?? Colors.white;
      case 'yellow':
        return Colors.yellow[800] ?? Colors.white;
      case 'purple':
        return Colors.purple[800] ?? Colors.white;
      default:
        return Colors.white; // Color predeterminado si el nombre no coincide con ninguno de los anteriores
    }
  }

  @override
  Widget build(BuildContext context) {
    Color containerColor = getContainerColorFromString(color);
    Color badgeColor = getBadgeColorFromString(color);
    Color textColor = getTextColorFromString(color);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        decoration: BoxDecoration(
          color: containerColor,
          borderRadius: BorderRadius.circular(radius),
        ),
        child: Column(
          children: [
            //badge
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Container(
                  decoration: BoxDecoration(
                    color: badgeColor, // Color con opacidad diferente
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(radius),
                      topRight: Radius.circular(radius),
                    ),
                  ),
                  // padding: EdgeInsets.all(8),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      '\Bs$price',
                      style: TextStyle(
                        fontSize: 18,
                        color: textColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            //image
            Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
                child: Image.network(
                  dotenv.env['API_BACK']!+'/../images/' + image,
                  width: 100,
                  height: 100,
                )
            ),
            // Agrega aquí los demás widgets que necesitas para tu tarjeta (título, subtítulo, imagen, etc.)
          ],
        ),
      ),
    );
  }
}
