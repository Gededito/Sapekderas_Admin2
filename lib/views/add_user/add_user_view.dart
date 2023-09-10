import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sapekderas/view_model/citizen/get_citizen/get_citizen_cubit.dart';

import '../../models/citizen_model.dart';
import '../../models/enums.dart';
import '../../routes/routes.dart';
import '../../utils/utils.dart';
import '../../view_model/citizen/add_citizen/add_citizen_cubit.dart';
import 'widgets/rt_textfield.dart';

class AddUserViewArgs {
  final CitizenModel? model;
  final Crud crud;

  const AddUserViewArgs({this.model, this.crud = Crud.create});
}

class AddUserView extends StatefulWidget {
  final AddUserViewArgs args;
  const AddUserView({super.key, required this.args});

  @override
  State<AddUserView> createState() => _AddUserViewState();
}

class _AddUserViewState extends State<AddUserView> {
  late TextEditingController kkController;
  late TextEditingController namaController;
  late TextEditingController nikController;
  late TextEditingController birthPlaceController;
  late TextEditingController jobController;
  late TextEditingController rtController;
  // late TextEditingController rwController;
  late TextEditingController addressController;
  late TextEditingController nationalityController;

  final genders = ["Laki-laki", "Perempuan"];
  String? valueGender;

  final religions = [
    "Islam",
    "Kristen",
    "Katolik",
    "Budha",
    "Hindhu",
    "Konghuchu"
  ];
  String? valueReligion;
  DateTime? initialDate;
  String? valueDatebirth;

  late bool isEdit;
  final bool _isSearching = false;

  String? statusMarried;
  List<String> statusMarrieds = [
    "Belum Kawin",
    "Kawin",
    "Cerai Hidup",
    "Cerai Mati",
  ];

