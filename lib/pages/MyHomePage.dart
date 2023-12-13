import 'package:cafeitalia/components/MyTab.dart';
import 'package:cafeitalia/models/Category.dart';
import 'package:cafeitalia/services/ImportService.dart';
import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;
import 'package:hive/hive.dart';
import 'package:line_icons/line_icons.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int cartItems = 5;
  bool _loading = false;
  String textCategory = 'TODO';
  List<Category> categories = [];
  List<Widget> tabs = [];
  import() async {
    setState(() {
      _loading = true;
    });
    final import = await ImportService().importDatos();
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
            Padding(
              padding: const EdgeInsets.only(right: 24.0),
              child: badges.Badge(
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
              ),
            ),
          ],
        ),
        body: Column(
          children: [
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
                }else{
                  textCategory = categories[i].name;
                }
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
          ],
        ),
      ),
    );
  }
}