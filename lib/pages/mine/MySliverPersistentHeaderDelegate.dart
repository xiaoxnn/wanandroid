import 'dart:math';

import 'package:flutter/material.dart';


class MySliverPersistentHeaderDelegate extends SliverPersistentHeaderDelegate{


  final TabBar  child;

  MySliverPersistentHeaderDelegate({

      @required this.child,
  });


  @override
  Widget build(BuildContext context, double shrinkOffset, bool overlapsContent) {
    // TODO: implement build
     return SizedBox.expand(child: child,);
  }

  @override
  // TODO: implement maxExtent
  double get maxExtent => this.child.preferredSize.height;

  @override
  // TODO: implement minExtent
  double get minExtent => this.child.preferredSize.height;

  @override
  bool shouldRebuild(MySliverPersistentHeaderDelegate oldDelegate) {
    // TODO: implement shouldRebuild
     return true;
  }

}