import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spech_recognition/utils/utils_data.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:speech_to_text/speech_to_text.dart' as speachToText;

class UserHome extends StatefulWidget {
  const UserHome({Key? key}) : super(key: key);

  @override
  State<UserHome> createState() => _UserHomeState();
}

class _UserHomeState extends State<UserHome> {
  final FlutterTts flutterTts = FlutterTts();
  final TextEditingController _controller = TextEditingController();
  final TextEditingController _controller2 = TextEditingController();
  FocusNode focusNode = FocusNode();
  String _selectedFromLanguage = 'French';
  String _selectedToLanguage = 'Arabic';
  bool isTransalated = false;
  late speachToText.SpeechToText _speech;
  bool _isListening = false;

  @override
  void initState() {
    // TODO: implement initState
    _speech = speachToText.SpeechToText();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                height: MediaQuery.of(context).size.height / 2.6,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 1,
                      blurRadius: 2,
                      offset: const Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        DropdownButton(
                          underline: const SizedBox(),
                          value: _selectedFromLanguage,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedFromLanguage = newValue!;
                            });
                          },
                          items: languageFrom.map((language) {
                            return DropdownMenuItem(
                              value: language,
                              child: Text(
                                language,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue[700],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.compare_arrows_outlined,
                            color: Colors.blue[700],
                          ),
                          onPressed: () {
                            print("Current Locale");
                            print(context.locale.languageCode.toString());
                            print(context.locale.languageCode == "ar");

                            if (context.locale.languageCode == "ar") {
                              context.setLocale(const Locale('fr'));
                            } else {
                              context.setLocale(const Locale('ar'));
                            }
                          },
                        ),
                        DropdownButton(
                          underline: SizedBox(),
                          value: _selectedToLanguage,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedToLanguage = newValue!;
                            });
                          },
                          items: languageTo.map((language) {
                            return DropdownMenuItem(
                              value: language,
                              child: Text(
                                language,
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w600,
                                  color: Colors.blue[700],
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          // Camera Conversation
                          children: [
                            Expanded(
                              child: Container(
                                height:
                                    MediaQuery.of(context).size.height / 6.5,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: TextFormField(
                                  style: const TextStyle(fontSize: 28),
                                  controller: _controller,
                                  focusNode: focusNode,
                                  textAlignVertical: TextAlignVertical.center,
                                  keyboardType: TextInputType.multiline,
                                  maxLines: 5,
                                  minLines: 1,
                                  decoration: InputDecoration(
                                    border: InputBorder.none,
                                    hintText: 'tap_here'.tr(),
                                    hintStyle: TextStyle(
                                        color: Colors.grey[400],
                                        fontSize: 28,
                                        fontWeight: FontWeight.w600),
                                    suffixIcon: Row(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        IconButton(
                                          icon: Icon(
                                            Icons.edit,
                                            color: Colors.grey[600],
                                          ),
                                          onPressed: () {
                                            _controller.text = "";
                                          },
                                        ),
                                        IconButton(
                                          icon: Icon(
                                            Icons.volume_up,
                                            color: Colors.grey[600],
                                          ),
                                          onPressed: () async {
                                            if (context.locale.languageCode ==
                                                "ar") {
                                              String val =
                                                  _controller.text.toString();
                                              speakInputArabicWord(
                                                  val, flutterTts);
                                            } else if (context
                                                    .locale.languageCode ==
                                                "fr") {
                                              String val2 =
                                                  _controller.text.toString();

                                              speakInputFrenchWord(
                                                  val2, flutterTts);
                                            }
                                          },
                                        ),
                                      ],
                                    ),
                                    contentPadding: const EdgeInsets.all(5),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            GestureDetector(
                              child: Column(
                                children: [
                                  _isListening
                                      ? const Icon(
                                          Icons.mic,
                                          size: 30,
                                          color: Colors.red,
                                        )
                                      : Icon(
                                          Icons.mic,
                                          size: 30,
                                          color: Colors.blue[700],
                                        ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'transcribe'.tr(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                              onTapDown: (_) {
                                if (context.locale.languageCode == "ar") {
                                  _listenToArabic();
                                } else if (context.locale.languageCode ==
                                    "fr") {
                                  _listenToFrench();
                                }
                              },
                            ),
                            InkWell(
                              onTap: () async {
                                setState(() {
                                  isTransalated = true;
                                });

                                String? translatedData = searchOppositeTranslation(
                                    _controller.text.toString(),
                                    context.locale.languageCode.toString());
                                _controller2.text = "";
                                _controller2.text = translatedData ?? '';
                              },
                              child: Column(
                                children: [
                                  Icon(
                                    Icons.search,
                                    size: 30,
                                    color: Colors.blue[700],
                                  ),
                                  const SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    'transcribe'.tr(),
                                    style: const TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500),
                                  )
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    )
                  ],
                ),
              ),
            ),

            isTransalated
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height / 2.6,
                      decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: const BorderRadius.all(Radius.circular(10)),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            spreadRadius: 1,
                            blurRadius: 2,
                            offset: const Offset(
                                0, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          Column(
                            children: [
                              Row(
                                children: [
                                  Expanded(
                                    child: Container(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              6.5,
                                      margin: const EdgeInsets.symmetric(
                                          horizontal: 10),
                                      child: TextFormField(
                                        style: const TextStyle(fontSize: 28),
                                        controller: _controller2,
                                        textAlignVertical:
                                            TextAlignVertical.center,
                                        keyboardType: TextInputType.multiline,
                                        maxLines: 5,
                                        minLines: 1,
                                        decoration: InputDecoration(
                                          border: InputBorder.none,
                                          //  hintText: 'tapHere'.tr(),
                                          hintStyle: const TextStyle(
                                              color: Colors.white,
                                              fontSize: 28,
                                              fontWeight: FontWeight.w600),
                                          suffixIcon: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            children: [
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.volume_up,
                                                  color: Colors.white,
                                                ),
                                                onPressed: () {
                                                  setState(() {
                                                    _isListening = false;
                                                  });
                                                  if (context.locale
                                                          .languageCode ==
                                                      "ar") {
                                                    String val = _controller2
                                                        .text
                                                        .toString();
                                                    speakOutFrench(
                                                        val, flutterTts);
                                                  } else if (context.locale
                                                          .languageCode ==
                                                      "fr") {
                                                    String val2 = _controller2
                                                        .text
                                                        .toString();

                                                    speakOutArabic(
                                                        val2, flutterTts);
                                                  }
                                                },
                                              ),
                                            ],
                                          ),
                                          contentPadding:
                                              const EdgeInsets.all(5),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                  )
                : Container(),
            //  Middle Card
          ],
        ),
      ),
    );
  }

  void _listenToArabic() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          localeId: 'ar',
          onResult: (val) => setState(() {
            _controller.text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              //_confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }

  void _listenToFrench() async {
    if (!_isListening) {
      bool available = await _speech.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech.listen(
          localeId: firstLanguage.code,
          onResult: (val) => setState(() {
            _controller.text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              //_confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech.stop();
    }
  }
}
