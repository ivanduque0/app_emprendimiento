import 'package:flutter/material.dart';

class StaggeredDualView extends StatelessWidget {
  const StaggeredDualView({
    super.key,
    required this.itemBuilder,
    required this.itemCount,
    required this.spacing,
    required this.aspectRatio
  });

  final IndexedWidgetBuilder itemBuilder;
  final int itemCount;
  final double spacing;
  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (_, constraints){
        final width = constraints.maxWidth;
        final itemHeight = (width*0.5/aspectRatio);
        final height = constraints.maxHeight + itemHeight;
        
        return ClipRect(
          child: OverflowBox(
            maxHeight: height,
            minWidth: width,
            minHeight: height,
            maxWidth: width,
            child: GridView.builder(
              padding: EdgeInsets.only(top: itemHeight/2, bottom: itemHeight),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: aspectRatio,
                crossAxisSpacing: spacing,
                mainAxisSpacing: spacing
              ), 
              itemCount: itemCount,
              itemBuilder: (_, index) {
                return Transform.translate(
                  offset: Offset(0.0, index.isOdd ? itemHeight * 0.3 : 0),
                  child: itemBuilder(_, index),
                );
              }
            ),
          ),
        );
      }); 
    
    
  }
}