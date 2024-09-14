import 'dart:convert';

import 'package:achofa/screens/maquinaria.dart';

Future<List<Maquinaria>> fetchFromApi(int page, int pageSize, String search) async {
  var http;
  final response = await http.post(
    Uri.parse('https://controller.agrochofa.cl/api/sgm/maquinarias/public'),
    body: jsonEncode({
      'page': page,
      'pageSize': pageSize,
      'search': search,
    }),
    headers: {
      'Content-Type': 'application/json',
    },
  );

  if (response.statusCode == 200) {
    final data = jsonDecode(response.body) as List;
    return data.map((json) => Maquinaria.fromJson(json)).toList();
  } else {
    throw Exception('Error al cargar las maquinarias');
  }
}
