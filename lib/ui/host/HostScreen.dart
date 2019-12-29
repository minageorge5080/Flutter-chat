import 'package:flutter/material.dart';
import 'package:flutter_chat/base/BaseScreenState.dart';
import 'package:flutter_chat/ui/host/HostPresenter.dart';

class HostScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return HostState();
  }
}

class HostState extends BaseScreenState<HostScreen> {
  HostPresenter _presenter;

  int _currentIndex = 0;

  @override
  void getScreenInitialization() {
    _presenter = HostPresenter(screen: this);
    _presenter.getUsersList();
    
  }

  @override
  Widget getScreenWidget() {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        items: [
          BottomNavigationBarItem(
            icon: new Icon(Icons.search),
            title: new Text('Discover'),
          ),
          BottomNavigationBarItem(
            icon: new Icon(Icons.inbox),
            title: new Text('Inbox'),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.person), title: Text('Profile'))
        ],
        onTap: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
      body: _processCurrentScreen(),
    );
  }

  Widget _processCurrentScreen() {
    switch (_currentIndex) {
      case 0:
        return getDiscoverScreen();
      case 1:
        return getInboxScreen();
      case 2:
        return getProfileScreen();
        break;
    }
    return Container();
  }

  Widget getDiscoverScreen() {
    return Center(
      child: Text("Discover"),
    );
  }

  Widget getProfileScreen() {
    return Center(
      child: Text("Profile"),
    );
  }

  Widget getInboxScreen() {
    return Center(
      child: Text("Inbox"),
    );
  }

}
