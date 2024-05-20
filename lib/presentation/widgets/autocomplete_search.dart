import 'package:fetch/core/providers/user_provider.dart';
import 'package:fetch/presentation/widgets/input_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class AutocompleteWidget extends ConsumerWidget {
  final MyInputTextController myInputText;
  const AutocompleteWidget({super.key, required this.myInputText});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usersData = ref.watch(usersProvider);

    return usersData.when(
      loading: () {
        return const CircularProgressIndicator();
      },
      error: (error, stackTrace) => Text('Error $error'),
      data: (usersName) {
        return Container(
          height: 40,
          width: 300,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: const Color.fromARGB(255, 182, 182, 180)),
          child: Autocomplete<String>(
            optionsBuilder: (TextEditingValue userTextEditingValue) {
              //Clear controllers when the text field is empty
              if (userTextEditingValue.text.isEmpty) {
                myInputText.nameController.text = '';
                myInputText.emailController.text = '';
                myInputText.phoneController.text = '';
                return const Iterable<String>.empty();
              }
              //Filter users names based on user input (case-insentive)
              final suggestions = usersName
                  .where(
                    (user) => user.name.toLowerCase().contains(
                          userTextEditingValue.text.toLowerCase(),
                        ),
                  )
                  .map((user) => user.name)
                  .toList();
              return suggestions;
            },
            onSelected: (String value) {
              final user = usersName.firstWhere(
                (user) => user.name == value,
              );
              myInputText.nameController.text = user.name.toString();
              myInputText.emailController.text = user.email.toString();
              myInputText.phoneController.text = user.phone.toString();
            },
          ),
        );
      },
    );
  }
}
