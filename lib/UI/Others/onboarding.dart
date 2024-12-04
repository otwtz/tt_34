import 'package:flutter/material.dart';
import 'package:tt_34/UI/Others/home.dart';
import 'package:tt_34/style.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  void _nextPage() {
    if (_currentPage < 2) {
      _pageController.nextPage(
        duration: Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    } else {
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: _pageController,
        onPageChanged: (int page) {
          setState(() {
            _currentPage = page;
          });
        },
        children: [
          _buildPage(
            image: 'Assets/Icons/Group 108.png', // Первая картинка
            title: 'Track your health,\ntransform your habits',
            description: 'Record, analyze, and improve\nyour health every day',
            gradientColors: Style.blueGrad,
          ),
          _buildPage(
            image: 'Assets/Icons/Group 109.png', // Вторая картинка
            title: 'Know your numbers,\nown your wellness',
            description: 'Simple tools for a healthier, more\nbalanced life',
            gradientColors: Style.pinkGrad,
          ),
          _buildPage(
            image: 'Assets/Icons/Group 110.png', // Третья картинка
            title: 'Your guide to better health insights',
            description: 'From tracking to thriving –\nit starts here',
            gradientColors: Style.purpleGrad, // Градиент для третьего экрана
          ),
        ],
      ),
      floatingActionButton: Container(
        width: 72,
        height: 72,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(36),
          gradient: LinearGradient(
            colors: [
              Color.fromRGBO(60, 169, 236, 1),
              Color.fromRGBO(35, 119, 235, 1),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: FloatingActionButton(
          onPressed: _nextPage,
          backgroundColor: Colors.transparent,
          child: Icon(
            Icons.arrow_forward_ios,
            color: Colors.white,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
      ),
    );
  }

  Widget _buildPage({
    required String image,
    required String title,
    required String description,
    required List<Color> gradientColors,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Style.bgColor,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(child: Image.asset(image, height: 300)),
          SizedBox(height: 20),
          Padding(
            padding: const EdgeInsets.only(right: 60.0),
            child: Container(
              height: 134,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(20),
                  bottomRight: Radius.circular(20),
                ),
                gradient: LinearGradient(
                  colors: gradientColors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              padding: EdgeInsets.only(right: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15.0),
                    child: Text(
                      title,
                      style: Style.txtStyle,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Text(
                      description,
                      style: TextStyle(
                        fontWeight: FontWeight.w400,
                        fontSize: 14,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
