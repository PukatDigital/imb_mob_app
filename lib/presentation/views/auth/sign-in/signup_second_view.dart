import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/base/base_widget.dart';
import 'package:ideal_marriage_bureau/presentation/views/auth/auth_view_model.dart';
import 'package:provider/provider.dart';
import '../../../../application/app_theme/color_scheme.dart';
import '../../../../application/core/result.dart';
import '../../../../application/network/result.dart';
import '../../../../constants/string_manager.dart';
import '../../../../widgets/custom_drop_down.dart';
import '../../../../widgets/loader.dart';
import '../../../../widgets/toast.dart';
import 'signup_form_data.dart';

class StepTwoView extends BaseStateFullWidget {
  final SignUpFormData formData;

   StepTwoView({super.key, required this.formData});



  @override
  State<StepTwoView> createState() => _StepTwoViewState();
}

class _StepTwoViewState extends State<StepTwoView>  implements ErrorResult {
  final List<String> qualifications = [
    "High School",
    "Bachelor's",
    "Master's",
    "PhD"
  ];
  final List<String> countries = ["Pakistan", "USA", "UK", "Canada"];
  final List<String> cities = ["Lahore", "Karachi", "Islamabad", "Multan"];
  late AuthViewModel newDocVM;
  @override
  void initState() {
    // TODO: implement initState
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<AuthViewModel>().getAllEducationData(this);
      context.read<AuthViewModel>().getAllCountryData(this);
      context.read<AuthViewModel>().getAllCitiesData(this);
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    return Consumer<AuthViewModel>(
        builder: (context, provider, child) {
          newDocVM = provider;
          return newDocVM.apiResponse is Loading
              ? Center(child: Loader())
              :  SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "What's Your Qualification?",
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 8),
                CustomDropDown<String>(
                  list: newDocVM.educationModel.data?.education
                      ?.map((e) => e.name ?? '')
                      .toList() ??
                      [],
                  selectedItem:  widget.formData.selectedQualification,
                  hintText: "Select Your Qualification",
                  onChanged: (val) => setState(() =>  widget.formData.selectedQualification = val),
                ),
                // CustomDropDown<String>(
                //   list: qualifications,
                //   selectedItem: widget.formData.selectedQualification,
                //   hintText: "Select qualification",
                //   onChanged: (val) {
                //     setState(() {
                //       // ✅ Writes directly into shared formData
                //       widget.formData.selectedQualification = val;
                //     });
                //   },
                // ),
                const SizedBox(height: 20),
                Text.rich(TextSpan(
                  text: StringManager.country,
                  style: context.textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: " *",
                      style: context.textTheme.bodyMedium
                          ?.copyWith(color: ColorManager.primary),
                    ),
                  ],
                )),
                const SizedBox(height: 8),
                CustomDropDown<String>(
                  list: newDocVM.countriesModel.data?.countries
                      ?.map((e) => e.name ?? '')
                      .toList() ??
                      [],
                  selectedItem:  widget.formData.selectedCountry,
                  hintText: "Select Your Country",
                  onChanged: (val) => setState(() =>  widget.formData.selectedCountry = val),
                ),
                // CustomDropDown<String>(
                //   list: countries,
                //   selectedItem: widget.formData.selectedCountry,
                //   hintText: "Select country",
                //   onChanged: (val) {
                //     setState(() {
                //       widget.formData.selectedCountry = val;
                //     });
                //   },
                // ),
                const SizedBox(height: 20),
                Text.rich(TextSpan(
                  text: StringManager.city,
                  style: context.textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: " *",
                      style: context.textTheme.bodyMedium
                          ?.copyWith(color: ColorManager.primary),
                    ),
                  ],
                )),
                const SizedBox(height: 8),
                CustomDropDown<String>(
                  list: newDocVM.citiesModel.data?.ethnicities
                      ?.map((e) => e.name ?? '')
                      .toList() ??
                      [],
                  selectedItem:  widget.formData.selectedCity,
                  hintText: "Select Your City",
                  onChanged: (val) => setState(() =>  widget.formData.selectedCity = val),
                ),
                // CustomDropDown<String>(
                //   list: cities,
                //   selectedItem: widget.formData.selectedCity,
                //   hintText: "Select city",
                //   onChanged: (val) {
                //     setState(() {
                //       widget.formData.selectedCity = val;
                //     });
                //   },
                // ),
              ],
            ),
          );
        });

  }
  @override
  onError(String error) => MyToast.showToast(message: error);
}