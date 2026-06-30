import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:ideal_marriage_bureau/application/core/extensions/extensions.dart';
import 'package:ideal_marriage_bureau/data/models/report_problem_model/problem_type_model.dart';
import 'package:ideal_marriage_bureau/presentation/views/report_problem/report_problem_view_model.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';

import '../../../application/app_theme/color_scheme.dart';
import '../../../application/common/enum.dart';
import '../../../application/core/result.dart';
import '../../../application/helper/validators.dart';
import '../../../application/network/result.dart';
import '../../../application/routes/route_generator.dart';
import '../../../base/base_widget.dart';
import '../../../constants/asset_manager.dart';
import '../../../widgets/custom_dailogBox.dart';
import '../../../widgets/custom_drop_down.dart';
import '../../../widgets/custom_field.dart';
import '../../../widgets/loader.dart';
import '../../../widgets/primary_button.dart';
import '../../../widgets/toast.dart';

class ReportProblemView extends BaseStateFullWidget {
  ReportProblemView({super.key});

  @override
  State<ReportProblemView> createState() => _ReportProblemViewState();
}

class _ReportProblemViewState extends State<ReportProblemView>
    implements ErrorResult,  Result<String>{
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController subjectController = TextEditingController();

  final TextEditingController descriptionController = TextEditingController();



  String? selectedProblemType;
  late ProblemType newDocVM;

  String? selectedFileName;
  final ImagePicker _picker = ImagePicker();
  File? _selectedImage;
  String attachmentBase64 = '';


  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<GetReportProblem>().getProblemTypes(this);


    });
  }
  Future<void> _pickImageFromGallery() async {
    final pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {

      final compressed = File(pickedFile.path);
      setState(() {
        _selectedImage = compressed;

      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: true,
      body: Consumer<GetReportProblem>(
        builder: (context, provider, child) {
          return provider.apiResponse is Loading
              ?  Center(child: Loader())
              : Stack(

            children: [
              _background(),
              SafeArea(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: widget.dimens.k18,
                    vertical: widget.dimens.k16,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
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
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Center(
                              child: Text(
                                "Report a Problem",
                                style: context.textTheme.titleMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  fontSize: widget.dimens.k18,
                                  color: ColorManager.textColor,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: widget.dimens.k40),
                        ],
                      ),

                      widget.dimens.k30.verticalBoxPadding,

                      /// Main Content
                      Expanded(
                        child: SingleChildScrollView(
                          child: Container(
                            padding: EdgeInsets.all(widget.dimens.k5),
                            child: Form(
                              key: formKey,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Problem Type",
                                    style: context.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: ColorManager.fieldHintColor,
                                    ),
                                  ),

                                  widget.dimens.k10.verticalBoxPadding,

                                  /// ✅ Problem Type Dropdown
                                  CustomDropDown<String>(
                                    list: provider.problemTypeModel.problemCategory
                                        ?.map((e) => e.name ?? '')
                                        .toList() ??
                                        [],
                                    selectedItem: selectedProblemType,
                                    hintText: "Select Problem Type",
                                    onChanged: (val) =>
                                        setState(() => selectedProblemType = val),
                                  ),

                                  widget.dimens.k10.verticalBoxPadding,

                                  Text(
                                    "Subject",
                                    style: context.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: ColorManager.fieldHintColor,
                                    ),
                                  ),

                                  widget.dimens.k8.verticalBoxPadding,

                                  CustomField(
                                    hintText: "Enter here",
                                    keyboardType: TextInputType.text,
                                    controller: subjectController,
                                    maxLines: 1,
                                    validator: (i) => AppValidators.fieldValidator(i),
                                  ),

                                  widget.dimens.k10.verticalBoxPadding,

                                  Text(
                                    "Description",
                                    style: context.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w500,
                                      color: ColorManager.fieldHintColor,
                                    ),
                                  ),

                                  widget.dimens.k8.verticalBoxPadding,

                                  CustomField(
                                    hintText: "Enter here",
                                    keyboardType: TextInputType.text,
                                    controller: descriptionController,
                                    maxLines: 4,
                                    validator: (i) => AppValidators.fieldValidator(i),
                                  ),

                                  widget.dimens.k18.verticalBoxPadding,

                                  /// Add Document
                                  GestureDetector(
                                    onTap: () => _pickImageFromGallery(),
                                    child: Container(
                                      width: double.infinity,
                                      height: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.transparent,
                                        borderRadius: BorderRadius.circular(widget.dimens.k12),
                                        border: Border.all(color: Colors.grey.shade300),
                                        image: _selectedImage != null
                                            ? DecorationImage(
                                          image: FileImage(_selectedImage!),
                                          fit: BoxFit.cover,
                                        )
                                            : null,
                                      ),
                                      child: _selectedImage != null
                                          ? ClipRRect(
                                        borderRadius: BorderRadius.circular(widget.dimens.k12),
                                        child: Stack(
                                          children: [
                                            // Dark overlay
                                            Container(color: Colors.black.withOpacity(0.3)),

                                            // Preview button
                                            GestureDetector(
                                              onTap: () => _showImagePreview(_selectedImage!), // ← preview
                                              child: Container(
                                                padding: EdgeInsets.symmetric(
                                                  horizontal: widget.dimens.k16,
                                                  vertical: widget.dimens.k8,
                                                ),
                                                decoration: BoxDecoration(

                                                  borderRadius: BorderRadius.circular(widget.dimens.k20),
                                                ),

                                              ),
                                            ),
                                          ],
                                        ),
                                      )
                                          : Column(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Image.asset(
                                            Assets.image,
                                            width: widget.dimens.k15,
                                            height: widget.dimens.k15,
                                          ),
                                          widget.dimens.k8.verticalBoxPadding,
                                          Text(
                                            selectedFileName ?? "Add Document",
                                            style: context.textTheme.bodyMedium?.copyWith(
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),

                                //  widget.dimens.k5.verticalBoxPadding,
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [

                                      /// Left Content
                                      // Expanded(
                                      //   child: Column(
                                      //     mainAxisSize: MainAxisSize.min,
                                      //     children: [
                                      //       if (_selectedImage == null) ...[
                                      //         Image.asset(
                                      //           Assets.image,
                                      //           width: widget.dimens.k15,
                                      //           height: widget.dimens.k15,
                                      //         ),
                                      //
                                      //         widget.dimens.k8.verticalBoxPadding,
                                      //
                                      //         Text(
                                      //           selectedFileName ?? "Add Document",
                                      //           style: context.textTheme.bodyMedium?.copyWith(
                                      //             color: Colors.grey,
                                      //           ),
                                      //         ),
                                      //       ] else ...[
                                      //         Text(
                                      //           selectedFileName ?? "Selected Image",
                                      //           style: context.textTheme.bodyMedium?.copyWith(
                                      //             color: Colors.white,
                                      //             fontWeight: FontWeight.w600,
                                      //           ),
                                      //         ),
                                      //       ],
                                      //     ],
                                      //   ),
                                      // ),

                                      /// ✅ Remove Button at Row End
                                      if (_selectedImage != null)
                                        ElevatedButton(
                                          onPressed: () {
                                            setState(() {
                                              _selectedImage = null;
                                              selectedFileName = null;
                                            });
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor: ColorManager.rejectedText,
                                            padding: EdgeInsets.symmetric(
                                              horizontal: widget.dimens.k12,
                                              vertical: widget.dimens.k10,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                              BorderRadius.circular(widget.dimens.k20
                                              ),
                                            ),
                                          ),
                                          child: const Text(
                                            "Remove Image",
                                            style: TextStyle(color: Colors.white),
                                          ),
                                        ),
                                    ],
                                  ),
                                  /// Submit Button
                                  widget.dimens.k40.verticalBoxPadding,
                                  PrimaryButton(
                                    childText: "Submit",
                                    isSafeArea: false,
                                    onPressed: () async {
                                      if (formKey.currentState!.validate()) {
                                        if (selectedProblemType == null) {
                                          MyToast.showToast(
                                            message: "Please select a problem type",
                                            typeToast: TypeToast.error,
                                          );
                                          return;
                                        }

                                        if (_selectedImage != null) {
                                          final bytes = await File(_selectedImage!.path).readAsBytes();
                                          attachmentBase64 = base64Encode(bytes);
                                        }

                                        final data = {
                                          "subject": subjectController.text.trim(),
                                          "problem_category": selectedProblemType ?? '',
                                          "description": descriptionController.text.trim(),
                                          "attachment":attachmentBase64,
                                        };

                                        context.read<GetReportProblem>().createReportProblem(data,this);
                                      }
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
  void _onControllerChanged() {
    if (!mounted) return; // ✅ guard against disposed state
    setState(() {
      // your logic here
    });
  }

  @override
  void dispose() {
    subjectController.dispose();
    descriptionController.dispose();
    // ✅ remove listener
    super.dispose();
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
  void _showImagePreview(File imageFile) {
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
                    child: Image.file(imageFile, fit: BoxFit.cover), // ← Image.file
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
  void _resetForm() {
    setState(() {
      selectedProblemType = null;
      _selectedImage = null;
      selectedFileName = null;
      attachmentBase64 = '';
    });
    subjectController.clear();
    descriptionController.clear();
  }
  @override
  onError(String error) {
   // MyToast.showToast(message: error, typeToast: TypeToast.error);
    showCustomStatusDialog(
      context: context,
      barrierDismissible: false ,
      dimens: widget.dimens,
      icon: Assets.error,
      title: "Not report submitted ",
      description:
      "Your report is not submitted. input\n required fields are missing",
      buttonText: "Retry",
      buttonColor: ColorManager.rejectedText,
      onPressed: () {
        Navigator.pop(context);
      },
    );
  }
  @override
  onSuccess(result) {
    // MyToast.showToast(
    //   message: result.toString(),
    //   typeToast: TypeToast.success,
    // );
    _resetForm();
    showCustomStatusDialog(
      barrierDismissible: false,
      context: context,
      dimens: widget.dimens,
      icon: Assets.success,
      title: "Report submitted \n successfully 🎉",
      description:
      "We will get back to you shortly.",
      buttonText: "Done",
      onPressed: () {

        /// Close Dialog
        Navigator.pop(context);

        /// Navigate
        Navigator.pushReplacementNamed(
          context,
          RouteManager.rProfileScreen,
        );
      },
    );
  }
}
