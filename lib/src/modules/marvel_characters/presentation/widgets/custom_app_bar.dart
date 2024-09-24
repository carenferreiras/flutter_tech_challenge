import 'package:flutter/material.dart';
import 'package:flutter_tech_challenge/src/core/core.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final bool showLogo;
  final bool showLading;

  const CustomAppBar({
    super.key,
    this.showLogo = true,
    this.showLading = false,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: showLading
          ? IconButton(
              onPressed: () => Navigator.pop(context),
              icon: const Icon(
                Icons.arrow_back_ios,
                color: AppColors.backgroundWhite,
              ))
          : null,
      title: Padding(
        padding: const EdgeInsets.only(bottom: AppSizes.s14),
        child: showLogo
            ? Image.asset(
                AppImages.logo,
                fit: BoxFit.cover,
                key: const Key('logo'),
              )
            : Text(
                title ?? '',
                style: const TextStyle(color: AppColors.backgroundWhite),
              ),
      ),
      backgroundColor: AppColors.backgroundDarkGrey,
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
