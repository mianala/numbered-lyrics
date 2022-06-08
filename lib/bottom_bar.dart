import 'package:flutter/material.dart';

Widget bottomBar(selectedIndex, context) {
  return BottomNavigationBar(
    items: const <BottomNavigationBarItem>[
      BottomNavigationBarItem(icon: Icon(Icons.apps), label: "Laharana"),
      BottomNavigationBarItem(icon: Icon(Icons.list), label: "Lisitra"),
      BottomNavigationBarItem(icon: Icon(Icons.article), label: "Hira"),
    ],
    currentIndex: selectedIndex,
    onTap: (index) {
      var currentRoute = ModalRoute.of(context)!.settings.name;
      var routes = ['/grid', '/list', '/song'];

      if (currentRoute == routes[index]) {
        return;
      }

      if (index == 2) {
        Navigator.pushNamed(context, routes[index]);
      } else {
        Navigator.pushNamedAndRemoveUntil(
            context, routes[index], (Route<dynamic> route) => false);
      }
    },
  );
}
