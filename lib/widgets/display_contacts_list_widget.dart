import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:contacts_manager/providers/providers.dart';
import 'package:contacts_manager/utils/utils.dart';
import 'package:contacts_manager/widgets/widgets.dart';


class DisplayContactsListWidget extends ConsumerWidget {
  const DisplayContactsListWidget(
      {super.key,
      // required this.contacts,
      this.message = 'Pas encore de contact'});

  // final List<Contact> contacts;
  final String message;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contacts = ref.watch(contactProvider).contacts;
    return Container(
      child: contacts.isEmpty
          ? Center(
              child: Text(message),
            )
          : Expanded(
              child: ListView.separated(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: contacts.length,
                itemBuilder: (BuildContext context, int index) {
                  final contact = contacts[index];
                  return InkWell(
                    onLongPress: () {
                      AppAlerts.showDeleteContactAlertDialog(context, ref, contact);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: Container(
                        decoration: BoxDecoration(
                          color: context.colorScheme.primary,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        width: MediaQuery.of(context).size.width,
                        height: 50,
                        child: Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: DisplayWhiteTextWidget(
                                  text:
                                      '${contact.contactLastName}  ${contact.contactFirstName}',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20,
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: ElevatedButton(
                                  onPressed: () {},
                                  child: Icon(Icons.edit,
                                      color: context.colorScheme.inversePrimary),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    height: 2,
                    thickness: 1.5,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  );
                },
              ),
            ),
    );
  }
}
