import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
import 'package:polygon_painter/config/app_colors.dart';
import 'package:polygon_painter/config/app_icons.dart';
import 'package:polygon_painter/providers/polygon_provider/polygon_provider.dart';

class ControlPanelWidget extends ConsumerWidget {
  const ControlPanelWidget({
    required this.polygonNotifier,
    super.key,
  });

  final Polygon polygonNotifier;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        DecoratedBox(
          decoration: BoxDecoration(
              color: AppColors.white, borderRadius: BorderRadius.circular(6)),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 7,
              horizontal: 11,
            ),
            child: Row(
              children: [
                GestureDetector(
                  onTap: () => polygonNotifier.undo(),
                  child: SvgPicture.asset(
                    height: 20,
                    AppIcons.undo,
                    colorFilter: ColorFilter.mode(
                      polygonNotifier.canUndo
                          ? AppColors.darkGrey
                          : AppColors.lightGrey,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: 10,
                  ),
                  child: ColoredBox(
                    color: AppColors.lightGrey,
                    child: SizedBox(
                      width: 1,
                      height: 12,
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () => polygonNotifier.redo(),
                  child: SvgPicture.asset(
                    height: 20,
                    AppIcons.redo,
                    colorFilter: ColorFilter.mode(
                      polygonNotifier.canRedo
                          ? AppColors.darkGrey
                          : AppColors.lightGrey,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        DecoratedBox(
          decoration: const BoxDecoration(
            color: AppColors.white,
            shape: BoxShape.circle,
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: SvgPicture.asset(
              height: 22,
              AppIcons.grid,
            ),
          ),
        ),
      ],
    );
  }
}
