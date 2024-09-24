import 'package:flutter/material.dart';

import '../../../../../core/core.dart';
import '../../../marvel_characters.dart';


class CharacterDetailsPage extends StatelessWidget {
  final Character character;

  const CharacterDetailsPage({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDarkGrey,
      appBar: const CustomAppBar(showLading: true,),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
           DetailCardWidget(
            imageUrl:character.imageUrl,
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.s24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  character.name,
                  style: AppTextStyles.boldLargeTextStyle(color: AppColors.backgroundWhite),
                ),
                const SizedBox(
                  height: AppSizes.s24,
                ),
                  Text(
                  AppStrings.biography,
                  style: AppTextStyles.characterNameStyle(color: AppColors.backgroundWhite),
                ),
                const SizedBox(
                  height: AppSizes.s8,
                ),

                Text(
                  character.description,
                  style: AppTextStyles.normalTextStyle(color: AppColors.backgroundWhite),
                ),
                
              ],
            ),
          ),
        ],
      ),
    );
  }
}