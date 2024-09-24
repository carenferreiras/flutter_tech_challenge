import 'package:flutter/material.dart';
import 'package:flutter_tech_challenge/src/core/core.dart';

class DetailCardWidget extends StatelessWidget {
  final String imageUrl;
  const DetailCardWidget({
    super.key,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: AppSizes.s375,
      child: ClipRRect(
        child: Stack(
          children: [
            Image.network(
              imageUrl,
              width: double.infinity,
              height: double.infinity,
              fit: BoxFit.cover,
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                height: AppSizes.s60,
                width: double.infinity,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                      begin: Alignment.center,
                      end: Alignment.topCenter,
                      colors: [
                        AppColors.backgroundDarkGrey.withOpacity(1.0),
                        Colors.black.withOpacity(0),
                      ]),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
