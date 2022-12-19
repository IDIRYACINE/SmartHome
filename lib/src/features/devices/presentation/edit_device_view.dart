import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:smarthome_algeria/src/core/navigation/navigator.dart';
import 'package:smarthome_algeria/src/features/devices/domain/device.dart';

import 'device_panel_view.dart';

class DeviceEditorView extends StatefulWidget {
  const DeviceEditorView({super.key, this.editMode = false});

  final bool editMode;
  final double bodyPadding = 8;

  @override
  State<DeviceEditorView> createState() => _DeviceEditorViewState();
}

class _DeviceEditorViewState extends State<DeviceEditorView> {
  void onDeviceClick(Device device) {}
  void onSave() {}

  void onCancel() {
    AppNavigator.pop();
  }

  void onConsumptionChanged(String? newValue) {}
  void onConsumptionSelected(int? newValue) {}

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
        child: Padding(
          padding: EdgeInsets.all(widget.bodyPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text(
                AppLocalizations.of(context)!.deviceType,
                style: Theme.of(context).textTheme.displaySmall,
              ),
              Flexible(
                child: DeviceControlPanelView(
                  onPressed: onDeviceClick,
                ),
              ),
              Flexible(
                child: TextFormField(
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
                onConsumptionChanged: onConsumptionChanged,
                onConsumptionSelected: onConsumptionSelected,
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

typedef OnConsumptionSelected = void Function(int? consumption);
typedef OnConsumptionChanged = void Function(String consumption);

class DeviceConsumptionForm extends StatefulWidget {
  const DeviceConsumptionForm(
      {super.key,
      required this.device,
      this.onConsumptionSelected,
      this.onConsumptionChanged,
      this.dropdownMode = false,
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
  bool? dropdownMode;

  final TextEditingController _consumptionController = TextEditingController();

  List<int> _getConsumptions(DeviceType deviceType) {
    return defaultDeviceConsumptions[deviceType.index];
  }

  void switchFormMode() {
    setState(() {
      dropdownMode = !dropdownMode!;
    });
  }

  void consumptionSelectionMenu() {
    List<int> consumptions =
        widget.consumptions ?? _getConsumptions(widget.device);

     AppNavigator.displayDialog(_PowerConsumptionSelectionMenu(
      consumptions: consumptions,
    )).then((value) {
      if (value != null) {
        _consumptionController.text = value.toString();
      }
    });
  }

  @override
  Widget build(BuildContext context) {

    dropdownMode ??= widget.dropdownMode;

    return Column(
      children: [
        Row(
          children: [
            Text(
              AppLocalizations.of(context)!.powerConsumption,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            IconButton(
                onPressed: switchFormMode, icon: const Icon(Icons.swap_horiz))
          ],
        ),
        TextFormField(
          controller: _consumptionController,
          readOnly: dropdownMode!,
          onTap: dropdownMode! ? consumptionSelectionMenu : null,
          decoration: InputDecoration(
            labelText: AppLocalizations.of(context)!.powerConsumption,
          ),
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
        ),
      ],
    );
  }
}

class _PowerConsumptionSelectionMenu extends StatelessWidget {
  final List<int> consumptions;

  const _PowerConsumptionSelectionMenu({required this.consumptions});

  void onConsumptionSelected(int consumption) {
    AppNavigator.pop(consumption);
  }

  @override
  Widget build(BuildContext context) {
    MediaQueryData mediaQuery = MediaQuery.of(context);

    return AlertDialog(
      content: SizedBox(
        width: mediaQuery.size.width * 0.5,
        height: mediaQuery.size.height * 0.5,
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: consumptions.length,
            itemBuilder: (context, index) {
              int consumption = consumptions[index];

              return MaterialButton(
                minWidth: double.infinity,
                onPressed: () => onConsumptionSelected(consumptions[index]),
                child: Text(
                  '$consumption Kw/h',
                ),
              );
            }),
      ),
    );
  }
}
