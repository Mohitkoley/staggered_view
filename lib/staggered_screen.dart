import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';

import 'global_enums.dart';

class StaggeredScreen extends StatefulWidget {
  final GridType selectedGrid;
  final String title;

  const StaggeredScreen(
      {required this.selectedGrid, required this.title, Key? key})
      : super(key: key);

  @override
  State<StaggeredScreen> createState() => _StaggeredScreenState();
}

class _StaggeredScreenState extends State<StaggeredScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context)),
          title: Text(widget.title),
          centerTitle: true,
        ),
        body: Padding(padding: EdgeInsets.all(10), child: getGrid()));
  }

  Widget getGrid() {
    switch (widget.selectedGrid) {
      case GridType.staggerd:
        return getStaggeredGrid();
      // TODO: Handle this case.

      case GridType.masonry:
        return getMasonry();
      // TODO: Handle this case.

      case GridType.quilted:
        // TODO: Handle this case.
        return getQuiltedGrid();

      case GridType.woven:
        // TODO: Handle this case.
        return getWovenGrid();

      case GridType.staired:
        // TODO: Handle this case.
        return getStairedGrid();

      case GridType.aligned:
        // TODO: Handle this case.
        return getAlignedGrid();
    }
  }

  /// grid properties:
  /// - Evenly divided in n columns
  ///  - Small number of items
  ///  - Not scrollable
  ///  - tile properties:
  /// - Must occupy 1 to n columns
  ///  placement: top-most & then left-most
  Widget getStaggeredGrid() {
    return StaggeredGrid.count(
      crossAxisCount: 4,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      axisDirection: AxisDirection.up,
      children: [
        StaggeredGridTile.count(
          crossAxisCellCount: 2,
          mainAxisCellCount: 2,
          child: Tile(index: 0),
        ),
        StaggeredGridTile.count(
            crossAxisCellCount: 2, mainAxisCellCount: 1, child: Tile(index: 1)),
        StaggeredGridTile.count(
            crossAxisCellCount: 1, mainAxisCellCount: 1, child: Tile(index: 2)),
        StaggeredGridTile.count(
            crossAxisCellCount: 1, mainAxisCellCount: 1, child: Tile(index: 3)),
        StaggeredGridTile.count(
            crossAxisCellCount: 4, mainAxisCellCount: 2, child: Tile(index: 4))
      ],
    );
  }

  /// grid properties:
  ///  - Evenly divided in n Columns
  /// Tile properties:
  /// - Must occupy 1 to n columns
  /// - Placement: top-most & left-most

  Widget getMasonry() {
    return MasonryGridView.count(
      crossAxisCount: 10,
      itemBuilder: (context, index) {
        return Tile(index: index, extent: (index % 5 + 1) * 100);
      },
    );
  }

  /// grid properties:
  /// -Evenly Divided in n Columns
  /// - Height os each row is equal to the height of the width of each column
  /// Tile properties:
  ///  - Must occupy 1 to n Columns
  ///  - Must occupy 1 or more entire rows
  /// Placement algorithm: Top-most & left-most

  Widget getQuiltedGrid() {
    return GridView.custom(
        gridDelegate: SliverQuiltedGridDelegate(
          crossAxisCount: 4,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          repeatPattern: QuiltedGridRepeatPattern.inverted,
          pattern: [
            QuiltedGridTile(2, 2),
            QuiltedGridTile(1, 1),
            QuiltedGridTile(1, 1),
            QuiltedGridTile(1, 2),
          ],
        ),
        childrenDelegate: SliverChildBuilderDelegate(
          (context, index) => Tile(index: index),
        ));
  }

  /// items are displayed in containers of varying ratios rhythemics layout
  /// Grid properties:
  /// - Evenly divided in n Columns
  /// - Height os each row is equal to the height of the width of each column
  ///  - A pattern defines size of the tiles
  /// size of tiles follows the pattern in a 'z'  awquence
  /// Tile properties:
  /// height is defined by an aspectRatio (width/colun's value)
  /// Each tile can define how it is aligned within the available space
  /// Placement algorithm: Top-most & left-most

  Widget getWovenGrid() {
    return GridView.custom(
        gridDelegate: SliverWovenGridDelegate.count(
          crossAxisCount: 2,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          pattern: [
            const WovenGridTile(1),
            const WovenGridTile(5 / 7,
                crossAxisRatio: 0.9, alignment: AlignmentDirectional.centerEnd)
          ],
        ),
        childrenDelegate: SliverChildBuilderDelegate(
          (context, index) => Tile(index: index),
        ));
  }

  /// Uses alternating container sizes and ratios to create a rhythmic effect.
  /// It's another kind of woven grid layout.
  /// Grid properties:
  ///   - A pattern defines the size of the tiles
  ///   - Each tile is shifted from the previous one by a margin in both axis
  ///   - The placement follows a 'z' sequence
  /// Tile properties:
  ///   - height: defined by aspectRatio (width/height)
  ///   - width: defined by crossAxisRatio (width/available horizontal space) between 0 (exclusive) and 1 (inclusive)
  /// Placement algorithm: 'z' sequence

  Widget getStairedGrid() {
    return GridView.custom(
        gridDelegate: SliverStairedGridDelegate(
            crossAxisSpacing: 48,
            mainAxisSpacing: 24,
            startCrossAxisDirectionReversed: true,
            pattern: [
              StairedGridTile(0.5, 1),
              StairedGridTile(0.5, 3 / 4),
              StairedGridTile(1.0, 10 / 4)
            ]),
        childrenDelegate:
            SliverChildBuilderDelegate((context, index) => Tile(index: index)));
  }

  /// Also called CSS Grid, which is common grid layout on the web.
  /// Each item within a track has the maximum cross axis extent of its siblings.
  /// Grid properties:
  ///   - Evenly divided in n columns
  ///   - The rows can have different heights
  /// Tile properties:
  ///   - Must occupy 1 column only
  ///   - Each tile has the same height as the tallest one of the row.
  /// Placement algorithm: Top-most & then left-most
  Widget getAlignedGrid() {
    return AlignedGridView.count(
        crossAxisCount: 4,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        itemBuilder: (contex, index) => Tile(index: index));
  }
}

class Tile extends StatelessWidget {
  const Tile(
      {required this.index,
      this.bottomSpace,
      this.extent,
      this.backgroundColor,
      Key? key})
      : super(key: key);
  final int index;
  final double? extent;
  final double? bottomSpace;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    final child = Container(
        color: backgroundColor ?? Colors.redAccent,
        height: extent,
        child: Center(
          child: CircleAvatar(
            minRadius: 20,
            maxRadius: 20,
            backgroundColor: Colors.white,
            foregroundColor: Colors.black,
            child: Text('$index', style: const TextStyle(fontSize: 20)),
          ),
        ));

    if (bottomSpace == null) {
      return child;
    }

    return Column(
      children: [
        Expanded(child: child),
        Container(
          height: bottomSpace,
          color: Colors.green,
        ),
      ],
    );
  }
}
