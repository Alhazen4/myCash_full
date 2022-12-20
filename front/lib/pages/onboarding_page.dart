import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:my_cash_mobile/theme.dart';

class OnBoardingPage extends StatefulWidget {
  const OnBoardingPage({super.key});

  @override
  State<OnBoardingPage> createState() => _OnBoardingPageState();
}

class _OnBoardingPageState extends State<OnBoardingPage> {
  final introKey = GlobalKey<IntroductionScreenState>();
  handleLogin() async {
    Navigator.pushNamed(context, '/login');
  }

  void _onIntroEnd(context) {
    Navigator.pushNamed(context, '/login');
  }

  Widget _buildFullscreenImage() {
    return Image.asset(
      'assets/fullscreen.jpg',
      fit: BoxFit.cover,
      height: double.infinity,
      width: double.infinity,
      alignment: Alignment.center,
    );
  }

  Widget _buildImage(String assetName, [double width = 1000]) {
    return Container(
        child: Image.asset(
      '$assetName',
      width: width,
    ));
  }

  @override
  Widget build(BuildContext context) {
    PageDecoration pageDecoration = PageDecoration(
      imagePadding: EdgeInsets.only(top: 100),
      imageAlignment: Alignment.center,
      titleTextStyle: primaryTextStyle.copyWith(
          fontSize: 28.0, fontWeight: FontWeight.w700),
      bodyTextStyle: subtitleTextStyle.copyWith(
        fontSize: 16.0,
      ),
      imageFlex: 1,
      pageColor: Colors.white,
      contentMargin: EdgeInsets.only(
        top: 100,
      ),
    );
    return IntroductionScreen(
      key: introKey,

      globalBackgroundColor: Colors.white,
      autoScrollDuration: 3000,
      // globalHeader: Align(
      //   alignment: Alignment.center,
      //   child: SafeArea(
      //     child: Padding(
      //       padding: const EdgeInsets.only(
      //         top: 12,
      //         right: 12,
      //       ),
      //       child: Image.asset('assets/logo/logo-2.png', width: 50),
      //     ),
      //   ),
      // ),
      // globalFooter: SizedBox(
      //   width: double.infinity,
      //   height: 60,
      //   child: ElevatedButton(
      //     child: const Text(
      //       'Let\'s go right away!',
      //       style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
      //     ),
      //     onPressed: () => _onIntroEnd(context),
      //   ),
      // ),
      pages: [
        PageViewModel(
          title: "Welcome to MyCash",
          body: "your financial support",
          image: _buildImage('assets/illustration/onBoarding1.png', 350),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Support your financial",
          body: "your financial support",
          image: _buildImage('assets/illustration/onBoarding2.png'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Start Your Journey",
          body: "your financial support",
          image: _buildImage('assets/illustration/onBoarding3.png'),
          decoration: pageDecoration,
          footer: Container(
            height: 50,
            width: 150,
            margin: EdgeInsets.only(top: 30),
            child: TextButton(
              onPressed: handleLogin,
              style: TextButton.styleFrom(
                backgroundColor: primaryColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Let\'s Go',
                style: primaryTextStyle.copyWith(
                    fontSize: 16, fontWeight: medium, color: bglight),
              ),
            ),
          ),
        ),
      ],

      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipOrBackFlex: 0,
      nextFlex: 0,
      showBackButton: false,
      showNextButton: false,
      showDoneButton: false,
      //rtl: true, // Display as right-to-left
      // back: Icon(
      //   Icons.arrow_back,
      //   color: primaryColor,
      // ),
      skip: Text('Skip',
          style: primaryTextStyle.copyWith(
              fontSize: 14, fontWeight: FontWeight.w600, color: primaryColor)),
      // next: Icon(
      //   Icons.arrow_forward,
      //   color: primaryColor,
      // ),
      done: Text('Done',
          style: primaryTextStyle.copyWith(
              fontSize: 14, fontWeight: FontWeight.w600, color: primaryColor)),
      curve: Curves.fastLinearToSlowEaseIn,
      controlsMargin: const EdgeInsets.all(16),
      controlsPadding: kIsWeb
          ? const EdgeInsets.all(12.0)
          : const EdgeInsets.fromLTRB(0.0, 8.0, 60.0, 30.0),
      dotsDecorator: DotsDecorator(
        size: Size(10.0, 10.0),
        activeColor: primaryColor,
        color: dotsHover,
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(25.0)),
        ),
      ),
      dotsContainerDecorator: const ShapeDecoration(
        color: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(8.0)),
        ),
      ),
      // body: Container(
      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       Center(
      //         child: Container(
      //           width: 300,
      //           height: 300,
      //           decoration: BoxDecoration(
      //             image: DecorationImage(
      //               image: AssetImage(
      //                 'assets/illustration/login.png',
      //               ),
      //             ),
      //           ),
      //         ),
      //       ),
      //       Column(
      //         children: [
      //           Text(
      //             'Welcome to MyCash',
      //             style: primaryTextStyle.copyWith(
      //               fontSize: 32,
      //               fontWeight: semiBold,
      //             ),
      //           ),
      //           Text(
      //             'your financial support',
      //             style: subtitleTextStyle.copyWith(
      //               fontSize: 16,
      //               fontWeight: regular,
      //             ),
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