  @override
  void initState() {
    super.initState();
    isEdit = widget.args.crud != Crud.read;
    _isSearching;
    kkController =
        TextEditingController(text: widget.args.model?.kk.toString() ?? "");
    namaController = TextEditingController(text: widget.args.model?.name ?? "");
    nikController =
        TextEditingController(text: widget.args.model?.nik.toString() ?? "");
    birthPlaceController =
        TextEditingController(text: widget.args.model?.birthPlace ?? "");
    jobController = TextEditingController(text: widget.args.model?.job ?? "");
    rtController = TextEditingController(text: widget.args.model?.rtrw);
    // rwController = TextEditingController(
    // text: widget.args.model?.rtrw.split("/")[1] ?? "");
    addressController =
        TextEditingController(text: widget.args.model?.address ?? "");
    nationalityController = TextEditingController(text: "");
    valueGender =
        widget.args.model?.gender == "" ? null : widget.args.model?.gender;
    initialDate = widget.args.model?.dob;
    valueReligion =
        widget.args.model?.religion == "" ? null : widget.args.model?.religion;
    final datePick = widget.args.model?.dob;
    valueDatebirth = datePick == null
        ? null
        : "${datePick.day} - ${datePick.month} - ${datePick.year}";

    statusMarried = widget.args.model?.statusMarried;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          'Form Data Warga',
          style: FontsUtils.poppins(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFieldBorder(
                  title: 'NIK',
                  controller: nikController,
                  keyboardType: TextInputType.number,
                  maxLength: 16,
                  enabled: _isSearching ? !isEdit : isEdit,
                ),
                TextFieldBorder(
                  title: 'No. KK',
                  controller: kkController,
                  keyboardType: TextInputType.number,
                  maxLength: 16,
                  enabled: _isSearching ? !isEdit : isEdit,
                ),
                TextFieldBorder(
                  title: 'Nama',
                  controller: namaController,
                  enabled: _isSearching ? !isEdit : isEdit,
                ),
                AddUserDropDownn(
                  title: "Jenis Kelamin",
                  value: valueGender,
                  items: genders,
                  isEdit: _isSearching ? !isEdit : isEdit,
                  onChange: (value) {
                    setState(() {
                      valueGender = value;
                    });
                  },
                ),
                TextFieldBorder(
                  title: 'Tempat\nLahir',
                  controller: birthPlaceController,
                  enabled: _isSearching ? !isEdit : isEdit,
                ),
                DatebirthField(
                  value: valueDatebirth,
                  isEdit: _isSearching ? !isEdit : isEdit,
                  onTap: () async {
                    if (!_isSearching) {
                      final datePick = await showDatePicker(
                        context: context,
                        initialDate: initialDate ?? DateTime(1945, 1, 1),
                        firstDate: DateTime(1900),
                        lastDate: DateTime.now(),
                      );
                      if (datePick != null) {
                        initialDate = datePick;
                        valueDatebirth =
                        "${datePick.day} - ${datePick.month} - ${datePick.year}";
                      }
                      setState(() {});
                    }
                  },
                ),
                AddUserDropDownn(
                  title: "Agama",
                  value: valueReligion,
                  items: religions,
                  isEdit: _isSearching ? !isEdit : isEdit,
                  onChange: (value) {
                    setState(() {
                      valueReligion = value;
                    });
                  },
                ),
                AddUserDropDownn(
                  title: "Status Perkawinan",
                  value: statusMarried,
                  items: statusMarrieds,
                  isEdit: _isSearching ? !isEdit : isEdit,
                  onChange: (value) {
                    setState(() {
                      statusMarried = value;
                    });
                  },
                ),
                TextFieldBorder(
                  title: 'Pekerjaan',
                  controller: jobController,
                  enabled: _isSearching ? !isEdit : isEdit,
                ),
                RtTextField(
                  controller: rtController,
                  isEdit: _isSearching ? !isEdit : isEdit,
                ),
                // TextFieldBorder(
                //   title: 'RT',
                //   controller: rtController,
                //   keyboardType: TextInputType.number,
                //   enabled: isEdit,
                //   maxLength: 3,
                // ),
                // TextFieldBorder(
                //   title: 'RW',
                //   controller: rwController,
                //   enabled: isEdit,
                //   keyboardType: TextInputType.number,
                //   maxLength: 3,
                // ),
                TextFieldBorder(
                  title: 'Alamat',
                  controller: addressController,
                  enabled: _isSearching ? !isEdit : isEdit,
                  maxLines: 4,
                ),
                if (widget.args.crud == Crud.create ||
                    widget.args.crud == Crud.update)
                  SizedBox(
                    width: 150,
                    height: 40,
                    child: BlocConsumer<AddCitizenCubit, AddCitizenState>(
                      listener: (context, state) {
                        if (state is AddCitizenSuccess) {
                          Fluttertoast.showToast(
                              msg: "Success ditambahkan",
                              backgroundColor: Colors.lightGreen);
                          Navigator.pushNamedAndRemoveUntil(
                              context, Routes.main, (context) => false,
                              arguments: 1);
                        } else if (state is AddCitizenError) {
                          Fluttertoast.showToast(
                              msg: state.message, backgroundColor: Colors.red);
                        }
                      },
                      builder: (context, state) {
                        if (state is AddCitizenLoading) {
                          return ElevatedButton(
                            onPressed: null,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: ColorsUtils.bgScaffold,
                              elevation: 2,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                  side: const BorderSide(color: Colors.black)),
                            ),
                            child: const SizedBox(
                                height: 20,
                                width: 20,
                                child: CircularProgressIndicator()),
                          );
                        }
                        return ElevatedButton(
                          onPressed: () {
                            if (kkController.text.length != 16) {
                              Fluttertoast.showToast(
                                  msg: "No. KK harus 16 angka",
                                  backgroundColor: Colors.red);
                            } else if (namaController.text == "") {
                              Fluttertoast.showToast(
                                  msg: "Nama tidak boleh kosong",
                                  backgroundColor: Colors.red);
                            } else if (nikController.text.length != 16) {
                              Fluttertoast.showToast(
                                  msg: "NIK harus 16 angka",
                                  backgroundColor: Colors.red);
                            } else if (valueGender == null) {
                              Fluttertoast.showToast(
                                  msg: "Pilih jenis kelamin",
                                  backgroundColor: Colors.red);
                            } else if (birthPlaceController.text == "") {
                              Fluttertoast.showToast(
                                  msg: "Tempat lahir tidak boleh kosong",
                                  backgroundColor: Colors.red);
                            } else if (initialDate == null) {
                              Fluttertoast.showToast(
                                  msg: "Tanggal lahir tidak boleh kosong",
                                  backgroundColor: Colors.red);
                            } else if (valueReligion == null) {
                              Fluttertoast.showToast(
                                  msg: "Pilih Agama",
                                  backgroundColor: Colors.red);
                            } else if (statusMarried == null) {
                              Fluttertoast.showToast(
                                  msg: "Pilih status perkawinan",
                                  backgroundColor: Colors.red);
                            } else if (jobController.text == "") {
                              Fluttertoast.showToast(
                                  msg: "Pekerjaan tidak boleh kosong",
                                  backgroundColor: Colors.red);
                            } else if (rtController.text == "") {
                              Fluttertoast.showToast(
                                  msg: "RT tidak boleh kosong",
                                  backgroundColor: Colors.red);
                            } else if (addressController.text == "") {
                              Fluttertoast.showToast(
                                  msg: "Alamat tidak boleh kosong",
                                  backgroundColor: Colors.red);
                            } else {
                              if (widget.args.crud == Crud.create) {
                                context
                                    .read<AddCitizenCubit>()
                                    .addCitizen(CitizenModel(
                                      nik:
                                          int.tryParse(nikController.text) ?? 0,
                                      kk: int.tryParse(kkController.text) ?? 0,
                                      name: namaController.text,
                                      gender: valueGender!,
                                      birthPlace: birthPlaceController.text,
                                      job: jobController.text,
                                      rtrw: rtController.text,
                                      address: addressController.text,
                                      dob: initialDate!,
                                      religion: valueReligion ?? "",
                                      statusMarried: statusMarried ?? "",
                                    ));
                              } else {
                                context
                                    .read<GetCitizenCubit>()
                                    .updateCitizen(CitizenModel(
                                      id: widget.args.model?.id ?? "",
                                      nik:
                                          int.tryParse(nikController.text) ?? 0,
                                      kk: int.tryParse(kkController.text) ?? 0,
                                      name: namaController.text,
                                      gender: valueGender!,
                                      birthPlace: birthPlaceController.text,
                                      job: jobController.text,
                                      rtrw: rtController.text,
                                      address: addressController.text,
                                      dob: initialDate!,
                                      religion: valueReligion ?? "",
                                      statusMarried: statusMarried ?? "",
                                    ));
                              }
                            }
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: ColorsUtils.bgScaffold,
                            elevation: 2,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                                side: const BorderSide(color: Colors.black)),
                          ),
                          child: Text(
                            widget.args.crud == Crud.create
                                ? 'Tambahkan'
                                : "Edit",
                            style: FontsUtils.poppins(
                                fontSize: 14, fontWeight: FontWeight.bold),
                          ),
                        );
                      },
                    ),
                  ),
              ],
            ),
          )),
    );
  }
}

