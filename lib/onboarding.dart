import 'package:flutter/material.dart';
import 'package:gdsc_onboarding_screen/OnboardingScreens/Page1.dart';
import 'package:gdsc_onboarding_screen/OnboardingScreens/Page2.dart';
import 'package:gdsc_onboarding_screen/OnboardingScreens/Page3.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({Key? key}) : super(key: key);

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  PageController controller = PageController();
  bool isLast = false;

  String title = 'Feeling stressed?';
  String content =
      'Everyone feels stressed from time to time and don’t know how to deal with it. We have curated many different ways to help you cope up with stress. Find people with whom you can talk, experts to assist you and meditation tricks to ease up your mind';

  @override
  void initState() {
    super.initState();
    controller.addListener(() {
      setState(() {
        if (controller.page == 0) {
          title = 'Feeling stressed?';
          content =
              'Everyone feels stressed from time to time and don’t know how to deal with it. We have curated many different ways to help you cope up with stress. Find people with whom you can talk, experts to assist you and meditation tricks to ease up your mind';
        } else if (controller.page == 1) {
          title = 'Healthy body, Healthy mind';
          content =
              'A balance between body and mind is the key to happy life. take some moment to meditate or to self evaluate your mental health with the resources curated by us';
        } else if (controller.page == 2) {
          title = 'Psychotherapy';
          content =
              'Psychotherapy is teaching new ways of thinking and behaving. It aims at changing habits that may cause depression. Connect with the experts to clear out your mind and get the right advices.';
        }
      });
    });
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final style = SystemUiOverlayStyle(
      systemNavigationBarColor: Theme.of(context).colorScheme.onSecondary,
      systemNavigationBarDividerColor:
          Theme.of(context).colorScheme.onSecondary,
      systemNavigationBarIconBrightness: Brightness.dark,
    );
    SystemChrome.setSystemUIOverlayStyle(style);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: PageView(
        controller: controller,
        onPageChanged: (index) {
          setState(() {
            isLast = index == 2;
          });
        },
        children: const [
          Page1(),
          Page2(),
          Page3(),
        ],
      ),
      bottomSheet: Container(
        height: MediaQuery.of(context).size.height * 0.43,
        width: MediaQuery.of(context).size.width,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(48),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
              left: 24.0, right: 24.0, top: 24.0, bottom: 8.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SmoothPageIndicator(
                    controller: controller,
                    count: 3,
                    effect: const WormEffect(
                      dotHeight: 15,
                      dotWidth: 15,
                      dotColor: Color(0xff1E0368),
                      activeDotColor: Color(0xff3600D0),
                      spacing: 15.0,
                    ),
                    onDotClicked: (index) {
                      controller.animateToPage(
                        index,
                        duration: const Duration(milliseconds: 500),
                        curve: Curves.ease,
                      );
                    },
                  ),
                ],
              ),
              SingleChildScrollView(
                //to prevent overflow error on small screens
                physics: const BouncingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                child: Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
                  child: Text(title,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        shadows: const <Shadow>[
                          Shadow(
                            offset: Offset(1.0, 1.0),
                            blurRadius: 6.0,
                            color: Color(0xffc2bcbc),
                          ),
                        ],
                        color: const Color(0xff1E0368),
                        fontSize: 24,
                        fontWeight: FontWeight.w700,
                        fontFamily: GoogleFonts.poppins().fontFamily,
                      )),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  //to prevent overflow error on small screens
                  scrollDirection: Axis.vertical,
                  physics: const BouncingScrollPhysics(),
                  child: Text(
                    content,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color(0xff676767),
                      fontSize: 19,
                      fontWeight: FontWeight.w400,
                      fontFamily: GoogleFonts.poppins().fontFamily,
                    ),
                  ),
                ),
              ),
              isLast
                  ? const Padding(
                      //prevent widget overlap
                      padding: EdgeInsets.only(top: 10.0, bottom: 16.0),
                      child: ElevatedButton(
                        onPressed: null, //TODO: Connect to a main page
                        child: Text('Get started',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w700,
                            )),
                      ),
                    )
                  : Padding(
                      //prevent widget overlap
                      padding: const EdgeInsets.only(top: 8.0),
                      child: Row(
                        children: [
                          const Spacer(),
                          IconButton(
                            onPressed: () {
                              controller.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.ease,
                              );
                            },
                            icon: const Icon(
                              Icons.arrow_circle_right_outlined,
                              size: 50,
                              color: Color(0xff1E0368),
                            ),
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}
