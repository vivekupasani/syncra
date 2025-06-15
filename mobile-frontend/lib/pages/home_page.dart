import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;

import 'package:syncra/pages/assistant_page.dart';
import 'package:syncra/pages/on_board_page.dart';
import 'package:syncra/painters/modern_wave_painter.dart';
import 'package:syncra/utils/status_bar_theme.dart';
import 'package:syncra/widgets/modern_action_card.dart';

// Modern Home Page Design
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> with TickerProviderStateMixin {
  late AnimationController _waveController;
  late AnimationController _floatingController;
  late Animation<double> _waveAnimation;
  late Animation<double> _floatingAnimation;
  FirebaseAuth auth = FirebaseAuth.instance;
  late String userName;

  @override
  void initState() {
    super.initState();

    statusBarTheme();

    final user = auth.currentUser;
    userName = user?.displayName ?? 'User';

    _waveController = AnimationController(
      duration: Duration(seconds: 3),
      vsync: this,
    )..repeat();

    _floatingController = AnimationController(
      duration: Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _waveAnimation = Tween<double>(
      begin: 0,
      end: 2 * math.pi,
    ).animate(_waveController);

    _floatingAnimation = Tween<double>(begin: -5, end: 5).animate(
      CurvedAnimation(parent: _floatingController, curve: Curves.easeInOut),
    );
  }

  void onSignOut() async {
    try {
      await auth.signOut();
      Navigator.pushAndRemoveUntil(
        context,
        CupertinoPageRoute(builder: (context) => OnboardPage()),
        (route) => false,
      );
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF0A0E1A),
      body: SafeArea(
        child: Column(
          children: [
            // Top Navigation Bar
            _navigationArea(),

            // Header Section
            _headerArea(),
            SizedBox(height: 40),

            // Animated Wave Visualization
            _animatedWaveVisual(),
            SizedBox(height: 40),

            // Action Cards Grid
            _actionCardGrid(),

            // Voice Command Button
            _voiceCommand(),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }

  Widget _voiceCommand() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            CupertinoPageRoute(builder: (context) => AssistantPage()),
          );
        },
        child: Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(vertical: 20),
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
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "Tap here to start work with Syncra",
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
              SizedBox(width: 12),
              Container(
                width: 32,
                height: 32,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(Icons.mic, color: Colors.white, size: 18),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _actionCardGrid() {
    return Expanded(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          children: [
            Row(
              children: [
                Expanded(
                  child: ModernActionCard(
                    icon: Icons.auto_awesome,
                    title: "Generating Image",
                    gradient: [Color(0xFF9C27B0), Color(0xFF673AB7)],
                    floatingAnimation: _floatingAnimation,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ModernActionCard(
                    icon: Icons.description_outlined,
                    title: "Creating Document",
                    gradient: [Color(0xFF00BCD4), Color(0xFF0097A7)],
                    floatingAnimation: _floatingAnimation,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: ModernActionCard(
                    icon: Icons.event_note_outlined,
                    title: "Scheduling Meeting",
                    gradient: [Color(0xFF4CAF50), Color(0xFF388E3C)],
                    floatingAnimation: _floatingAnimation,
                  ),
                ),
                SizedBox(width: 16),
                Expanded(
                  child: ModernActionCard(
                    icon: Icons.edit_note_outlined,
                    title: "Writing Note",
                    gradient: [Color(0xFFFF9800), Color(0xFFF57C00)],
                    floatingAnimation: _floatingAnimation,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _animatedWaveVisual() {
    return Container(
      height: 150,
      width: double.infinity,
      child: AnimatedBuilder(
        animation: _waveAnimation,
        builder: (context, child) {
          return CustomPaint(
            painter: ModernWavePainter(waveValue: _waveAnimation.value),
            child: Container(),
          );
        },
      ),
    );
  }

  Widget _headerArea() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Text(
            "Hi, $userName",
            style: TextStyle(
              color: Colors.white,
              fontSize: 32,
              fontWeight: FontWeight.w300,
            ),
          ),
          SizedBox(height: 8),
          Text(
            "Give any command naturally, from generating image to\nscheduling meetings",
            style: TextStyle(color: Colors.white60, fontSize: 16, height: 1.5),
          ),
        ],
      ),
    );
  }

  Widget _navigationArea() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: onSignOut,
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
                Icons.person_outline,
                color: Colors.white70,
                size: 20,
              ),
            ),
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  Color(0xFF9C27B0).withOpacity(0.2),
                  Color(0xFF673AB7).withOpacity(0.2),
                ],
              ),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(
                color: Color(0xFF9C27B0).withOpacity(0.5),
                width: 1,
              ),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.auto_awesome, color: Color(0xFF9C27B0), size: 16),
                SizedBox(width: 6),
                Text(
                  'Try Premium',
                  style: TextStyle(
                    color: Color(0xFF9C27B0),
                    fontSize: 12,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _waveController.dispose();
    _floatingController.dispose();
    super.dispose();
  }
}
