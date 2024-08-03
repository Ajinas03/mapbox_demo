import 'package:flutter/material.dart';

class ExpandableContainer extends StatefulWidget {
  final Widget child;
  final String title;

  const ExpandableContainer({
    Key? key,
    required this.child,
    required this.title,
  }) : super(key: key);

  @override
  _ExpandableContainerState createState() => _ExpandableContainerState();
}

class _ExpandableContainerState extends State<ExpandableContainer> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.only(
            bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
      ),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            leading: CircleAvatar(
              child: Icon(Icons.person),
            ),
            titleTextStyle: TextStyle(color: Colors.white),
            subtitleTextStyle: TextStyle(color: Colors.white),
            title: Text("John Doe"),
            subtitle: Text("johndoe@gmail.com"),
          ),
          AnimatedCrossFade(
            firstChild: Container(),
            secondChild: Padding(
              padding: EdgeInsets.all(16),
              child: widget.child,
            ),
            crossFadeState: _isExpanded
                ? CrossFadeState.showSecond
                : CrossFadeState.showFirst,
            duration: Duration(milliseconds: 300),
          ),
        ],
      ),
    );
  }
}
