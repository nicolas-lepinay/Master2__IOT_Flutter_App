import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:arduino_iot_app/models/schema/equipment.dart';
import 'package:arduino_iot_app/utils/extensions.dart';
import 'package:arduino_iot_app/utils/constants.dart';
import 'package:arduino_iot_app/store/equipments_cubit.dart';
import 'package:arduino_iot_app/widgets/components/typography/caption.dart';
import 'package:go_router/go_router.dart';

class AnimatedCard extends StatelessWidget {
  // Callback pour l'appel d'API au double-tap
  final bool Function() onDoubleTap;
  final Equipment equipment;
  final double ratio;

  const AnimatedCard({
    super.key,
    required this.onDoubleTap,
    required this.equipment,
    this.ratio = 1.2,
  });

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width - (60 * 2);
    return GestureDetector(
      onDoubleTap: () {
        context.read<EquipmentsCubit>().toggleEquipmentState(equipment);
      },
      onLongPress: () {
        context.push('/details', extra: equipment);
      },
      child: Center(
        child: Opacity(
          opacity: equipment.state ? 1 : 1,
          child: Stack(
            alignment: Alignment.center,
            clipBehavior: Clip.none,
            children: [
              Background(
                width: width,
                ratio: ratio,
                equipment: equipment,
              ),
              Foreground(
                equipment: equipment,
                width: width,
                ratio: ratio,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class Foreground extends StatelessWidget {
  const Foreground({
    super.key,
    required this.equipment,
    required this.width,
    required this.ratio,
  });

  final Equipment equipment;
  final double width;
  final double ratio;

  @override
  Widget build(BuildContext context) {
    return AnimatedPositioned(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeInOut,
      child: AnimatedRotation(
        turns: equipment.state ? -0.025 : 0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.easeInOut,
        child: Container(
          width: width,
          height: width * ratio,
          padding: const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 20,
          ),
          decoration: BoxDecoration(
            color: equipment.state
                ? Constants.lightest
                : Constants.lightest.withOpacity(0.8),
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: equipment.state
                    ? Constants.darkest.withOpacity(0.15)
                    : Constants.darkest.withOpacity(0.07),
                blurRadius: 10,
                offset: const Offset(5, 5),
              ),
            ],
          ),
          child: AnimatedCardContent(
            equipment: equipment,
          ),
        ),
      ),
    );
  }
}

class Background extends StatelessWidget {
  const Background({
    super.key,
    required this.width,
    required this.ratio,
    required this.equipment,
  });

  final double width;
  final double ratio;
  final Equipment equipment;

  @override
  Widget build(BuildContext context) {
    return Container(
      //width: width,
      //height: width * ratio,
      width: width,
      height: width * ratio,
      decoration: BoxDecoration(
        color: equipment.state
            ? equipment.colorOn.withOpacity(0.2)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: equipment.state
                ? equipment.colorOn.withOpacity(0.8)
                : Colors.transparent,
            blurRadius: 15,
          ),
        ],
      ),
    );
  }
}

class AnimatedCardContent extends StatelessWidget {
  final Equipment equipment;

  const AnimatedCardContent({
    required this.equipment,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        DisplayImage(equipment: equipment),
        const SizedBox(height: 30),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            DisplayName(equipment: equipment),
            const SizedBox(width: 10),
            DisplayState(equipment: equipment),
          ],
        ),
        const SizedBox(height: 5),
        DisplayValue(equipment: equipment),
      ],
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
      children: [
        Icon(
          equipment.dataIcon,
          size: 24,
          color: Constants.periwinkle,
        ),
        const SizedBox(width: 7.0),
        Caption(
          text:
              '${equipment.formatedValue ?? 'Aucune donnée'} ${equipment.unit ?? ''}',
          color: Constants.periwinkle,
        ),
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

class DisplayName extends StatelessWidget {
  const DisplayName({
    super.key,
    required this.equipment,
  });

  final Equipment equipment;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Text(
        equipment.name,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w900,
        ),
      ),
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
      //width: MediaQuery.of(context).size.width / 4,
      height: MediaQuery.of(context).size.width / 3,
      decoration: BoxDecoration(
        image: DecorationImage(
          fit: BoxFit.contain,
          image: AssetImage(equipment.imageAssetPath),
        ),
      ),
    );
  }
}
