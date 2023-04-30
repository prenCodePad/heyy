import 'package:flutter/material.dart';
import 'package:heyy/common/common.dart';

class HomeLayout extends StatelessWidget with AppMixin {
  final double? headingPanelheight;
  final Widget headingChild;
  final Widget mainChild;
  const HomeLayout({Key? key, required this.headingChild, this.headingPanelheight, required this.mainChild})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        color: const Color(0xff1BD7BB),
        child: Column(
          children: [
            SizedBox(height: headingPanelheight ?? sizes.sh(0.3), width: double.infinity, child: headingChild),
            Expanded(
                child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.95),
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(42),
                  topRight: Radius.circular(42),
                ),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 12),
              child: mainChild,
            ))
          ],
        ));
  }
}
