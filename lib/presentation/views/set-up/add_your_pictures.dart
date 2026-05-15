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

  // ── Each slot can be a local File OR a network URL string ──────────────
  // We track them separately so submit logic knows what to do
  List<_ImageSlot> _slots = [];

  bool _imagesLoaded = false;
  bool _isSaving = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _loadFromPrefs());
  }

  // ── Determine if a stored string is a network URL ──────────────────────
  bool _isNetworkUrl(String path) =>
      path.startsWith('http://') || path.startsWith('https://');

  // ── Load from prefs — supports both local paths and network URLs ───────
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

    final slots = <_ImageSlot>[];

    for (final path in paths) {
      if (_isNetworkUrl(path)) {
        // Edit mode: came from server
        slots.add(_ImageSlot.network(path));
      } else {
        // New registration: local file
        final file = File(path);
        if (file.existsSync()) {
          slots.add(_ImageSlot.local(file));
        }
      }
    }

    if (slots.isNotEmpty) {
      setState(() => _slots = slots);
    }
  }

  // ── Pick new image from gallery ────────────────────────────────────────
  Future<void> pickImage() async {
    if (_slots.length >= 4) return;

    final XFile? image =
    await _picker.pickImage(source: ImageSource.gallery);
    if (image == null) return;

    final File savedFile = await _saveFileToAppDir(File(image.path));

    setState(() {
      _slots.add(_ImageSlot.local(savedFile));
    });

    await saveSetupProfileStep();
  }

  Future<File> _saveFileToAppDir(File file) async {
    final appDir = await getApplicationDocumentsDirectory();
    final fileName =
        '${DateTime.now().millisecondsSinceEpoch}_${file.path.split('/').last}';
    return file.copy('${appDir.path}/$fileName');
  }

  // ── Save step — stores local paths & network URLs ─────────────────────
  Future<void> saveSetupProfileStep() async {
    while (_isSaving) {
      await Future.delayed(const Duration(milliseconds: 50));
    }
    if (!mounted) return;
    setState(() => _isSaving = true);

    try {
      final pref    = context.read<IPrefHelper>();
      final current = pref.retrieveSetupProfile() ?? SetupProfilePrefModel();

      // Each slot: local → its file path, network → its URL
      final paths = _slots.map((s) => s.isNetwork ? s.url! : s.file!.path).toList();

      final updated = SetupProfilePrefModel(
        // ── carry all existing fields ────────────────────────────────
        profileName:              current.profileName,
        lastName:                 current.lastName,
        gender:                   current.gender,
        dateOfBirth:              current.dateOfBirth,
        profileCompleted: current.profileCompleted,
        motherTongue:             current.motherTongue,
        caste:                    current.caste,
        height:                   current.height,
        weight:                   current.weight,
        materialStatus:           current.materialStatus,
        country:                  current.country,
        ethnicity:                current.ethnicity,
        nationality:              current.nationality,
        religion:                 current.religion,
        belongsTo:                current.belongsTo,
        religiousPractice:        current.religiousPractice,
        zodiacSign:               current.zodiacSign,
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
        qualification:            current.qualification,
        nameInstitution:          current.nameInstitution,
        profession:               current.profession,
        employer:                 current.employer,
        employeeType:             current.employeeType,
        jobTitle:                 current.jobTitle,
        income:                   current.income,
        business:                 current.business,
        businessText:             current.businessText,
        lifeStyleAndInterest:     current.lifeStyleAndInterest,
        futurePlan:               current.futurePlan,
        familyInvolvement:        current.familyInvolvement,
        marriagePeriod:           current.marriagePeriod,
        smoke:                    current.smoke,
        halalFood:                current.halalFood,
        forGirl:                  current.forGirl,
        forBoy:                   current.forBoy,
        lifePartner:              current.lifePartner,
        // ── image slots (paths OR urls) ──────────────────────────────
        images:  paths,
        attach1: paths.isNotEmpty ? paths[0] : '',
        attach2: paths.length > 1 ? paths[1] : '',
        attach3: paths.length > 2 ? paths[2] : '',
        attach4: paths.length > 3 ? paths[3] : '',
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
      print("✅ ${paths.length} image slots saved to prefs");
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  // ── Build image widget per slot ────────────────────────────────────────
  Widget _buildSlotImage(_ImageSlot slot) {
    if (slot.isNetwork) {
      return Image.network(
        slot.url!,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
        loadingBuilder: (_, child, progress) => progress == null
            ? child
            : const Center(
          child: SizedBox(
            width: 20,
            height: 20,
            child: CircularProgressIndicator(strokeWidth: 1.5),
          ),
        ),
        errorBuilder: (_, __, ___) => Image.asset(
          Assets.addPicture,
          height: 25,
          width: 25,
        ),
      );
    } else {
      return Image.file(
        slot.file!,
        width: double.infinity,
        height: double.infinity,
        fit: BoxFit.cover,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final size = MediaQuery.of(context).size;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── Add button ─────────────────────────────────────────────────
          GestureDetector(
            onTap: _isSaving ? null : pickImage,
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

          // ── Preview grid ───────────────────────────────────────────────
          Row(
            children: List.generate(4, (index) {
              final hasSlot = _slots.length > index;

              return Container(
                margin: const EdgeInsets.only(right: 8),
                width: size.width / 5,
                height: size.width / 4,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(widget.dimens.k15),
                  border: Border.all(color: ColorManager.dropDownBroder),
                  color: ColorManager.addPicture,
                ),
                child: Stack(
                  children: [
                    Center(
                      child: hasSlot
                          ? ClipRRect(
                        borderRadius:
                        BorderRadius.circular(widget.dimens.k15),
                        child: _buildSlotImage(_slots[index]),
                      )
                          : Image.asset(Assets.addPicture,
                          height: 25, width: 25),
                    ),
                    if (hasSlot)
                      Positioned(
                        top: 6,
                        left: 6,
                        child: GestureDetector(
                          onTap: _isSaving
                              ? null
                              : () async {
                            setState(() => _slots.removeAt(index));
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

// ── Simple discriminated union for a slot ─────────────────────────────────
class _ImageSlot {
  final File? file;
  final String? url;

  const _ImageSlot._({this.file, this.url});

  factory _ImageSlot.local(File f) => _ImageSlot._(file: f);
  factory _ImageSlot.network(String u) => _ImageSlot._(url: u);

  bool get isNetwork => url != null;
}