import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/base/base_widget.dart';
import 'package:ideal_marriage_bureau/data/models/get_profile_model/get_all_profile_list_model.dart';
import '../../../application/app_theme/color_scheme.dart';

class ProfileInfo extends BaseStateLessWidget {
  final Profiles profile;   // ← only this changed

  ProfileInfo({super.key, required this.profile});

  int? get _age {
    if (profile.dateOfBirth == null) return null;
    final dob = DateTime.tryParse(profile.dateOfBirth!);
    if (dob == null) return null;
    final now = DateTime.now();
    int age = now.year - dob.year;
    if (now.month < dob.month ||
        (now.month == dob.month && now.day < dob.day)) {
      age--;
    }
    return age;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        // Name — UI SAME
        Text(
          profile.profileName ?? "Unknown",
          style: context.textTheme.bodyLarge?.copyWith(
            fontWeight: FontWeight.w400,
            fontSize: dimens.k24,
            color: ColorManager.white,
          ),
        ),
        dimens.k6.verticalBoxPadding,

        // Chips Row — UI SAME (original Row, not Wrap)
        Row(
          children: [

            // Active chip — UI SAME
            Container(
              height: 37,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(dimens.k20),
                  color: ColorManager.white.withOpacity(.3)),
              child: Padding(
                padding: EdgeInsets.all(dimens.k8),
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: dimens.k4,
                      backgroundColor: profile.isBlocked == true
                          ? Colors.red
                          : Colors.green,
                    ),
                    SizedBox(width: dimens.k2),
                    Text(
                      profile.isBlocked == true ? "Blocked" : "Active",
                      style: context.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w400,
                        fontSize: dimens.k14,
                        color: ColorManager.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            dimens.k5.horizontalBoxPadding,

            // Location chip — UI SAME
            if (profile.location != null)
              Container(
                height: 37,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(dimens.k20),
                    color: ColorManager.white.withOpacity(.3)),
                child: Padding(
                  padding: EdgeInsets.all(dimens.k8),
                  child: Text(
                    "Location: ${profile.location}",
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: dimens.k14,
                      color: ColorManager.white,
                    ),
                  ),
                ),
              ),
            dimens.k5.horizontalBoxPadding,

            // Age chip — UI SAME
            if (_age != null)
              Container(
                height: 37,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(dimens.k20),
                    color: ColorManager.white.withOpacity(.3)),
                child: Padding(
                  padding: EdgeInsets.all(dimens.k8),
                  child: Text(
                    "Age: $_age",
                    style: context.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w400,
                      fontSize: dimens.k14,
                      color: ColorManager.white,
                    ),
                  ),
                ),
              ),
          ],
        ),
      ],
    );
  }
}