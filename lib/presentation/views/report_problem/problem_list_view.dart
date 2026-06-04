import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/base/base_widget.dart';
import 'package:ideal_marriage_bureau/presentation/views/report_problem/report_problem_view_model.dart';
import 'package:provider/provider.dart';

import '../../../application/app_theme/color_scheme.dart';
import '../../../application/common/enum.dart';
import '../../../application/core/result.dart';
import '../../../application/network/result.dart';
import '../../../application/routes/route_generator.dart';
import '../../../data/models/report_problem_model/problem_list_model.dart';
import '../../../widgets/toast.dart';

class ProblemListView extends BaseStateFullWidget {
  ProblemListView({super.key});

  @override
  State<ProblemListView> createState() => _ProblemListViewState();
}

class _ProblemListViewState extends State<ProblemListView> implements Result {
  bool isSearchVisible = false;
  final TextEditingController searchController = TextEditingController();
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GetReportProblem>().getProblemList(this, searchName: '');
    });
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          _background(),
          SafeArea(
            child: Column(
              children: [
                widget.dimens.k10.verticalBoxPadding,
                _header(),
                widget.dimens.k10.verticalBoxPadding,
                if (isSearchVisible) _searchField(),
                widget.dimens.k40.verticalBoxPadding,
                Expanded(
                  child: Consumer<GetReportProblem>(
                    builder: (context, provider, _) {
                      // Loading state
                      if (provider.apiResponse is Loading) {
                        return const Center(child: CircularProgressIndicator());
                      }

                      // All problems from provider
                      final allProblems =
                          provider.problemListModel?.problemListData ?? [];

                      // ✅ Filter applied inline inside Consumer
                      final List<ProblemListData> items = searchQuery.isEmpty
                          ? allProblems
                          : allProblems.where((problem) {
                        final subject =
                        (problem.subject ?? "").toLowerCase();
                        final name = (problem.name ?? "").toLowerCase();
                        return subject.contains(
                            searchQuery.toLowerCase()) ||
                            name.contains(searchQuery.toLowerCase());
                      }).toList();

                      // Empty state
                      if (items.isEmpty) {
                        return Center(
                          child: Text(
                            "No problems found",
                            style: TextStyle(
                              fontSize: widget.dimens.k14,
                              color: ColorManager.textColorSubTitle,
                            ),
                          ),
                        );
                      }

                      // List
                      return SingleChildScrollView(
                        padding: EdgeInsets.symmetric(
                          horizontal: widget.dimens.k18,
                        ),
                        child: Column(
                          children: items.map((item) {
                            return Padding(
                              padding:
                              EdgeInsets.only(bottom: widget.dimens.k12),
                              child: Container(
                                width: double.infinity,
                                padding: EdgeInsets.all(widget.dimens.k16),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(
                                      widget.dimens.k15),
                                  border: Border.all(
                                    color: Colors.grey.shade200,
                                    width: 1,
                                  ),
                                ),
                                child: _problemListTile(item),
                              ),
                            );
                          }).toList(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _searchField() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.dimens.k18),
      child: TextField(
        controller: searchController,
        onChanged: (value) {
          setState(() {
            searchQuery = value;
          });
        },
        decoration: InputDecoration(
          hintText: "Search problems...",
          filled: true,
          fillColor: Colors.white,
          suffixIcon: Icon(Icons.search, size: widget.dimens.k25),
          contentPadding: EdgeInsets.symmetric(
            vertical: widget.dimens.k15,
            horizontal: widget.dimens.k20,
          ),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
          disabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(50),
            borderSide: const BorderSide(color: Colors.transparent),
          ),
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: widget.dimens.k16),
      child: Row(
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
                  style: TextStyle(
                    color: ColorManager.rejectedText,
                    fontSize: widget.dimens.k16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          const Spacer(),
          Text(
            "Problem List",
            style: TextStyle(
              fontSize: widget.dimens.k18,
              fontWeight: FontWeight.w600,
              color: Colors.black87,
            ),
          ),
          const Spacer(),
          GestureDetector(
            onTap: () {
              setState(() {
                isSearchVisible = !isSearchVisible;
                searchController.clear();
                searchQuery = "";
              });
            },
            child: SizedBox(
              width: widget.dimens.k40,
              child: Align(
                alignment: Alignment.centerRight,
                child: CircleAvatar(
                  backgroundColor: ColorManager.primary.withOpacity(.2),
                  radius: widget.dimens.k16,
                  child: Icon(
                    isSearchVisible ? Icons.close : Icons.search,
                    color: ColorManager.primary,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _problemListTile(ProblemListData item) {
    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          RouteManager.rProblemDetails,
          arguments: item.name,
        );
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: widget.dimens.k12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    item.subject ?? '',
                    style: TextStyle(
                      fontSize: widget.dimens.k15,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  widget.dimens.k4.verticalBoxPadding,
                  Text(
                    item.name ?? '',
                    style: TextStyle(
                      fontSize: widget.dimens.k13,
                      color: ColorManager.textColorSubTitle,
                    ),
                  ),
                  widget.dimens.k4.verticalBoxPadding,
                  Row(
                    children: [
                      Text(
                        "Priority: ",
                        style: TextStyle(
                          fontSize: widget.dimens.k13,
                          color: ColorManager.textColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        item.priority ?? '',
                        style: TextStyle(
                          fontSize: widget.dimens.k13,
                          color: ColorManager.textColorSubTitle,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                _statusBadge(item.status ?? ''),
                widget.dimens.k6.verticalBoxPadding,
                Text(
                  item.creation ?? '',
                  style: TextStyle(
                    fontSize: widget.dimens.k11,
                    color: ColorManager.textColorSubTitle,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _statusBadge(String status) {
    Color bgColor;
    Color textColor;

    switch (status) {
      case 'In Review':
        bgColor = ColorManager.approveBg;
        textColor = ColorManager.inReview;
        break;
      case 'Rejected':
        bgColor = ColorManager.rejectedBg;
        textColor = ColorManager.rejectedText;
        break;
      case 'Pending':
        bgColor = ColorManager.progressBg;
        textColor = ColorManager.progressText;
        break;
      case 'Resolved':
      default:
        bgColor = ColorManager.progressBg;
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

  @override
  onError(String error) {
    MyToast.showToast(message: error, typeToast: TypeToast.error);
  }

  @override
  onSuccess(result) {
    MyToast.showToast(
      message: result.toString(),
      typeToast: TypeToast.success,
    );
  }
}