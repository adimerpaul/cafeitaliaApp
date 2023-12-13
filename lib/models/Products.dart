import 'package:hive/hive.dart';
part 'Products.g.dart';

@HiveType(typeId: 0)
class Product {
  @HiveField(0)
  final int id;
  @HiveField(1)
  final String name;
  @HiveField(2)
  final double price;
  @HiveField(3)
  final String imagen;
  @HiveField(4)
  final int cantidad;
  @HiveField(5)
  final int category_id;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.imagen,
    required this.cantidad,
    required this.category_id,
  });
}