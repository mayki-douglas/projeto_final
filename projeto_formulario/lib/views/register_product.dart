import 'package:flutter/material.dart';
import 'package:projeto_formulario/database/product_helper.dart';
import 'package:projeto_formulario/model/model.dart';
import 'package:projeto_formulario/views/home.dart';

class RegisterProduct extends StatefulWidget {

  @override
  _RegisterProductState createState() => _RegisterProductState();
}

class _RegisterProductState extends State<RegisterProduct> {

  ProductHelper helper = ProductHelper();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final _ipController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _familyController = TextEditingController();
  final _standardController = TextEditingController();
  final _typeController = TextEditingController();

  _rowIp() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: new TextFormField(
      controller: _ipController,
      keyboardType: TextInputType.number,
      decoration: new InputDecoration(labelText: 'Digite o IP', border: OutlineInputBorder()),
      validator: (value){
        if(value.isEmpty){
          return 'Preencha o campo corretamente';
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
      keyboardType: TextInputType.number,
      decoration: new InputDecoration(labelText: 'Digite a Descrição', border: OutlineInputBorder()),
      validator: (value){
        if(value.isEmpty){
          return 'Preencha o campo corretamente';
        }
        return null;
       },
      ),
    );

  }

  _rowFamily() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: new TextFormField(
      controller: _familyController,
      keyboardType: TextInputType.text,
      decoration: new InputDecoration(labelText: 'Digite a Família do pneu', border: OutlineInputBorder()),
      validator: (value){
        if(value.isEmpty){
          return 'Preencha o campo corretamente';
        }
        return null;
        },
      ),
    );
  }

  _rowStandard() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: new TextFormField(
      controller: _standardController,
      keyboardType: TextInputType.number,
      decoration: new InputDecoration(labelText: 'Digite o padrão de bancalização', border: OutlineInputBorder()),
      validator: (value){
        if(value.isEmpty){
          return 'Preencha o campo corretamente';
        }
        return null;
        }
      ),
    );
  }

  _rowType() {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: new TextFormField(
      controller: _typeController,
      keyboardType: TextInputType.text,
      decoration: new InputDecoration(labelText: 'Digite se o Pneu é Radial/Convencional/Agro/OTR', border: OutlineInputBorder()),
      validator: (value){
        if(value.isEmpty){
          return 'Preencha o campo corretamente';
        }
        return null;
        },
      ),
    );
  }


  _rowRegister(BuildContext context) {
    return TextButton(
      onPressed: () {
        print('clicou em registrar');
        if(_formKey.currentState.validate()){
          Product product = Product(_ipController.text,
              _descriptionController.text,
              _familyController.text,
              _standardController.text,
              _typeController.text);
          helper.save(product);
          Navigator.push(context, MaterialPageRoute(builder: (context) => Home()));
        }else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Não foi possível salvar o produto')));
        }
      },
      child: Text('Registrar'),
    );
  }

  _rowFormUI(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          _rowIp(),
          _rowDescription(),
          _rowFamily(),
          _rowStandard(),
          _rowType(),
          _rowRegister(context),
        ],
      ),
    );
  }

  _rowForm(BuildContext context){
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.onUserInteraction,
      child: _rowFormUI(context),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  ProductHelper _helper = ProductHelper();
  List<Product> _products = [];

  save(BuildContext context) async {
    print('clicou');
    final product = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => RegisterProduct()));
    if (product != null)
      await _helper.save(product);
    await _helper.fetchAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Registro de produto'),),
      body: _rowForm(context),
    );
  }
}