// ignore_for_file: must_be_immutable

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_demo/logic/bloc/map_bloc.dart';

class ExpandableContainer extends StatelessWidget {
  final Widget child;
  final String title;

  ExpandableContainer({
    Key? key,
    required this.child,
    required this.title,
  }) : super(key: key);

  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: Colors.blue,
        border: Border.all(color: Colors.grey),
        borderRadius: const BorderRadius.only(
            bottomLeft: Radius.circular(8), bottomRight: Radius.circular(8)),
      ),
      child: Column(
        children: [
          ListTile(
            onTap: () {
              _isExpanded = !_isExpanded;
              context.read<MapBloc>().add(ExpandAppBar(isExpand: _isExpanded));
            },
            leading: const CircleAvatar(
              child: Icon(Icons.person),
            ),
            titleTextStyle: const TextStyle(color: Colors.white),
            subtitleTextStyle: const TextStyle(color: Colors.white),
            title: const Text("John Doe"),
            subtitle: const Text("johndoe@gmail.com"),
          ),
          BlocBuilder<MapBloc, MapState>(
            builder: (context, state) {
              return AnimatedCrossFade(
                firstChild: Container(),
                secondChild: Padding(
                  padding: EdgeInsets.all(16),
                  child: child,
                ),
                crossFadeState: state.isExpanded
                    ? CrossFadeState.showSecond
                    : CrossFadeState.showFirst,
                duration: Duration(milliseconds: 300),
              );
            },
          ),
        ],
      ),
    );
  }
}
