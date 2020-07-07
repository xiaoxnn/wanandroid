import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyListTile extends StatelessWidget{

  final Widget leading;
  final Widget title;
  final Widget subtitle;
  final  Widget trailing;
  final double height;
  final EdgeInsetsGeometry contentPadding;
  final EdgeInsetsGeometry leftPadding;
  final GestureTapCallback  onTap;
  MyListTile({
    this.leading,
    this.title,
    this.subtitle,
    this.trailing,
    this.height=46,
    this.contentPadding,
    this.leftPadding,
    this.onTap,
   });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    IconThemeData iconThemeData;
    if (leading != null )
      iconThemeData = IconThemeData(color:Colors.black45);
    /// : Colors.black45;
    Widget leadingIcon;
    if (leading != null) {
      leadingIcon = IconTheme.merge(
        data: iconThemeData,
        child: leading,
      );
    }
    Widget trailingIcon;
    if (trailing != null) {
      trailingIcon = IconTheme.merge(
        data: iconThemeData,
        child: trailing,
      );
    }
     EdgeInsets _defaultContentPadding = this.contentPadding??EdgeInsets.only(left: 16);
     EdgeInsets _defaultLeftPadding = this.leftPadding??EdgeInsets.only(left: 20);
     EdgeInsets _defaultMargin = subtitle==null?EdgeInsets.only(bottom: 0):EdgeInsets.only(bottom: 10);
     return Container(
         height: this.height,
         child: InkWell(
           onTap: ()=>onTap?.call(),
           splashColor: Colors.grey,
           child: Row(
             children: [
               Container(
                 margin: _defaultLeftPadding,
               ),
               Container(
                 child: leadingIcon,
               )
               ,
               Container(
                 margin: _defaultContentPadding,
               ),
               Column(
                 mainAxisAlignment: MainAxisAlignment.center,
                 crossAxisAlignment: CrossAxisAlignment.start,
                 children: [
                   Container(
                     margin: _defaultMargin,
                     child: title,
                   ),
                   Container(
                       child: subtitle,
                   )
                 ],
               )
              ,
               Expanded(child: Container()),
               Container(
                 margin: EdgeInsets.only(right: 10),
                 child: trailingIcon ,
               )
             ],
           ),
         ),
     );
  }
}