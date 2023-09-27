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


