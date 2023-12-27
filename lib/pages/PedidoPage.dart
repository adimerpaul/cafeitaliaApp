import 'package:flutter/material.dart';

import '../models/Products.dart';
import '../services/ImportService.dart';

class PedidoPage extends StatefulWidget {
  final List<Product> products;
  const PedidoPage({
    super.key,
    required this.products,
  });

  @override
  State<PedidoPage> createState() => _PedidoPageState();
}

class _PedidoPageState extends State<PedidoPage> {
  List orderPending = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getOrdersPending();
  }
  getOrdersPending() async{
    var orders = await ImportService().orderPending();
    setState(() {
      orderPending = orders;
      print(orderPending);
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pedidos'),
      ),
      body: Column(
        children: [
          Text(
            'Pedidos Pendientes',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          Expanded(
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: orderPending.length,
              itemBuilder: (BuildContext context, int index) {
                // Asumiendo que orderPending contiene información sobre los pedidos pendientes
                // Puedes personalizar esto según la estructura real de tus datos
                return ListTile(
                  title: Text(
                    '${orderPending[index]['id']} Mesa #${orderPending[index]['mesa']} - Total: Bs ${orderPending[index]['total']}',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Productos: ${orderPending[index]['TextProducts']}',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                  ),
                  // Agrega más información según sea necesario
                  onTap: () {
                    // Implementa la lógica para agregar productos a este pedido pendiente
                    // Puedes abrir otro diálogo o realizar la acción deseada
                    // ...
                  },
                );
              },
            ),
          ),
        ],
      )
    );
  }
}
