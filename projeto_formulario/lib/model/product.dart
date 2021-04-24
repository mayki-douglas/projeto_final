import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:projeto_formulario/database/product_helper.dart';
import 'package:projeto_formulario/views/register_product.dart';

class Product {

  int id;
  String ip;
  String description;
  String family;
  String standard;
  String type;

  Product(this.ip, this.description, this.family, this.standard, this.type);

  Product.fromMap(Map map) {
    id = map['id_column'];
    ip = map['ip_column'];
    description = map['description_column'];
    family = map['family_column'];
    standard = map['standard_column'];
    type = map['type_column'];
  }

  Map toMap(){
    Map<String, dynamic> map = {
      'ip_column': ip,
      'description_column': description,
      'family_column': family,
      'standard_column': standard,
      'type_column': type,
    };
    if(id != null) {
      map['id_column'] = id;
    }
    return map;
  }

  @override
  String toString() {
    return 'Product{id: $id, ip: $ip, description: $description, family: $family, standard: $standard, type: $type}';
  }

}