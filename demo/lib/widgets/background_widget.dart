import 'package:flutter/material.dart';

class BackgroundWidget extends StatelessWidget{
  final int flexTop;
  final int flexBottom;
  const BackgroundWidget({super.key, required this.flexTop, required this.flexBottom});

  @override
  Widget build(BuildContext context) {
    return Container(
            color: Colors.black,
            child: Column(
              children: [
                Expanded(
                  flex: flexTop,
                  child: Stack(
                    children: [
                      Container(
                        decoration: const BoxDecoration(
                          // borderRadius:
                          //     BorderRadius.only(bottomLeft: Radius.circular(50)),
                          color: Colors.white,
                        ),
                      ),
                      Container(
                        decoration: const BoxDecoration(
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(50)),
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: flexBottom,
                  child: Container(
                    height: 300,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.only(topRight: Radius.circular(50))),
                  ),
                ),
              ],
            ),
          );
  }

}