import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';

import 'authentication_page.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({Key? key}) : super(key: key);

  toAuthenticationPage(context) {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => AuthenticationPage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    toAuthenticationPage(context);
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: Container(
        alignment: Alignment.center,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              height: 200,
              width: 200,
              child: Image.asset('assets/images/logo.png'),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Expanded(
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      'Powered by ',
                      style: TextStyle(
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                Expanded(
                  child: AnimatedTextKit(
                    animatedTexts: [
                      TypewriterAnimatedText(
                        'D',
                        textStyle: const TextStyle(fontSize: 25),
                      ),
                      TypewriterAnimatedText(
                        'D',
                        textStyle: const TextStyle(fontSize: 25),
                      ),
                      //TypewriterAnimatedText('D'),
                      TypewriterAnimatedText('DEMAKK',
                          textStyle: const TextStyle(fontSize: 25),
                          speed: const Duration(milliseconds: 150))
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 100,
            ),
            Column(
              children: const [
                Text(
                  'Contact Us',
                  style: TextStyle(fontSize: 20),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  '0922493805',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: 15,
                ),
                Text(
                  'www.demakk.com',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w600,
                      letterSpacing: 3),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
