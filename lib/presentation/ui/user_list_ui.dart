import 'package:fetch/core/providers/user_provider.dart';
import 'package:fetch/presentation/widgets/autocomplete_search.dart';
import 'package:fetch/presentation/widgets/card_form.dart';
import 'package:fetch/presentation/widgets/input_text_form.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class UserListUi extends ConsumerStatefulWidget {
  const UserListUi({super.key});
  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _UserListUiState();
}

final _myInputText = MyInputTextController();

class _UserListUiState extends ConsumerState<UserListUi> {
  @override
  void initState() {
    super.initState();
    ref.read(usersControllerProvider.notifier).reloadUsers();
  }

  @override
  Widget build(BuildContext context) {
    final users = ref.watch(usersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Autocomplete Search'),
      ),
      body: users.when(
          loading: () {
            return const CircularProgressIndicator();
          },
          error: (error, stackTrace) => Text('Error: $error'),
          data: (usersListX) {
            return Column(
              children: [
                const Text('Autocomplete Search'),
                AutocompleteWidget(myInputText: _myInputText),
                const SizedBox(height: 15),
                CardFormText(
                  nameController: _myInputText.nameController,
                  emailController: _myInputText.emailController,
                  phoneController: _myInputText.phoneController,
                ),
                Expanded(
                    child: ListView.builder(
                  itemCount: usersListX.length,
                  itemBuilder: (context, index) {
                    final user = usersListX[index];
                    return ListTile(
                      title: Text(user.name),
                      subtitle: Text(user.email),
                      trailing: const Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [Text('buttons')],
                      ),
                    );
                  },
                ))
              ],
            );
          }),
    );
  }
}
