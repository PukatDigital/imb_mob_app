import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/application/core/result.dart';
import 'package:ideal_marriage_bureau/presentation/views/report_problem/report_problem_view_model.dart';
import 'package:provider/provider.dart';

import '../../../application/app_theme/color_scheme.dart';
import '../../../application/network/result.dart';
import '../../../base/base_widget.dart';

class ProblemDetailView extends BaseStateFullWidget {
  final String problemId;
  ProblemDetailView({super.key, required this.problemId});

  @override
  State<ProblemDetailView> createState() => _ProblemDetailViewState();
}

class _ProblemDetailViewState extends State<ProblemDetailView>
    implements Result {

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GetReportProblem>().getProblemDetail(
        this,
        problemId: widget.problemId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorManager.liteGrey,
      body: _body(),
    );
  }
  Widget _background() {
    return Container(
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
    );
  }
  Widget _body() {
    return Stack(
      children: [
        _background(),
        SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: widget.dimens.k18,
            vertical: widget.dimens.k16,
          ),
          child: Column(
            children: [
              /// Header
              Row(
                children: [
                  GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Row(
                      children: [
                        Icon(
                          Icons.arrow_back_ios,
                          size: widget.dimens.k16,
                          color: ColorManager.rejectedText,
                        ),
                        Text(
                          "Back",
                          style: context.textTheme.bodyMedium?.copyWith(
                            color: ColorManager.rejectedText,
                            fontSize: widget.dimens.k14,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Center(
                      child: Text(
                        "Problem Detail",
                        style: context.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          fontSize: widget.dimens.k18,
                          color: Colors.black87,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: widget.dimens.k40),
                ],
              ),

              widget.dimens.k40.verticalBoxPadding,

              /// Main Card
              Expanded(
                child: Consumer<GetReportProblem>(
                  builder: (context, provider, _) {

                    /// Loading
                    if (provider.apiResponse is Loading) {
                      return const Center(child: CircularProgressIndicator());
                    }

                    final model = provider.profileDetailsModel;
                    final detail = model.detail;

                    /// No data
                    if (detail == null) {
                      return Center(
                        child: Text(
                          "No details found",
                          style: TextStyle(
                            fontSize: widget.dimens.k14,
                            color: ColorManager.textColorSubTitle,
                          ),
                        ),
                      );
                    }



                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          if(detail.status == 'Rejected')
                          _responseCard(
                            status: detail.status ?? '',
                            remark: detail.remarks ?? '',
                            date: '${detail.postingDate ?? ''} . ${_formatTime(detail.postingTime)}',
                          //  time: detail?.postingTime ??'',
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.all(widget.dimens.k5),
                            decoration: BoxDecoration(color: ColorManager.white),
                            child: Column(
                              children: [
                                widget.dimens.k16.verticalBoxPadding,
                                _submissionCard(
                                  problemType: detail.problemCategory ?? '',
                                  ticketId: detail.name??'',
                                  subject: detail.subject ?? '',
                                  description: detail.description ?? '',
                                  image: detail.attachmentUrl ?? '',
                                  date: '${detail.postingDate ?? ''} . ${_formatTime(detail.postingTime)}',
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      )]  ,
    );
  }
  String _formatTime(String? time) {
    if (time == null || time.isEmpty) return '';
    // "10:46:53.956419" → "10:46 AM/PM"
    final parts = time.split(':');
    if (parts.length < 2) return time;
    final hour = int.tryParse(parts[0]) ?? 0;
    final minute = parts[1];
    final period = hour >= 12 ? 'PM' : 'AM';
    final hour12 = hour > 12 ? hour - 12 : hour == 0 ? 12 : hour;
    return '$hour12:$minute $period';
  }
  Widget _responseCard({
    required String status,
    required String remark,
    required String date,

  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(widget.dimens.k14),
      decoration: BoxDecoration(color: _statusBgColor(status),
      borderRadius: BorderRadius.circular(widget.dimens.k5)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Response",
                style: TextStyle(
                  fontSize: widget.dimens.k18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              Row(
                children: [
                  Text(
                    date,
                    style: TextStyle(
                      fontSize: widget.dimens.k12,
                      color: Colors.grey,
                    ),),
                  //   Text(
                  //   '. $time',
                  //   style: TextStyle(
                  //     fontSize: widget.dimens.k12,
                  //     color: Colors.grey,
                  //   ),
                  // ),
                ],
              ),
            ],
          ),

          widget.dimens.k18.verticalBoxPadding,

          Row(
            children: [
              Text(
                "Status",
                style: TextStyle(
                  fontSize: widget.dimens.k14,
                  color: Colors.grey,
                ),
              ),
              const Spacer(),
              _statusBadge(status),
            ],
          ),

          widget.dimens.k18.verticalBoxPadding,

          Text(
            "Remark:",
            style: TextStyle(fontSize: widget.dimens.k14, color: Colors.grey),
          ),

          widget.dimens.k5.verticalBoxPadding,

          Text(
            remark,
            style: TextStyle(
              fontSize: widget.dimens.k16,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
        ],
      ),
    );
  }

  Widget _submissionCard({
    required String problemType,
    required String ticketId,
    required String subject,
    required String description,
    required String image,
    required String date,
  }) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(widget.dimens.k14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(widget.dimens.k30),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Submission",
                style: TextStyle(
                  fontSize: widget.dimens.k18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              Text(
                date,
                style: TextStyle(
                  fontSize: widget.dimens.k12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),
          widget.dimens.k18.verticalBoxPadding,
          Row(
            children: [
              Text(
                "Ticket ID",
                style: TextStyle(
                  fontSize: widget.dimens.k18,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const Spacer(),
              Text(
                ticketId,
                style: TextStyle(
                  fontSize: widget.dimens.k12,
                  color: Colors.grey,
                ),
              ),
            ],
          ),

          widget.dimens.k18.verticalBoxPadding,
          _detailItem(title: "Problem Type:", value: problemType),

          widget.dimens.k18.verticalBoxPadding,
          _detailItem(title: "Subject:", value: subject),

          widget.dimens.k18.verticalBoxPadding,
          _detailItem(title: "Description:", value: description),

          widget.dimens.k20.verticalBoxPadding,

          /// Image — only show if not empty
          if (image.isNotEmpty)
            GestureDetector(
              onTap: () => _showImagePreview(image),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(widget.dimens.k14),
                child: Image.network(
                  image,
                  width: double.infinity,
                  height: widget.dimens.k180,
                  fit: BoxFit.cover,
                ),
              ),
            ),
        ],
      ),
    );
  }

  Widget _detailItem({required String title, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(fontSize: widget.dimens.k14, color: Colors.grey),
        ),
        widget.dimens.k5.verticalBoxPadding,
        Text(
          value,
          style: TextStyle(
            fontSize: widget.dimens.k16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
      ],
    );
  }

  Widget _statusBadge(String status) {
    Color bgColor;
    Color textColor;

    switch (status) {
      case 'In Review':
        bgColor = ColorManager.white;
        textColor = ColorManager.inReview;
        break;
      case 'Rejected':
        bgColor = ColorManager.white;
        textColor = ColorManager.rejectedText;
        break;
      case 'Pending':
        bgColor = ColorManager.white;
        textColor = ColorManager.progressText;
        break;
      case 'Resolved':
      default:
        bgColor = ColorManager.white;
        textColor = ColorManager.progressText;
        break;
    }

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: widget.dimens.k10,
        vertical: widget.dimens.k4,
      ),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(widget.dimens.k20),
      ),
      child: Text(
        status,
        style: TextStyle(
          fontSize: widget.dimens.k11,
          fontWeight: FontWeight.w500,
          color: textColor,
        ),
      ),
    );
  }

  Color _statusBgColor(String status) {
    switch (status) {
      case 'Rejected':
        return ColorManager.rejectedBg;
      case 'Pending':
        return ColorManager.progressBg;
      case 'In Review':
        return ColorManager.approveBg;
      case 'Resolved':
      default:
        return ColorManager.approveBg;
    }
  }

  void _showImagePreview(String imageUrl) {
    final size = MediaQuery.of(context).size;
    showDialog(
      context: context,
      barrierColor: Colors.black.withOpacity(.50),
      builder: (_) {
        return Dialog(
          backgroundColor: Colors.transparent,
          insetPadding: EdgeInsets.symmetric(
            horizontal: widget.dimens.k16,
            vertical: widget.dimens.k24,
          ),
          child: SizedBox(
            height: size.height * 0.80,
            width: size.width,
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(widget.dimens.k16),
                  child: SizedBox.expand(
                    child: Image.network(imageUrl, fit: BoxFit.cover),
                  ),
                ),
                Positioned(
                  top: widget.dimens.k10,
                  right: widget.dimens.k10,
                  child: GestureDetector(
                    onTap: () => Navigator.pop(context),
                    child: Container(
                      padding: EdgeInsets.all(widget.dimens.k6),
                      decoration: const BoxDecoration(
                        color: Colors.black54,
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.close,
                        color: Colors.white,
                        size: widget.dimens.k20,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  @override
  onError(String error) {
    // handle error (e.g. show snackbar)
  }

  @override
  onSuccess(result) {
    // success callback — data is already set in provider
  }
}