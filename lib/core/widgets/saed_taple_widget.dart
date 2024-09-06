import 'package:collection/collection.dart';
import 'package:drawable_text/drawable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../strings/app_color_manager.dart';

class SaedTableWidget extends StatelessWidget {
  const SaedTableWidget({
    super.key,
    required this.title,
    required this.data,
    this.weights,
    this.onTapItem,
    this.height,
    this.onTapHeader,
  });

  final double? height;
  final List<dynamic> title;
  final List<int>? weights;
  final List<List<dynamic>> data;
  final Function(int i)? onTapItem;
  final Function()? onTapHeader;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: AppColorManager.lightGray,
        borderRadius: BorderRadius.circular(12.0.r),
        border: Border.all(color: AppColorManager.cardColor),
      ),
      clipBehavior: Clip.hardEdge,
      child: Column(
        children: [
          GestureDetector(
            onTap: onTapHeader,
            child: Container(
              padding: const EdgeInsets.symmetric(vertical: 10.0).h,
              color: AppColorManager.tableHeader,
              child: TitleWidget(
                title: title,
                weights: weights,
              ),
            ),
          ),
          Expanded(
            flex: height == null ? 0 : 1,
            child: ListView.builder(
              shrinkWrap: true,
              physics: height == null ? const NeverScrollableScrollPhysics() : null,
              itemCount: data.length,
              padding: EdgeInsets.only(bottom: 150.0.h),
              itemBuilder: (context, i) {
                final e  = data[i];
              return  InkWell(
                  onTap: () => onTapItem?.call(i),
                  child: CellWidget(
                    e: e,
                    weights: weights,
                    withDivider: i != 0,
                  ),
                );
              },
            ),
          ),
          30.0.verticalSpace,
        ],
      ),
    );
  }
}

class CellWidget extends StatelessWidget {
  const CellWidget({super.key, required this.e, this.withDivider = true, this.weights});

  final Iterable e;
  final List<int>? weights;

  final bool withDivider;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        if (withDivider) Divider(height: 30.0.h) else 15.0.verticalSpace,
        Row(
          children: e.mapIndexed(
            (i, e) {
              final widget = (e is String)
                  ? Directionality(
                      textDirection: TextDirection.ltr,
                      child: DrawableText(
                        size: 12.0.sp,
                        matchParent: true,
                        maxLines: 2,
                        textAlign: TextAlign.center,
                        text: e.isEmpty ? '-' : e,
                      ),
                    )
                  : (e is Widget)
                      ? e
                      : Container(
                          height: 10,
                          color: Colors.red,
                        );

              return Expanded(
                flex: (i >= (weights?.length ?? 0)) ? 1 : weights![i],
                child: widget,
              );
            },
          ).toList(),
        ),
      ],
    );
  }
}

class TitleWidget extends StatelessWidget {
  const TitleWidget({super.key, required this.title, this.weights});

  final Iterable title;
  final List<int>? weights;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: title.mapIndexed(
        (i, e) {
          final widget = e is String
              ? DrawableText(
                  matchParent: true,
                  textAlign: TextAlign.center,
                  size: 12.0.sp,
                  color: AppColorManager.mainColor,
                  fontWeight: FontWeight.w800,
                  text: e,
                )
              : title is Widget
                  ? title as Widget
                  : Container(
                      color: Colors.red,
                      height: 10,
                    );

          return Expanded(
            flex: (i >= (weights?.length ?? 0)) ? 1 : weights![i],
            child: widget,
          );
        },
      ).toList(),
    );
  }
}
