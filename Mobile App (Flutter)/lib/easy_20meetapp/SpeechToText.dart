import 'package:avatar_glow/avatar_glow.dart';
import 'package:flutter/material.dart';
import 'package:highlight_text/highlight_text.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;
// import 'package:speech_to_text/speech_to_text.dart';


// class MyApp extends StatelessWidget {
  
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Voice',
//       debugShowCheckedModeBanner: false,
//       theme: ThemeData(
//         primarySwatch: Colors.red,
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: SpeechScreen(),
//     );
//   }
// }

class SpeechScreen extends StatefulWidget {
  
  @override
  _SpeechScreenState createState() => _SpeechScreenState();
}

class _SpeechScreenState extends State<SpeechScreen> {
  final Map<String, HighlightedWord> _highlights = {
    'flutter': HighlightedWord(
      onTap: () => print('flutter'),
      textStyle: const TextStyle(
        color: Color.fromARGB(255, 97, 29, 139),
        fontWeight: FontWeight.bold,
      ),
    ),
    'voice': HighlightedWord(
      onTap: () => print('voice'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
    'subscribe': HighlightedWord(
      onTap: () => print('subscribe'),
      textStyle: const TextStyle(
        color: Colors.red,
        fontWeight: FontWeight.bold,
      ),
    ),
    'like': HighlightedWord(
      onTap: () => print('like'),
      textStyle: const TextStyle(
        color: Color.fromARGB(255, 97, 29, 139),
        fontWeight: FontWeight.bold,
      ),
    ),
    'comment': HighlightedWord(
      onTap: () => print('comment'),
      textStyle: const TextStyle(
        color: Colors.green,
        fontWeight: FontWeight.bold,
      ),
    ),
  };

  stt.SpeechToText? _speech;
  bool _isListening = false;
  String _text = 'Press the button and start speaking';
  double _confidence = 1.0;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 97, 29, 139),
        title: Text('Confidence: ${(_confidence * 100.0).toStringAsFixed(1)}%'),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: AvatarGlow(
        animate: _isListening,
        glowColor: Theme.of(context).primaryColor,
        endRadius: 75.0,
        duration: const Duration(milliseconds: 2000),
        repeatPauseDuration: const Duration(milliseconds: 100),
        repeat: true,
        child: FloatingActionButton(
          backgroundColor: Color.fromARGB(255, 97, 29, 139),
          onPressed: _listen,
          child: Icon(_isListening ? Icons.mic : Icons.mic_none),
        ),
      ),
      body: SingleChildScrollView(
        reverse: true,
        child: Container(
          padding: const EdgeInsets.fromLTRB(30.0, 30.0, 30.0, 150.0),
          child: TextHighlight(
            text: _text,
            words: _highlights,
            textStyle: const TextStyle(
              fontSize: 32.0,
              color: Colors.black,
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ),
    );
  }

  void _listen() async {
    if (!_isListening) {
      bool available = await _speech!.initialize(
        onStatus: (val) => print('onStatus: $val'),
        onError: (val) => print('onError: $val'),
      );
      if (available) {
        setState(() => _isListening = true);
        _speech!.listen(
          onResult: (val) => setState(() {
            _text = val.recognizedWords;
            if (val.hasConfidenceRating && val.confidence > 0) {
              _confidence = val.confidence;
            }
          }),
        );
      }
    } else {
      setState(() => _isListening = false);
      _speech!.stop();
    }
  }
}

// var locales =  speech.locales();

// // Some UI or other code to select a locale from the list
// // resulting in an index, selectedLocale

// var selectedLocale = locales[selectedLocale];
// speech.listen(
//     onResult: resultListener,
//     localeId: selectedLocale.localeId,
//     );


// import 'dart:async';
// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:speech_to_text/speech_recognition_error.dart';
// import 'package:speech_to_text/speech_recognition_result.dart';
// import 'package:speech_to_text/speech_to_text.dart';

// class SpeechSampleApp extends StatefulWidget {
//   static String id = 'SpeechSampleApp';
//   @override
//   _SpeechSampleAppState createState() => _SpeechSampleAppState();
// }

// /// An example that demonstrates the basic functionality of the
// /// SpeechToText plugin for using the speech recognition capability
// /// of the underlying platform.
// class _SpeechSampleAppState extends State<SpeechSampleApp> {
//   static String id = 'SpeechSampleApp';
//   bool _hasSpeech = false;
//   bool _logEvents = false;
//   bool _onDevice = false;
//   final TextEditingController _pauseForController =
//       TextEditingController(text: '3');
//   final TextEditingController _listenForController =
//       TextEditingController(text: '30');
//   double level = 0.0;
//   double minSoundLevel = 50000;
//   double maxSoundLevel = -50000;
//   String lastWords = '';
//   String lastError = '';
//   String lastStatus = '';
//   String _currentLocaleId = '';
//   List<LocaleName> _localeNames = [];
//   final SpeechToText speech = SpeechToText();

//   @override
//   void initState() {
//     super.initState();
//   }

//   /// This initializes SpeechToText. That only has to be done
//   /// once per application, though calling it again is harmless
//   /// it also does nothing. The UX of the sample app ensures that
//   /// it can only be called once.
//   Future<void> initSpeechState() async {
//     _logEvent('Initialize');
//     try {
//       var hasSpeech = await speech.initialize(
//         onError: errorListener,
//         onStatus: statusListener,
//         debugLogging: _logEvents,
//       );
//       if (hasSpeech) {
//         // Get the list of languages installed on the supporting platform so they
//         // can be displayed in the UI for selection by the user.
//         _localeNames = await speech.locales();

//         var systemLocale = await speech.systemLocale();
//         _currentLocaleId = systemLocale?.localeId ?? '';
//       }
//       if (!mounted) return;

//       setState(() {
//         _hasSpeech = hasSpeech;
//       });
//     } catch (e) {
//       setState(() {
//         lastError = 'Speech recognition failed: ${e.toString()}';
//         _hasSpeech = false;
//       });
//     }
//   }

//   //  static String id = 'SpeechSampleApp';

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         // appBar: AppBar(
//         //   title:  Text('Speech to Text'),
//         //   backgroundColor: Color.fromARGB(255, 5, 117, 119),
//         // ),
//         body: Column(children: [
//           HeaderWidget(),
//           Container(
//             child: Column(
//               children: <Widget>[
//                 InitSpeechWidget(_hasSpeech, initSpeechState),
//                 SpeechControlWidget(_hasSpeech, speech.isListening,
//                     startListening, stopListening, cancelListening),
//                 SessionOptionsWidget(
//                   _currentLocaleId,
//                   _switchLang,
//                   _localeNames,
//                   _logEvents,
//                   _switchLogging,
//                   _pauseForController,
//                   _listenForController,
//                   _onDevice,
//                   _switchOnDevice,
//                 ),
//               ],
//             ),
//           ),
//           Expanded(
//             flex: 4,
//             child: RecognitionResultsWidget(lastWords: lastWords, level: level),
//           ),
//           Expanded(
//             flex: 1,
//             child: ErrorWidget(lastError: lastError),
//           ),
//           SpeechStatusWidget(speech: speech),
//         ]),
//       ),
//     );
//   }

//   // This is called each time the users wants to start a new speech
//   // recognition session
//   void startListening() {
//     _logEvent('start listening');
//     lastWords = '';
//     lastError = '';
//     final pauseFor = int.tryParse(_pauseForController.text);
//     final listenFor = int.tryParse(_listenForController.text);
//     // Note that `listenFor` is the maximum, not the minimun, on some
//     // systems recognition will be stopped before this value is reached.
//     // Similarly `pauseFor` is a maximum not a minimum and may be ignored
//     // on some devices.
//     speech.listen(
//       onResult: resultListener,
//       listenFor: Duration(seconds: listenFor ?? 30),
//       pauseFor: Duration(seconds: pauseFor ?? 3),
//       partialResults: true,
//       localeId: _currentLocaleId,
//       onSoundLevelChange: soundLevelListener,
//       cancelOnError: true,
//       listenMode: ListenMode.confirmation,
//       onDevice: _onDevice,
//     );
//     setState(() {});
//   }

//   void stopListening() {
//     _logEvent('stop');
//     speech.stop();
//     setState(() {
//       level = 0.0;
//     });
//   }

//   void cancelListening() {
//     _logEvent('cancel');
//     speech.cancel();
//     setState(() {
//       level = 0.0;
//     });
//   }

//   /// This callback is invoked each time new recognition results are
//   /// available after `listen` is called.
//   void resultListener(SpeechRecognitionResult result) {
//     _logEvent(
//         'Result listener final: ${result.finalResult}, words: ${result.recognizedWords}');
//     setState(() {
//       lastWords = '${result.recognizedWords} - ${result.finalResult}';
//     });
//   }

//   void soundLevelListener(double level) {
//     minSoundLevel = min(minSoundLevel, level);
//     maxSoundLevel = max(maxSoundLevel, level);
//     // _logEvent('sound level $level: $minSoundLevel - $maxSoundLevel ');
//     setState(() {
//       this.level = level;
//     });
//   }

//   void errorListener(SpeechRecognitionError error) {
//     _logEvent(
//         'Received error status: $error, listening: ${speech.isListening}');
//     setState(() {
//       lastError = '${error.errorMsg} - ${error.permanent}';
//     });
//   }

//   void statusListener(String status) {
//     _logEvent(
//         'Received listener status: $status, listening: ${speech.isListening}');
//     setState(() {
//       lastStatus = '$status';
//     });
//   }

//   void _switchLang(selectedVal) {
//     setState(() {
//       _currentLocaleId = selectedVal;
//     });
//     print(selectedVal);
//   }

//   void _logEvent(String eventDescription) {
//     if (_logEvents) {
//       var eventTime = DateTime.now().toIso8601String();
//       print('$eventTime $eventDescription');
//     }
//   }

//   void _switchLogging(bool? val) {
//     setState(() {
//       _logEvents = val ?? false;
//     });
//   }

//   void _switchOnDevice(bool? val) {
//     setState(() {
//       _onDevice = val ?? false;
//     });
//   }
// }

// /// Displays the most recently recognized words and the sound level.
// class RecognitionResultsWidget extends StatelessWidget {
//   const RecognitionResultsWidget({
//     Key? key,
//     required this.lastWords,
//     required this.level,
//   }) : super(key: key);

//   final String lastWords;
//   final double level;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Center(
//           child: Text(
//             'Recognized Words',
//             style: TextStyle(fontSize: 22.0),
//           ),
//         ),
//         Expanded(
//           child: Stack(
//             children: <Widget>[
//               Container(
//                 color: Theme.of(context).selectedRowColor,
//                 child: Center(
//                   child: Text(
//                     lastWords,
//                     textAlign: TextAlign.center,
//                   ),
//                 ),
//               ),
//               Positioned.fill(
//                 bottom: 10,
//                 child: Align(
//                   alignment: Alignment.bottomCenter,
//                   child: Container(
//                     width: 40,
//                     height: 40,
//                     alignment: Alignment.center,
//                     decoration: BoxDecoration(
//                       boxShadow: [
//                         BoxShadow(
//                             blurRadius: .26,
//                             spreadRadius: level * 1.5,
//                             color: Colors.black.withOpacity(.05))
//                       ],
//                       color: Colors.white,
//                       borderRadius: BorderRadius.all(Radius.circular(50)),
//                     ),
//                     child: IconButton(
//                       icon: Icon(Icons.mic),
//                       onPressed: () => null,
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ],
//     );
//   }
// }

// class HeaderWidget extends StatelessWidget {
//   const HeaderWidget({
//     Key? key,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Text(
//         'Speech recognition available',
//         style: TextStyle(fontSize: 22.0),
//       ),
//     );
//   }
// }

// /// Display the current error status from the speech
// /// recognizer
// class ErrorWidget extends StatelessWidget {
//   const ErrorWidget({
//     Key? key,
//     required this.lastError,
//   }) : super(key: key);

//   final String lastError;

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: <Widget>[
//         Center(
//           child: Text(
//             'Error Status',
//             style: TextStyle(fontSize: 22.0),
//           ),
//         ),
//         Center(
//           child: Text(lastError),
//         ),
//       ],
//     );
//   }
// }

// /// Controls to start and stop speech recognition
// class SpeechControlWidget extends StatelessWidget {
//   const SpeechControlWidget(this.hasSpeech, this.isListening,
//       this.startListening, this.stopListening, this.cancelListening,
//       {Key? key})
//       : super(key: key);

//   final bool hasSpeech;
//   final bool isListening;
//   final void Function() startListening;
//   final void Function() stopListening;
//   final void Function() cancelListening;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: <Widget>[
//         TextButton(
//           onPressed: !hasSpeech || isListening ? null : startListening,
//           child: Text('Start'),
//         ),
//         TextButton(
//           onPressed: isListening ? stopListening : null,
//           child: Text('Stop'),
//         ),
//         TextButton(
//           onPressed: isListening ? cancelListening : null,
//           child: Text('Cancel'),
//         )
//       ],
//     );
//   }
// }

// class SessionOptionsWidget extends StatefulWidget {
//    SessionOptionsWidget(
//       this.currentLocaleId,
//       this.switchLang,
//       this.localeNames,
//       this.logEvents,
//       this.switchLogging,
//       this.pauseForController,
//       this.listenForController,
//       this.onDevice,
//       this.switchOnDevice,
//       {Key? key})
//       : super(key: key);

//   String currentLocaleId;
//   final void Function(String?) switchLang;
//   final void Function(bool?) switchLogging;
//   final void Function(bool?) switchOnDevice;
//   final TextEditingController pauseForController;
//   final TextEditingController listenForController;
//   final List<LocaleName> localeNames;
//   final bool logEvents;
//   final bool onDevice;

//   @override
//   State<SessionOptionsWidget> createState() => _SessionOptionsWidgetState();
// }

// class _SessionOptionsWidgetState extends State<SessionOptionsWidget> {
//   @override
//   void initState() {
//     super.initState();
//     widget.currentLocaleId = "Arabic";
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         children: <Widget>[
//           Row(
//             children: [
//               Text('Language: '),
//               DropdownButton(
//                   onChanged: (selectedVal) => widget.switchLang(selectedVal),
//                   value: widget.currentLocaleId,
//                   items: [
//                     // DropdownMenuItem(
//                     //   value: localeName.localeId,
//                     //   child: Text(localeName.name),
//                     // ),

//                     DropdownMenuItem(
//                       value: "AMG",
//                       child: Text("AMG"),
//                     ),

//                     DropdownMenuItem(
//                       value: "AMG 2",
//                       child: Text("AMG 2"),
//                     ),
//                   ]

//                   /*
//                 widget.localeNames
//                     .map(
//                       (localeName) => 
//                     )
//                     .toList(),
//                     */
//                   ),
//             ],
//           ),
//           Row(
//             children: [
//               Text('pauseFor: '),
//               Container(
//                   padding: EdgeInsets.only(left: 8),
//                   width: 80,
//                   child: TextFormField(
//                     controller: widget.pauseForController,
//                   )),
//               Container(
//                   padding: EdgeInsets.only(left: 16),
//                   child: Text('listenFor: ')),
//               Container(
//                   padding: EdgeInsets.only(left: 8),
//                   width: 80,
//                   child: TextFormField(
//                     controller: widget.listenForController,
//                   )),
//             ],
//           ),
//           Row(
//             children: [
//               Text('On device: '),
//               Checkbox(
//                 value: widget.onDevice,
//                 onChanged: widget.switchOnDevice,
//               ),
//               Text('Log events: '),
//               Checkbox(
//                 value: widget.logEvents,
//                 onChanged: widget.switchLogging,
//               ),
//             ],
//           ),
//         ],
//       ),
//     );
//   }
// }

// class InitSpeechWidget extends StatelessWidget {
//   const InitSpeechWidget(this.hasSpeech, this.initSpeechState, {Key? key})
//       : super(key: key);

//   final bool hasSpeech;
//   final Future<void> Function() initSpeechState;

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceAround,
//       children: <Widget>[
//         TextButton(
//           onPressed: hasSpeech ? null : initSpeechState,
//           child: Text('Initialize'),
//         ),
//       ],
//     );
//   }
// }

// /// Display the current status of the listener
// class SpeechStatusWidget extends StatelessWidget {
//   const SpeechStatusWidget({
//     Key? key,
//     required this.speech,
//   }) : super(key: key);

//   final SpeechToText speech;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.symmetric(vertical: 20),
//       color: Theme.of(context).backgroundColor,
//       child: Center(
//         child: speech.isListening
//             ? Text(
//                 "I'm listening...",
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               )
//             : Text(
//                 'Not listening',
//                 style: TextStyle(fontWeight: FontWeight.bold),
//               ),
//       ),
//     );
//   }
// }
