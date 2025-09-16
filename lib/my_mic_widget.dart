import 'package:flutter/material.dart';
import 'package:avatar_glow/avatar_glow.dart';
import 'package:speech_to_text/speech_to_text.dart' as stt;

/// A customizable microphone widget with speech-to-text functionality
class MyMic extends StatefulWidget {
  /// Callback function that returns the recognized speech text
  final Function(String) onResult;

  /// Color of the microphone icon
  final Color? color;

  /// Background color when not listening
  final Color? bgColor;

  /// Size of the microphone icon
  final double? size;

  /// Glow color when listening
  final Color? glowColor;

  /// Duration to listen for speech (default: 10 seconds)
  final int? listeningDuration;

  /// Duration to pause before stopping (default: 3 seconds)
  final int? pauseDuration;

  /// Custom icon when listening
  final IconData? listeningIcon;

  /// Custom icon when not listening
  final IconData? notListeningIcon;

  /// Whether to show a glow effect when listening
  final bool showGlow;

  const MyMic({
    Key? key,
    required this.onResult,
    this.color,
    this.bgColor,
    this.size,
    this.glowColor,
    this.listeningDuration,
    this.pauseDuration,
    this.listeningIcon,
    this.notListeningIcon,
    this.showGlow = true,
  }) : super(key: key);

  @override
  State<MyMic> createState() => _MyMicState();
}

class _MyMicState extends State<MyMic> {
  late stt.SpeechToText _speech;
  bool _isListening = false;
  bool _isAvailable = false;
  String? _lastError;

  @override
  void initState() {
    super.initState();
    _speech = stt.SpeechToText();
  }

  /// Initialize speech recognition
  Future<void> _initializeSpeech() async {
    try {
      _isAvailable = await _speech.initialize(
        onStatus: _onSpeechStatus,
        onError: _onSpeechError,
      );
      setState(() {
        _lastError = null;
      });
    } catch (e) {
      setState(() {
        _lastError = e.toString();
      });
    }
  }

  /// Start listening for speech
  void _listen() async {
    await _initializeSpeech();
    if (!_isListening && _isAvailable) {
      setState(() {
        _isListening = true;
        _lastError = null;
      });

      await _speech.listen(
        onResult: (val) {
          if (val.finalResult) {
            _stopSpeech();
            widget.onResult(val.recognizedWords);
          }
        },
        listenFor: Duration(seconds: widget.listeningDuration ?? 10),
        pauseFor: Duration(seconds: widget.pauseDuration ?? 3),
        listenOptions: stt.SpeechListenOptions(cancelOnError: true),
      );
    } else {
      _stopSpeech();
    }
  }

  /// Stop speech recognition
  void _stopSpeech() {
    if (mounted) {
      setState(() {
        _isListening = false;
      });
    }
    _speech.stop();
  }

  /// Handle speech status changes
  void _onSpeechStatus(String status) {
    if (status == 'notListening' || status == 'done') {
      _stopSpeech();
    }
  }

  /// Handle speech errors
  void _onSpeechError(dynamic error) {
    debugPrint("Speech Error: $error");
    setState(() {
      _lastError = error.toString();
    });
    _stopSpeech();
  }

  @override
  Widget build(BuildContext context) {
    if (widget.showGlow) {
      return AvatarGlow(
        glowColor: _isListening
            ? (widget.glowColor ?? Theme.of(context).primaryColor)
            : (widget.bgColor ?? Colors.grey[300]!),
        animate: _isListening,
        duration: const Duration(milliseconds: 2000),
        repeat: true,
        child: _buildMicIcon(),
      );
    } else {
      return _buildMicIcon();
    }
  }

  Widget _buildMicIcon() {
    return GestureDetector(
      onTap: _listen,
      child: Container(
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: _isListening
              ? (widget.glowColor?.withOpacity(0.2) ??
                  Theme.of(context).primaryColor.withOpacity(0.2))
              : Colors.transparent,
          shape: BoxShape.circle,
        ),
        child: Icon(
          _isListening
              ? (widget.listeningIcon ?? Icons.mic)
              : (widget.notListeningIcon ?? Icons.mic_none),
          size: widget.size ?? 40.0,
          color: widget.color ?? Theme.of(context).primaryColor,
        ),
      ),
    );
  }

  @override
  void dispose() {
    _speech.stop();
    super.dispose();
  }
}




// import 'package:flutter/material.dart';
// import 'package:avatar_glow/avatar_glow.dart';
// import 'package:speech_to_text/speech_to_text.dart' as stt;

// class MyMic extends StatefulWidget {
//   final Function(String) onResult;
//   final Color color;
//   final Color bgColor;
//   final double size;
//   final Color glowColor;
//   final int listeningDuration;
//   final int pauseDuration;

//   const MyMic({
//     Key? key,
//     required this.onResult,
//     required this.color,
//     required this.size,
//     required this.glowColor,
//     required this.bgColor,
//     this.listeningDuration = 10,
//     this.pauseDuration = 3,
//   }) : super(key: key);

//   @override
//   State<MyMic> createState() => _MyMicState();
// }

// class _MyMicState extends State<MyMic> {
//   late stt.SpeechToText _speech;
//   bool _isListening = false;
//   bool _isAvailable = false;

//   @override
//   void initState() {
//     super.initState();
//     _speech = stt.SpeechToText();
//   }

//   Future<void> _initializeSpeech() async {
//     _isAvailable = await _speech.initialize(
//       onStatus: _onSpeechStatus,
//       onError: _onSpeechError,
//     );
//     setState(() {});
//   }

//   void _listen() async {
//     await _initializeSpeech();
//     if (!_isListening && _isAvailable) {
//       setState(() {
//         _isListening = true;
//       });

//       await _speech.listen(
//         onResult: (val) {
//           if (val.finalResult) {
//             _stopSpeech();
//             widget.onResult(val.recognizedWords);
//           }
//         },
//         listenFor: Duration(seconds: widget.listeningDuration),
//         pauseFor: Duration(seconds: widget.pauseDuration),
//         listenOptions: stt.SpeechListenOptions(cancelOnError: true),
//       );
//     } else {
//       _stopSpeech();
//     }
//   }

//   void _stopSpeech() {
//     if (mounted) {
//       setState(() {
//         _isListening = false;
//       });
//     }
//     _speech.stop();
//   }

//   void _onSpeechStatus(String status) {
//     if (status == 'notListening' || status == 'done') {
//       _stopSpeech();
//     }
//   }

//   void _onSpeechError(dynamic error) {
//     debugPrint("Speech Error: $error");
//     _stopSpeech();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//       onTap: _listen,
//       child: AvatarGlow(
//         glowColor: _isListening ? widget.glowColor : widget.bgColor,
//         animate: _isListening,
//         duration: const Duration(milliseconds: 2000),
//         child: Icon(
//           _isListening ? Icons.mic : Icons.mic_none,
//           size: widget.size,
//           color: widget.color,
//         ),
//       ),
//     );
//   }
// }
