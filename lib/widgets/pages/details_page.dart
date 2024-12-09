import 'package:arduino_iot_app/utils/extensions.dart';
import 'package:flutter/material.dart';
import 'package:arduino_iot_app/widgets/components/layout/animated_background.dart';
import 'package:arduino_iot_app/models/schema/equipment.dart';
import 'package:arduino_iot_app/widgets/components/typography/h2.dart';
import 'package:arduino_iot_app/widgets/components/typography/h3.dart';
import 'package:arduino_iot_app/utils/constants.dart';
import 'package:arduino_iot_app/widgets/components/typography/caption.dart';
import 'package:arduino_iot_app/widgets/components/buttons/ui_button.dart';
import 'package:arduino_iot_app/store/equipments_cubit.dart';
import 'package:arduino_iot_app/widgets/components/textfields/ui_text_field.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:go_router/go_router.dart';

class DetailsPage extends StatelessWidget {
  final Equipment equipment;
  const DetailsPage({
    super.key,
    required this.equipment,
  });

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EquipmentsCubit, EquipmentsState>(
        builder: (context, state) {
      return AnimatedBackground(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          toolbarHeight: 100,
          leading: IconButton(
            icon: const Icon(
              Icons.chevron_left_rounded,
              color: Constants.neutral,
              size: 32,
            ),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: H3(
            text: equipment.esp32Id.replaceAll('_', ' '),
            color: Constants.neutral,
          ),
          centerTitle: true,
        ),
        child: SingleChildScrollView(
          //reverse: true,
          child: Padding(
            padding: const EdgeInsets.all(Constants.paddingMedium),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                DisplayImage(equipment: equipment),
                //const Spacer(),
                const SizedBox(height: 25),
                H2(text: equipment.name),
                const SizedBox(height: 8),
                DisplayValue(equipment: equipment),
                const SizedBox(height: 25),
                DisplayState(equipment: equipment),
                const SizedBox(height: 50),
                //const Spacer(),
                equipment.defaultRangeValues != null
                    ? DisplaySlider(equipment: equipment)
                    : const SizedBox(),
                equipment.esp32Id == 'LCD_DISPLAY'
                    ? DisplayTextArea(equipment: equipment)
                    : const SizedBox(),
                equipment.esp32Id == 'RGB_LED'
                    ? DisplayColorPicker(equipment: equipment)
                    : const SizedBox(),
              ],
            ),
          ),
        ),
      );
    });
  }
}

class DisplayTextArea extends StatefulWidget {
  const DisplayTextArea({
    super.key,
    required this.equipment,
  });

  final Equipment equipment;

  @override
  State<DisplayTextArea> createState() => _DisplayTextAreaState();
}

class _DisplayTextAreaState extends State<DisplayTextArea> {
  late TextEditingController _textController;
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _textController = TextEditingController(text: widget.equipment.value);

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        _scrollToTextField();
      }
    });
  }

  void _scrollToTextField() {
    // Utiliser Scrollable.ensureVisible pour faire défiler l'écran jusqu'au TextField
    Future.delayed(const Duration(milliseconds: 100), () {
      Scrollable.ensureVisible(
        _focusNode.context!,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        UITextField(
          controller: _textController,
          focusNode: _focusNode,
          hintText: 'Entrez un message...',
        ),
        const SizedBox(height: 50),
        UIButton(
          size: 'small',
          label: "Appliquer",
          color: Constants.periwinkle,
          callback: () async {
            await context.read<EquipmentsCubit>().updateEquipmentValue(
                  equipment: widget.equipment,
                  value: _textController.text,
                );
            context.pop();
          },
        ),
        const SizedBox(height: 450),
      ],
    );
  }
}

class DisplayState extends StatelessWidget {
  const DisplayState({
    super.key,
    required this.equipment,
  });

  final Equipment equipment;

  @override
  Widget build(BuildContext context) {
    return Chip(
      label: equipment.state ? const Text('ON') : const Text('OFF'),
      labelStyle: TextStyle(
        fontSize: 13,
        fontWeight: FontWeight.w900,
        color: equipment.state
            ? equipment.colorOn != Constants.tomato
                ? Constants.darkest
                : Constants.lightest
            : Constants.lightest,
      ),
      backgroundColor: equipment.state
          ? equipment.colorOn != Constants.tomato
              ? equipment.colorOn.withOpacity(0.6)
              : equipment.colorOn
          : equipment.colorOff,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(50),
        side: const BorderSide(color: Colors.transparent),
      ),
      visualDensity: const VisualDensity(vertical: -2),
    );
  }
}

