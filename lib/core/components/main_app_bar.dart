import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:study_easy/core/utils/const_colors.dart';

class MainAppBar extends StatefulWidget implements PreferredSizeWidget {
  final bool showBackButton;
  final bool transparentBackground;
  final bool lightColors;
  final bool hideUserMenu;
  final Function? onTap;
  final brightness;
  final double height;
  final EdgeInsetsGeometry? padding;
  final Color backgroundColor;
  MainAppBar({
    this.onTap,
    this.showBackButton = false,
    this.transparentBackground = false,
    this.lightColors = false,
    this.hideUserMenu = false,
    this.height = 55,
    this.padding,
    required this.backgroundColor,
    this.brightness}) : preferredSize = Size.fromHeight(kToolbarHeight);
  @override
  final Size preferredSize;

  _MainAppBarState createState() => _MainAppBarState();

}

class _MainAppBarState extends State<MainAppBar> {
  @override
  Widget build(BuildContext context) {
    return PreferredSize(
      preferredSize: Size.fromHeight(85),
      child: AppBar(
          backgroundColor: widget.transparentBackground == true ? Colors.transparent : Colors.white,
          automaticallyImplyLeading: false,
          elevation: 0,
          titleSpacing: 0.0,
          leading: null,
          brightness: widget.brightness,
          flexibleSpace: Container(
            decoration: widget.transparentBackground == true ?
            BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    stops: [0.25, 1],
                    colors: [
                      widget.backgroundColor,
                      widget.backgroundColor.withOpacity(0),
                    ]
                )
            ) :
            BoxDecoration(),
            child: Stack(
              children: [
                SizedBox(
                  height: widget.height,
                  child: Container(
                    color: widget.transparentBackground == true ? Colors.transparent : Colors.white,
                    padding: widget.padding == null ? EdgeInsets.only(left: 20, right: 20,) : widget.padding,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        widget.showBackButton?
                        GestureDetector(
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.arrow_back_ios,
                                  color: ConstColors.yellow,
                                ),
                                Text(
                                  'Voltar',
                                  style: TextStyle(
                                      fontFamily: "Jost Medium",
                                      fontSize: 15,
                                      color: widget.lightColors == false ? Color(0xFF202020) : Colors.white
                                  ),
                                )
                              ],
                            ),
                            onTap: () {
                              if(widget.onTap != null)
                                widget.onTap!.call();
                              else
                                Navigator.pop(context);
                            }
                        ) :
                        Container(),
                      ],
                    ),
                  ),
                )
              ],
            ),
          )
      ),
    );
  }
}