import 'package:contacts_manager/data/data.dart';
import 'package:contacts_manager/data/repositories/contact_repository_provider.dart';
import 'package:contacts_manager/utils/extensions.dart';
// import 'package:contacts_manager/widgets/display_list_of_contacts.dart';
// import 'package:contacts_manager/data/models/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:contacts_manager/widgets/widgets.dart';
import 'package:contacts_manager/providers/providers.dart';

class HomeScreen extends ConsumerWidget {
  static HomeScreen builder(
    BuildContext context,
    GoRouterState state,
  ) =>
      const HomeScreen();
  const HomeScreen({super.key});

  // @override
  // State<HomeScreen> createState() => _HomeScreenState();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactState = ref.watch(contactProvider);
    final contacts = contactState.contacts;

    return Scaffold(
      appBar: AppBar(
        title: const DisplayWhiteText(
          text: 'Liste des contacts',
          fontWeight: FontWeight.bold,
          fontSize: 25,
        ),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.settings,
              color: Theme.of(context).colorScheme.inversePrimary,
              size: 25,
            ),
            style: IconButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.onPrimary),
          ),
        ],
      ),
      body: Column(
        children: [
          const HorizontalButtonBar(),
          DisplayContactsList(contacts: contacts)
          // Expanded(
          //   child: ListView.builder(
          //     scrollDirection: Axis.vertical,
          //     shrinkWrap: true,
          //     itemCount: contacts.length,
          //     itemBuilder: (BuildContext context, int index) {
          //       return Padding(
          //         padding: const EdgeInsets.all(6.0),
          //         child: Container(
          //           decoration: BoxDecoration(
          //               color: context.colorScheme.primary,
          //               borderRadius: BorderRadius.circular(5)),
          //           width: MediaQuery.of(context).size.width,
          //           height: 50,
          //           child: Row(
          //             mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //             children: [
          //               Padding(
          //                 padding: const EdgeInsets.only(left: 15.0),
          //                 child: DisplayWhiteText(
          //                   text:
          //                       ' ${contacts[index].contactLastName}  ${contacts[index].contactFirstName}',
          //                   fontWeight: FontWeight.bold,
          //                   fontSize: 20,
          //                 ),
          //               ),
          //               Padding(
          //                 padding: const EdgeInsets.all(8.0),
          //                 child: ElevatedButton(
          //                   onPressed: () {},
          //                   child: const Icon(Icons.edit, color: Colors.orange),
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ),
          //       );
          //     },
          //   ),
          // ),
        ],
      ),
    );
  }
}
