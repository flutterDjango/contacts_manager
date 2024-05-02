import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:contacts_manager/config/routes/routes_location.dart';

class HorizontalButtonBarWidget extends StatelessWidget {
  const HorizontalButtonBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
        FloatingActionButton(
          heroTag: 'contacts',
          onPressed: () {
            context.push(RouteLocation.createContact);
          },
          child: const Icon(Icons.person_add),
        ),
        FloatingActionButton(
            heroTag: 'categories',
            onPressed: () {
               context.push(RouteLocation.category);
            },
            child: const Icon(Icons.playlist_add_rounded),
          ),
          
      ]),
    );
  }
}
