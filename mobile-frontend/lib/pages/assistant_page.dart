import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';
import 'dart:math' as math;

import 'package:syncra/painters/voice_wave_pointer.dart';
import 'package:syncra/utils/syncra_conversations.dart';

// Modern Assistant Page Design
class AssistantPage extends StatefulWidget {
  const AssistantPage({super.key});

  @override
  State<AssistantPage> createState() => _AssistantPageState();
}

class _AssistantPageState extends State<AssistantPage>
    with TickerProviderStateMixin {
  final SpeechToText _speechToText = SpeechToText();
  bool _speechEnabled = false;
  String _userInput = '';
  String _assistantResponse = '';
  bool _isProcessing = false;

  late AnimationController _pulseController;
  late AnimationController _waveController;
  late AnimationController _textController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _waveAnimation;
  late Animation<double> _textFadeAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _initSpeech();

    Permission.microphone.request().then((value) {
      if (value.isGranted) {
        _initSpeech();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Microphone permission is required to use this feature.",
            ),
          ),
        );
      }
    });
  }

  void _initAnimations() {
    _pulseController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    );

    _waveController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    );

    _textController = AnimationController(
      duration: Duration(milliseconds: 800),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.3).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _waveAnimation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(_waveController);

    _textFadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _textController, curve: Curves.easeInOut),
    );
  }

  void _initSpeech() async {
    _speechEnabled = await _speechToText.initialize();
    setState(() {});
  }

  void _startListening() async {
    if (_speechEnabled) {
      setState(() {
        _userInput = '';
        _assistantResponse = '';
        _isProcessing = false;
      });

      _pulseController.repeat();
      _waveController.repeat();

      await _speechToText.listen(onResult: _onSpeechResult);
      setState(() {});
    }
  }

  void _stopListening() async {
    _pulseController.stop();
    _waveController.stop();

    await _speechToText.stop();

    if (_userInput.isNotEmpty) {
      _processInput();
    }

    setState(() {});
  }

  void _onSpeechResult(SpeechRecognitionResult result) {
    setState(() {
      _userInput = result.recognizedWords;
    });
  }

  void _processInput() async {
    setState(() {
      _isProcessing = true;
    });

    // Simulate AI processing
    // await Future.delayed(Duration(seconds: 2));
    _assistantResponse = await textBasedConversation(_userInput) ?? "";
    setState(() {
      _isProcessing = false;
    });

    _textController.forward();
  }

  // String _generateResponse(String input) {
  //   // Simple response generation based on input
  //   final lowercaseInput = input.toLowerCase();

  //   if (lowercaseInput.contains('hello') || lowercaseInput.contains('hi')) {
  //     return "Hello! I'm here to help you with anything you need.";
  //   } else if (lowercaseInput.contains('weather')) {
  //     return "I'd be happy to help with weather information. What location would you like to know about?";
  //   } else if (lowercaseInput.contains('time')) {
  //     return "The current time is ${DateTime.now().hour}:${DateTime.now().minute.toString().padLeft(2, '0')}.";
  //   } else if (lowercaseInput.contains('help')) {
  //     return "I'm here to assist you! You can ask me about weather, time, general questions, or just have a conversation.";
  //   } else {
  //     return "That's interesting! I understand you said '$input'. How can I help you with that?";
  //   }
  // }

  @override
  void dispose() {
    _pulseController.dispose();
    _waveController.dispose();
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0E1A),
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation Bar
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      width: 44,
                      height: 44,
                      decoration: BoxDecoration(
                        color: Color(0xFF1E293B).withOpacity(0.8),
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: Colors.white.withOpacity(0.1),
                          width: 1,
                        ),
                      ),
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white70,
                        size: 18,
                      ),
                    ),
                  ),
                  Text(
                    "AI Assistant",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Color(0xFF1E293B).withOpacity(0.8),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white.withOpacity(0.1),
                        width: 1,
                      ),
                    ),
                    child: Icon(
                      Icons.more_vert,
                      color: Colors.white70,
                      size: 18,
                    ),
                  ),
                ],
              ),
            ),

            // Main Content Area
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  children: [
                    SizedBox(height: 20),

                    // Status Text
                    Text(
                      _getStatusText(),
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                      ),
                    ),

                    SizedBox(height: 40),

                    // Voice Visualization
                    Expanded(
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // Animated Voice Interface
                            Container(
                              width: 280,
                              height: 280,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  // Animated Background Waves
                                  if (_speechToText.isListening)
                                    AnimatedBuilder(
                                      animation: Listenable.merge([
                                        _pulseAnimation,
                                        _waveAnimation,
                                      ]),
                                      builder: (context, child) {
                                        return CustomPaint(
                                          painter: VoiceWavePainter(
                                            pulseValue: _pulseAnimation.value,
                                            waveValue: _waveAnimation.value,
                                            isListening:
                                                _speechToText.isListening,
                                          ),
                                          size: Size(280, 280),
                                        );
                                      },
                                    ),

                                  // Central Microphone Button
                                  GestureDetector(
                                    onTap: _speechToText.isListening
                                        ? _stopListening
                                        : _startListening,
                                    child: Container(
                                      width: 100,
                                      height: 100,
                                      decoration: BoxDecoration(
                                        gradient: _speechToText.isListening
                                            ? LinearGradient(
                                                colors: [
                                                  Color(0xFFE91E63),
                                                  Color(0xFF9C27B0),
                                                ],
                                              )
                                            : LinearGradient(
                                                colors: [
                                                  Color(0xFF9C27B0),
                                                  Color(0xFF673AB7),
                                                ],
                                              ),
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color:
                                                (_speechToText.isListening
                                                        ? Color(0xFFE91E63)
                                                        : Color(0xFF9C27B0))
                                                    .withOpacity(0.4),
                                            blurRadius: 25,
                                            spreadRadius:
                                                _speechToText.isListening
                                                ? 8
                                                : 2,
                                          ),
                                        ],
                                      ),
                                      child: Icon(
                                        _speechToText.isListening
                                            ? Icons.mic
                                            : Icons.mic_none_outlined,
                                        color: Colors.white,
                                        size: 40,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            SizedBox(height: 40),

                            // User Input Display
                            if (_userInput.isNotEmpty)
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(20),
                                margin: EdgeInsets.only(bottom: 16),
                                decoration: BoxDecoration(
                                  color: Color(0xFF1E293B).withOpacity(0.8),
                                  borderRadius: BorderRadius.circular(20),
                                  border: Border.all(
                                    color: Color(0xFF9C27B0).withOpacity(0.3),
                                    width: 1,
                                  ),
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Row(
                                      children: [
                                        Container(
                                          width: 24,
                                          height: 24,
                                          decoration: BoxDecoration(
                                            color: Color(0xFF9C27B0),
                                            shape: BoxShape.circle,
                                          ),
                                          child: Icon(
                                            Icons.person,
                                            color: Colors.white,
                                            size: 14,
                                          ),
                                        ),
                                        SizedBox(width: 8),
                                        Text(
                                          "You said:",
                                          style: TextStyle(
                                            color: Colors.white70,
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                    SizedBox(height: 8),
                                    Text(
                                      _userInput,
                                      style: TextStyle(
                                        color: Colors.white,
                                        fontSize: 16,
                                        height: 1.4,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            // Processing Indicator
                            if (_isProcessing)
                              Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(20),
                                margin: EdgeInsets.only(bottom: 16),
                                decoration: BoxDecoration(
                                  color: Color(0xFF1E293B).withOpacity(0.6),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Row(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                      height: 20,
                                      child: CircularProgressIndicator(
                                        strokeWidth: 2,
                                        valueColor:
                                            AlwaysStoppedAnimation<Color>(
                                              Color(0xFF00BCD4),
                                            ),
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    Text(
                                      "Processing your request...",
                                      style: TextStyle(
                                        color: Colors.white70,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                            // Assistant Response
                            if (_assistantResponse.isNotEmpty)
                              FadeTransition(
                                opacity: _textFadeAnimation,
                                child: Container(
                                  width: double.infinity,
                                  padding: EdgeInsets.all(20),
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        Color(0xFF00BCD4).withOpacity(0.1),
                                        Color(0xFF0097A7).withOpacity(0.05),
                                      ],
                                    ),
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                      color: Color(0xFF00BCD4).withOpacity(0.3),
                                      width: 1,
                                    ),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 24,
                                            height: 24,
                                            decoration: BoxDecoration(
                                              color: Color(0xFF00BCD4),
                                              shape: BoxShape.circle,
                                            ),
                                            child: Icon(
                                              Icons.smart_toy,
                                              color: Colors.white,
                                              size: 14,
                                            ),
                                          ),
                                          SizedBox(width: 8),
                                          Text(
                                            "Syncra Assistant:",
                                            style: TextStyle(
                                              color: Colors.white70,
                                              fontSize: 12,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: 8),
                                      Text(
                                        _assistantResponse,
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                          height: 1.4,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // Bottom Instruction
            Padding(
              padding: EdgeInsets.all(24),
              child: Text(
                _speechToText.isListening
                    ? "Listening... Tap to stop"
                    : "Tap the microphone to start speaking",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white60, fontSize: 14),
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _getStatusText() {
    if (_speechToText.isListening) {
      return "I'm listening...";
    } else if (_isProcessing) {
      return "Processing...";
    } else if (_assistantResponse.isNotEmpty) {
      return "Ready for your next question";
    } else {
      return "Ready to help you";
    }
  }
}
