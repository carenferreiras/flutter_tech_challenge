import 'package:flutter/material.dart';

import '../../../../core/core.dart';

class SearchBarWidget extends StatelessWidget {
  final void Function(String)? onChanged;
  const SearchBarWidget({super.key, this.onChanged});

  @override
  Widget build(BuildContext context) {
    return  Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.s24),
      child: TextField(
        onChanged: onChanged,
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.search), 
          hintText: AppStrings.searchBarText, 
          hintStyle: AppTextStyles.lightItalicTextStyle(),
          enabledBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.backgroundBlack), 
          ),
          focusedBorder: const UnderlineInputBorder(
            borderSide: BorderSide(color: AppColors.backgroundBlack, width: 2.0), 
          ),
        ),
      ),
    );
  }
}