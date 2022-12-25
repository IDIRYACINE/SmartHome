import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smarthome_algeria/src/features/devices/data/devices.dart';
import 'package:smarthome_algeria/src/features/devices/data/routes_data.dart';
import 'package:smarthome_algeria/src/features/devices/domain/device_editor_controller.dart';
import 'package:smarthome_algeria/src/core/state_manager/bloc.dart';
import 'device_button.dart';
import 'device_fields.dart';
import 'device_panel_view.dart';

class DeviceEditorView extends StatefulWidget {
  const DeviceEditorView({super.key, required this.editorSettings});

  
  final DeviceEditorData editorSettings;

  final double bodyPadding = 8;

  @override
  State<DeviceEditorView> createState() => _DeviceEditorViewState();
}

class _DeviceEditorViewState extends State<DeviceEditorView> {
  DeviceEditorController? controller;

  @override
  Widget build(BuildContext context) {

    controller ??= DeviceEditorController(BlocProvider.of<AppBloc>(context), widget.editorSettings);
    
    return Scaffold(
      appBar: _DeviceEditorAppBar(
        editMode: widget.editorSettings.isEditMode,
        onCancel: controller!.onCancel,
        onSave: controller!.onSave,
      ),
      body: Form(
        key: controller!.key,
        child: Padding(
          padding: EdgeInsets.all(widget.bodyPadding),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                AppLocalizations.of(context)!.deviceType,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
              Flexible(
                child: DeviceTypePanelView(
                  onPressed: controller!.onDeviceClick,
                ),
              ),
              Flexible(child: DeviceRoomSelector(onRoomSelected: controller!.selectRoom,)),
              Flexible(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.deviceName,
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return AppLocalizations.of(context)!.errorEmptyField;
                    }
                    controller!.deviceName = value;
                    return null;
                  },
                ),
              ),
              Flexible(
                child: TextFormField(
                  decoration: InputDecoration(
                    labelText: AppLocalizations.of(context)!.description,
                  ),
                ),
              ),
              Flexible(
                  child: DeviceConsumptionForm(
                device: DeviceType.light,
                onConsumptionChanged: controller!.onConsumptionChanged,
                onConsumptionSelected: controller!.onConsumptionSelected,
              ))
            ],
          ),
        ),
      ),
    );
  }
}

class _DeviceEditorAppBar extends StatelessWidget
    implements PreferredSizeWidget {
  final bool editMode;

  const _DeviceEditorAppBar(
      {required this.editMode, required this.onSave, required this.onCancel});

  final VoidCallback onSave;
  final VoidCallback onCancel;

  @override
  Widget build(BuildContext context) {
    final appBarTitle = editMode
        ? AppLocalizations.of(context)!.editDevice
        : AppLocalizations.of(context)!.addDevice;

    return AppBar(
      leading: IconButton(
        icon: const Icon(Icons.cancel),
        onPressed: onCancel,
      ),
      title: Text(appBarTitle),
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
