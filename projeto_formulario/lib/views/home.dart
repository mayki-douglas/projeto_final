import 'package:flutter/material.dart';
import 'package:projeto_formulario/constant.dart';
import 'package:projeto_formulario/database/database.dart';
import 'package:projeto_formulario/menu/menu_drawer.dart';
import 'package:projeto_formulario/model/model.dart';
import 'package:projeto_formulario/views/products_list.dart';

import 'register_product.dart';

class Home extends StatefulWidget {

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Home> {

  ProductHelper helper = ProductHelper();
  List<Product> products = [];

  GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
  TextEditingController _ipController = new TextEditingController();
  TextEditingController _descriptionController = new TextEditingController();

  _rowImage(){
    return Image.asset(Constant.ASSET_LOGO, width: 265, height: 265,);
  }

  _rowIp(){
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: new TextFormField(
        controller: _ipController,
        keyboardType: TextInputType.number,
        decoration: new InputDecoration(labelText: 'Digite o IP do Pneu',border: OutlineInputBorder()),
        maxLength: 20,
        validator: (value) {
          if(value.isEmpty) {
            return 'Digite um valor válido!';
          }
          return null;
        },
      ),
    );
  }

  _rowDescription() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: new TextFormField(
        controller: _descriptionController,
        decoration: new InputDecoration(labelText: 'Digite a Descrição do Pneu', border: OutlineInputBorder()),
        maxLength: 100,
        validator: (value) {
          if(value.isEmpty) {
            return 'Digite uma descrição válida!';
          }
          return null;
        },
      ),
    );
  }

  _rowButton(BuildContext context) {
    return TextButton.icon(
      onPressed: () {
        _register(context);
        _resetFields();
      },
      label: Text('Buscar'),
      icon: Icon(Icons.search),
    );
  }


  _formUI(BuildContext context) {
    return Column(
      children: [
        _rowImage(),
        _rowIp(),
        _rowDescription(),
        _rowButton(context),
       ]
    );
  }

  _rowForm(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: _formUI(context),
    );
  }

  @override
  void initState() {
    helper.fetchAll().then((list) {
      setState(() {
        products = list;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Consulta de mercadoria'),
        centerTitle: true,
      ),
      drawer: MenuDrawer(),
      body: Center(
        child: ListView(
            children: <Widget>[
              _rowForm(context),
            ]
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) => ProductsList(products: products,)));
          },
          child: Icon(Icons.list),
          backgroundColor: Colors.indigo,
        ),
    );
  }


  _register(BuildContext context) {
    print('Buscou: ${_formKey.currentState.validate()}');
    }

  _resetFields() => _formKey.currentState.reset();



}
