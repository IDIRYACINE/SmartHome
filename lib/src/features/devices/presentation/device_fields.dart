
import 'package:flutter/material.dart';
import 'package:smarthome_algeria/src/core/navigation/navigator.dart';
import 'package:smarthome_algeria/src/features/devices/devices_feature.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

import '../data/type_aliases.dart';

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
