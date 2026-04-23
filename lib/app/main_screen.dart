// import 'dart:ui';
// import 'package:flutter/material.dart';
// import '../features/home/home_screen.dart';

// class MainScreen extends StatefulWidget {
//   const MainScreen({super.key});

//   @override
//   State<MainScreen> createState() => _MainScreenState();
// }

// class _MainScreenState extends State<MainScreen> {
//   int currentIndex = 0;

//   final List<Widget> screens = [
//     const HomeScreen(),
//     const Center(child: Text("Search Screen", style: TextStyle(color: Colors.white))),
//     const Center(child: Text("Profile Screen", style: TextStyle(color: Colors.white))),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: const Color(0xFF0F1923), // Matches Valorant Dark Theme
//       extendBody: true, // Crucial: allows content to flow behind the glass bar
//       body: screens[currentIndex],
//       bottomNavigationBar: Padding(
//         padding: const EdgeInsets.only(left: 20, right: 20, bottom: 24),
//         child: ClipRRect(
//           borderRadius: BorderRadius.circular(24),
//           child: BackdropFilter(
//             filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
//             child: Container(
//               height: 70,
//               decoration: BoxDecoration(
//                 color: Colors.white.withOpacity(0.08),
//                 borderRadius: BorderRadius.circular(24),
//                 border: Border.all(
//                   color: Colors.white.withOpacity(0.1),
//                   width: 1,
//                 ),
//               ),
//               child: BottomNavigationBar(
//                 backgroundColor: Colors.transparent,
//                 elevation: 0,
//                 currentIndex: currentIndex,
//                 onTap: (index) {
//                   setState(() {
//                     currentIndex = index;
//                   });
//                 },
//                 selectedItemColor: Colors.redAccent,
//                 unselectedItemColor: Colors.white54,
//                 showSelectedLabels: false,
//                 showUnselectedLabels: false,
//                 type: BottomNavigationBarType.fixed,
//                 items: const [
//                   BottomNavigationBarItem(
//                     icon: Icon(Icons.grid_view_rounded, size: 28),
//                     label: "",
//                   ),
//                   BottomNavigationBarItem(
//                     icon: Icon(Icons.search_rounded, size: 28),
//                     label: "",
//                   ),
//                   BottomNavigationBarItem(
//                     icon: Icon(Icons.person_outline_rounded, size: 28),
//                     label: "",
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }