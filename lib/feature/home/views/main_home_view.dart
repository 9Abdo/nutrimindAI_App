import 'package:circle_nav_bar/circle_nav_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nutrimind/core/constant/app_color.dart';
import 'package:nutrimind/feature/chat/views/chat_bot_view.dart';
import 'package:nutrimind/feature/history/views/history_page_view.dart';
import 'package:nutrimind/feature/home/cubit/home_cubit.dart';
import 'package:nutrimind/feature/home/views/home_page_views.dart';
import 'package:nutrimind/feature/profile/views/profile_page_view.dart';

class MainHomeView extends StatefulWidget {
  const MainHomeView({super.key});

  @override
  State<MainHomeView> createState() => _MainHomeViewState();
}

class _MainHomeViewState extends State<MainHomeView> {
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<HomeCubit>().loadMeals(
        FirebaseAuth.instance.currentUser!.uid,
      );
    });
  }

  final List<Widget> pages = [
    HomePageViews(),
    ChatBotView(),
    HistoryPageView(),
    ProfilePageView(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_currentIndex],

      bottomNavigationBar: CircleNavBar(
        activeIndex: _currentIndex,

        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },

        activeIcons: const [
          Icon(Icons.home, color: Colors.white),
          Icon(Icons.support_agent, color: Colors.white),
          Icon(Icons.history_outlined, color: Colors.white),
          Icon(Icons.person, color: Colors.white),
        ],

        inactiveIcons: const [
          Icon(Icons.home_outlined, color: Colors.white),
          Icon(Icons.support_agent_outlined, color: Colors.white),
          Icon(Icons.history, color: Colors.white),
          Icon(Icons.person_outline, color: Colors.white),
        ],

        levels: const ["Home", "ChatBot", "History", "Profile"],

        activeLevelsStyle: const TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),

        color: AppColor.primaryColor,
        circleColor: Colors.orange,

        height: 70,
        circleWidth: 48,

        shadowColor: Colors.black26,
        circleShadowColor: Colors.black26,

        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),

        cornerRadius: const BorderRadius.only(
          topLeft: Radius.circular(25),
          topRight: Radius.circular(25),
        ),
      ),
    );
  }
}
