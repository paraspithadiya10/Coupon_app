import 'dart:convert';
import 'package:demo_app/data/preferences/country_model.dart';
import 'package:demo_app/data/preferences/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// Fetches countries from the REST API and returns a list of CountryModel.
Future<List<CountryModel>> fetchCountriesFromApi() async {
  final url = 'https://restcountries.com/v3.1/all?fields=name,flags,cca2,currencies';
  final response = await http.get(Uri.parse(url));
  if (response.statusCode == 200) {
    final List<dynamic> jsonList = json.decode(response.body);
    return jsonList.map((json) => CountryModel.fromJson(json)).toList();
  } else {
    throw Exception('Failed to load countries');
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Ensure the database is initialized.
  await CountryDbHelper.getInstance.getDB();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Country List',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CountryListPage(),
    );
  }
}

class CountryListPage extends StatefulWidget {
  @override
  _CountryListPageState createState() => _CountryListPageState();
}

class _CountryListPageState extends State<CountryListPage> {
  List<CountryModel> _countries = [];
  List<CountryModel> _displayedCountries = [];
  bool _ascending = true;
  String _searchQuery = '';

  @override
  void initState() {
    super.initState();
    _loadCountries();
  }

  /// Loads countries from the local database.
  /// If none exist, fetches from the API and stores them locally.
  Future<void> _loadCountries() async {
    final List<Map<String, dynamic>> countryMaps =
        await CountryDbHelper.getInstance.getAllCountries();
    List<CountryModel> countriesFromDb =
        countryMaps.map((map) => CountryModel.fromDbMap(map)).toList();

    if (countriesFromDb.isEmpty) {
      // Fetch from API and then insert into the database.
      countriesFromDb = await fetchCountriesFromApi();
      List<Map<String, dynamic>> dbMaps =
          countriesFromDb.map((country) => country.toDbMap()).toList();
      await CountryDbHelper.getInstance.insertCountries(dbMaps);
    }

    setState(() {
      _countries = countriesFromDb;
    });
    _applyFilters();
  }

  /// Applies search filtering and sorts by country code.
  void _applyFilters() {
    List<CountryModel> filtered = _countries.where((country) {
      return (country.name?.common ?? '')
          .toLowerCase()
          .contains(_searchQuery.toLowerCase());
    }).toList();

    filtered.sort((a, b) => _ascending
        ? (a.cca2 ?? '').compareTo(b.cca2 ?? '')
        : (b.cca2 ?? '').compareTo(a.cca2 ?? ''));
    setState(() {
      _displayedCountries = filtered;
    });
  }

  void _toggleSortOrder() {
    setState(() {
      _ascending = !_ascending;
    });
    _applyFilters();
  }

  void _onSearchChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
    _applyFilters();
  }

  /// Deletes a country on long press.
  void _deleteCountry(CountryModel country) async {
    await CountryDbHelper.getInstance.deleteCountry(country.cca2 ?? '');
    setState(() {
      _countries.removeWhere((c) => c.cca2 == country.cca2);
    });
    _applyFilters();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Countries'),
        actions: [
          IconButton(
            icon:
                Icon(_ascending ? Icons.arrow_upward : Icons.arrow_downward),
            onPressed: _toggleSortOrder,
          ),
        ],
      ),
      body: Column(
        children: [
          // Search functionality.
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                labelText: 'Search by country name',
                border: OutlineInputBorder(),
              ),
              onChanged: _onSearchChanged,
            ),
          ),
          // Country list.
          Expanded(
            child: ListView.builder(
              itemCount: _displayedCountries.length,
              itemBuilder: (context, index) {
                final country = _displayedCountries[index];
                return ListTile(
                  leading: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              FlagFullScreenPage(country: country),
                        ),
                      );
                    },
                    child: Hero(
                      tag: country.cca2 ?? '',
                      child: Image.network(
                        country.flags?.png ?? '',
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  title: Text(country.name?.common ?? ''),
                  /*subtitle: Text(
                      'Code: ${country.cca2 ?? ''}\nCurrency: ${country.currencies?.sHP?.name ?? ''}'),*/
                  onLongPress: () {
                    _deleteCountry(country);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

/// Displays the country flag in full-screen with a Hero animation.
class FlagFullScreenPage extends StatelessWidget {
  final CountryModel country;
  const FlagFullScreenPage({Key? key, required this.country}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(country.name?.common ?? ''),
      ),
      body: Center(
        child: Hero(
          tag: country.cca2 ?? '',
          child: Image.network(
            country.flags?.png ?? '',
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
