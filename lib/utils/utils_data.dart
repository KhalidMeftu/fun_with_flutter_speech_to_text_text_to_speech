import 'package:flutter_spech_recognition/model/language_entity.dart';
import 'package:flutter_tts/flutter_tts.dart';

List<String> _languageFrom = [
  'Arabic',
  'French',
];
List<String> _languageTo = [
  'French',
  'Arabic',
];

Language _firstLanguage = Language('fr', 'French');
Language _secondLanguage = Language('ar', 'Arabic');
final FlutterTts flutterTts= FlutterTts();


/// user speaks french word
Future speakInputFrenchWord(String frenchWord) async
{
  await flutterTts.setLanguage("fr-FR");
  await flutterTts.setPitch(1);
  await flutterTts.speak(frenchWord);
}

/// user speacking arabic word
Future speakInputArabicWord(String arWord) async
{
  await flutterTts.setLanguage("ar");
  await flutterTts.setPitch(1);
  await flutterTts.speak(arWord);
}


/// app will out put in french
Future speakOutFrench(String frenchWord) async
{
  await flutterTts.setLanguage("fr-FR");
  await flutterTts.setPitch(1);
  await flutterTts.speak(frenchWord);
}

/// app will speack out arabic
Future speakOutArabic(String arWord) async
{
  await flutterTts.setLanguage("ar");
  await flutterTts.setPitch(1);
  await flutterTts.speak(arWord);
}