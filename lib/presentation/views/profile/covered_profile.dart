import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import '../../../../application/app_theme/color_scheme.dart';
import '../../../constants/asset_manager.dart';
import '../../../widgets/primary_button.dart';

class ProfileCoverCard extends StatefulWidget {
  final List<String> coverImages;
  final String image;
  final String name;
  final String email;
  final String reach;
  final String impressions;
  final String credit;
  final VoidCallback onProfileTap;
  final VoidCallback? onImpressionsTap;

  const ProfileCoverCard({
    super.key,
    required this.coverImages,
    required this.name,
    required this.image,
    required this.email,
    required this.reach,
    required this.impressions,
    required this.credit,
    required this.onProfileTap,
    required this.onImpressionsTap,
  });

  @override
  State<ProfileCoverCard> createState() => _ProfileCoverCardState();
}

class _ProfileCoverCardState extends State<ProfileCoverCard> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: ColorManager.white,
      ),
      child: Column(
        children: [
          _coverSlider(size, context),
          const SizedBox(height: 5),
          _statsRow(context),
          const SizedBox(height: 5),
        ],
      ),
    );
  }

  Widget _coverSlider(Size size, BuildContext context) {
    return Container(
      height: 250,
      width: size.width,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            PageView.builder(
              itemCount: widget.coverImages.length,
              onPageChanged: (index) {
                setState(() => _currentIndex = index);
              },
              itemBuilder: (_, index) {
                return Image.network(
                  widget.coverImages[index],
                  fit: BoxFit.cover,
                  width: size.width,
                  errorBuilder: (context, error, stackTrace) {
                    return Container(
                      color: Colors.grey.shade300,
                      child: const Center(
                        child: Icon(Icons.broken_image, size: 40, color: Colors.grey),
                      ),
                    );
                  },
                  loadingBuilder: (context, child, loadingProgress) {
                    if (loadingProgress == null) return child;
                    return const Center(
                      child: CircularProgressIndicator(strokeWidth: 2),
                    );
                  },
                );
              },
            ),

            /// index badge
            Positioned(
              top: 10,
              right: 10,
              child: Container(
                height: 30,
                width: 80,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: ColorManager.fieldTextColor.withOpacity(.4),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Text(
                  "${_currentIndex + 1}/${widget.coverImages.length}",
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            /// bottom profile info
            Positioned(
              bottom: 10,
              left: 10,
              right: 10,
              child:
              Row(
                children: [
                  CircleAvatar(
                    radius: 21,
                    backgroundColor: ColorManager.white,
                    child:  CircleAvatar(
                      radius: 20,
                      backgroundImage: _getImageProvider(widget.image),
                      child: (widget.image.isEmpty)
                          ? const Icon(Icons.person, size: 20)
                          : null,
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.name,
                          style: context.textTheme.titleMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                        Text(
                          widget.email,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: context.textTheme.bodySmall?.copyWith(
                            color: Colors.white70,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: PrimaryButton(
                      height: 30,
                      onPressed: widget.onProfileTap, // 👈 passed callback
                      childText: "Profile",
                      issquare: false,
                      color: ColorManager.primary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _statsRow(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _statItem(widget.reach, "Reach", context),
          _divider(),
          GestureDetector( onTap: widget.onImpressionsTap,child: _statItem(widget.impressions, "Impressions", context)),
          _divider(),
          _statItem(widget.credit, "Credit", context),
        ],
      ),
    );
  }

  Widget _divider() {
    return SizedBox(
      height: 30,
      child: VerticalDivider(
        thickness: 1,
        color: ColorManager.border,
      ),
    );
  }

  Widget _statItem(String value, String label, BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          value,
          style: context.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
            color: ColorManager.textColor,
          ),
        ),
        Text(
          label,
          style: context.textTheme.bodySmall?.copyWith(
            color: ColorManager.fieldTextColor,
          ),
        ),
      ],
    );
  }
  ImageProvider? _getImageProvider(String path) {
    if (path.isEmpty) return null;

    if (path.startsWith("http")) {
      return NetworkImage(path);
    } else {
      return AssetImage(path);
    }
  }
}
