import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:text_to_speech/text_to_speech.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(MyApp());
}

// ignore: must_be_immutable
class MyApp extends StatelessWidget {
  MyApp({Key? key}) : super(key: key);
  final speak = TextEditingController();
  String para = '';
  double volume = 1.0;
  @override
  Widget build(BuildContext context) {
    Future<void> speaktext(String para) async {
      TextToSpeech speech = TextToSpeech();
      speech.setVolume(volume);
      speech.setRate(0.75);
      speech.setPitch(1.0);
      speech.setLanguage('en-US');
      List<String>? voices = await speech.getVoiceByLang('en-US');
      speech.speak(para);
    }

    return MaterialApp(
        debugShowCheckedModeBanner: false,
        home: Scaffold(
          resizeToAvoidBottomInset: false,
          backgroundColor: Colors.red[100],
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Text-To-Speech'),
            backgroundColor: Colors.red[300],
          ),
          body: Container(
            padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
            child: Column(children: [
              const SizedBox(
                height: 90,
              ),
              TextField(
                cursorColor: Colors.red[800],
                controller: speak,
                decoration: InputDecoration(
                  labelText: 'Text',
                  labelStyle: const TextStyle(color: Colors.red),
                  hintText: 'Enter the paragraph',
                  hintStyle: TextStyle(color: Colors.red[300]),
                  enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.red),
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                  ),
                  suffixIcon: IconButton(
                    onPressed: () {
                      speak.clear();
                    },
                    icon: const Icon(
                      Icons.clear,
                      color: Colors.red,
                    ),
                  ),
                ),
                maxLines: 5,
              ),
              const SizedBox(
                height: 300,
              ),
              Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      onPressed: () {
                        if (volume > 0.0) {
                          volume = volume - 0.2;
                        } else if (volume <= 0.0) {
                          volume = 0.0;
                        }
                      },
                      child: const Icon(
                        Icons.volume_down_rounded,
                      ),
                      backgroundColor: Colors.red[300],
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        para = speak.text;
                        speaktext(para);
                      },
                      child: const Icon(
                        Icons.play_arrow_rounded,
                      ),
                      backgroundColor: Colors.red[300],
                    ),
                    FloatingActionButton(
                      onPressed: () {
                        if (volume < 1.0) {
                          volume = volume + 0.2;
                        } else if (volume >= 1.0) {
                          volume = 1.0;
                        }
                      },
                      child: const Icon(
                        Icons.volume_up_rounded,
                      ),
                      backgroundColor: Colors.red[300],
                    ),
                  ]),
            ]),
          ),
        ));
  }
}
