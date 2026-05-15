import 'dart:convert';
import 'dart:io';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/presentation/views/profile/profile_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../../../../application/app_theme/color_scheme.dart';
import '../../../../application/core/result.dart';
import '../../../../base/base_widget.dart';
import '../../../../widgets/toast.dart';
import '../../../constants/asset_manager.dart';
import '../../../data/local_data_source/preference/i_pref_helper.dart';
import '../../../data/models/get_profile_model/profile_details_model.dart';
import '../auth/auth_view_model.dart';
import '../set-up/edit_profile/edit_profile_mapping.dart';
import '../set-up/sign_up_home_view.dart';


class ProfileDetailsView extends BaseStateFullWidget {
  final ProfileData? profileData; // ✅ accept ProfileData

  ProfileDetailsView({super.key, this.profileData});

  @override
  State<ProfileDetailsView> createState() => _ProfileDetailsViewState();
}

class _ProfileDetailsViewState extends State<ProfileDetailsView>
    implements Result<String> {
  late GetPersonalProfileViewModel personalProfileData;

  bool isPersonalDetails = false;
  bool isFamilyDetails = false;
  bool isEducationProfession = false;
  bool isLifeStyleInterest = false;
  bool isPartnerPreferences = false;

  File? _selectedImage;
  final ImagePicker _picker = ImagePicker();


  Future<void> _pickImage(ImageSource source) async {
    final XFile? image = await _picker.pickImage(
      source: source,
      imageQuality: 70,
    );

    if (image != null) {
      setState(() {
        _selectedImage = File(image.path);
      });

      // ✅ Convert image to base64
      List<int> imageBytes = await _selectedImage!.readAsBytes();
      String base64Image = base64Encode(imageBytes);

      // ✅ API Payload
      Map<String, dynamic> map = {
        "data": {
          "user_id": widget.profileData?.userId,
          "profile_picture": base64Image,
        }
      };

      personalProfileData.updateProfileImages(map, this);
    }
  }

  // ✅ Helper: show "--" if value is null or empty
  String _val(String? value) =>
      (value == null || value.trim().isEmpty) ? "--" : value;

  @override
  Widget build(BuildContext context) {
    return Consumer<GetPersonalProfileViewModel>(
      builder: (_, provider, __) {
        personalProfileData = provider;
        return Scaffold(
          backgroundColor: Colors.white,
          body: _mainContent(),
        );
      },
    );
  }

  Widget _mainContent() {
    final data = widget.profileData;
    final size = MediaQuery.of(context).size;

    // ✅ Build lifestyle interest list from model
    final List<String> lifeStyleInterests = data?.lifeStyleAndInterest
        ?.map((e) => e.name ?? "")
        .where((e) => e.isNotEmpty)
        .toList() ??
        [];

    // ✅ Build profile images from attachments
    final List<String> attachmentImages = [
      data?.attachments?.attach1 ?? "",
      data?.attachments?.attach2 ?? "",
      data?.attachments?.attach3 ?? "",
      data?.attachments?.attach4 ?? "",
    ].where((e) => e.isNotEmpty).toList();

    return SingleChildScrollView(
      child: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color(0xFFB11E24).withOpacity(.18),
              Colors.transparent,
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(widget.dimens.k15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              widget.dimens.k50.verticalBoxPadding,
              _header(),
              widget.dimens.k40.verticalBoxPadding,
              _profileSection(data),
              widget.dimens.k10.verticalBoxPadding,

              // ✅ Bio Card - dynamic
              bioCard("Bio", _val(data?.bio)),
              widget.dimens.k10.verticalBoxPadding,

              // ✅ Marriage Intention Card - dynamic
              bioCard("Marriage Intention", _val(data?.marriageIntension)),
              widget.dimens.k10.verticalBoxPadding,

              // ✅ Personal Details - dynamic
              _expandableSection(
                title: "Personal Details",
                isExpanded: isPersonalDetails,
                onTap: () =>
                    setState(() => isPersonalDetails = !isPersonalDetails),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _detailItem(label: "Gender", value: _val(data?.gender)),
                    widget.dimens.k5.verticalBoxPadding,
                    _detailItem(label: "Marital Status", value: _val(data?.materialStatus)),
                    widget.dimens.k5.verticalBoxPadding,
                    _detailItem(label: "Date of Birth", value: _val(data?.dateOfBirth)),
                    widget.dimens.k5.verticalBoxPadding,
                    _detailItem(label: "Mother Tongue", value: _val(data?.motherTongue)),
                    widget.dimens.k5.verticalBoxPadding,
                    _detailItem(label: "Caste", value: _val(data?.caste)),
                    widget.dimens.k5.verticalBoxPadding,
                    _detailItem(label: "Height", value: _val(data?.hight)),
                    widget.dimens.k5.verticalBoxPadding,
                    _detailItem(label: "Weight", value: _val(data?.weight)),
                    widget.dimens.k5.verticalBoxPadding,
                    _detailItem(label: "Country", value: _val(data?.country)),
                    widget.dimens.k5.verticalBoxPadding,
                    _detailItem(label: "City", value: _val(data?.belongsTo)),
                    widget.dimens.k5.verticalBoxPadding,
                    _detailItem(label: "Nationality", value: _val(data?.nationality)),
                    widget.dimens.k5.verticalBoxPadding,
                    _detailItem(label: "Religion", value: _val(data?.religion)),
                    widget.dimens.k5.verticalBoxPadding,
                    _detailItem(label: "Sect", value: _val(data?.ethnicity)),
                    widget.dimens.k5.verticalBoxPadding,
                    _detailItem(label: "Religious", value: _val(data?.religiousPractice)),
                    widget.dimens.k5.verticalBoxPadding,
                    _detailItem(label: "Zodiac Sign", value: _val(data?.zodiacSign)),
                    widget.dimens.k5.verticalBoxPadding,
                  ],
                ),
              ),
              widget.dimens.k10.verticalBoxPadding,

              // ✅ Family Details - dynamic
              _expandableSection(
                title: "Family Details",
                isExpanded: isFamilyDetails,
                onTap: () =>
                    setState(() => isFamilyDetails = !isFamilyDetails),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _detailItem(label: "Father's Name", value: _val(data?.fatherName)),
                    widget.dimens.k5.verticalBoxPadding,
                    _detailItem(label: "Father's Occupation", value: _val(data?.fatherOccupation)),
                    widget.dimens.k5.verticalBoxPadding,
                    _detailItem(label: "Family Values", value: _val(data?.familyValues)),
                    widget.dimens.k5.verticalBoxPadding,
                    _detailItem(label: "Live With", value: _val(data?.livingArrangement)),
                    widget.dimens.k5.verticalBoxPadding,
                    _detailItem(label: "Siblings Are Married", value: _val(data?.married)),
                    widget.dimens.k5.verticalBoxPadding,
                    _detailItem(label: "Siblings Are Unmarried", value: _val(data?.unmarried)),
                    widget.dimens.k5.verticalBoxPadding,
                    _detailItem(label: "Size of House", value: _val(data?.houseSize)),
                    widget.dimens.k5.verticalBoxPadding,
                    _detailItem(label: "Society or Area Live In", value: _val(data?.areaSociety)),
                    widget.dimens.k5.verticalBoxPadding,
                    _detailItem(label: "Move Abroad for Marriage", value: _val(data?.canMoveAbroadForMarriage)),
                    widget.dimens.k5.verticalBoxPadding,
                    _detailItem(label: "Children's", value: _val(data?.haveChildern)),
                    widget.dimens.k5.verticalBoxPadding,
                    _detailItem(label: "Additional Details About Your Family ", value: _val(data?.otherFamilyDetails)),
                    widget.dimens.k5.verticalBoxPadding,
                  ],
                ),
              ),
              widget.dimens.k10.verticalBoxPadding,

              // ✅ Education & Profession - dynamic
              _expandableSection(
                title: "Education and Profession",
                isExpanded: isEducationProfession,
                onTap: () => setState(
                        () => isEducationProfession = !isEducationProfession),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _detailItem(label: "Qualification", value: _val(data?.qualification)),
                    widget.dimens.k5.verticalBoxPadding,
                    _detailItem(label: "Educational Institute", value: _val(data?.nameInstitution)),
                    widget.dimens.k5.verticalBoxPadding,
                    _detailItem(label: "Profession", value: _val(data?.profession)),
                    widget.dimens.k5.verticalBoxPadding,
                    _detailItem(label: "Employer", value: _val(data?.employer)),
                    widget.dimens.k5.verticalBoxPadding,
                    _detailItem(label: "Employee Type", value: _val(data?.employeeType)),
                    widget.dimens.k5.verticalBoxPadding,
                    _detailItem(label: "Job Title or Role", value: _val(data?.jobTitle)),
                    widget.dimens.k5.verticalBoxPadding,
                    _detailItem(label: "Monthly Income", value: _val(data?.incomeRange)),
                    widget.dimens.k5.verticalBoxPadding,
                    _detailItem(label: "Business Own or Run", value: _val(data?.businessText)),
                    widget.dimens.k5.verticalBoxPadding,
                  ],
                ),
              ),
              widget.dimens.k10.verticalBoxPadding,

              // ✅ Lifestyle & Interest - dynamic
              _expandableSection(
                title: "Life Style and Interest",
                isExpanded: isLifeStyleInterest,
                onTap: () =>
                    setState(() => isLifeStyleInterest = !isLifeStyleInterest),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    if (lifeStyleInterests.isNotEmpty) ...[
                      Text(
                        "Life Style And Interest",
                        style: context.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w500,
                          color: ColorManager.fieldTextColor,
                          fontSize: widget.dimens.k13,
                        ),
                      ),
                      widget.dimens.k3.verticalBoxPadding,
                      Wrap(
                        spacing: widget.dimens.k8,
                        runSpacing: widget.dimens.k8,
                        children: lifeStyleInterests.map((item) {
                          return Container(
                            padding: EdgeInsets.symmetric(
                              horizontal: widget.dimens.k12,
                              vertical: widget.dimens.k6,
                            ),
                            decoration: BoxDecoration(
                              borderRadius:
                              BorderRadius.circular(widget.dimens.k10),
                              color: ColorManager.loginContainer,
                            ),
                            child: Text(
                              item,
                              style: context.textTheme.bodyMedium?.copyWith(
                                color: ColorManager.textColorSubTitle,
                                fontSize: widget.dimens.k12,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                      widget.dimens.k5.verticalBoxPadding,
                    ],
                    _detailItem(label: "Future Plans", value: _val(data?.futurePlan)),
                    widget.dimens.k5.verticalBoxPadding,
                    _detailItem(label: "Family Involved In Marriage Decision", value: _val(data?.familyInvolvement)),
                    widget.dimens.k5.verticalBoxPadding,
                    _detailItem(label: "Planning to Get Married", value: _val(data?.marriagePeriod)),
                    widget.dimens.k5.verticalBoxPadding,
                    _detailItem(label: "Smoking", value: _val(data?.smoke)),
                    widget.dimens.k5.verticalBoxPadding,
                    _detailItem(label: "Eat Only Halal Food", value: _val(data?.halalFood)),
                    widget.dimens.k5.verticalBoxPadding,
                    _detailItem(label: "Prefer to Wear A Hijab", value: _val(data?.forGirl)),
                    widget.dimens.k5.verticalBoxPadding,
                    _detailItem(label: "Prefer A Beard Man", value: _val(data?.forBoy)),
                    widget.dimens.k5.verticalBoxPadding,
                  ],
                ),
              ),
              widget.dimens.k10.verticalBoxPadding,

              // ✅ Partner Preferences - dynamic
              _expandableSection(
                title: "Partner Preferences / Requirements",
                isExpanded: isPartnerPreferences,
                onTap: () => setState(
                        () => isPartnerPreferences = !isPartnerPreferences),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    widget.dimens.k5.verticalBoxPadding,
                    _detailItem(
                      label: "What Are You Looking For In Your Life Partner?",
                      value: _val(data?.lifePartner),
                    ),
                    widget.dimens.k5.verticalBoxPadding,
                  ],
                ),
              ),
              widget.dimens.k10.verticalBoxPadding,

              // ✅ Pictures Section - dynamic from attachments
              Text(
                "Pictures",
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w500,
                  color: ColorManager.fieldTextColor,
                  fontSize: widget.dimens.k13,
                ),
              ),
              widget.dimens.k5.verticalBoxPadding,
              SizedBox(
                height: widget.dimens.k300,
                child: Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                          BorderRadius.circular(widget.dimens.k20),
                          image: DecorationImage(
                            image: attachmentImages.isNotEmpty
                                ? NetworkImage(attachmentImages[0])
                            as ImageProvider
                                : AssetImage(Assets.user),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    widget.dimens.k8.horizontalBoxPadding,
                    Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Expanded(
                              child: _smallImage(
                                  attachmentImages.length > 1
                                      ? attachmentImages[1]
                                      : null)),
                          widget.dimens.k8.verticalBoxPadding,
                          Expanded(
                              child: _smallImage(
                                  attachmentImages.length > 2
                                      ? attachmentImages[2]
                                      : null)),
                          widget.dimens.k8.verticalBoxPadding,
                          Expanded(
                              child: _smallImage(
                                  attachmentImages.length > 3
                                      ? attachmentImages[3]
                                      : null)),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              widget.dimens.k20.verticalBoxPadding,
            ],
          ),
        ),
      ),
    );
  }

  // ✅ Profile section with dynamic name, city, picture
  Widget _profileSection(ProfileData? data) {
    ImageProvider profileImage;
    if (_selectedImage != null) {
      profileImage = FileImage(_selectedImage!);
    } else if (data?.profilePicture != null &&
        data!.profilePicture!.isNotEmpty) {
      profileImage = NetworkImage(data.profilePicture!);
    } else {
      profileImage = AssetImage(Assets.user);
    }

    final fullName =
    "${data?.profileName ?? ""} ${data?.lastName ?? ""}".trim();
    final city = _val(data?.belongsTo);
    final country = _val(data?.country);

    return Column(
      children: [
        Stack(
          children: [
            CircleAvatar(
              radius: widget.dimens.k60,
              backgroundImage: profileImage,
            ),
            Positioned(
              bottom: 2,
              right: 2,
              child: GestureDetector(
                onTap: () {
                  showModalBottomSheet(
                    context: context,
                    builder: (_) {
                      return SafeArea(
                        child: Wrap(
                          children: [
                            ListTile(
                              leading: const Icon(Icons.camera_alt),
                              title: const Text("Camera"),
                              onTap: () {
                                Navigator.pop(context);
                                _pickImage(ImageSource.camera);
                              },
                            ),
                            ListTile(
                              leading: const Icon(Icons.photo),
                              title: const Text("Gallery"),
                              onTap: () {
                                Navigator.pop(context);
                                _pickImage(ImageSource.gallery);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  );
                },
                child: CircleAvatar(
                  radius: widget.dimens.k18,
                  backgroundColor: ColorManager.white,
                  child: Icon(
                    Icons.camera_alt_outlined,
                    size: widget.dimens.k22,
                    color: ColorManager.primary,
                  ),
                ),
              ),
            ),
          ],
        ),
        widget.dimens.k10.verticalBoxPadding,
        Text(
          fullName.isEmpty ? "N/A" : fullName,
          style: TextStyle(
            fontSize: widget.dimens.k18,
            fontWeight: FontWeight.w600,
          ),
        ),
        widget.dimens.k5.verticalBoxPadding,
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on_outlined,
              size: widget.dimens.k20,
              color: ColorManager.fieldTextColor,
            ),
            widget.dimens.k5.horizontalBoxPadding,
            Text(
              "$city, $country",
              style: TextStyle(
                fontSize: widget.dimens.k13,
                fontWeight: FontWeight.w400,
                color: ColorManager.fieldTextColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _expandableSection({
    required String title,
    required bool isExpanded,
    required VoidCallback onTap,
    required Widget child,
  }) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: EdgeInsets.symmetric(
        vertical: widget.dimens.k20,
        horizontal: widget.dimens.k15,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.dimens.k25),
        color: ColorManager.halfWhite,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: onTap,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  title,
                  style: context.textTheme.bodySmall?.copyWith(
                    fontWeight: FontWeight.w600,
                    color: ColorManager.textColor,
                  ),
                ),
                Icon(
                  isExpanded
                      ? Icons.keyboard_arrow_down_outlined
                      : Icons.arrow_forward_ios_sharp,
                  color: isExpanded
                      ? ColorManager.textColor
                      : ColorManager.fieldTextColor,
                ),
              ],
            ),
          ),
          if (isExpanded) ...[
            widget.dimens.k10.verticalBoxPadding,
            child,
          ],
        ],
      ),
    );
  }

  // ✅ Small image: supports network URL or falls back to asset
  Widget _smallImage(String? url) {
    ImageProvider img;
    if (url != null && url.isNotEmpty) {
      img = NetworkImage(url);
    } else {
      img = AssetImage(Assets.home1);
    }
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.dimens.k15),
        image: DecorationImage(
          image: img,
          fit: BoxFit.cover,
        ),
      ),
    );
  }

  Widget _detailItem({required String label, required String value}) {
    return Padding(
      padding: EdgeInsets.only(bottom: widget.dimens.k12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w500,
              color: ColorManager.fieldTextColor,
              fontSize: widget.dimens.k13,
            ),
          ),
          widget.dimens.k4.verticalBoxPadding,
          Text(
            value,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600,
              color: ColorManager.fieldHintColor,
              fontSize: widget.dimens.k16,
            ),
          ),
        ],
      ),
    );
  }

  Widget bioCard(String title, String text) {
    final size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      padding: EdgeInsets.symmetric(
        vertical: widget.dimens.k20,
        horizontal: widget.dimens.k15,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.dimens.k25),
        color: ColorManager.halfWhite,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: context.textTheme.bodySmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: ColorManager.textColor,
            ),
          ),
          widget.dimens.k5.verticalBoxPadding,
          Text(
            text,
            style: context.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w400,
              color: ColorManager.fieldTextColor,
            ),
          ),
        ],
      ),
    );
  }
  Widget _header() {
    return Row(
      children: [
        GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Row(
            children: [
              Icon(Icons.arrow_back_ios,
                  size: widget.dimens.k20, color: ColorManager.primary),
              Text(
                "Back",
                style: context.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w400,
                  fontSize: widget.dimens.k17,
                  color: ColorManager.primary,
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: Center(
            child: Text(
              "Profile",
              style: TextStyle(
                fontSize: widget.dimens.k18,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        GestureDetector(
          onTap: _onEditTapped,          // ← changed
          child: CircleAvatar(
            backgroundColor: ColorManager.primary.withOpacity(.2),
            radius: widget.dimens.k20,
            child: Icon(Icons.edit, color: ColorManager.primary),
          ),
        ),
      ],
    );
  }

  /// Maps ProfileData → pref → navigate to edit flow
  void _onEditTapped() {
    final data = widget.profileData;
    if (data == null) return;

    // 1. Convert ProfileData → SetupProfilePrefModel
    final prefModel = ProfileEditMapper.fromProfileData(data);

    // 2. Save to SharedPreferences
    context.read<IPrefHelper>().saveSetupProfile(prefModel);

    // 3. Navigate to the 7-step sign-up creation view (edit mode)
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => SignUpCreationView()),
    );
  }
  // Widget _header() {
  //   return Row(
  //     children: [
  //       GestureDetector(
  //         onTap: () => Navigator.pop(context),
  //         child: Row(
  //           children: [
  //             Icon(Icons.arrow_back_ios,
  //                 size: widget.dimens.k20, color: ColorManager.primary),
  //             Text(
  //               "Back",
  //               style: context.textTheme.titleMedium?.copyWith(
  //                   fontWeight: FontWeight.w400,
  //                   fontSize: widget.dimens.k17,
  //                   color: ColorManager.primary),
  //             ),
  //           ],
  //         ),
  //       ),
  //       Expanded(
  //         child: Center(
  //           child: Text(
  //             "Profile",
  //             style: TextStyle(
  //               fontSize: widget.dimens.k18,
  //               fontWeight: FontWeight.w600,
  //             ),
  //           ),
  //         ),
  //       ),
  //       GestureDetector(
  //         onTap: () {},
  //         child: CircleAvatar(
  //           backgroundColor: ColorManager.primary.withOpacity(.2),
  //           radius: widget.dimens.k20,
  //           child: Icon(
  //             Icons.edit,
  //             color: ColorManager.primary,
  //           ),
  //         ),
  //       ),
  //     ],
  //   );
  // }

  @override
  void onError(String error) {
    MyToast.showToast(message: error);
  }

  @override
  void onSuccess(String result) {
    // MyToast.showToast(message: result);
    context.read<GetPersonalProfileViewModel>().getAllPersonalProfileDetails(
      this,
      profileId: widget.profileData?.userId??"", // ✅ FIXED
    );
  }
}