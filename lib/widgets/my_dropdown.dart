import 'package:cargo/constants.dart';
import 'package:flutter/material.dart';

class MyDropDown extends StatefulWidget {
  const MyDropDown(
      {Key? key, this.hintText, required this.selectedOption, this.options})
      : super(key: key);
  final String? hintText;
  final List<String>? options;
  final Function(String option) selectedOption;

  @override
  State<MyDropDown> createState() => _MyDropDownState();
}

class _MyDropDownState extends State<MyDropDown> {
  String? optionSelected;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showModalBottomSheet(
            isScrollControlled: true,
            backgroundColor: Colors.transparent,
            context: context,
            builder: (ctx) {
              widget.options!.sort();
              return DropDownOptions(
                options: widget.options,
                hintText: widget.hintText,
                selectedOption: (val) {
                  setState(() {
                    optionSelected = val;
                    widget.selectedOption(val);
                  });
                },
              );
            });
      },
      child: Container(
          margin: const EdgeInsets.symmetric(vertical: 10),
          height: 40,
          padding: const EdgeInsets.only(left: 15, right: 10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(3),
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
          ),
          alignment: Alignment.centerLeft,
          child: Row(
            children: [
              Text(
                optionSelected == null ? widget.hintText! : optionSelected!,
                style: TextStyle(
                    color: optionSelected == null ? Colors.grey : Colors.black,
                    fontSize: 12),
              ),
              const Spacer(),
              const Icon(
                Icons.arrow_drop_down,
                color: Colors.grey,
                size: 18,
              )
            ],
          )),
    );
  }
}

class DropDownOptions extends StatelessWidget {
  const DropDownOptions(
      {Key? key, this.options, this.hintText, this.selectedOption})
      : super(key: key);
  final List<String>? options;
  final String? hintText;
  final Function(String option)? selectedOption;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => Navigator.of(context).pop(),
        child: GestureDetector(
            onTap: () {},
            child: DraggableScrollableSheet(
                initialChildSize: 0.3,
                maxChildSize: 0.8,
                minChildSize: 0.1,
                builder: (ctx, controller) => AnimatedContainer(
                    duration: const Duration(milliseconds: 500),
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).scaffoldBackgroundColor,
                        borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20)),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(20),
                                    topRight: Radius.circular(20)),
                              ),
                              width: double.infinity,
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 10),
                              margin: const EdgeInsets.only(bottom: 2),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Container(
                                      width: 70,
                                      height: 5,
                                      decoration: BoxDecoration(
                                          color: Colors.blueGrey[100],
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                  ),
                                  const SizedBox(height: 22),
                                  Text(
                                    hintText!,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w500,
                                        color: kPrimaryColor),
                                  ),
                                ],
                              )),
                          Expanded(
                            child: ListView(
                              controller: controller,
                              children: List.generate(
                                options!.length,
                                (index) => GestureDetector(
                                  onTap: () {
                                    selectedOption!(options![index]);
                                    Navigator.of(context).pop();
                                  },
                                  child: Container(
                                    color: Colors.white,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 18),
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 1),
                                    child: Text(options![index]),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    )))));
  }
}
