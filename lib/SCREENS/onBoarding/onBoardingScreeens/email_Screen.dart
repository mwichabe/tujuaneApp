import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:tujuane_app/SCREENS/onBoarding/onBoardingScreeens/widgets/custom_button.dart';
import 'package:tujuane_app/SCREENS/onBoarding/onBoardingScreeens/widgets/custom_textField.dart';
import 'package:tujuane_app/SCREENS/onBoarding/onBoardingScreeens/widgets/custom_text_header.dart';
import '/cubits/cubits.dart';

class Email extends StatelessWidget {
  final TabController tabController;

  const Email({
    Key? key,
    required this.tabController,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignupCubit, SignupState>(
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 50),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomTextHeader(text: 'What\'s Your Email Address?'),
                  CustomTextField(
                    hint: 'ENTER YOUR EMAIL',
                    onChanged: (value) {
                      context.read<SignupCubit>().emailChanged(value);
                    },
                  ),
                  SizedBox(height: 100),
                  CustomTextHeader(text: 'Choose a Password'),
                  CustomTextField(
                    hint: 'ENTER YOUR PASSWORD',
                    onChanged: (value) {
                      context.read<SignupCubit>().passwordChanged(value);
                    },
                  ),
                ],
              ),
              Column(
                children: [
                  StepProgressIndicator(
                    totalSteps: 6,
                    currentStep: 1,
                    selectedColor: Theme.of(context).primaryColor,
                    unselectedColor: Theme.of(context).backgroundColor,
                  ),
                  SizedBox(height: 10),
                  CustomButton(tabController: tabController, text: 'NEXT STEP'),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
