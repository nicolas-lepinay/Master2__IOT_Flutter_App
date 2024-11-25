import 'package:flutter/material.dart';
import 'package:arduino_iot_app/utils/constants.dart';
import 'package:arduino_iot_app/widgets/components/layout/animated_background.dart';
import 'package:arduino_iot_app/widgets/components/headers/app_bar_actions.dart';
import 'package:arduino_iot_app/widgets/components/typography/h2.dart';
import 'package:arduino_iot_app/widgets/components/typography/h3.dart';
import 'package:arduino_iot_app/widgets/components/typography/caption.dart';
import 'package:arduino_iot_app/widgets/components/buttons/animated_buttons_bar.dart';
import 'package:arduino_iot_app/widgets/components/misc/localization.dart';
import 'package:arduino_iot_app/widgets/components/buttons/animated_card.dart';
import 'package:arduino_iot_app/store/equipments_cubit.dart';
import 'package:arduino_iot_app/injection/get_it.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<EquipmentsCubit>(),
      child: BlocBuilder<EquipmentsCubit, EquipmentsState>(
          builder: (context, state) {
        return AnimatedBackground(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(Constants.paddingMedium),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const AppBarActions(),
                    const SizedBox(height: 30),
                    const H2(text: Constants.home__title),
                    const SizedBox(height: 5),
                    const Localization(location: 'Pertuis, France'),
                    const SizedBox(height: 30),
                    AnimatedButtonsBar(
                      outerPadding: Constants.paddingMedium,
                      tabNames: const ["Extérieur", "RDC", "Étage"],
                      onTabSelected: [
                        () => print(
                            'Equipments Length: ${state.equipments.length}'),
                        () => print("RDC selected"),
                        () => print("Étage selected"),
                      ],
                    ),
                    const Padding(
                      padding: EdgeInsets.only(
                        top: 15.0,
                        left: 15.0,
                        right: 15.0,
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          H3(text: Constants.home__subtitle),
                          Spacer(),
                          Caption(
                            text: "1 sur 5",
                            color: Constants.neutral,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              state.isLoading || state.equipments.isEmpty
                  ? const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    )
                  : Expanded(
                      child: CarouselSlider(
                        options: CarouselOptions(
                          height: double.infinity,
                          viewportFraction: 1.1,
                        ),
                        items: state.equipments.map((equipment) {
                          return Builder(
                            builder: (BuildContext context) {
                              return AnimatedCard(
                                equipment: equipment,
                                onDoubleTap: () {
                                  return !equipment.state;
                                },
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
              const SizedBox(height: 75),
            ],
          ),
        );
      }),
    );
  }
}
