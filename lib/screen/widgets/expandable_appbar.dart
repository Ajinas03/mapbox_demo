import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mapbox_demo/logic/bloc/map_bloc.dart';

class ExpandableAppBar extends StatelessWidget implements PreferredSizeWidget {
  final Widget child;

  ExpandableAppBar({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MapBloc, MapState>(
      builder: (context, state) {
        return AppBar(
          bottom: PreferredSize(
            preferredSize: Size.fromHeight(state.isExpanded ? 200 : 0),
            child: AnimatedContainer(
              duration: Duration(milliseconds: 300),
              height: state.isExpanded ? 200 : 0,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    ListTile(
                      leading: const CircleAvatar(
                        child: Icon(Icons.person),
                      ),
                      title: const Text("John Doe"),
                      subtitle: const Text("johndoe@gmail.com"),
                      titleTextStyle: const TextStyle(color: Colors.white),
                      subtitleTextStyle: const TextStyle(color: Colors.white),
                    ),
                    Padding(
                      padding: EdgeInsets.all(16),
                      child: child,
                    ),
                  ],
                ),
              ),
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                  state.isExpanded ? Icons.expand_less : Icons.expand_more),
              onPressed: () {
                context
                    .read<MapBloc>()
                    .add(ExpandAppBar(isExpand: !state.isExpanded));
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight + (200));
}
