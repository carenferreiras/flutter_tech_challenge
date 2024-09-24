import 'package:flutter/material.dart';
import 'package:flutter_tech_challenge/src/core/core.dart';


class CharacterCardWidget extends StatelessWidget {
  final String imageUrl;
  final String characterName;
  final double? size;
  final double? linearSize;
  final double? paddinRight;
  final void Function()? onTap;
  const CharacterCardWidget({
    super.key,
    required this.imageUrl,
    required this.characterName,
    this.linearSize,
    this.size, 
    this.paddinRight,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Padding(
        padding:  EdgeInsets.only(right: paddinRight?? AppSizes.s16),
        child: Container(
          width: size ?? AppSizes.s180,
          height: size ?? AppSizes.s180,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppSizes.s15),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppSizes.s15),
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
                    height: linearSize ?? AppSizes.s60,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        bottomLeft: Radius.circular(AppSizes.s15),
                        bottomRight: Radius.circular(AppSizes.s15),
                      ),
                      gradient: LinearGradient(
                          begin: Alignment.center,
                          end: Alignment.topCenter,
                          colors: [
                            AppColors.backgroundBlack.withOpacity(0.60),
                            AppColors.backgroundBlack.withOpacity(0),
                          ]),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: AppSizes.s14,
                        vertical: AppSizes.s7,
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Text(
                          characterName,
                          overflow: TextOverflow.ellipsis,
                          style: AppTextStyles.characterNameStyle(),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
