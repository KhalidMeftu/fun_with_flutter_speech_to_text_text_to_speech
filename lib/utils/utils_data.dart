import 'package:flutter_spech_recognition/model/language_entity.dart';
import 'package:flutter_tts/flutter_tts.dart';

List<String> languageFrom = [
  'Arabic',
  'French',
];
List<String> languageTo = [
  'French',
  'Arabic',
];

Language firstLanguage = Language('fr', 'French');
Language secondLanguage = Language('ar', 'Arabic');


/// user speaks french word
Future speakInputFrenchWord(String frenchWord, FlutterTts flutterTts) async
{
  await flutterTts.setLanguage("fr-FR");
  await flutterTts.setPitch(1);
  await flutterTts.speak(frenchWord);
}

/// user speacking arabic word
Future speakInputArabicWord(String arWord, FlutterTts flutterTts) async
{
  await flutterTts.setLanguage("ar");
  await flutterTts.setPitch(1);
  await flutterTts.speak(arWord);
}


/// app will out put in french
Future speakOutFrench(String frenchWord, FlutterTts flutterTts) async
{
  await flutterTts.setLanguage("fr-FR");
  await flutterTts.setPitch(1);
  await flutterTts.speak(frenchWord);
}

/// app will speack out arabic
Future speakOutArabic(String arWord, FlutterTts flutterTts) async
{
  await flutterTts.setLanguage("ar");
  await flutterTts.setPitch(1);
  await flutterTts.speak(arWord);
}


Map<String, String> arabicToFrenchData = {
  'مرحبا': 'importun',
  'غير مرحب به': 'il est le bienvenu',
};

Map<String, String> frenchToArabicData = {
  'importun':'مرحبا',
  'il est le bienvenu':'غير مرحب به',
  'Salut':'الوداع',
};

Map<String, String> mix = {
  'importun':'مرحبا',
  'il est le bienvenu':'غير مرحب به',
  'Salut':'الوداع',
  'مرحبا': 'importun',
  'غير مرحب به': 'il est le bienvenu',
};



String? searchMap(String query,String languageCode ) {

  if (languageCode == "ar") {
    final List<String> arabicMatchingKey = arabicToFrenchData.keys
        .where((key) => key.toLowerCase().contains(query.toLowerCase()))
        .toList();
    if (arabicMatchingKey.isNotEmpty) {
      final String firstMatchingKey = arabicMatchingKey.first;
      return arabicToFrenchData[firstMatchingKey];
    } else {
      return 'No matching value found';
    }
  }
  else if(languageCode == "fr") {
    final List<String> frenchMatchingKeys = frenchToArabicData.keys
        .where((key) => key.toLowerCase().contains(query.toLowerCase()))
        .toList();

    if (frenchMatchingKeys.isNotEmpty) {
      final String firstMatchingKey = frenchMatchingKeys.first;
      return frenchToArabicData[firstMatchingKey];
    } else {
      return 'No matching value found';
    }
  }
}

