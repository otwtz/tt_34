import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../UI/Others/home.dart';
import '../UI/Others/settings.dart';
import '../UI/Water/water.dart';
import '../UI/WEight/weight.dart';

class ChangeBodies extends StatefulWidget {
  final int index;
  const ChangeBodies({super.key, required this.index});

  @override
  State<ChangeBodies> createState() => _ChangeBodiesState();
}

class _ChangeBodiesState extends State<ChangeBodies>
    with TickerProviderStateMixin {
  TabController? _controller;

  // late final selectWidget;
  int selectWidget = 0;
  @override
  void initState() {
    selectWidget = widget.index;
    _controller = TabController(length: 4, vsync: this,initialIndex: selectWidget);
    super.initState();
  }


  void _onTabTapped(int index) {
    setState(() {
      selectWidget = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      body: TabBarView(
        physics: NeverScrollableScrollPhysics(),
        controller: _controller,
        children: [
          HomeScreen(),
          WeightControlScreen(),
          WaterScreen(),
          SettingsScreen(),
        ],
      ),
      bottomNavigationBar: Container(
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),
          color: Color.fromRGBO(10, 10, 23, 1),
        ),
        child: TabBar(
          padding: EdgeInsets.zero,
          indicator: BoxDecoration(
            color: Colors.transparent,
          ),
          controller: _controller,
          onTap: _onTabTapped,
          tabs: [
            Tab(
              icon: SvgPicture.asset(
                selectWidget == 0
                    ? 'Assets/Icons/tabler_home-filled (1).svg'
                    : 'Assets/Icons/tabler_home-filled.svg',
              ),
            ),
            Tab(
              icon: SvgPicture.asset(
                selectWidget == 1
                    ? 'Assets/Icons/icon-park-solid_weight (1).svg'
                    : 'Assets/Icons/icon-park-solid_weight.svg',
              ),
            ),
            Tab(
              icon: SvgPicture.asset(
                selectWidget == 2
                    ? 'Assets/Icons/material-symbols_water-drop (1).svg'
                    : 'Assets/Icons/material-symbols_water-drop.svg',
              ),
            ),
            Tab(
              icon: SvgPicture.asset(
                selectWidget == 3
                    ? 'Assets/Icons/ic_round-settings (1).svg'
                    : 'Assets/Icons/ic_round-settings.svg',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
