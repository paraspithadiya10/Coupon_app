// country.dart
import 'dart:convert';

List<CountryModel> countryModelFromJson(String str) =>
    List<CountryModel>.from(json.decode(str).map((x) => CountryModel.fromJson(x)));

String countryModelToJson(List<CountryModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class CountryModel {
  Flags? flags;
  Name? name;
  String? cca2;
  Map<String, Currency>? currencies;

  CountryModel({
    this.flags,
    this.name,
    this.cca2,
    this.currencies,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) => CountryModel(
        flags: Flags.fromJson(json["flags"]),
        name: Name.fromJson(json["name"]),
        cca2: json["cca2"],
        currencies: Map.from(json["currencies"])
            .map((k, v) => MapEntry<String, Currency>(k, Currency.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "flags": flags?.toJson(),
        "name": name?.toJson(),
        "cca2": cca2,
        "currencies": Map.from(currencies!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };

  /// Converts the model into a map for storing in the local database.
  /// Here we store the currency symbol instead of the currency name.
  Map<String, dynamic> toDbMap() {
    return {
      'code': cca2,
      'name': name?.common,
      'flagUrl': flags?.png,
      'currency': currencies?.values.first.symbol, // store symbol
    };
  }

  /// Creates a CountryModel from a database map.
  /// We create partial objects because we only stored a few fields.
  factory CountryModel.fromDbMap(Map<String, dynamic> map) {
    return CountryModel(
      flags: Flags(png: map['flagUrl'], svg: '', alt: ''),
      name: Name(common: map['name'], official: '', nativeName: {}),
      cca2: map['code'],
      currencies: {
        '': Currency(name: '', symbol: map['currency'])
      },
    );
  }
}

class Currency {
  String? name;
  String? symbol;

  Currency({
    this.name,
    this.symbol,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        name: json["name"],
        symbol: json["symbol"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "symbol": symbol,
      };
}

class Flags {
  String? png;
  String? svg;
  String? alt;

  Flags({
    this.png,
    this.svg,
    this.alt,
  });

  factory Flags.fromJson(Map<String, dynamic> json) => Flags(
        png: json["png"],
        svg: json["svg"],
        alt: json["alt"],
      );

  Map<String, dynamic> toJson() => {
        "png": png,
        "svg": svg,
        "alt": alt,
      };
}

class Name {
  String? common;
  String? official;
  Map<String, NativeName>? nativeName;

  Name({
    this.common,
    this.official,
    this.nativeName,
  });

  factory Name.fromJson(Map<String, dynamic> json) => Name(
        common: json["common"],
        official: json["official"],
        nativeName: Map.from(json["nativeName"])
            .map((k, v) => MapEntry<String, NativeName>(k, NativeName.fromJson(v))),
      );

  Map<String, dynamic> toJson() => {
        "common": common,
        "official": official,
        "nativeName": Map.from(nativeName!)
            .map((k, v) => MapEntry<String, dynamic>(k, v.toJson())),
      };
}

class NativeName {
  String? official;
  String? common;

  NativeName({
    this.official,
    this.common,
  });

  factory NativeName.fromJson(Map<String, dynamic> json) => NativeName(
        official: json["official"],
        common: json["common"],
      );

  Map<String, dynamic> toJson() => {
        "official": official,
        "common": common,
      };
}
