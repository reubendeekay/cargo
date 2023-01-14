import 'dart:io';

import 'package:cargo/helpers/my_loader.dart';
import 'package:cargo/models/branch_model.dart';
import 'package:cargo/providers/branch_provider.dart';
import 'package:cargo/theme/app_theme.dart';
import 'package:cargo/theme/custom_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:media_picker_widget/media_picker_widget.dart';
import 'package:provider/provider.dart';

class EditBranchScreen extends StatefulWidget {
  const EditBranchScreen({Key? key, required this.branch}) : super(key: key);
  final BranchModel branch;

  @override
  _EditBranchScreenState createState() => _EditBranchScreenState();
}

class _EditBranchScreenState extends State<EditBranchScreen> {
  late CustomTheme customTheme;
  late ThemeData theme;
  String? phoneNumber;

  String? emailAdress;

  String? destinaton;
  String? branchAdress;

  String? managerId;

  String? branchName;
  String? managerName;
  File? image;
  List<Media> mediaList = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    customTheme = AppTheme.customTheme;
    theme = AppTheme.theme;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: theme.scaffoldBackgroundColor,
          elevation: 0.5,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back_ios,
              size: 18,
              color: theme.colorScheme.onBackground,
            ),
          ),
          title: FxText.titleMedium("Edit Branch", fontWeight: 600),
        ),
        body: ListView(padding: FxSpacing.nTop(15), children: <Widget>[
          const SizedBox(height: 15),
          FxText.bodyLarge("General information",
              fontWeight: 600, letterSpacing: 0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(top: 16),
                child: TextFormField(
                  onChanged: (val) {
                    setState(() {
                      branchName = val;
                    });
                  },
                  initialValue: widget.branch.name,
                  style: FxTextStyle.titleSmall(
                      letterSpacing: 0,
                      color: theme.colorScheme.onBackground,
                      fontWeight: 500),
                  decoration: InputDecoration(
                    labelText: "Branch Name",
                    hintStyle: FxTextStyle.titleSmall(
                        letterSpacing: 0,
                        color: theme.colorScheme.onBackground,
                        fontWeight: 500),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                        borderSide: BorderSide.none),
                    enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                        borderSide: BorderSide.none),
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                        borderSide: BorderSide.none),
                    filled: true,
                    fillColor: customTheme.card,
                    prefixIcon: const Icon(
                      MdiIcons.domain,
                      size: 22,
                    ),
                    isDense: true,
                    contentPadding: const EdgeInsets.all(0),
                  ),
                  keyboardType: TextInputType.emailAddress,
                  textCapitalization: TextCapitalization.sentences,
                ),
              ),
              Container(
                margin: const EdgeInsets.only(top: 12),
                child: TextFormField(
                  onChanged: (val) {
                    setState(() {
                      branchAdress = val;
                    });
                  },
                  maxLength: null,
                  maxLines: null,
                  initialValue: widget.branch.address,
                  style: FxTextStyle.titleSmall(
                      letterSpacing: 0,
                      color: theme.colorScheme.onBackground,
                      fontWeight: 500),
                  decoration: InputDecoration(
                    labelText: "Address",
                    hintStyle: FxTextStyle.titleSmall(
                        letterSpacing: 0,
                        color: theme.colorScheme.onBackground,
                        fontWeight: 500),
                    border: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                        borderSide: BorderSide.none),
                    enabledBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                        borderSide: BorderSide.none),
                    focusedBorder: const OutlineInputBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(4),
                        ),
                        borderSide: BorderSide.none),
                    filled: true,
                    fillColor: customTheme.card,
                    prefixIcon: const Icon(
                      MdiIcons.locationEnter,
                      size: 22,
                    ),
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(vertical: 10),
                  ),
                  keyboardType: TextInputType.name,
                ),
              ),
              InkWell(
                onTap: () {
                  openImagePicker(context);
                },
                child: Container(
                    margin: const EdgeInsets.only(top: 12),
                    child: Row(
                      children: [
                        CircleAvatar(
                            backgroundColor:
                                theme.colorScheme.primary.withAlpha(28),
                            child: const Icon(Icons.camera_alt_outlined)),
                        const SizedBox(
                          width: 10,
                        ),
                        const Text('Profile Image'),
                        const Spacer(),
                        Icon(
                          Icons.check_circle,
                          color: image == null
                              ? theme.colorScheme.primary.withAlpha(28)
                              : Colors.green,
                        )
                      ],
                    )),
              ),
              Container(
                margin: const EdgeInsets.only(top: 24, bottom: 0),
                child: FxText.bodyLarge("Branch information",
                    fontWeight: 600, letterSpacing: 0),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    child: TextFormField(
                      onChanged: (val) {
                        setState(() {
                          phoneNumber = val;
                        });
                      },
                      initialValue: widget.branch.phoneNumber,
                      style: FxTextStyle.titleSmall(
                          letterSpacing: 0,
                          color: theme.colorScheme.onBackground,
                          fontWeight: 500),
                      decoration: InputDecoration(
                        labelText: "Phone Number",
                        hintStyle: FxTextStyle.titleSmall(
                            letterSpacing: 0,
                            color: theme.colorScheme.onBackground,
                            fontWeight: 500),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                            borderSide: BorderSide.none),
                        enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                            borderSide: BorderSide.none),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                            borderSide: BorderSide.none),
                        filled: true,
                        fillColor: customTheme.card,
                        prefixIcon: const Icon(
                          MdiIcons.phone,
                          size: 22,
                        ),
                        isDense: true,
                        contentPadding: const EdgeInsets.all(0),
                      ),
                      keyboardType: TextInputType.phone,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    child: TextFormField(
                      onChanged: (val) {
                        setState(() {
                          emailAdress = val;
                        });
                      },
                      initialValue: widget.branch.email,
                      style: FxTextStyle.titleSmall(
                          letterSpacing: 0,
                          color: theme.colorScheme.onBackground,
                          fontWeight: 500),
                      decoration: InputDecoration(
                        labelText: "Email Address",
                        hintStyle: FxTextStyle.titleSmall(
                            letterSpacing: 0,
                            color: theme.colorScheme.onBackground,
                            fontWeight: 500),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                            borderSide: BorderSide.none),
                        enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                            borderSide: BorderSide.none),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                            borderSide: BorderSide.none),
                        filled: true,
                        fillColor: customTheme.card,
                        prefixIcon: const Icon(
                          MdiIcons.mail,
                          size: 22,
                        ),
                        isDense: true,
                        contentPadding: const EdgeInsets.all(0),
                      ),
                      keyboardType: TextInputType.emailAddress,
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 24),
                    child: FxText.bodyLarge("Management information",
                        fontWeight: 600, letterSpacing: 0),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    child: TextFormField(
                      onChanged: (val) {
                        setState(() {
                          managerName = val;
                        });
                      },
                      initialValue: widget.branch.managerName,
                      style: FxTextStyle.titleSmall(
                          letterSpacing: 0,
                          color: theme.colorScheme.onBackground,
                          fontWeight: 500),
                      decoration: InputDecoration(
                        labelText: "Manager Name",
                        hintStyle: FxTextStyle.titleSmall(
                            letterSpacing: 0,
                            color: theme.colorScheme.onBackground,
                            fontWeight: 500),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                            borderSide: BorderSide.none),
                        enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                            borderSide: BorderSide.none),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                            borderSide: BorderSide.none),
                        filled: true,
                        fillColor: customTheme.card,
                        prefixIcon: const Icon(MdiIcons.account),
                        isDense: true,
                        contentPadding: const EdgeInsets.all(0),
                      ),
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 12),
                    child: TextFormField(
                      onChanged: (val) {
                        setState(() {
                          managerId = val;
                        });
                      },
                      initialValue: widget.branch.managerId,
                      style: FxTextStyle.titleSmall(
                          letterSpacing: 0,
                          color: theme.colorScheme.onBackground,
                          fontWeight: 500),
                      decoration: InputDecoration(
                        labelText: " Manager ID",
                        hintStyle: FxTextStyle.titleSmall(
                            letterSpacing: 0,
                            color: theme.colorScheme.onBackground,
                            fontWeight: 500),
                        border: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                            borderSide: BorderSide.none),
                        enabledBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                            borderSide: BorderSide.none),
                        focusedBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(
                              Radius.circular(4),
                            ),
                            borderSide: BorderSide.none),
                        filled: true,
                        fillColor: customTheme.card,
                        prefixIcon: const Icon(MdiIcons.briefcaseOutline),
                        isDense: true,
                        contentPadding: const EdgeInsets.all(0),
                      ),
                      textCapitalization: TextCapitalization.sentences,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    width: double.infinity,
                    height: 48,
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.all(Radius.circular(4)),
                      boxShadow: [
                        BoxShadow(
                          color: theme.colorScheme.primary.withAlpha(28),
                          blurRadius: 4,
                          offset: const Offset(0, 1),
                        ),
                      ],
                    ),
                    child: ElevatedButton(
                      onPressed: () async {
                        setState(() {
                          isLoading = true;
                        });
                        final branch = BranchModel(
                          name: branchName ?? widget.branch.name,
                          managerName: managerName ?? widget.branch.managerName,
                          managerId: managerId ?? widget.branch.managerId,
                          email: emailAdress ?? widget.branch.email,
                          imageFile: image,
                          phoneNumber: phoneNumber ?? widget.branch.phoneNumber,
                          address: branchAdress ?? widget.branch.address,
                          imageUrl: widget.branch.imageUrl,
                          country: widget.branch.country,
                          region: widget.branch.region,
                        );

                        await Provider.of<BranchProvider>(context,
                                listen: false)
                            .editBranch(branch);
                        setState(() {
                          isLoading = false;
                        });
                        Navigator.of(context).pop();

                        ScaffoldMessenger.of(context)
                            .showSnackBar(const SnackBar(
                          content: Text('Branch details successfully edited'),
                        ));
                      },
                      child: isLoading
                          ? const MyLoader()
                          : FxText.bodyMedium("Edit Branch",
                              fontWeight: 600,
                              color: theme.colorScheme.onPrimary),
                      style: ButtonStyle(
                          padding:
                              MaterialStateProperty.all(FxSpacing.xy(16, 0))),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ]));
  }

  Future<void> openImagePicker(
    BuildContext context,
  ) async {
    // openCamera(onCapture: (image){
    //   setState(()=> mediaList = [image]);
    // });
    showModalBottomSheet(
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20)),
        ),
        context: context,
        builder: (context) {
          return GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () => Navigator.of(context).pop(),
              child: DraggableScrollableSheet(
                initialChildSize: 0.6,
                maxChildSize: 0.95,
                minChildSize: 0.6,
                builder: (ctx, controller) => AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    color: Colors.white,
                    child: MediaPicker(
                      scrollController: controller,
                      mediaList: mediaList,
                      onPick: (selectedList) {
                        setState(() => mediaList = selectedList);

                        image = mediaList.first.file;
                        mediaList.clear();

                        Navigator.pop(context);
                      },
                      onCancel: () => Navigator.pop(context),
                      mediaCount: MediaCount.single,
                      mediaType: MediaType.image,
                      decoration: PickerDecoration(
                        cancelIcon: const Icon(Icons.close),
                        albumTitleStyle: TextStyle(
                            color: Theme.of(context).iconTheme.color,
                            fontWeight: FontWeight.bold),
                        actionBarPosition: ActionBarPosition.top,
                        blurStrength: 2,
                        completeButtonStyle: const ButtonStyle(),
                        completeTextStyle:
                            TextStyle(color: Theme.of(context).iconTheme.color),
                        completeText: 'Select',
                      ),
                    )),
              ));
        });
  }
}
