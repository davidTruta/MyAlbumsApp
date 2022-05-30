import 'package:flutter/material.dart';
import 'package:my_albums_app/ui/views/albums_screen.dart';
import 'package:my_albums_app/ui/views/temp_screen.dart';
import 'package:my_albums_app/view_models/album_view_model.dart';

class TabsScreen extends StatefulWidget {
  final AlbumsViewModel albumsViewModel;

  const TabsScreen({Key? key, required this.albumsViewModel}) : super(key: key);

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late final List<Map<String, Object>> _pages;

  @override
  initState() {
    super.initState();
    _pages = [
      {
        'body': AlbumsScreen(viewModel: widget.albumsViewModel),
        'appBar': AppBar(
          centerTitle: false,
          title: const Text(
            'My Albums',
            style: TextStyle(
                fontSize: 24,
                color: Colors.black87,
                fontWeight: FontWeight.w700),
          ),
          backgroundColor: Colors.white,
        )
      },
      {
        'body': const TempScreen(),
        'appBar': AppBar(
          backgroundColor: Colors.white,
        )
      },
      {
        'body': const TempScreen(),
        'appBar': AppBar(
          backgroundColor: Colors.white,
        )
      },
      {
        'body': const TempScreen(),
        'appBar': AppBar(
          backgroundColor: Colors.white,
        )
      },
    ];
  }

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: _pages[_selectedPageIndex]['appBar'] as AppBar,
      body: _pages[_selectedPageIndex]['body'] as Widget,
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        currentIndex: _selectedPageIndex,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Colors.grey.shade400,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(Icons.search),
              label: 'BROWSE'),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(Icons.tag_faces),
              label: 'FRIENDS'),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(Icons.article_outlined),
              label: 'NEWS'),
          BottomNavigationBarItem(
              backgroundColor: Theme.of(context).primaryColor,
              icon: const Icon(Icons.account_circle_outlined),
              label: 'PROFILE'),
        ],
      ),
    );
  }
}
