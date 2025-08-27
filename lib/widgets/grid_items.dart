import 'package:flutter/material.dart';

class GridItems extends StatelessWidget {
  const GridItems({super.key, required this.itemCount, required this.builder});
  final int itemCount;
  final Widget? Function(BuildContext, int) builder;
  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: EdgeInsets.only(top: 12, bottom: 8),
      itemCount: itemCount,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3, // No of Columns
        childAspectRatio: 18 / 22,
        crossAxisSpacing: 10,
        mainAxisSpacing: 20,
      ),
      itemBuilder: builder,
    );
  }
}
