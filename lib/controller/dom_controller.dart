import 'package:flutter/material.dart';

import '../provider/dom_provider.dart';

class DominioController extends ChangeNotifier {
  String estatus = '';
  List<dynamic> hosts = [];
  final DominioProvider provider;

  DominioController({required this.provider});

  Future getDominio(String dominio) async {
    try {
      var json = await provider.getDominioApi(dominio);
      estatus = json?['status'];
      hosts = json?['hosts'];
      notifyListeners();
    } catch (e) {
      print(e);
    }
  }
}
