import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:contacts_manager/widgets/category_form_widget.dart';
import 'package:contacts_manager/providers/providers.dart';
import 'package:contacts_manager/utils/utils.dart';
import 'package:contacts_manager/widgets/widgets.dart';

class DisplayCategoriesListWidget extends ConsumerWidget {
  const DisplayCategoriesListWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoryProvider).categories;

    return Column(
      children: [
        Expanded(
          child: ListView.separated(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            itemCount: categories.length,
            itemBuilder: (BuildContext context, int index) {
              final category = categories[index];
              return InkWell(
                onLongPress: () {
                  AppAlerts.showDeleteCategoryAlertDialog(context, ref, category);
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
                              text: category.categoryName,
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
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
        ElevatedButton(
          onPressed: () {
             showModalBottomSheet(
                context: context,
                builder: (ctx) {
                  return const CategoryFormWidget();
                },
              );
            },
          child: const DisplayWhiteTextWidget(
              text: 'Ajouter une catégorie', fontSize: 20),
        ),
      ],
    );
  }
}
