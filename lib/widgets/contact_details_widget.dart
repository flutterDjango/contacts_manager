import 'package:flutter/material.dart';
import 'package:contacts_manager/config/routes/routes_location.dart';
import 'package:go_router/go_router.dart';

import 'package:contacts_manager/data/models/models.dart';
import 'package:contacts_manager/utils/utils.dart';

class ContactDetailsWidget extends StatelessWidget {
  const ContactDetailsWidget({super.key, required this.contact});

  final Contact contact;
  @override
  Widget build(BuildContext context) {
    final Color colorIcon = Theme.of(context).colorScheme.primary;
    final Color colorDivider = Theme.of(context).colorScheme.primary;

    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                (contact.contactLastName == null)
                    ? ''
                    : contact.contactLastName!,
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                width: 16,
              ),
              Text(
                (contact.contactFirstName == null)
                    ? ''
                    : contact.contactFirstName!,
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
            ],
          ),
          Divider(
            thickness: 1.5,
            color: colorDivider,
          ),
          const SizedBox(
            height: 15,
          ),
          Visibility(
            visible: contact.contactPhoneNumber1 != null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Téléphone 1 : ${contact.completePhoneNumber1}',
                    style: context.textTheme.bodyLarge),
                const SizedBox(
                  width: 15,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.phone),
                  color: colorIcon,
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.sms),
                    color: colorIcon),
              ],
            ),
          ),
          Visibility(
            visible: contact.contactPhoneNumber2 != null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Téléphone 2 : ${contact.completePhoneNumber2}',
                    style: context.textTheme.bodyLarge),
                const SizedBox(
                  width: 15,
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.phone),
                  color: colorIcon,
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.sms),
                    color: colorIcon),
              ],
            ),
          ),
          Visibility(
            visible: contact.contactEmail != null,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text('Email : ${contact.contactEmail}',
                    style: context.textTheme.bodyLarge),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.email),
                    color: colorIcon),
              ],
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Text('Catégorie : ${contact.contactCategoryId}'),
          Divider(
            thickness: 1.5,
            color: colorDivider,
          ),
          const SizedBox(
            height: 15,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ElevatedButton(
                  onPressed: () {
                    context.push(RouteLocation.home);
                  },
                  child: const Text('Annuler')),
            ],
          )
        ],
      ),
    );
  }
}
