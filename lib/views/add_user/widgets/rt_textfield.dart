import 'package:flutter/material.dart';

import '../../../utils/utils.dart';

class RtTextField extends StatefulWidget {
  final TextEditingController controller;
  final bool isEdit;

  const RtTextField(
      {super.key, required this.controller, required this.isEdit});

  @override
  State<RtTextField> createState() => _RtTextFieldState();
}

class _RtTextFieldState extends State<RtTextField> {
  ScrollController? rtController;
  ScrollController? rwController2;

  int selectedRt = 0;
  int selectedRw = 0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 0),
              child: SizedBox(
                width: 90,
                child: Text(
                  "Rt / Rw",
                  textAlign: TextAlign.start,
                  style: FontsUtils.poppins(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: InkWell(
              onTap: () {
                if (!widget.isEdit) return;

                debugPrint("asdsa");
                showGeneralDialog(
                    context: context,
                    barrierLabel: "rt",
                    barrierDismissible: true,
                    barrierColor: Colors.black54,
                    transitionDuration: const Duration(milliseconds: 300),
                    transitionBuilder: (_, anim, __, child) {
                      return SlideTransition(
                        position: Tween(
                                begin: const Offset(0, 1),
                                end: const Offset(0, 0))
                            .animate(anim),
                        child: child,
                      );
                    },
                    pageBuilder: (_, __, ___) => Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Container(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 12, vertical: 20),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                    top: Radius.circular(20)),
                              ),
                              child: Material(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    DateTimeSlider(
                                      controller: rtController,
                                      text: "RT",
                                      length: 18,
                                      onChanged: (int value) {
                                        setState(() {
                                          selectedRt = (value + 1);
                                        });
                                      },
                                      plus: 1,
                                      selectedItem: selectedRt,
                                    ),
                                    DateTimeSlider(
                                      controller: rwController2,
                                      text: "RW",
                                      length: 18,
                                      onChanged: (int value) {
                                        setState(() {
                                          selectedRw = (value + 1);
                                        });
                                      },
                                      plus: 1,
                                      selectedItem: selectedRw,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        )).then((value) {
                  debugPrint("rt: $selectedRt");
                  debugPrint("rw: $selectedRw");
                  widget.controller.text =
                      "${selectedRt.toString().padLeft(3, '0')}/${selectedRw.toString().padLeft(3, '0')}";
                });
              },
              child: SizedBox(
                height: 46,
                child: TextFormField(
                  controller: widget.controller,
                  style: FontsUtils.poppins(
                      fontSize: 14, fontWeight: FontWeight.normal),
                  decoration: InputDecoration(
                    hintText: "Pilih Rt/Rw",
                    isDense: true,
                    enabled: false,
                    contentPadding: const EdgeInsets.fromLTRB(10, 10, 0, 10),
                    border: const OutlineInputBorder(),
                    focusedBorder: const OutlineInputBorder(),
                    enabledBorder: const OutlineInputBorder(),
                    disabledBorder:
                        widget.isEdit ? const OutlineInputBorder() : null,
                    suffixIcon: const Icon(
                      Icons.arrow_drop_down_outlined,
                      size: 25,
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DateTimeSlider extends StatelessWidget {
  final int selectedItem;
  final int length;
  final int plus;
  final ValueChanged<int> onChanged;
  final ScrollController? controller;
  final String text;
  const DateTimeSlider({
    Key? key,
    required this.selectedItem,
    required this.length,
    required this.plus,
    required this.onChanged,
    this.text = "",
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(text,
            style: FontsUtils.poppins(
              fontSize: 16,
              color: Colors.black,
              fontWeight: FontWeight.bold,
            )),
        const SizedBox(height: 20),
        Stack(
          alignment: Alignment.center,
          children: [
            Container(
              height: 50,
              width: 70,
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                border: Border(
                  top: BorderSide(width: 2, color: Colors.black),
                  bottom: BorderSide(width: 2, color: Colors.black),
                ),
              ),
            ),
            SizedBox(
              height: 150,
              width: 100,
              child: ListWheelScrollView.useDelegate(
                // controller: controller,
                controller: controller,
                itemExtent: 40,
                diameterRatio: 4,
                perspective: 0.01,
                squeeze: .7,
                physics: const FixedExtentScrollPhysics(),
                onSelectedItemChanged: (index) {
                  onChanged(index);
                },
                childDelegate: ListWheelChildLoopingListDelegate(
                  children: List<Widget>.generate(
                    length,
                    (index) => Center(
                      child: Text(
                        '${index + plus}',
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                              fontSize: 16,
                              color: selectedItem == (index + plus)
                                  ? Colors.black
                                  : Colors.grey,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
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
