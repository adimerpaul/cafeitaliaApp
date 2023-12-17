import 'package:cafeitalia/components/MyCard.dart';
import 'package:cafeitalia/components/MyDialog.dart';
import 'package:cafeitalia/components/MyTab.dart';
import 'package:cafeitalia/models/Category.dart';
import 'package:cafeitalia/models/Products.dart';
import 'package:cafeitalia/services/ImportService.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:hive/hive.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final url_back = dotenv.env['API_BACK'];
  int cartItems = 0;
  double total = 0;
  bool _loading = false;
  String textCategory = 'TODO';
  int category_id = 0;
  List<Category> categories = [];
  List<Product> products = [];
  List<Product> productsAll = [];
  List<Widget> tabs = [];
  int selectedMesa = 0;
  import() async {
    setState(() {
      _loading = true;
    });
    await ImportService().importDatos();
    getDatos();
    setState(() {
      _loading = false;
    });
  }

  @override
  initState() {
    // TODO: implement initState
    super.initState();
    getDatos();
  }
  getDatos() async {
    var categoriesBox = await Hive.openBox<Category>('categories');
    categories = categoriesBox.values.toList();
    tabs.clear();
    tabs.add(
      MyTab(icon: 'checkCircle'),
    );
    categories.forEach((category) {
      tabs.add(
        MyTab(icon: category.icon),
      );
    });
    var productsBox = await Hive.openBox<Product>('products');
    products = productsBox.values.toList();
    products.sort((a, b) => a.category_id.compareTo(b.category_id));
    productsAll = products;
    setState(() {});
  }

  filtrarCategoria(int category_id){
    if(category_id == 0){
      products = productsAll;
    }else{
      products = productsAll.where((element) => element.category_id == category_id).toList();
    }
  }
  cantidadPedida(){
    cartItems = 0;
    total = 0;
    products.forEach((element) {
      cartItems += element.cantidadCarrito;
      total += element.cantidadCarrito * element.price;
    });
    setState(() {});
  }
  productConCarrito(List<Product> products){
    List<Product> productsCarrito = [];
    products.forEach((element) {
      if(element.cantidadCarrito > 0){
        productsCarrito.add(element);
      }
    });
    return productsCarrito;
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: tabs.length,
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.only(left: 24.0),
            child: Icon(
              Icons.menu,
              color: Colors.grey[900],
              size: 36,
            ),
          ),
          actions: [
            MyDialog(
              total: total,
              mesa: selectedMesa+1,
              products: productConCarrito(products),
              callback: () {
                setState(() {
                  products.forEach((element) {
                    element.cantidadCarrito = 0;
                  });
                  cantidadPedida();
                });
              },
            ),
            Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child:
              cartItems != 0 ?
              badges.Badge(
                position: badges.BadgePosition.topEnd(top: -10, end: -12),
                badgeContent: Text(
                  cartItems.toString(),
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
                child: Icon(
                  Icons.shopping_cart,
                  color: Colors.grey[900],
                  size: 36,
                ),
              ):
              Icon(
                Icons.shopping_cart,
                color: Colors.grey[900],
                size: 36,
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(8, (index) {
                    return TextButton(
                      onPressed: () {
                        // print(index);
                        setState(() {
                          selectedMesa = index;
                        });
                      },
                      child: Text(
                        'Mesa ${index + 1}',
                        style: TextStyle(
                          fontSize: 18,
                          color: selectedMesa == index ? Colors.white : Colors.black,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        primary: selectedMesa == index ? Colors.purple : Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                    );
                  }),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 24.0),
              child: Row(
                children: [
                  Text(
                    'Categoria ',
                    style: TextStyle(
                      fontSize: 18,
                      // fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    textCategory,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: _loading ? null : import,
                    child: _loading? CircularProgressIndicator() : Text(
                      'Import',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.purple,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  ),
                  ElevatedButton(
                      onPressed: (){
                        setState(() {
                          filtrarCategoria(0);
                          products.forEach((element) {
                            element.cantidadCarrito = 0;
                          });
                          cantidadPedida();
                        });
                      },
                      child: Text(
                        'Cancelar',
                        style: TextStyle(
                          fontSize: 16,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(16),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(height: 24),
            TabBar(
              onTap: (index) {
                final i= index-1;
                if(i == -1){
                    textCategory = 'TODO';
                    category_id = 0;
                }else{
                  textCategory = categories[i].name;
                  category_id = categories[i].id;
                }
                filtrarCategoria(category_id);
                setState(() {});
              },
              tabs: tabs,
              labelColor: Colors.purple,
              unselectedLabelColor: Colors.grey[400],
              indicatorColor: Colors.purple,
              indicatorSize: TabBarIndicatorSize.label,
              indicatorWeight: 4,
              labelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
              unselectedLabelStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            Expanded(
                child: GridView.builder(
                  padding: EdgeInsets.all(10),
                  itemCount: products.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 5,
                    childAspectRatio: 1/1.4,
                    // childAspectRatio: 0.75,
                    // crossAxisSpacing: 24,
                    // mainAxisSpacing: 10,
                  ),
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        setState(() {
                          products[index].cantidadCarrito++;
                          cantidadPedida();
                        });
                      },
                      child: MyCard(
                        index: index,
                        title: products[index].name,
                        subtitle: products[index].categoryName,
                        image: products[index].imagen,
                        price: products[index].price.toString(),
                        color: products[index].color,
                        cantidadCarrito: products[index].cantidadCarrito,
                        callbackMinus: (){
                          setState(() {
                            products[index].cantidadCarrito--;
                            cantidadPedida();
                          });
                        },
                      ),
                    );
                  },
                )
            )
          ],
        ),
      ),
    );
  }
}