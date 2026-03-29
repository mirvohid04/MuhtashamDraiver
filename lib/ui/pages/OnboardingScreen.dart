import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../const/sizes/textSize.dart';
import 'BottomNavigation.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;

  // To'g'ridan-to'g'ri list ichida
  final List<Map<String, dynamic>> onboardingData = const
  [
    {
      "title": "Piyoda kuryerlik",
      "desc": "O'z hududingizda transportga ehtiyoj sezmasdan ishlang. Bo'sh vaqtingizda daromad topishni hoziroq boshlang.",
      "image": "assets/images/piyoda.png"
    },
    {
      "title": "Skuterda tezkorlik",
      "desc": "Tirbandliklarda vaqt yuting va ko'proq buyurtma bajaring. Chaqqonlik bilan kunlik daromadingizni oshiring.",
      "image": "assets/images/skuterda.png"
    },
    {
      "title": "Avtomobilda qulaylik",
      "desc": "Har qanday ob-havoda shaxsiy mashinangizda ishlang. Uzoq masofali buyurtmalar bilan barqaror daromadga ega bo'ling.",
      "image": "assets/images/mashinada.png"
    }
  ];

  @override
  Widget build(BuildContext context) {
    const Color primaryColor = Color(0xFF1BC261);
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            // Skip va progress
            Padding(
              padding: EdgeInsets.symmetric(horizontal: size.width * 0.06),
              child: Row(
                children: [
                  TextButton(
                    onPressed: () {},
                    style: TextButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: Size.zero,
                      tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    ),
                    child: Text(
                      "Skip",
                      style: GoogleFonts.plusJakartaSans(
                        color: Colors.grey.shade600,
                        fontSize: TextSize.text16(context),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const Spacer(),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: size.width * 0.032,
                      vertical: size.height * 0.008,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade100,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Text(
                      "${_currentPage + 1}/${onboardingData.length}",
                      style: GoogleFonts.plusJakartaSans(
                        color: primaryColor,
                        fontSize: TextSize.text14(context),
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ],
              ),
            ),


            // PageView
            Expanded(
              child: PageView.builder(
                controller: _controller,
                onPageChanged: (value) => setState(() => _currentPage = value),
                itemCount: onboardingData.length,
                itemBuilder: (context, index) {
                  final data = onboardingData[index];

                  return Column(
                    children: [
                      Spacer(flex: 1),

                      TweenAnimationBuilder(
                        tween: Tween<double>(begin: 0, end: 1),
                        duration: const Duration(milliseconds: 800),
                        curve: Curves.easeOutCubic,
                        builder: (context, double scale, child) {
                          return Transform.scale(
                            scale: scale,
                            child: child,
                          );
                        },
                        child: Container(
                          height: size.width * 0.7,
                          width: size.width * 0.9,
                          decoration: BoxDecoration(
                            color: Colors.transparent,
                            image: DecorationImage(image: AssetImage(onboardingData[index]['image'])),

                          ),
                        ),
                      ),

                      const Spacer(),

                      // Sarlavha
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width * 0.04),
                        child: Text(
                          data["title"]!,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.arvo(
                            fontSize: TextSize.text28(context),
                            fontWeight: FontWeight.w700,
                            height: 1.2,
                            letterSpacing: -0.5,
                          ),
                        ),
                      ),

                      SizedBox(height: size.height * 0.02),

                      // Tavsif
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: size.width * 0.104),
                        child: Text(
                          data["desc"]!,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.plusJakartaSans(
                            color: Colors.grey.shade600,
                            fontSize: TextSize.text16(context),
                            fontWeight: FontWeight.w500,
                            height: 1.5,
                            letterSpacing: 0.2,
                          ),
                        ),
                      ),

                      const Spacer(flex: 3),
                    ],
                  );
                },
              ),
            ),

            // Pastki qism
            Container(
              padding: EdgeInsets.fromLTRB(
                size.width * 0.06,
                size.height * 0.02,
                size.width * 0.06,
                size.height * 0.04,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.shade200,
                    blurRadius: 20,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Dots
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      onboardingData.length,
                          (index) => AnimatedContainer(
                        duration: const Duration(milliseconds: 300),
                        margin: EdgeInsets.only(right: size.width * 0.015),
                        height: size.width * 0.02,
                        width: _currentPage == index
                            ? size.width * 0.08
                            : size.width * 0.02,
                        decoration: BoxDecoration(
                          color: _currentPage == index
                              ? primaryColor
                              : Colors.grey.shade300,
                          borderRadius: BorderRadius.circular(size.width * 0.02),
                          boxShadow: _currentPage == index
                              ? [
                            BoxShadow(
                              color: primaryColor.withValues(alpha: 0.4),
                              blurRadius: 8,
                              offset: const Offset(0, 2),
                            ),
                          ]
                              : null,
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: size.height * 0.03),

                  // Tugma
                  Container(
                    width: double.infinity,
                    height: size.height * 0.065,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(size.width * 0.039),
                      gradient: LinearGradient(
                        colors: [
                          primaryColor,
                          Color(0xFF28E07B), // biroz ochiqroq
                        ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: primaryColor.withValues(alpha: 0.3),
                          blurRadius: 15,
                          offset: const Offset(0, 5),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        shadowColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(size.width * 0.039),
                        ),
                        elevation: 0,
                      ),
                      onPressed: () {
                        if (_currentPage < onboardingData.length - 1) {
                          _controller.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.easeOutCubic,
                          );

                        }
                        else{Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (builder)=>BottomNavigation()));}
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _currentPage == onboardingData.length - 1
                                ? "Boshlash"
                                : "Keyingisi",
                            style: GoogleFonts.plusJakartaSans(
                              fontSize: TextSize.text18(context),
                              color: Colors.white,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.5,
                            ),
                          ),
                          if (_currentPage != onboardingData.length - 1) ...[
                            SizedBox(width: size.width * 0.02),
                            const Icon(
                              Icons.arrow_forward,
                              color: Colors.white,
                              size: 20,
                            ),
                          ],
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}