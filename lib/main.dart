import 'package:flutter/material.dart';
import 'package:translator/translator.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Translator',
      home: const MyHomePage(title: ''),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  TextEditingController textController = new TextEditingController();
  List<String> langauges = ["İngilizce", "Türkçe", "Fransızca", "Almanca"];

  String dropdownValue = "İngilizce";
  String dropdownValue1 = "Türkçe";

  dilayar() {
    if (dropdownValue == "İngilizce") {
      dil1 = "en";
    }
    if (dropdownValue == "Türkçe") {
      dil1 = "tr";
    }
    if (dropdownValue == "Fransızca") {
      dil1 = "fr";
    }
    if (dropdownValue == "Almanca") {
      dil1 = "de";
    }
    if (dropdownValue1 == "İngilizce") {
      dil2 = "en";
    }
    if (dropdownValue1 == "Türkçe") {
      dil2 = "tr";
    }
    if (dropdownValue1 == "Almanca") {
      dil2 = "de";
    }
    if (dropdownValue1 == "Fransızca") {
      dil2 = "fr";
    }
  }

  dil(String dil1, String dil2) {
    setState(() {
      translator.translate(textController.text, from: dil1, to: dil2).then((s) {
        setState(() {
          translatedPhrase = s.toString();
        });
      });
    });
  }

  var dil1 = "";
  var dil2 = "";
  var translator = GoogleTranslator();
  var translatedPhrase = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.black,
        actions: [
          DropdownButton<String>(
            underline: Container(
              alignment: Alignment.topLeft,
              height: 50,
              width: 20,
            ),
            dropdownColor: Color.fromRGBO(32, 33, 36, 5),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue = newValue!;
              });
            },
            value: dropdownValue,
            items: langauges.map<DropdownMenuItem<String>>(
              (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ).toList(),
          ),
          DropdownButton<String>(
            iconSize: 24,
            elevation: 16,
            underline: Container(
              height: 2,
              width: 20,
            ),
            dropdownColor: Color.fromRGBO(32, 33, 36, 5),
            onChanged: (String? newValue) {
              setState(() {
                dropdownValue1 = newValue!;
              });
            },
            value: dropdownValue1,
            items: langauges.map<DropdownMenuItem<String>>(
              (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(color: Colors.white),
                  ),
                );
              },
            ).toList(),
          )
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Flexible(
              flex: 1,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Color.fromRGBO(32, 33, 36, 5),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                          fillColor: Colors.white,
                          focusedBorder: OutlineInputBorder(
                            borderSide: const BorderSide(
                                color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.circular(25.0),
                          )),
                      style: TextStyle(color: Colors.white),
                      controller: textController,
                      cursorColor: Colors.white,
                    ),
                    MaterialButton(
                      child: Text("Translate"),
                      color: Colors.yellow,
                      onPressed: () {
                        dilayar();
                        dil(dil1, dil2);
                      },
                    ),
                  ],
                ),
              ),
            ),
            Flexible(
              flex: 1,
              child: Container(
                width: double.infinity,
                height: double.infinity,
                color: Color.fromRGBO(32, 33, 36, 5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      translatedPhrase,
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        MaterialButton(
                          child: Icon(Icons.content_copy),
                          onPressed: () {
                            Clipboard.setData(
                                ClipboardData(text: translatedPhrase));
                          },
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
