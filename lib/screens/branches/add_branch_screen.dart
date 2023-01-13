// ignore_for_file: use_build_context_synchronously

import 'dart:io';

import 'package:cargo/helpers/my_loader.dart';
import 'package:cargo/models/branch_model.dart';
import 'package:cargo/providers/branch_provider.dart';
import 'package:cargo/theme/app_theme.dart';
import 'package:cargo/theme/custom_theme.dart';
import 'package:cargo/widgets/my_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutx/flutx.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:media_picker_widget/media_picker_widget.dart';
import 'package:provider/provider.dart';

class AddBranchScreen extends StatefulWidget {
  const AddBranchScreen({Key? key}) : super(key: key);

  @override
  _AddBranchScreenState createState() => _AddBranchScreenState();
}

class _AddBranchScreenState extends State<AddBranchScreen> {
  late CustomTheme customTheme;
  late ThemeData theme;
  String? phoneNumber;

  String? emailAdress;

  String? destinaton;
  String? branchAdress;

  String? managerId;

  String? branchName;
  String? managerName;
  String? country;
  String? region;
  File? image;
  List<Media> mediaList = [];
  bool isLoading = false;
  int selectedIndex = 0;

  List<Map<String, dynamic>> countries = [
    {
      'country': 'Kenya',
      'regions': [
        'Nairobi',
        'Mombasa',
        'Nakuru',
        'Eldoret',
        'Kisumu',
      ]
    },
    {
      'country': 'China',
      'regions': [
        'Guangzhou',
        'Yiwu',
      ]
    },
    {
      'country': 'Quatar',
      'regions': [
        'Dubai',
      ]
    },
    {
      'country': 'Turkey',
      'regions': [
        'Istanbul',
      ]
    },
    {
      'country': 'India',
      'regions': [
        'Mumbai',
      ],
    },
    {
      'country': 'United Kingdom',
      'regions': [
        'London',
      ],
    }
  ];

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
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(
              Icons.arrow_back_ios,
              size: 18,
              color: theme.colorScheme.onBackground,
            ),
          ),
          title: FxText.titleMedium("Add Branch", fontWeight: 600),
        ),
        body: ListView(padding: FxSpacing.nTop(20), children: <Widget>[
          FxText.bodyLarge("General information",
              fontWeight: 600, letterSpacing: 0),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              MyDropDown(
                selectedOption: (val) {
                  final all =
                      countries.map((e) => e['country'].toString()).toList();
                  setState(() {
                    selectedIndex = all.indexOf(val);
                    country = val;
                  });
                },
                hintText: "Select country",
                options: countries.map((e) => e['country'].toString()).toList(),
              ),
              if (country != null)
                MyDropDown(
                  selectedOption: (val) {
                    setState(() {
                      region = val;
                    });
                  },
                  hintText: "Select region",
                  options: countries[selectedIndex]['regions'],
                ),
              Container(
                margin: const EdgeInsets.only(top: 14, bottom: 0),
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
                          branchName = val;
                        });
                      },
                      style: FxTextStyle.titleSmall(
                          letterSpacing: 0,
                          color: theme.colorScheme.onBackground,
                          fontWeight: 500),
                      decoration: InputDecoration(
                        hintText: "Branch Name",
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
                      style: FxTextStyle.titleSmall(
                          letterSpacing: 0,
                          color: theme.colorScheme.onBackground,
                          fontWeight: 500),
                      decoration: InputDecoration(
                        hintText: "Address",
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
                        contentPadding: const EdgeInsets.all(0),
                      ),
                      keyboardType: TextInputType.name,
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 16),
                    child: TextFormField(
                      onChanged: (val) {
                        setState(() {
                          phoneNumber = val;
                        });
                      },
                      style: FxTextStyle.titleSmall(
                          letterSpacing: 0,
                          color: theme.colorScheme.onBackground,
                          fontWeight: 500),
                      decoration: InputDecoration(
                        hintText: "Phone Number",
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
                      style: FxTextStyle.titleSmall(
                          letterSpacing: 0,
                          color: theme.colorScheme.onBackground,
                          fontWeight: 500),
                      decoration: InputDecoration(
                        hintText: "Email Address",
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
                            const Text('Cover Image'),
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
                      style: FxTextStyle.titleSmall(
                          letterSpacing: 0,
                          color: theme.colorScheme.onBackground,
                          fontWeight: 500),
                      decoration: InputDecoration(
                        hintText: "Manager Name",
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
                      style: FxTextStyle.titleSmall(
                          letterSpacing: 0,
                          color: theme.colorScheme.onBackground,
                          fontWeight: 500),
                      decoration: InputDecoration(
                        hintText: " Manager ID",
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
                    margin: const EdgeInsets.only(top: 24),
                    child: Center(
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius:
                              const BorderRadius.all(Radius.circular(4)),
                          boxShadow: [
                            BoxShadow(
                              color: theme.colorScheme.primary.withAlpha(28),
                              blurRadius: 4,
                              offset: const Offset(0, 1),
                            ),
                          ],
                        ),
                        child: ElevatedButton(
                          onPressed: image == null
                              ? null
                              : () async {
                                  setState(() {
                                    isLoading = true;
                                  });
                                  final branch = BranchModel(
                                    name: branchName,
                                    managerName: managerName,
                                    managerId: managerId,
                                    email: emailAdress,
                                    imageFile: image,
                                    phoneNumber: phoneNumber,
                                    address: branchAdress,
                                    country: country,
                                    region: region,
                                  );

                                  await Provider.of<BranchProvider>(context,
                                          listen: false)
                                      .addBranch(branch);
                                  setState(() {
                                    isLoading = false;
                                  });
                                  Navigator.of(context).pop();

                                  ScaffoldMessenger.of(context)
                                      .showSnackBar(const SnackBar(
                                    content: Text(
                                        'Branch details successfully added'),
                                  ));
                                },
                          style: ButtonStyle(
                              padding: MaterialStateProperty.all(
                                  FxSpacing.xy(16, 0))),
                          child: isLoading
                              ? const MyLoader()
                              : FxText.bodyMedium("Add Branch",
                                  fontWeight: 600,
                                  color: theme.colorScheme.onPrimary),
                        ),
                      ),
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
