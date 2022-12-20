import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smarthome_algeria/src/core/navigation/navigator.dart';

class HomeEditorView extends StatelessWidget {
  const HomeEditorView({super.key, this.editMode = false});

  final bool editMode;

  void onSave() {}

  void onCancel() {
    AppNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    final appBarTitle = editMode
        ? AppLocalizations.of(context)!.editHome
        : AppLocalizations.of(context)!.addHome;

    final GlobalKey<FormState> formKey = GlobalKey<FormState>();

    return Scaffold(
      appBar: _HomeEditorAppBar(
          title: appBarTitle, onSave: onSave, onCancel: onCancel),
      body: Form(
        key: formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.homeName,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)!.errorEmptyField;
                }
                return null;
              },
            ),
          ],
        ),
      ),
    );
  }
}

class _HomeEditorAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _HomeEditorAppBar(
      {required this.title, required this.onSave, required this.onCancel});

  final VoidCallback onSave;
  final VoidCallback onCancel;
  final String title;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.cancel),
        onPressed: onCancel,
      ),
      title: Text(title),
      actions: [
        IconButton(
          icon: const Icon(Icons.save),
          onPressed: onSave,
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
