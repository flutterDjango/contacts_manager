import 'package:contacts_manager/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:contacts_manager/config/routes/routes_location.dart';
import 'package:go_router/go_router.dart';

import 'package:contacts_manager/data/models/models.dart';
import 'package:contacts_manager/utils/utils.dart';

class ContactDetailsWidget extends ConsumerWidget {
  const ContactDetailsWidget({super.key, required this.contact});

  final Contact contact;


  String getCategoryName(categories, contact) {
    String cat = '';
    for (var category in categories){
      if (category.categoryId == contact.contactCategoryId){
        cat = '${category.categoryName}';
        break;
  
      }
    }
    // print('contactId ${contact.contactCategoryId}');
    return cat;
  }


  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoryProvider).categories;
    // String cat = 'Aucune';
    final Color colorIcon = Theme.of(context).colorScheme.primary;
    final Color colorDivider = Theme.of(context).colorScheme.primary;
    // if (categories.isNotEmpty) {
    //   print('cats ${categories}');
    //   // print('cat id ${categories[0].categoryId}');
    //   // print('cat name ${categories[0].categoryName}');
     
    // }
    
    print('----------');
    print(contact.contactCategoryId);
    String cat = (contact.contactCategoryId == 0)
                ? 'Aucune'
                : getCategoryName(categories, contact);
                // : 'pas aucune';

    return Padding(
      padding: const EdgeInsets.all(30),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text(
                (contact.contactLastName == "")
                    ? ''
                    : contact.contactLastName!,
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Text(
                (contact.contactFirstName == "")
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
            visible: contact.contactPhoneNumber1 != "",
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
            visible: contact.contactPhoneNumber2 != "",
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
            visible: contact.contactEmail != "",
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
         
          Text('Catégorie : $cat'),
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

  // Future<String?> _getCategoryName(ref) async {
  //   return await ref.read(categoryProvider);
  // }
}