class DisplayValue extends StatelessWidget {
  const DisplayValue({
    super.key,
    required this.equipment,
  });

  final Equipment equipment;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Icon(
          equipment.dataIcon,
          size: 16,
          color: Constants.neutral,
        ),
        const SizedBox(width: 7.0),
        Caption(
          text:
              '${equipment.formatedValue ?? 'Aucune donnée'} ${equipment.unit ?? ''}',
          color: Constants.neutral,
        ),
      ],
    );
  }
}

class DisplayImage extends StatelessWidget {
  const DisplayImage({
    super.key,
    required this.equipment,
  });

  final Equipment equipment;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: equipment.esp32Id == 'RGB_LED'
          ? MediaQuery.of(context).size.width / 4
          : MediaQuery.of(context).size.width / 2,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.contain,
          image: AssetImage(equipment.imageAssetPath),
        ),
      ),
    );
  }
}

class DisplaySlider extends StatefulWidget {
  const DisplaySlider({
    super.key,
    required this.equipment,
  });

  final Equipment equipment;

  @override
  State<DisplaySlider> createState() => _DisplaySliderState();
}

class _DisplaySliderState extends State<DisplaySlider> {
  double? _currentValue;
  double? _minValue;
  double? _maxValue;

  @override
  void initState() {
    super.initState();
    _minValue = widget.equipment.defaultRangeValues![0];
    _maxValue = widget.equipment.defaultRangeValues![1];
    _currentValue = widget.equipment.value != null
        ? double.tryParse(widget.equipment.value!) ?? _minValue
        : _minValue;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: Constants.paddingSmall),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              H3(
                color: Constants.dark,
                text:
                    '${widget.equipment.defaultRangeValues![0].toStringAsFixed(0)} ${widget.equipment.unit ?? ''}',
              ),
              H3(
                color: Constants.dark,
                text:
                    '${widget.equipment.defaultRangeValues![1].toStringAsFixed(0)} ${widget.equipment.unit ?? ''}',
              ),
            ],
          ),
        ),
        Slider(
          value: _currentValue!,
          min: _minValue!,
          max: _maxValue!,
          divisions: 10,
          label:
              '  ${_currentValue!.toStringAsFixed(0)} ${widget.equipment.unit ?? ''}  ',
          activeColor: Constants.periwinkle,
          inactiveColor: Constants.light,
          onChanged: (value) {
            setState(() {
              _currentValue = value;
            });
          },
        ),
        const SizedBox(height: 50),
        UIButton(
          size: 'small',
          label: "Appliquer",
          color: Constants.periwinkle,
          callback: () async {
            await context.read<EquipmentsCubit>().updateEquipmentValue(
                  equipment: widget.equipment,
                  value: _currentValue!.toStringAsFixed(0),
                );
            context.pop();
          },
        ),
      ],
    );
  }
}

class DisplayColorPicker extends StatefulWidget {
  const DisplayColorPicker({
    super.key,
    required this.equipment,
  });

  final Equipment equipment;

  @override
  State<DisplayColorPicker> createState() => _DisplayColorPickerState();
}

class _DisplayColorPickerState extends State<DisplayColorPicker> {
  late Color _currentColor;

  @override
  void initState() {
    super.initState();
    final rgbValues =
        widget.equipment.value?.split(',').map(int.parse).toList();
    _currentColor = rgbValues != null && rgbValues.length == 3
        ? Color.fromARGB(255, rgbValues[0], rgbValues[1], rgbValues[2])
        : Colors.white;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding:
              const EdgeInsets.symmetric(horizontal: Constants.paddingSmall),
          child: ColorPicker(
            pickerColor: _currentColor,
            enableAlpha: false,
            labelTypes: const [],
            pickerAreaBorderRadius: const BorderRadius.all(Radius.circular(10)),
            //colorPickerWidth: 200,
            pickerAreaHeightPercent: 0.4,
            onColorChanged: (color) {
              setState(() {
                _currentColor = color;
              });
            },
          ),
        ),
        const SizedBox(height: 25),
        UIButton(
          size: 'small',
          label: "Appliquer",
          color: Constants.periwinkle,
          callback: () async {
            final rgbValue =
                '${_currentColor.red},${_currentColor.green},${_currentColor.blue}';
            await context.read<EquipmentsCubit>().updateEquipmentValue(
                  equipment: widget.equipment,
                  value: rgbValue,
                );
            context.pop();
          },
        ),
      ],
    );
  }
}