class AddUserDropDownn extends StatelessWidget {
  final String title;
  final String? value;
  final List<String> items;
  final Function(String?)? onChange;
  final bool isEdit;
  final dynamic type;
  const AddUserDropDownn({
    super.key,
    this.value,
    this.isEdit = true,
    required this.items,
    required this.onChange,
    required this.title,
    this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 90,
            child: Text(
              title,
              style:
                  FontsUtils.poppins(fontSize: 14, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Container(
              width: double.infinity,
              height: 46,
              decoration: BoxDecoration(
                // color: Colors.amber,
                borderRadius: BorderRadius.circular(4),
                border:
                    isEdit ? Border.all() : Border.all(color: Colors.black12),
              ),
              child: DropdownButton<String>(
                underline: const SizedBox(),
                padding: const EdgeInsets.only(left: 10),
                isExpanded: true,
                style: FontsUtils.poppins(fontSize: 14),
                value: value,
                hint: Text(
                  "Pilih",
                  style: FontsUtils.poppins(fontSize: 14),
                ),
                onChanged: onChange,
                items: items
                    .map(
                      (e) => DropdownMenuItem<String>(
                        value: e,
                        enabled: isEdit,
                        child: Text(
                          e,
                          style: FontsUtils.poppins(fontSize: 14),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class TextFieldBorder extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final TextInputType? keyboardType;
  final int? maxLength;
  final bool? enabled;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final Function(String)? onFieldSubmitted;
  final Widget? suffixIcon;
  const TextFieldBorder({
    super.key,
    required this.title,
    required this.controller,
    this.keyboardType,
    this.enabled,
    this.maxLines,
    this.maxLength,
    this.textInputAction,
    this.onFieldSubmitted,
    this.suffixIcon,
  });

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
              padding: EdgeInsets.only(bottom: maxLength == null ? 0 : 30),
              child: SizedBox(
                width: 90,
                child: Text(
                  title,
                  textAlign: TextAlign.start,
                  style: FontsUtils.poppins(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: SizedBox(
              height: maxLines != null
                  ? 100
                  : maxLength == null
                      ? 46
                      : 70,
              child: TextFormField(
                controller: controller,
                keyboardType: keyboardType,
                textInputAction: textInputAction ?? TextInputAction.next,
                maxLength: maxLength,
                enabled: enabled,
                maxLines: maxLines,
                style: FontsUtils.poppins(
                    fontSize: 14, fontWeight: FontWeight.normal),
                onFieldSubmitted: onFieldSubmitted,
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  border: const OutlineInputBorder(),
                  focusedBorder: const OutlineInputBorder(),
                  enabledBorder: const OutlineInputBorder(),
                  suffixIcon: suffixIcon,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class DatebirthField extends StatelessWidget {
  final VoidCallback onTap;
  final String? value;
  final bool isEdit;
  final String? title;
  const DatebirthField({
    super.key,
    required this.onTap,
    this.value,
    this.isEdit = true,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        SizedBox(
          width: 90,
          child: Text(
            title ?? "Tanggal\nLahir",
            style:
                FontsUtils.poppins(fontSize: 14, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: InkWell(
            onTap: isEdit ? onTap : () {},
            child: Container(
              width: double.infinity,
              height: 46,
              padding: const EdgeInsets.only(left: 10),
              alignment: Alignment.centerLeft,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(4),
                border:
                    isEdit ? Border.all() : Border.all(color: Colors.black12),
              ),
              child: Text(
                value ?? 'mm - dd - yyyy',
                style: FontsUtils.poppins(
                    fontSize: 14, fontWeight: FontWeight.normal),
              ),
            ),
          ),
        ),
        InkWell(
          onTap: onTap,
          child: const Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: Icon(
              Icons.date_range,
              size: 25,
            ),
          ),
        ),
      ]),
    );
  }
}
