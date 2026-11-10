/*
import 'package:flutter/material.dart';
import 'package:glass_bottom_navigation/glass_bottom_navigation.dart';

class DashboardLiquidGlassBottomNavigationBar extends StatelessWidget {
  const DashboardLiquidGlassBottomNavigationBar({
    required this.selectedIndex,
    required this.onPageSelected,
    super.key,
  });

  final int selectedIndex;
  final ValueChanged<MainDashboardPage> onPageSelected;

  static const _pages = MainDashboardPage.values;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => GlassBottomBar(
        currentIndex: selectedIndex,
        onTap: (index) => onPageSelected(_pages[index]),
        width: constraints.maxWidth,
        height: 72,
        style: GlassBottomNavStyle(
          accent: context.palette.colorAccent,
          height: 72,
          widthFactor: 1,
          edgePadding: 0,
          nativeHorizontalOverflow: 16,
          nativeIconSize: 32,
          nativeLabelFontName: 'TildaSans-Semibold',
          nativeLabelFontSize: 12,
          nativeIsDark: context.isDarkTheme,
          nativeSelectedColor: context.palette.colorAccent,
          nativeUnselectedColor: context.palette.colorPrimary,
          nativeSelectionIndicatorColor: context.palette.colorAccent,
          nativeSelectionIndicatorOpacity: context.isLightTheme ? 0.07 : 0.12,
        ),
        items: [
          GlassBarItem(
            icon: Icons.add_box_outlined,
            label: context.texts.mainDashboardNavigationAdd,
            nativeAssetName: 'dashboard_add',
            nativeSymbolName: 'plus.square',
          ),
          GlassBarItem(
            icon: Icons.show_chart,
            label: context.texts.mainDashboardStatistics,
            nativeAssetName: 'dashboard_statistics',
            nativeSymbolName: 'chart.xyaxis.line',
          ),
          GlassBarItem(
            icon: Icons.tune,
            label: context.texts.mainDashboardManagement,
            nativeAssetName: 'dashboard_management',
            nativeSymbolName: 'slider.vertical.3',
          ),
          GlassBarItem(
            icon: Icons.menu,
            label: context.texts.mainDashboardNavigationMenu,
            nativeAssetName: 'dashboard_menu',
            nativeSymbolName: 'line.3.horizontal',
          ),
        ],
      ),
    );
  }
}
*/
