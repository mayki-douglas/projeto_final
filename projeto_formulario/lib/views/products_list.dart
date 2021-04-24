import 'package:flutter/material.dart';
import 'package:projeto_formulario/database/product_helper.dart';
import 'package:projeto_formulario/model/product.dart';
import 'package:projeto_formulario/views/register_product.dart';

class ProductsList extends StatefulWidget {

  List<Product> products;


  ProductsList({this.products});

  @override
  _ProductsListState createState() => _ProductsListState();
}

class _ProductsListState extends State<ProductsList> {

  ProductHelper _helper = ProductHelper();
  List<Product> _products = [];
  int _size = 0;

  save(BuildContext context) async {
    print('clicou');
    final product = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => RegisterProduct()));
    if (product != null)
      await _helper.save(product);
    await _helper.fetchAll();
  }


  _list(BuildContext context){
    print(widget.products.toString());
    print(widget.products.length);
    return ListView.builder(
        padding: EdgeInsets.all(10.0),
        itemCount: widget.products.length,
        itemBuilder: (context, index)=> _productCard(context, index),
      );
    }

  _productCard(BuildContext context, int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _helper.delete(index);
          _helper.fetchAll().then((list){
            widget.products = list;
          });
        });
        print('clicou card');
      },
      child: Card(
        child: Padding(
          padding: EdgeInsets.all(10.0),
          child: Row(
            children: [
              Container(
                width: 80.0,
                height: 80.0,
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.indigo
                ),
              ),
              Padding(padding: EdgeInsets.only(left: 10.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(widget.products[index].ip ?? '',
                        style: TextStyle(
                            fontSize: 20.0, fontWeight: FontWeight.bold),
                      ),
                      Text(widget.products[index].description ?? '',
                        style: TextStyle(fontSize: 15.0),
                      ),
                      Text(widget.products[index].family ?? '',
                        style: TextStyle(fontSize: 15.0),
                      ),
                      Text(widget.products[index].standard ?? '',
                        style: TextStyle(fontSize: 15.0),
                      ),
                      Text(widget.products[index].type ?? '',
                        style: TextStyle(fontSize: 15.0),
                      )
                    ],
                  )
              )
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de produtos'),),
      body: Column(
        children: [

          Expanded(child: _list(context),),
          ],
        ),
      );
  }
}
