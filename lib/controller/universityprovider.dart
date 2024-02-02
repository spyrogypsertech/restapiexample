import 'dart:convert';
import 'dart:async';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:uidemo/model/university.dart';

class UniversityProvider extends ChangeNotifier {
  List<University> _universities = [];

  List<University> get universities => _universities;

  Future<void> fetchUniversities() async {
    final client = http.Client();
    try {
      final response = await client
          .get(
            Uri.parse(
                'http://universities.hipolabs.com/search?country=United+states'),
          )
          .timeout(Duration(seconds: 30));

      print(response.body);

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body) as List<dynamic>;
        _universities = data.map((item) {
          return University(
              name: item['name'],
              domain: item['domains'] != null && item['domains'].isNotEmpty
                  ? item['domains'][0]
                  : '',
              alphaCode: item['alpha_two_code'],
              stateProvince: item['state-province'] ?? 'N/A',
              webPages:
                  item['web_pages'] != null && item['web_pages'].isNotEmpty
                      ? item['web_pages'][0]
                      : '');
        }).toList();
        notifyListeners();
      } else {
        throw Exception('Failed to load universities');
      }
    } catch (error) {
      print('Error fetching universities: $error');
      throw Exception('Timeout or Error occurred while fetching universities');
    } finally {
      client.close();
    }
  }
}
