import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smarthome_algeria/src/features/devices/domain/device.dart';

import 'device_panel_view.dart';

class DeviceEditorView extends StatefulWidget {
  const DeviceEditorView({super.key, this.editMode = false});

  final bool editMode;

  @override
  State<DeviceEditorView> createState() => _DeviceEditorViewState();
}

class _DeviceEditorViewState extends State<DeviceEditorView> {
  void onDeviceClick(Device device) {}
  void onSave() {}
  void onCancel() {}

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey();

    return Scaffold(
      appBar: _DeviceEditorAppBar(
        editMode: widget.editMode,
        onCancel: onCancel,
        onSave: onSave,
      ),
      body: Form(
        key: key,
        child: Column(
          children: [
            DeviceControlPanelView(
              onPressed: onDeviceClick,
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.deviceName,
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return AppLocalizations.of(context)!.errorEmptyField;
                }
                return null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: AppLocalizations.of(context)!.description,
              ),
            ),
          ],
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

typedef OnConsumptionSelected = void Function(int? consumption);
typedef OnConsumptionChanged = void Function(String consumption);

class DeviceConsumptionForm extends StatefulWidget {
  const DeviceConsumptionForm(
      {super.key,
      required this.device,
      this.onConsumptionSelected,
      this.onConsumptionChanged,
      required this.dropdownMode,
      this.consumptions})
      : assert(
          onConsumptionChanged != null || onConsumptionSelected != null,
          'Either onConsumptionChanged or onConsumptionSelected must be provided',
        );

  final DeviceType device;
  final OnConsumptionSelected? onConsumptionSelected;
  final OnConsumptionChanged? onConsumptionChanged;
  final bool dropdownMode;
  final List<int>? consumptions;

  @override
  State<DeviceConsumptionForm> createState() => _DeviceConsumptionFormState();
}

class _DeviceConsumptionFormState extends State<DeviceConsumptionForm> {
  List<int> consumptions = [];

  Widget _buildDropdownConsumptionForm() {

    List<DropdownMenuItem<int>> items = consumptions.map((consumption) {
      return DropdownMenuItem<int>(
        value: consumption,
        child: Text(consumption.toString()),
      );
    }).toList();



    return DropdownButton<int>(items: items, onChanged: widget.onConsumptionSelected);
  }

  Widget _buildTextFieldConsumptionForm() {
    return TextFormField(
    
      validator: (value) {
        if (value == null || value.isEmpty) {
          return AppLocalizations.of(context)!.errorEmptyField;
        }

        if (int.tryParse(value) == null) {
          return AppLocalizations.of(context)!.errorMustBeNumber;
        }

        return null;
      },
      onChanged: widget.onConsumptionChanged,
    );
  }

  List<int> _getConsumptions(DeviceType deviceType) {
    return [];
  }

  @override
  Widget build(BuildContext context) {
    consumptions = widget.consumptions ?? _getConsumptions(widget.device);

    return widget.dropdownMode
        ? _buildDropdownConsumptionForm()
        : _buildTextFieldConsumptionForm();
  }
}
