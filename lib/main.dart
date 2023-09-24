import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/custom_animated_bottom_bar.dart';
import 'core/providers/index_provider.dart';

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  final _inactiveColor = Colors.grey;

  Widget _buildBottomBar(){
    return Consumer(
        builder: (_, WidgetRef ref, __) {
          return CustomAnimatedBottomBar(
            containerHeight: 70,
            backgroundColor: Colors.black,
            selectedIndex: ref.watch(currentIndexProvider), // Read the current index from the provider
            showElevation: true,
            itemCornerRadius: 24,
            curve: Curves.easeIn,
            onItemSelected: (index) => ref.read(currentIndexProvider.notifier).state = index,
            items: <BottomNavyBarItem>[
              BottomNavyBarItem(
                icon: const Icon(Icons.apps),
                title: const Text('Home'),
                activeColor: Colors.green,
                inactiveColor: _inactiveColor,
                textAlign: TextAlign.center,
              ),
              BottomNavyBarItem(
                icon: const Icon(Icons.people),
                title: const Text('Users'),
                activeColor: Colors.purpleAccent,
                inactiveColor: _inactiveColor,
                textAlign: TextAlign.center,
              ),
              BottomNavyBarItem(
                icon: const Icon(Icons.message),
                title: const Text(
                  'Messages ',
                ),
                activeColor: Colors.pink,
                inactiveColor: _inactiveColor,
                textAlign: TextAlign.center,
              ),
              BottomNavyBarItem(
                icon: const Icon(Icons.settings),
                title: const Text('Settings'),
                activeColor: Colors.blue,
                inactiveColor: _inactiveColor,
                textAlign: TextAlign.center,
              ),
            ],
          );
        }
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
          title: Text(title),
        ),
        bottomNavigationBar: _buildBottomBar(),
        body: getBody()
    );
  }

  Widget getBody() {
    List<Widget> pages = [
      Container(
        alignment: Alignment.center,
        child: const Text("Home Screen",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
      ),
      Container(
        alignment: Alignment.center,
        child: const Text("Users Screen",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
      ),
      Container(
        alignment: Alignment.center,
        child: const Text("Messages Screen",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
      ),
      Container(
        alignment: Alignment.center,
        child: const Text("Settings Screen",style: TextStyle(fontSize: 25,fontWeight: FontWeight.bold),),
      ),
    ];
    return Consumer(
        builder: (_, WidgetRef ref, __) {
        return IndexedStack(
          index: ref.watch(currentIndexProvider),
          children: pages,
        );
      }
    );
  }
}




