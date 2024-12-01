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
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:carousel_slider/carousel_slider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CarouselSliderController _carouselController =
      CarouselSliderController();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EquipmentsCubit, EquipmentsState>(
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
                    tabNames: const ["Actions", "Données", "Routines"],
                    initialTab: state.currentTab,
                    onTabSelected: [
                      () {
                        context.read<EquipmentsCubit>().changeTab(0);
                        Future.delayed(const Duration(milliseconds: 100), () {
                          _carouselController.animateToPage(
                            0,
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeInOutSine,
                          );
                        });
                      },
                      () {
                        context.read<EquipmentsCubit>().changeTab(1);
                        Future.delayed(const Duration(milliseconds: 100), () {
                          _carouselController.animateToPage(
                            0,
                            duration: const Duration(milliseconds: 600),
                            curve: Curves.easeInOutSine,
                          );
                        });
                      },
                      () => print("Routines selected."),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(
                      top: 15.0,
                      left: 15.0,
                      right: 15.0,
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const H3(text: Constants.home__subtitle),
                        const Spacer(),
                        Caption(
                          text: state.isLoading
                              ? '...'
                              : '${state.currentIndex + 1} sur ${state.filteredEquipments.length}',
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
                      carouselController: _carouselController,
                      options: CarouselOptions(
                        height: double.infinity,
                        viewportFraction: 1.1,
                        initialPage: state.currentIndex,
                        onPageChanged: (index, reason) {
                          context.read<EquipmentsCubit>().updateIndex(index);
                        },
                      ),
                      items: state.filteredEquipments.map((equipment) {
                        return Builder(
                          builder: (BuildContext context) {
                            return AnimatedCard(
                              equipment: equipment,
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
    });
  }
}
