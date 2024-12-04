class Translations {
  static const Map<String, String> countries = {
    'England': 'Angleterre',
    'Spain': 'Espagne',
    'Germany': 'Allemagne',
    'France': 'France',
    'Italy': 'Italie',
    'Portugal': 'Portugal',
    'Netherlands': 'Pays-Bas',
    'Argentina': 'Argentine',
    'Brazil': 'Brésil',
    'Bulgaria': 'Bulgarie',
     'Serbia' : 'Serbie',
     'Austria' : 'Autriche'
  };

  static const Map<String, String> roundTranslations = {
    'Regular Season': 'Saison Régulière',
    'Regular Season - 1': '1ère Journée',
    'Regular Season - 2': '2ème Journée',
    'Regular Season - 3': '3ème Journée',
    'Regular Season - 4': '4ème Journée',
    'Regular Season - 5': '5ème Journée',
     'Regular Season - 6': '6ème Journée',
     'Regular Season - 7': '7ème Journée',
  'Regular Season - 8': '8ème Journée',
  'Regular Season - 9': '9ème Journée',
  'Regular Season - 10': '10ème Journée',
  'Regular Season - 11': '11ème Journée',
  'Regular Season - 12': '12ème Journée',
  'Regular Season - 13': '13ème Journée',
  'Regular Season - 14': '14ème Journée',
  'Regular Season - 15': '15ème Journée',
  'Regular Season - 16': '16ème Journée',
  'Regular Season - 17': '17ème Journée',
  'Regular Season - 18': '18ème Journée',
  'Regular Season - 19': '19ème Journée',
  'Regular Season - 20': '20ème Journée',
  'Regular Season - 21': '21ème Journée',
  'Regular Season - 22': '22ème Journée',
  'Regular Season - 23': '23ème Journée',
  'Regular Season - 24': '24ème Journée',
  'Regular Season - 25': '25ème Journée',
  'Regular Season - 26': '26ème Journée',
  'Regular Season - 27': '27ème Journée',
  'Regular Season - 28': '28ème Journée',
  'Regular Season - 29': '29ème Journée',
  'Regular Season - 30': '30ème Journée',
  'Regular Season - 31': '31ème Journée',
  'Regular Season - 32': '32ème Journée',
  'Regular Season - 33': '33ème Journée',
  'Regular Season - 34': '34ème Journée',
  'Regular Season - 35': '35ème Journée',
  'Regular Season - 36': '36ème Journée',
  'Regular Season - 37': '37ème Journée',
  'Regular Season - 38': '38ème Journée',
  'Regular Season - 39': '39ème Journée',
  'Regular Season - 40': '40ème Journée',
  'Regular Season - 41': '41ème Journée',
  'Regular Season - 42': '42ème Journée',
  'Regular Season - 43': '43ème Journée',
  'Regular Season - 44': '44ème Journée',
  'Regular Season - 45': '45ème Journée',
  'Regular Season - 46': '46ème Journée',
  'Regular Season - 47': '47ème Journée',
  'Regular Season - 48': '48ème Journée',
  'Regular Season - 49': '49ème Journée',
  'Regular Season - 50': '50ème Journée',
  'Regular Season - 51': '51ème Journée',
  'Regular Season - 52': '52ème Journée',
  'Regular Season - 53': '53ème Journée',
  'Regular Season - 54': '54ème Journée',
  'Regular Season - 55': '55ème Journée',
  'Regular Season - 56': '56ème Journée',
  'Regular Season - 57': '57ème Journée',
  'Regular Season - 58': '58ème Journée',
  'Regular Season - 59': '59ème Journée',
  'Regular Season - 60': '60ème Journée',
    'Round of 16': '8èmes de finale',
    'Quarter-finals': 'Quarts de finale',
    'Semi-finals': 'Demi-finales',
    'Final': 'Finale',
  };

  static String getCountryName(String? englishName) {
    if (englishName == null) return '';
    return countries[englishName] ?? englishName;
  }

  static String getRoundName(String? englishName) {
    if (englishName == null) return '';
    return roundTranslations[englishName] ?? englishName;
  }
}