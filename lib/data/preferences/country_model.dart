// country.dart
class CountryModel {
  Flags? flags;
  Name? name;
  String? cca2;
  Currencies? currencies;

  CountryModel({this.flags, this.name, this.cca2, this.currencies});

  CountryModel.fromJson(Map<String, dynamic> json) {
    flags = json['flags'] != null ? Flags.fromJson(json['flags']) : null;
    name = json['name'] != null ? Name.fromJson(json['name']) : null;
    cca2 = json['cca2'];
    currencies = json['currencies'] != null
        ? Currencies.fromJson(json['currencies'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (flags != null) {
      data['flags'] = flags!.toJson();
    }
    if (name != null) {
      data['name'] = name!.toJson();
    }
    data['cca2'] = cca2;
    if (currencies != null) {
      data['currencies'] = currencies!.toJson();
    }
    return data;
  }

  /// Converts the model into a map for database storage.
  /// Only the fields needed for display are stored.
  Map<String, dynamic> toDbMap() {
    return {
      'code': cca2 ?? '',
      'name': name?.common ?? '',
      'flagUrl': flags?.png ?? '',
      'currency': currencies?.sHP?.name ?? '',
    };
  }

  /// Creates a CountryModel from a database map.
  factory CountryModel.fromDbMap(Map<String, dynamic> map) {
    return CountryModel(
      flags: Flags(png: map['flagUrl']),
      name: Name(common: map['name']),
      cca2: map['code'],
      currencies: Currencies(sHP: SHP(name: map['currency'])),
    );
  }
}

class Flags {
  String? png;
  String? svg;
  String? alt;

  Flags({this.png, this.svg, this.alt});

  Flags.fromJson(Map<String, dynamic> json) {
    png = json['png'];
    svg = json['svg'];
    alt = json['alt'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['png'] = png;
    data['svg'] = svg;
    data['alt'] = alt;
    return data;
  }
}

class Name {
  String? common;
  String? official;
  NativeName? nativeName;

  Name({this.common, this.official, this.nativeName});

  Name.fromJson(Map<String, dynamic> json) {
    common = json['common'];
    official = json['official'];
    nativeName = json['nativeName'] != null
        ? NativeName.fromJson(json['nativeName'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['common'] = common;
    data['official'] = official;
    if (nativeName != null) {
      data['nativeName'] = nativeName!.toJson();
    }
    return data;
  }
}

class NativeName {
  Eng? eng;

  NativeName({this.eng});

  NativeName.fromJson(Map<String, dynamic> json) {
    eng = json['eng'] != null ? Eng.fromJson(json['eng']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (eng != null) {
      data['eng'] = eng!.toJson();
    }
    return data;
  }
}

class Eng {
  String? official;
  String? common;

  Eng({this.official, this.common});

  Eng.fromJson(Map<String, dynamic> json) {
    official = json['official'];
    common = json['common'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['official'] = official;
    data['common'] = common;
    return data;
  }
}

class Currencies {
  SHP? sHP;

  Currencies({this.sHP});

  Currencies.fromJson(Map<String, dynamic> json) {
    sHP = json['SHP'] != null ? SHP.fromJson(json['SHP']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    if (sHP != null) {
      data['SHP'] = sHP!.toJson();
    }
    return data;
  }
}

class SHP {
  String? name;
  String? symbol;

  SHP({this.name, this.symbol});

  SHP.fromJson(Map<String, dynamic> json) {
    name = json['name'];
    symbol = json['symbol'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = {};
    data['name'] = name;
    data['symbol'] = symbol;
    return data;
  }
}
