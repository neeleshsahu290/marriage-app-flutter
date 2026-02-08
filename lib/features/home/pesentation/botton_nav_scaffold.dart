import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:swan_match/core/constants/asset_constants.dart';
import 'package:swan_match/core/router/route_names.dart';
import 'package:swan_match/core/theme/app_colors.dart';
import 'package:swan_match/core/utils/extensions.dart';
import 'package:swan_match/shared/widgets/common/custom_app_bar.dart';
import 'package:swan_match/shared/widgets/my_text.dart';

class BottomNavScaffold extends StatelessWidget {
  final Widget child;

  const BottomNavScaffold({super.key, required this.child});

  int _currentIndex(BuildContext context) {
    final loc = GoRouterState.of(context).uri.toString();

    if (loc.startsWith(RouteNames.explore)) return 1;
    if (loc.startsWith(RouteNames.chat)) return 2;
    if (loc.startsWith(RouteNames.profile)) return 3;

    return 0; // home
  }

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(RouteNames.home);
        break;
      case 1:
        context.go(RouteNames.explore);
        break;
      case 2:
        context.go(RouteNames.chat);
        break;
      case 3:
        context.go(RouteNames.profile);
        break;
    }
  }

  Widget _navItem({
    required String selectedIcon,
    // required IconData unSelectedIcon,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              // Icon(
              //   isSelected ? selectedIcon : unSelectedIcon,
              //   color: isSelected ? AppColors.primary : Colors.grey,
              //   size: isSelected ? 26 : 24,
              // ),
              SvgPicture.asset(
                selectedIcon,
                // ignore: deprecated_member_use
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                height: isSelected ? 32 : 26,
                width: isSelected ? 32 : 26,
              ),

              const SizedBox(height: 2),
              MyText(
                text: label,

                fontSize: isSelected ? 14 : 12,
                color: isSelected ? AppColors.primary : AppColors.textSecondary,
                fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final current = _currentIndex(context);

    return Scaffold(
      appBar: CustomAppBar(
        title: context.tr.appName,
        leading: Icon(
          size: 32,
          Icons.favorite,
          color: const Color.fromARGB(255, 247, 17, 74),
        ),
        actionsList: [
          GestureDetector(
            onTap: () {
              context.push(RouteNames.settings);
            },
            child: SvgPicture.asset(AssetConstants.settingsIcon),
          ),
          SizedBox(width: 10),
        ],
      ),
      body: child,

      bottomNavigationBar: Container(
        color: Colors.white,
        padding: const EdgeInsets.only(bottom: 6),
        child: Row(
          children: [
            _navItem(
              selectedIcon: AssetConstants.homeIcon,
              label: context.tr.navHome,
              isSelected: current == 0,
              onTap: () => _onTap(context, 0),
            ),
            _navItem(
              selectedIcon: AssetConstants.exploreIcon,
              label: context.tr.navExplore,
              isSelected: current == 1,
              onTap: () => _onTap(context, 1),
            ),
            _navItem(
              selectedIcon: AssetConstants.chatIcon,
              label: context.tr.navChat,
              isSelected: current == 2,
              onTap: () => _onTap(context, 2),
            ),
            _navItem(
              selectedIcon: AssetConstants.userIcon,
              label: context.tr.navProfile,
              isSelected: current == 3,
              onTap: () => _onTap(context, 3),
            ),
          ],
        ),
      ),
    );
  }
}
