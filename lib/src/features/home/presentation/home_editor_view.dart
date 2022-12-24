import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smarthome_algeria/src/core/navigation/navigator.dart';
import 'package:smarthome_algeria/src/features/home/home_feature.dart';

class HomeEditorView extends StatefulWidget {
  const HomeEditorView({super.key, this.editMode = false});

  final bool editMode;

  @override
  State<HomeEditorView> createState() => _HomeEditorViewState();
}

class _HomeEditorViewState extends State<HomeEditorView> {
  String homeName = "";

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  void onSave() {
    if (formKey.currentState!.validate()) {
      BlocProvider.of<HomeBloc>(context).add(AddHome(homeName));
      AppNavigator.pop();
    }
  }

  void onCancel() {
    AppNavigator.pop();
  }

  @override
  Widget build(BuildContext context) {
    final appBarTitle = widget.editMode
        ? AppLocalizations.of(context)!.editHome
        : AppLocalizations.of(context)!.addHome;

    return Scaffold(
      appBar: _HomeEditorAppBar(
          title: appBarTitle, onSave: onSave, onCancel: onCancel),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
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
                  homeName = value;
                  return null;
                },
              ),
            ],
          ),
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
