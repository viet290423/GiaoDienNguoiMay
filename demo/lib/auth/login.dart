import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class LoginScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: 428,
        height: 926,
        clipBehavior: Clip.antiAlias,
        decoration: ShapeDecoration(
          color: const Color(0xFFF8F8F8),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(50),
          ),
        ),
        child: Stack(
          children: [
            Positioned(
              left: 0,
              top: 0,
              child: Container(
                width: 428,
                height: 926,
                decoration: BoxDecoration(
                  color: Colors.white.withOpacity(0.4699999988079071),
                ),
              ),
            ),
            Positioned(
              left: -153.60,
              top: 625,
              child: Transform(
                transform: Matrix4.identity()
                  ..translate(0.0, 0.0)
                  ..rotateZ(0.47),
                child: Container(
                  width: 372,
                  height: 372,
                  decoration: const ShapeDecoration(
                    shape: RoundedRectangleBorder(
                      side: BorderSide(width: 2, color: Color(0xFFD7EBE9)),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: -264.70,
              top: 684.30,
              child: Container(
                width: 372,
                height: 372,
                decoration: const ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    side: BorderSide(width: 2, color: Color(0xFFD7EBE9)),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 57,
              top: -142,
              child: Container(
                width: 496,
                height: 496,
                decoration: const ShapeDecoration(
                  shape: OvalBorder(
                    side: BorderSide(width: 3, color: Color(0xFFD7EBE9)),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 148,
              top: -327,
              child: Container(
                width: 635,
                height: 635,
                decoration: const ShapeDecoration(
                  color: Color(0xFFD7EBE9),
                  shape: OvalBorder(),
                ),
              ),
            ),
            Positioned(
              left: 25,
              top: 160,
              child: Container(
                height: 422,
                padding:
                    const EdgeInsets.symmetric(horizontal: 11, vertical: 52),
                decoration: ShapeDecoration(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.only(top: 15.57, bottom: 23),
                      clipBehavior: Clip.antiAlias,
                      decoration: const BoxDecoration(),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Container(
                            width: 368.61,
                            height: 331.43,
                            child: Stack(
                              children: [
                                Positioned(
                                  left: 0,
                                  top: 330.83,
                                  child: Container(
                                    width: 358.04,
                                    height: 0.60,
                                    child: const Stack(),
                                  ),
                                ),
                                Positioned(
                                  left: 16.29,
                                  top: 87.89,
                                  child: Container(
                                    width: 162.15,
                                    height: 243.01,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 101.10,
                                          top: 111.88,
                                          child: Container(
                                            width: 61.05,
                                            height: 131.13,
                                            child: const Stack(),
                                          ),
                                        ),
                                        Positioned(
                                          left: 16.22,
                                          top: 107.31,
                                          child: Container(
                                            width: 92.55,
                                            height: 9.30,
                                            child: const Stack(),
                                          ),
                                        ),
                                        Positioned(
                                          left: 62.04,
                                          top: 107.31,
                                          child: Container(
                                            width: 92.73,
                                            height: 9.30,
                                            child: const Stack(),
                                          ),
                                        ),
                                        Positioned(
                                          left: 0,
                                          top: 0,
                                          child: Container(
                                            width: 98.23,
                                            height: 54.73,
                                            child: const Stack(),
                                          ),
                                        ),
                                        Positioned(
                                          left: 4.59,
                                          top: -0,
                                          child: Container(
                                            width: 98.23,
                                            height: 54.73,
                                            child: const Stack(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 31.17,
                                  top: 0,
                                  child: Container(
                                    width: 218.18,
                                    height: 331.16,
                                    child: Stack(
                                      children: [
                                        Positioned(
                                          left: 45.67,
                                          top: -0,
                                          child: Container(
                                            width: 45.76,
                                            height: 73.36,
                                            child: Stack(
                                              children: [
                                                Positioned(
                                                  left: 6.29,
                                                  top: 2.34,
                                                  child: Container(
                                                    width: 32.99,
                                                    height: 34.90,
                                                    child: const Stack(),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                        Positioned(
                                          left: 24.52,
                                          top: 150.97,
                                          child: Container(
                                            width: 176.55,
                                            height: 169.11,
                                            child: const Stack(),
                                          ),
                                        ),
                                        Positioned(
                                          left: 79.81,
                                          top: 92.67,
                                          child: Container(
                                            width: 122.17,
                                            height: 59.75,
                                            child: const Stack(),
                                          ),
                                        ),
                                        Positioned(
                                          left: 79.74,
                                          top: 84.19,
                                          child: Container(
                                            width: 24.44,
                                            height: 21.98,
                                            child: const Stack(),
                                          ),
                                        ),
                                        Positioned(
                                          left: 63.47,
                                          top: 87.88,
                                          child: Container(
                                            width: 24.48,
                                            height: 22.10,
                                            child: const Stack(),
                                          ),
                                        ),
                                        Positioned(
                                          left: 89.15,
                                          top: 44.77,
                                          child: Container(
                                            width: 11.07,
                                            height: 32.15,
                                            child: const Stack(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                  left: 291.35,
                                  top: 181.07,
                                  child: Container(
                                    width: 77.26,
                                    height: 150.36,
                                    child: const Stack(),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 45,
              top: 612,
              child: Container(
                height: 76,
                child: const Stack(
                  children: [
                    Positioned(
                      left: 0,
                      top: 0,
                      child: SizedBox(
                        width: 343,
                        height: 47,
                        child: Text(
                          'FuzzySnap',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Color(0xFF89CCC5),
                            fontSize: 35,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w600,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      left: 10,
                      top: 55,
                      child: SizedBox(
                        width: 323,
                        height: 21,
                        child: Text(
                          'Kết nối những khoảnh khắc',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontFamily: 'Poppins',
                            fontWeight: FontWeight.w400,
                            height: 0,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              left: 39,
              top: 778,
              child: Container(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      decoration: ShapeDecoration(
                        color: const Color(0xFF89CCC5),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        // ignore: prefer_const_literals_to_create_immutables
                        shadows: [
                          const BoxShadow(
                            color: Color(0xFFCAD6FF),
                            blurRadius: 20,
                            offset: Offset(0, 10),
                            spreadRadius: 0,
                          )
                        ],
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Login',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(width: 30),
                    Container(
                      height: 60,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 15),
                      decoration: ShapeDecoration(
                        color: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      child: const Row(
                        mainAxisSize: MainAxisSize.min,
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            'Register',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Color(0xFF0A0A0A),
                              fontSize: 20,
                              fontFamily: 'Poppins',
                              fontWeight: FontWeight.w600,
                              height: 0,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
