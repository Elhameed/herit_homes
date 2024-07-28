import 'dart:convert';
import 'package:http/http.dart' as http;

class CountryService {
  Future<List<dynamic>> fetchCountries() async {
    final response =
        await http.get(Uri.parse('https://restcountries.com/v3.1/all'));

    if (response.statusCode == 200) {
      return jsonDecode(response.body).map((data) {
        return {
          'name': data['name']['common'],
          'code': (data['idd']['root'] +
              (data['idd']['suffixes'] != null
                  ? data['idd']['suffixes'][0]
                  : '')),
          'flag': data['flags']['png']
        };
      }).toList();
    } else {
      throw Exception('Failed to load country data');
    }
  }
}
