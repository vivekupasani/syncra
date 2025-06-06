import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:syncra/pages/home_page.dart';
import 'dart:math' as math;

import 'package:syncra/utils/scafold_message.dart';

// Third Screen with Voice Control Design
class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _OnboardPageState createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage>
    with TickerProviderStateMixin {
  late AnimationController _pulseController;
  late AnimationController _waveController;
  late Animation<double> _pulseAnimation;
  late Animation<double> _waveAnimation;
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GoogleSignIn googleSignIn = GoogleSignIn(
    clientId:
        '55757197450-888nlj45slscolv1aloukmk7f3a6p92p.apps.googleusercontent.com',
  );

  @override
  void initState() {
    super.initState();

    _pulseController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat();

    _waveController = AnimationController(
      duration: Duration(milliseconds: 1500),
      vsync: this,
    )..repeat();

    _pulseAnimation = Tween<double>(begin: 0.8, end: 1.2).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _waveAnimation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(_waveController);
  }

  @override
  void dispose() {
    _pulseController.dispose();
    _waveController.dispose();
    super.dispose();
  }

  void signinORsignup() async {
    try {
      final GoogleSignInAccount? googleUser = await googleSignIn.signIn();
      if (googleUser == null) {
        // User cancelled the sign-in
        return;
      }

      final googleAuth = await googleUser.authentication;

      final credential = GoogleAuthProvider.credential(
        idToken: googleAuth.idToken,
        accessToken: googleAuth.accessToken,
      );

      final user = await auth.signInWithCredential(credential);

      if (user.user != null) {
        // Successfully signed in
        print("User signed in: ${user.user!.displayName}");
        Navigator.push(
          context,
          CupertinoPageRoute(builder: (context) => HomePage()),
        );
      } else {
        // Sign-in failed
        print("Sign-in failed");
      }
    } catch (e) {
      // Handle sign-in or sign-up errors
      print("Error during sign-in/sign-up: $e");
      // ignore: use_build_context_synchronously
      scafoldMessage("Failed to sign in or sign up.${e.toString()}", context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0E1A),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            children: [
              SizedBox(height: 40),

              // Header
              Text(
                "Effortless",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36,
                  fontWeight: FontWeight.w300,
                  letterSpacing: 1,
                ),
              ),

              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: "control with ",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.w300,
                        letterSpacing: 1,
                      ),
                    ),
                    TextSpan(
                      text: "Syncra",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              Text(
                "At Syncra, we believe in the power of voice to\ntransform the way you work",
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white60,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),

              SizedBox(height: 80),

              // Voice Control Visualization
              Expanded(
                child: Center(
                  child: AnimatedBuilder(
                    animation: Listenable.merge([
                      _pulseAnimation,
                      _waveAnimation,
                    ]),
                    builder: (context, child) {
                      return Container(
                        width: 300,
                        height: 300,
                        child: CustomPaint(
                          painter: VoiceVisualizationPainter(
                            pulseValue: _pulseAnimation.value,
                            waveValue: _waveAnimation.value,
                          ),
                          child: Center(
                            child: Container(
                              width: 80,
                              height: 80,
                              decoration: BoxDecoration(
                                gradient: RadialGradient(
                                  colors: [
                                    Color(0xFF9C27B0).withOpacity(0.8),
                                    Color(0xFF3F51B5).withOpacity(0.6),
                                  ],
                                ),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: Color(0xFF9C27B0).withOpacity(0.4),
                                    blurRadius: 20,
                                    spreadRadius: 5,
                                  ),
                                ],
                              ),
                              child: Icon(
                                Icons.mic,
                                color: Colors.white,
                                size: 32,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),

              // Voice Command Indicator
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Color(0xFF1E293B).withOpacity(0.8),
                  borderRadius: BorderRadius.circular(25),
                  border: Border.all(
                    color: Color(0xFF9C27B0).withOpacity(0.3),
                    width: 1,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        color: Color(0xFF00E676),
                        shape: BoxShape.circle,
                        boxShadow: [
                          BoxShadow(
                            color: Color(0xFF00E676).withOpacity(0.5),
                            blurRadius: 8,
                            spreadRadius: 2,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(width: 12),
                    Text(
                      "AI Voice Command",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 60),

              // Page Indicator
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(
                  5,
                  (index) => Container(
                    width: index == 2 ? 24 : 8,
                    height: 8,
                    margin: EdgeInsets.symmetric(horizontal: 4),
                    decoration: BoxDecoration(
                      color: index == 2
                          ? Color(0xFF9C27B0)
                          : Colors.white.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 40),

              // Sign Up Button
              GestureDetector(
                onTap: () {
                  signinORsignup();
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 18),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [Color(0xFF9C27B0), Color(0xFF673AB7)],
                      begin: Alignment.centerLeft,
                      end: Alignment.centerRight,
                    ),
                    borderRadius: BorderRadius.circular(30),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xFF9C27B0).withOpacity(0.3),
                        blurRadius: 15,
                        offset: Offset(0, 5),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 16),

              // Sign In Button
              GestureDetector(
                onTap: () {
                  signinORsignup();
                },
                child: Container(
                  width: double.infinity,
                  padding: EdgeInsets.symmetric(vertical: 18),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(30),
                    border: Border.all(
                      color: Colors.white.withOpacity(0.3),
                      width: 1,
                    ),
                  ),
                  child: Center(
                    child: Text(
                      "Sign In",
                      style: TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ),

              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}

class VoiceVisualizationPainter extends CustomPainter {
  final double pulseValue;
  final double waveValue;

  VoiceVisualizationPainter({
    required this.pulseValue,
    required this.waveValue,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final Paint paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;

    // Draw concentric circles with gradient effect
    for (int i = 1; i <= 4; i++) {
      final radius = (40 + i * 25) * pulseValue;
      final opacity = (1.0 - (i * 0.2)).clamp(0.0, 1.0);

      paint.color = Color(0xFF9C27B0).withOpacity(opacity * 0.3);
      canvas.drawCircle(center, radius, paint);
    }

    // Draw animated wave rings
    for (int ring = 0; ring < 3; ring++) {
      final baseRadius = 60.0 + (ring * 30);
      final waveOffset = waveValue + (ring * math.pi / 3);

      Path wavePath = Path();
      bool isFirst = true;

      for (double angle = 0; angle < 2 * math.pi; angle += 0.1) {
        final waveAmplitude = 10 * math.sin(waveOffset + angle * 3);
        final radius = baseRadius + waveAmplitude;
        final x = center.dx + radius * math.cos(angle);
        final y = center.dy + radius * math.sin(angle);

        if (isFirst) {
          wavePath.moveTo(x, y);
          isFirst = false;
        } else {
          wavePath.lineTo(x, y);
        }
      }

      wavePath.close();

      paint.color = Color(0xFF3F51B5).withOpacity(0.2 - ring * 0.05);
      paint.strokeWidth = 1.5;
      canvas.drawPath(wavePath, paint);
    }

    // Draw small particles
    for (int i = 0; i < 8; i++) {
      final angle = (i * math.pi / 4) + waveValue;
      final distance = 100 + 20 * math.sin(waveValue * 2 + i);
      final x = center.dx + distance * math.cos(angle);
      final y = center.dy + distance * math.sin(angle);

      paint.style = PaintingStyle.fill;
      paint.color = Color(0xFF00E676).withOpacity(0.6);
      canvas.drawCircle(Offset(x, y), 2, paint);
    }
  }

  @override
  bool shouldRepaint(VoiceVisualizationPainter oldDelegate) {
    return oldDelegate.pulseValue != pulseValue ||
        oldDelegate.waveValue != waveValue;
  }
}
