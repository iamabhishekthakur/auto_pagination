library auto_pagination;

import 'dart:developer';

import 'package:flutter/material.dart';

class AutoPagination extends StatefulWidget {
  const AutoPagination({
    super.key,
    required this.items,
    this.itemGap,
    this.previousButton,
    this.nextButton,
    this.currentPageCounterTextStyle,
    this.otherPageCounterTextStyle,
  });

  /// You can use your raw list and create a list of wiget my using map or List.generate
  final List<Widget> items;

  /// It is the sepeartor height between two item widget
  final double? itemGap;

  /// It allows users to have there own view for previous button
  final Widget? previousButton;

  /// It allows users to have there own view for next button
  final Widget? nextButton;

  /// It allows users to set the current page counter style
  final TextStyle? currentPageCounterTextStyle;

  /// It allows users to style unselected page counter
  final TextStyle? otherPageCounterTextStyle;
  @override
  State<AutoPagination> createState() => _AutoPaginationState();
}

class _AutoPaginationState extends State<AutoPagination> {
  ///
  final _pageController = PageController();
  GlobalKey? _itemViewGlobalKey;
  final GlobalKey _parentBoxGlobalKey = GlobalKey();
  final ValueNotifier<int> _currentPageIndex = ValueNotifier(0);
  int _itemPerPage = 3;

  /// Item gap
  late final double _itemGap;

  @override
  void initState() {
    /// If [itemGap] is not set by user, by default set 10 as [itemGap]
    _itemGap = widget.itemGap ?? 10;

    /// After knowing the sizes of view, handle initial [_itemPerPage] change
    WidgetsBinding.instance
        .addPostFrameCallback((timeStamp) => handleChangeOfView());

    super.initState();
  }

  /// Calculate and handle the height of widget and based on height of widget calculate the [_itemPerPage]
  /// Every time height of the view change this function should recalculate the [_itemPerPage]
  /// After calculation rebuild occurs
  void handleChangeOfView() {
    final parentBox =
        _parentBoxGlobalKey.currentContext!.findRenderObject() as RenderBox;
    final itemBox =
        _itemViewGlobalKey!.currentContext!.findRenderObject() as RenderBox;
    final heightOfParentWidget = parentBox.size.height;
    final heightOfItemWidget = itemBox.size.height;
    _itemPerPage = (heightOfParentWidget / heightOfItemWidget).floor();
    log("Height of parent : $heightOfParentWidget , Height of item : $heightOfItemWidget , Item per page : $_itemPerPage");
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener(
      onNotification: (SizeChangedLayoutNotification notification) {
        Future.delayed(const Duration(milliseconds: 400), () {
          handleChangeOfView();
        });
        return true;
      },
      child: SizeChangedLayoutNotifier(
        child: Column(
          children: [
            Expanded(
              key: _parentBoxGlobalKey,
              child: PageView.builder(
                  padEnds: false,
                  controller: _pageController,
                  itemCount: (widget.items.length / _itemPerPage).ceil(),
                  onPageChanged: (currentPageIndex) {
                    _currentPageIndex.value = currentPageIndex;
                  },
                  itemBuilder: (context, index) {
                    final int startIndex = _itemPerPage * index;

                    int endIndex = (startIndex + _itemPerPage);
                    if (endIndex >= widget.items.length) {
                      endIndex = widget.items.length;
                    }

                    return Column(
                      children: widget.items.getRange(startIndex, endIndex).map(
                        (e) {
                          _itemViewGlobalKey = GlobalKey();
                          return Container(
                            key: _itemViewGlobalKey,
                            margin: EdgeInsets.only(bottom: _itemGap),
                            padding: EdgeInsets.zero,
                            child: e,
                          );
                        },
                      ).toList(),
                    );
                  }),
            ),
            const SizedBox(
              height: 15,
            ),
            ValueListenableBuilder(
              valueListenable: _currentPageIndex,
              builder: (context, value, child) {
                return Align(
                  alignment: Alignment.centerRight,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      InkWell(
                        onTap: () {
                          _pageController.previousPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.decelerate,
                          );
                        },
                        child: widget.previousButton ??
                            const Icon(
                              Icons.arrow_back_ios,
                              size: 14,
                            ),
                      ),
                      Row(
                        children: List.generate(
                          (widget.items.length / _itemPerPage).ceil(),
                          (index) => InkWell(
                            onTap: () {
                              _pageController.animateToPage(
                                index,
                                duration: const Duration(milliseconds: 500),
                                curve: Curves.decelerate,
                              );
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Text(
                                "${index + 1}",
                                style: value == index
                                    ? widget.currentPageCounterTextStyle ??
                                        Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.w700,
                                            )
                                    : widget.otherPageCounterTextStyle ??
                                        Theme.of(context)
                                            .textTheme
                                            .bodyMedium
                                            ?.copyWith(
                                              fontWeight: FontWeight.w400,
                                            ),
                              ),
                            ),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          _pageController.nextPage(
                            duration: const Duration(milliseconds: 500),
                            curve: Curves.decelerate,
                          );
                        },
                        child: widget.nextButton ??
                            const Icon(
                              Icons.arrow_forward_ios,
                              size: 14,
                            ),
                      ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
