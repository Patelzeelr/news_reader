import 'package:flutter/material.dart';

import 'sign_in_screen.dart';
import 'sign_up_screen.dart';

class CreateAccountScreen extends StatefulWidget {
  const CreateAccountScreen({Key? key}) : super(key: key);

  @override
  State<CreateAccountScreen> createState() => _CreateAccountScreenState();
}

class _CreateAccountScreenState extends State<CreateAccountScreen>
    with SingleTickerProviderStateMixin {
  bool value = false;
  List<Tab> tabs = <Tab>[
    const Tab(text: 'LogIn'),
    const Tab(text: 'Sign UP'),
  ];
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: tabs.length);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        backgroundColor: const Color(0xFFc0c0c0),
        appBar: AppBar(
          backgroundColor: Colors.red,
          title: _appBarTitle(),
          elevation: 0,
        ),
        body: Column(
          children: [
            _tabBar(),
            _tabBarView(),
          ],
        ),
      ),
    );
  }

  _appBarTitle() => RichText(
        text: const TextSpan(
          children: <TextSpan>[
            TextSpan(
              text: 'Social',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Raleway-Medium',
                fontSize: 30.0,
              ),
            ),
            TextSpan(
              text: ' X',
              style: TextStyle(
                color: Colors.white,
                fontFamily: 'Raleway-Medium',
                fontWeight: FontWeight.bold,
                fontSize: 40.0,
              ),
            ),
          ],
        ),
      );
  _tabBar() => Container(
        height: 60,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(40.0),
            bottomRight: Radius.circular(40.0),
          ),
          border: Border.all(color: Colors.red, width: 2.0),
        ),
        child: TabBar(
          controller: _tabController,
          indicator: BoxDecoration(
            color: Colors.red,
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(35.0),
              bottomRight: Radius.circular(35.0),
            ),
            border: Border.all(color: Colors.red, width: 2.0),
          ),
          labelColor: Colors.white,
          unselectedLabelColor: Colors.grey,
          labelStyle: const TextStyle(fontSize: 16.0),
          tabs: tabs,
        ),
      );
  _tabBarView() => Expanded(
        child: Padding(
          padding: const EdgeInsets.only(top: 10.0),
          child: TabBarView(
            controller: _tabController,
            children: [
              SignInScreen(_tabController),
              SignUpScreen(_tabController),
            ],
          ),
        ),
      );
}
