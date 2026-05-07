import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import '../../../../application/app_theme/color_scheme.dart';
import '../../../../constants/asset_manager.dart';
import '../../../data/local_data_source/preference/i_pref_helper.dart';
import '../../../data/models/set_up_profile_model/set_up_profile_pref/set_up_profile_pref_model.dart';
import 'package:ideal_marriage_bureau/base/base_widget.dart';

class AddYourPictures extends BaseStateFullWidget {
  AddYourPictures({super.key});

  @override
  State<AddYourPictures> createState() => AddYourPicturesState();
}

class AddYourPicturesState extends State<AddYourPictures>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;
  final ImagePicker _picker = ImagePicker();
  List<File> selectedImages = [];
  bool _imagesLoaded = false;
  bool _isSaving = false; // ✅ saving indicator
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadFromPrefs());
  }
  Future<String> _fileToBase64(File file) async {
    final bytes = await file.readAsBytes();
    final ext   = file.path.split('.').last.toLowerCase();

    // mime type
    String mime = 'image/jpeg';
    if (ext == 'png')  mime = 'image/png';
    if (ext == 'webp') mime = 'image/webp';

    // ✅ data URI format: "data:image/jpeg;base64,/9j/4AAQ..."
    return 'data:$mime;base64,${base64Encode(bytes)}';
  }
  Future<void> pickImage() async {
    if (selectedImages.length >= 4) return;

    final XFile? image =
    await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final File savedFile = await _saveFileToAppDir(File(image.path));

    setState(() {
      selectedImages.add(savedFile);
    });

    await saveSetupProfileStep(); // ✅ async save
  }
  Future<File> _saveFileToAppDir(File file) async {
    final appDir   = await getApplicationDocumentsDirectory();
    final fileName =
        '${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';
    return file.copy('${appDir.path}/$fileName');
  }
  void _loadFromPrefs() {
    if (_imagesLoaded) return;
    _imagesLoaded = true;
    final saved = context.read<IPrefHelper>().retrieveSetupProfile();
    if (saved == null) return;
    final paths = [
      saved.attach1 ?? '',
      saved.attach2 ?? '',
      saved.attach3 ?? '',
      saved.attach4 ?? '',
    ].where((p) => p.isNotEmpty).toList();
    final tempImages = <File>[];
    for (final path in paths) {
      final file = File(path);
      if (file.existsSync()) tempImages.add(file);
    }
    if (tempImages.isNotEmpty) {
      setState(() => selectedImages = tempImages);
    }
  }
  // Future<void> saveSetupProfileStep() async {
  //   // ✅ Agar pehle se saving chal rahi hai toh complete hone ka wait karo
  //   while (_isSaving) {
  //     await Future.delayed(const Duration(milliseconds: 50));
  //   }
  //
  //   if (!mounted) return;
  //   setState(() => _isSaving = true);
  //
  //   try {
  //     final pref    = context.read<IPrefHelper>();
  //     final current = pref.retrieveSetupProfile() ?? SetupProfilePrefModel();
  //     final paths   = selectedImages.map((e) => e.path).toList();
  //
  //     // ✅ Convert all selected images to base64
  //     final List<String> base64List = [];
  //     for (final file in selectedImages) {
  //       final b64 = await _fileToBase64(file);
  //       base64List.add(b64);
  //     }
  //
  //     final updated = SetupProfilePrefModel(
  //       // ── Page 1 ──────────────────────────────────────────────────────
  //       profileName:       current.profileName,
  //       lastName:          current.lastName,
  //       gender:            current.gender,
  //       dateOfBirth:       current.dateOfBirth,
  //       motherTongue:      current.motherTongue,
  //       caste:             current.caste,
  //       height:            current.height,
  //       weight:            current.weight,
  //       materialStatus:    current.materialStatus,
  //       country:           current.country,
  //       ethnicity:         current.ethnicity,
  //       nationality:       current.nationality,
  //       religion:          current.religion,
  //       belongsTo:         current.belongsTo,
  //       religiousPractice: current.religiousPractice,
  //       zodiacSign:        current.zodiacSign,
  //       // ── Page 2 ──────────────────────────────────────────────────────
  //       fatherName:               current.fatherName,
  //       fatherOccupation:         current.fatherOccupation,
  //       familyValues:             current.familyValues,
  //       livingArrangement:        current.livingArrangement,
  //       married:                  current.married,
  //       unmarried:                current.unmarried,
  //       houseSize:                current.houseSize,
  //       areaSociety:              current.areaSociety,
  //       canMoveAbroadForMarriage: current.canMoveAbroadForMarriage,
  //       haveChildren:             current.haveChildren,
  //       otherFamilyDetails:       current.otherFamilyDetails,
  //       // ── Page 3 ──────────────────────────────────────────────────────
  //       qualification:   current.qualification,
  //       nameInstitution: current.nameInstitution,
  //       profession:      current.profession,
  //       employer:        current.employer,
  //       employeeType:    current.employeeType,
  //       jobTitle:        current.jobTitle,
  //       income:          current.income,
  //       business:        current.business,
  //       businessText:    current.businessText,
  //       // ── Page 4 ──────────────────────────────────────────────────────
  //       lifeStyleAndInterest: current.lifeStyleAndInterest,
  //       futurePlan:           current.futurePlan,
  //       familyInvolvement:    current.familyInvolvement,
  //       marriagePeriod:       current.marriagePeriod,
  //       smoke:                current.smoke,
  //       halalFood:            current.halalFood,
  //       forGirl:              current.forGirl,
  //       forBoy:               current.forBoy,
  //       lifePartner:          current.lifePartner,
  //       // ── Page 6 — local paths ─────────────────────────────────────────
  //       images:  paths,
  //       attach1: paths.isNotEmpty ? paths[0] : '',
  //       attach2: paths.length > 1 ? paths[1] : '',
  //       attach3: paths.length > 2 ? paths[2] : '',
  //       attach4: paths.length > 3 ? paths[3] : '',
  //       // ── Page 6 — base64 for API ──────────────────────────────────────
  //       attach1Base64: base64List.isNotEmpty ? base64List[0] : '',
  //       attach2Base64: base64List.length > 1 ? base64List[1] : '',
  //       attach3Base64: base64List.length > 2 ? base64List[2] : '',
  //       attach4Base64: base64List.length > 3 ? base64List[3] : '',
  //       // ── Page 7 ──────────────────────────────────────────────────────
  //       bio:                current.bio,
  //       marriageIntension:  current.marriageIntension,
  //       createrProfile:     current.createrProfile,
  //       enableNotification: current.enableNotification,
  //     );
  //
  //     pref.saveSetupProfile(updated);
  //   } finally {
  //     if (mounted) setState(() => _isSaving = false);
  //   }
  // }
  Future<void> saveSetupProfileStep() async {
    while (_isSaving) {
      await Future.delayed(const Duration(milliseconds: 50));
    }
    if (!mounted) return;
    setState(() => _isSaving = true);
    try {
      final pref    = context.read<IPrefHelper>();
      final current = pref.retrieveSetupProfile() ?? SetupProfilePrefModel();
      final paths   = selectedImages.map((e) => e.path).toList();
      // ✅ Sirf paths save karo — base64 payload time pe banao
      final updated = SetupProfilePrefModel(
        profileName:       current.profileName,
        lastName:          current.lastName,
        gender:            current.gender,
        dateOfBirth:       current.dateOfBirth,
        motherTongue:      current.motherTongue,
        caste:             current.caste,
        height:            current.height,
        weight:            current.weight,
        materialStatus:    current.materialStatus,
        country:           current.country,
        ethnicity:         current.ethnicity,
        nationality:       current.nationality,
        religion:          current.religion,
        belongsTo:         current.belongsTo,
        religiousPractice: current.religiousPractice,
        zodiacSign:        current.zodiacSign,
        fatherName:               current.fatherName,
        fatherOccupation:         current.fatherOccupation,
        familyValues:             current.familyValues,
        livingArrangement:        current.livingArrangement,
        married:                  current.married,
        unmarried:                current.unmarried,
        houseSize:                current.houseSize,
        areaSociety:              current.areaSociety,
        canMoveAbroadForMarriage: current.canMoveAbroadForMarriage,
        haveChildren:             current.haveChildren,
        otherFamilyDetails:       current.otherFamilyDetails,
        qualification:   current.qualification,
        nameInstitution: current.nameInstitution,
        profession:      current.profession,
        employer:        current.employer,
        employeeType:    current.employeeType,
        jobTitle:        current.jobTitle,
        income:          current.income,
        business:        current.business,
        businessText:    current.businessText,
        lifeStyleAndInterest: current.lifeStyleAndInterest,
        futurePlan:           current.futurePlan,
        familyInvolvement:    current.familyInvolvement,
        marriagePeriod:       current.marriagePeriod,
        smoke:                current.smoke,
        halalFood:            current.halalFood,
        forGirl:              current.forGirl,
        forBoy:               current.forBoy,
        lifePartner:          current.lifePartner,
        // ✅ Sirf local paths — base64 nahi
        images:  paths,
        attach1: paths.isNotEmpty ? paths[0] : '',
        attach2: paths.length > 1 ? paths[1] : '',
        attach3: paths.length > 2 ? paths[2] : '',
        attach4: paths.length > 3 ? paths[3] : '',
        // ✅ Base64 prefs mein save nahi karte
        attach1Base64: null,
        attach2Base64: null,
        attach3Base64: null,
        attach4Base64: null,
        bio:                current.bio,
        marriageIntension:  current.marriageIntension,
        createrProfile:     current.createrProfile,
        enableNotification: current.enableNotification,
      );
      pref.saveSetupProfile(updated);
      print("✅ ${paths.length} image paths saved to prefs");

    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }
  // ── Save to prefs with base64 ─────────────────────────────────────────────
  // Future<void> saveSetupProfileStep() async {
  //   if (_isSaving) return;
  //   setState(() => _isSaving = true);
  //
  //   try {
  //     final pref    = context.read<IPrefHelper>();
  //     final current = pref.retrieveSetupProfile() ?? SetupProfilePrefModel();
  //     final paths   = selectedImages.map((e) => e.path).toList();
  //
  //     // ✅ Convert all selected images to base64
  //     final List<String> base64List = [];
  //     for (final file in selectedImages) {
  //       final b64 = await _fileToBase64(file);
  //       base64List.add(b64);
  //     }
  //
  //     final updated = SetupProfilePrefModel(
  //       // ── Page 1 ──────────────────────────────────────────────────────
  //       profileName:       current.profileName,
  //       lastName:          current.lastName,
  //       gender:            current.gender,
  //       dateOfBirth:       current.dateOfBirth,
  //       motherTongue:      current.motherTongue,
  //       caste:             current.caste,
  //       height:            current.height,
  //       weight:            current.weight,
  //       materialStatus:    current.materialStatus,
  //       country:           current.country,
  //       ethnicity:         current.ethnicity,
  //       nationality:       current.nationality,
  //       religion:          current.religion,
  //       belongsTo:         current.belongsTo,
  //       religiousPractice: current.religiousPractice,
  //       zodiacSign:        current.zodiacSign,
  //       // ── Page 2 ──────────────────────────────────────────────────────
  //       fatherName:               current.fatherName,
  //       fatherOccupation:         current.fatherOccupation,
  //       familyValues:             current.familyValues,
  //       livingArrangement:        current.livingArrangement,
  //       married:                  current.married,
  //       unmarried:                current.unmarried,
  //       houseSize:                current.houseSize,
  //       areaSociety:              current.areaSociety,
  //       canMoveAbroadForMarriage: current.canMoveAbroadForMarriage,
  //       haveChildren:             current.haveChildren,
  //       otherFamilyDetails:       current.otherFamilyDetails,
  //       // ── Page 3 ──────────────────────────────────────────────────────
  //       qualification:   current.qualification,
  //       nameInstitution: current.nameInstitution,
  //       profession:      current.profession,
  //       employer:        current.employer,
  //       employeeType:    current.employeeType,
  //       jobTitle:        current.jobTitle,
  //       income:          current.income,
  //       business:        current.business,
  //       businessText:    current.businessText,
  //       // ── Page 4 ──────────────────────────────────────────────────────
  //       lifeStyleAndInterest: current.lifeStyleAndInterest,
  //       futurePlan:           current.futurePlan,
  //       familyInvolvement:    current.familyInvolvement,
  //       marriagePeriod:       current.marriagePeriod,
  //       smoke:                current.smoke,
  //       halalFood:            current.halalFood,
  //       forGirl:              current.forGirl,
  //       forBoy:               current.forBoy,
  //       lifePartner:          current.lifePartner,
  //       // ── Page 6 — local paths ─────────────────────────────────────────
  //       images:  paths,
  //       attach1: paths.isNotEmpty ? paths[0] : '',
  //       attach2: paths.length > 1 ? paths[1] : '',
  //       attach3: paths.length > 2 ? paths[2] : '',
  //       attach4: paths.length > 3 ? paths[3] : '',
  //       // ── Page 6 — base64 for API ──────────────────────────────────────
  //       attach1Base64: base64List.isNotEmpty ? base64List[0] : '',
  //       attach2Base64: base64List.length > 1 ? base64List[1] : '',
  //       attach3Base64: base64List.length > 2 ? base64List[2] : '',
  //       attach4Base64: base64List.length > 3 ? base64List[3] : '',
  //       // ── Page 7 ──────────────────────────────────────────────────────
  //       bio:                current.bio,
  //       marriageIntension:  current.marriageIntension,
  //       createrProfile:     current.createrProfile,
  //       enableNotification: current.enableNotification,
  //     );
  //
  //     pref.saveSetupProfile(updated);
  //
  //   } finally {
  //     if (mounted) setState(() => _isSaving = false);
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    super.build(context);
    final size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Add button ──────────────────────────────────────────────────
          GestureDetector(
            onTap: _isSaving ? null : pickImage, // disable while saving
            child: Container(
              width: size.width,
              height: widget.dimens.k100,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(widget.dimens.k15),
                color: ColorManager.addPicture,
                border: Border.all(color: ColorManager.dropDownBroder),
              ),
              child: _isSaving
                  ? const Center(
                child: SizedBox(
                  height: 24,
                  width: 24,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              )
                  : Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(Assets.addPicture,
                      height: widget.dimens.k25,
                      width: widget.dimens.k25),
                  widget.dimens.k5.verticalBoxPadding,
                  Text(
                    "Add Pictures",
                    style: context.textTheme.bodySmall?.copyWith(
                      color: ColorManager.fieldHintColor,
                      fontWeight: FontWeight.w500,
                      fontSize: 13,
                    ),
                  ),
                ],
              ),
            ),
          ),

          widget.dimens.k10.verticalBoxPadding,

          Text(
            "Preview",
            style: context.textTheme.bodySmall?.copyWith(
              color: ColorManager.fieldHintColor,
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),

          widget.dimens.k10.verticalBoxPadding,

          // ── Preview grid ─────────────────────────────────────────────────
          Row(
            children: List.generate(4, (index) {
              final hasImage = selectedImages.length > index;

              return Container(
                margin: const EdgeInsets.only(right: 8),
                width: size.width / 5,
                height: size.width / 4,   // ✅ slightly taller than wide
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.dimens.k15),
                  border: Border.all(color: ColorManager.dropDownBroder),
                  color: ColorManager.addPicture,
                ),
                child: Stack(
                  children: [
                    Center(
                      child: hasImage
                          ? ClipRRect(
                        borderRadius:
                        BorderRadius.circular(widget.dimens.k15),
                        child: Image.file(
                          selectedImages[index],
                          width: double.infinity,
                          height: double.infinity,
                          fit: BoxFit.cover,
                        ),
                      )
                          : Image.asset(Assets.addPicture,
                          height: 25, width: 25),
                    ),
                    if (hasImage)
                      Positioned(
                        top: 6,
                        left: 6,
                        child: GestureDetector(
                          onTap: _isSaving
                              ? null
                              : () async {
                            setState(() {
                              selectedImages.removeAt(index);
                            });
                            await saveSetupProfileStep();
                          },
                          child: Container(
                            decoration: const BoxDecoration(
                              color: Colors.black45,
                              shape: BoxShape.circle,
                            ),
                            padding: const EdgeInsets.all(2),
                            child: const Icon(Icons.close,
                                size: 14, color: Colors.white),
                          ),
                        ),
                      ),
                  ],
                ),
              );
            }),
          ),

          // ✅ Saving indicator text
          if (_isSaving) ...[
            widget.dimens.k10.verticalBoxPadding,
            Center(
              child: Text(
                "Saving images...",
                style: context.textTheme.bodySmall?.copyWith(
                  color: ColorManager.fieldHintColor,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}