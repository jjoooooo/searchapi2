import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'Products.dart';

import 'addsearch.dart';


void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider<ProductProvider>(create: (_) => ProductProvider()),

    ],
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);


    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Search'),
        ),
        body: ProductSearchScreen(),
      ),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ProductSearchScreen extends StatefulWidget {
  @override
  _ProductSearchScreenState createState() => _ProductSearchScreenState();
}

class _ProductSearchScreenState extends State<ProductSearchScreen> {
  TextEditingController _searchController = TextEditingController();
  List<Products> _products = [];

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);


    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            onChanged: (value){
              if(value.length%2==0){
                provider.fetchProducts(value);
              }
            },
            controller: _searchController,
            decoration: InputDecoration(
              labelText: 'Products',
              suffixIcon: IconButton(
                icon: Icon(Icons.search),
                onPressed: () {
                  provider.fetchProducts(_searchController.text.toString());
                },
              ),
            ),
          ),
        ),
        Expanded(
          child:
          MyList(),
        ),
      ],
    );
  }


}
class MyList extends StatelessWidget {
  const MyList({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductProvider>(context);


    return  ListView.builder(
        itemCount: provider.products.length,
        itemBuilder: (context, index) {
          var p = provider.products[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage('${p.thumbnail}'),),
            title: Text(p.brand.toString()),
            subtitle: Text(p.price.toString()),
          );
        }
        );
    }
  }