import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sapekderas/models/letter_model.dart';
import 'package:sapekderas/utils/extension.dart';
import 'package:uuid/uuid.dart';

import '../../models/enums.dart';
import '../../routes/routes.dart';
import '../../utils/utils.dart';
import '../../view_model/citizen/get_citizen/get_citizen_cubit.dart';
import '../../view_model/letter/add_letter/add_letter_cubit.dart';
import '../add_user/add_user_view.dart';
import '../add_user/widgets/rt_textfield.dart';

class LetterFormView extends StatefulWidget {
  final LetterDetailViewArgs args;
  const LetterFormView({super.key, required this.args});

  @override
  State<LetterFormView> createState() => _LetterFormViewState();
}

class _LetterFormViewState extends State<LetterFormView> {
  /// Text Controller
  late TextEditingController kkController;
  late TextEditingController namaController;
  late TextEditingController nikController;
  late TextEditingController birthPlaceController;
  late TextEditingController jobController;
  late TextEditingController rtController;
  late TextEditingController nationalityController;
  late TextEditingController addressController;
  late TextEditingController informationController;

  /// Dropdonw
  String? valueGender;
  final genders = ["Laki-laki", "Perempuan"];

  String? valueReligion;
  final religions = [
    "Islam",
    "Kristen",
    "Katolik",
    "Budha",
    "Hindhu",
    "Konghuchu"
  ];
  LetterType? type;
  final letterTypes = LetterType.values;

  StatusLetter? status;
  final statusList = [
    StatusLetter.success,
    StatusLetter.progress,
    StatusLetter.error
  ];

  String? statusMarried;
  List<String> statusMarrieds = [
    "Belum Kawin",
    "Kawin",
    "Cerai Hidup",
    "Cerai Mati",
  ];

  DateTime? initialDate;
  String? valueDatebirth;

  late bool isEdit;
  bool _isSearching = false;

  void _performSearch() {
    setState(() {
      if (nikController.text.length != 16) {
        Fluttertoast.showToast(
          msg: "NIK harus 16 angka", backgroundColor: Colors.red
        );

        return;
      }

      context.read<GetCitizenCubit>().searchNikCitizen(
        nikController.text,
        type: SearchType.main
      );

      _isSearching = true;
    });
  }

  void _performSearchFather() {
    setState(() {
      if (nikFatherController.text.length != 16) {
        Fluttertoast.showToast(
          msg: "NIK harus 16 angka", backgroundColor: Colors.red
        );

        return;
      }

      context.read<GetCitizenCubit>().searchNikCitizen(
        nikFatherController.text,
        type: SearchType.father
      );

      _isSearching = true;
    });
  }

  void _performSearchMother() {
    setState(() {
      if (nikMotherController.text.length != 16) {
        Fluttertoast.showToast(
          msg: "NIK harus 16 angka", backgroundColor: Colors.red
        );

        return;
      }

      context.read<GetCitizenCubit>().searchNikCitizen(
        nikMotherController.text,
        type: SearchType.mother
      );

      _isSearching = true;
    });
  }

  void _searchSubmit() {
    if (nikController.text.length != 16) {
      Fluttertoast.showToast(
        msg: "NIK harus 16 angka", backgroundColor: Colors.red
      );

      return;
    }

    context.read<GetCitizenCubit>().searchNikCitizen(
      nikController.text,
      type: SearchType.main
    );

    _isSearching = true;
  }

  void _searchSubmitFather() {
    if (nikFatherController.text.length != 16) {
      Fluttertoast.showToast(
        msg: "NIK harus 16 angka", backgroundColor: Colors.red
      );

      return;
    }

    context.read<GetCitizenCubit>().searchNikCitizen(
      nikFatherController.text,
      type: SearchType.father
    );

    _isSearching = true;
  }

  void _searchSubmitMother() {
    if (nikMotherController.text.length != 16) {
      Fluttertoast.showToast(
        msg: "NIK harus 16 angka", backgroundColor: Colors.red
      );

      return;
    }

    context.read<GetCitizenCubit>().searchNikCitizen(
      nikMotherController.text,
      type: SearchType.mother
    );

    _isSearching = true;
  }

  // Father Contoller
  late TextEditingController nameFatherController;
  late TextEditingController nikFatherController;
  late TextEditingController birthPlaceFatherController;
  late TextEditingController nationalityFatherController;
  late TextEditingController jobFatherController;
  late TextEditingController addressFatherController;
  late TextEditingController rtFatherController;

  String? valueReligionFather;
  DateTime? initialDateFather;
  String? valueDatebirthFather;

  // Mother
  late TextEditingController nameMotherController;
  late TextEditingController nikMotherController;
  late TextEditingController birthPlaceMotherController;
  late TextEditingController nationalityMotherController;
  late TextEditingController jobMotherController;
  late TextEditingController addressMotherController;
  late TextEditingController rtMotherController;

  String? valueReligionMother;
  DateTime? initialDateMother;
  String? valueDatebirthMother;

  /// Activity
  late TextEditingController activityController;
  late TextEditingController activityAddressController;
  late TextEditingController rtActivityController;

  DateTime? initialDateActivity;
  String? valueDatebirthActivity;

  /// RIP
  late TextEditingController nameRipController;
  late TextEditingController addressRipController;
  late TextEditingController ageRipController;
  late TextEditingController locationRipController;
  late TextEditingController reasonRipController;
  late TextEditingController rtRipController;

  DateTime? initialDateRip;
  String? valueDatebirthRip;

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
    addressController =
        TextEditingController(text: widget.args.model?.address ?? "");
    nationalityController = TextEditingController(
        text: widget.args.model?.nationality ?? "Indonesia");
    rtController = TextEditingController(text: widget.args.model?.rtrw);
    informationController = TextEditingController(text: widget.args.model?.informations ?? "");

    valueGender = widget.args.model?.gender == null
        ? null
        : widget.args.model?.gender == Gender.male
            ? genders[0]
            : genders[1];
    initialDate = widget.args.model?.dob;
    valueReligion =
        widget.args.model?.religion == "" ? null : widget.args.model?.religion;
    final datePick = widget.args.model?.dob;
    valueDatebirth = datePick == null
        ? null
        : "${datePick.day} - ${datePick.month} - ${datePick.year}";
    type = widget.args.model?.type;
    status = widget.args.model?.status;
    statusMarried = widget.args.model?.statusMarried;
    initFather();
    initMother();
    initActivity();
    initRip();
  }

  void initFather() {
    var data = widget.args.model?.father;
    nameFatherController = TextEditingController(text: data?.name ?? "");
    nikFatherController =
        TextEditingController(text: data?.nik.toString() ?? "");
    birthPlaceFatherController =
        TextEditingController(text: data?.birthPlace ?? "");
    nationalityFatherController =
        TextEditingController(text: data?.nationality ?? "Indonesia");
    jobFatherController = TextEditingController(text: data?.job ?? "");
    addressFatherController = TextEditingController(text: data?.address ?? "");
    rtFatherController = TextEditingController(text: data?.rtrw ?? "");

    valueReligionFather = data?.religion == "" ? null : data?.religion;
    initialDateFather = data?.dob;
    valueDatebirthFather = data?.dob == null
        ? null
        : "${data?.dob?.day} - ${data?.dob?.month} - ${data?.dob?.year}";
  }

  void initMother() {
    var data = widget.args.model?.mother;
    nameMotherController = TextEditingController(text: data?.name ?? "");
    nikMotherController =
        TextEditingController(text: data?.nik.toString() ?? "");
    birthPlaceMotherController =
        TextEditingController(text: data?.birthPlace ?? "");
    nationalityMotherController =
        TextEditingController(text: data?.nationality ?? "Indonesia");
    jobMotherController = TextEditingController(text: data?.job ?? "");
    addressMotherController = TextEditingController(text: data?.address ?? "");
    rtMotherController = TextEditingController(text: data?.rtrw ?? "");

    valueReligionMother = data?.religion == "" ? null : data?.religion;
    initialDateMother = data?.dob;
    valueDatebirthMother = data?.dob == null
        ? null
        : "${data?.dob?.day} - ${data?.dob?.month} - ${data?.dob?.year}";
  }

  void initActivity() {
    var data = widget.args.model?.activity;
    activityController = TextEditingController(text: data?.activity ?? "");
    activityAddressController =
        TextEditingController(text: data?.address ?? "");
    initialDateMother = data?.time;
    rtActivityController = TextEditingController(text: data?.rtrw ?? "");

    valueDatebirthMother = data?.time == null
        ? null
        : "${data?.time?.day} - ${data?.time?.month} - ${data?.time?.year}";
  }

  void initRip() {
    var data = widget.args.model?.rip;

    nameRipController = TextEditingController(text: data?.name ?? "");
    addressRipController = TextEditingController(text: data?.address ?? "");
    ageRipController = TextEditingController(text: data?.age.toString() ?? "");
    locationRipController = TextEditingController(text: data?.location ?? "");
    reasonRipController = TextEditingController(text: data?.reason ?? "");
    rtRipController = TextEditingController(text: data?.rtrw ?? "");

    initialDateRip = data?.deathTime;
    valueDatebirthRip = data?.deathTime == null
        ? null
        : "${data?.deathTime?.day} - ${data?.deathTime?.month} - ${data?.deathTime?.year}";
  }

  void _onSubmit() {
    if (type == null) {
      Fluttertoast.showToast(
          msg: "Pilih Type surat terlebih dahulu", backgroundColor: Colors.red);
    } else {
      bool isError = false;
      switch (type) {
        case LetterType.sku:
          isError = _submitSku();
          break;
        case LetterType.skck:
          isError = _submitSkck();
          break;
        case LetterType.sktm:
          isError = _submitSktm();
          break;
        case LetterType.skdt:
          isError = _submitSkdt();
          break;
        case LetterType.skbm:
          isError = _submitSkbm();
          break;

        case LetterType.sktps:
          isError = _submitSktps();
          break;
        case LetterType.spn:
          isError = _submitSpn();
          break;

        case LetterType.skrr:
          isError = _submitSkrr();
          break;
        case LetterType.skk:
          isError = _submitSkk();
          break;
        case LetterType.skkl:
          isError = _submitSkkl();
          break;

        default:
          return;
      }

      if (isError) {
        return;
      }
      LetterFamily? father;
      LetterFamily? mother;
      LetterActivity? activity;
      LetterRip? rip;

      if (type == LetterType.spn || type == LetterType.skkl) {
        father = LetterFamily(
          name: nameFatherController.text,
          nik: int.tryParse(nikFatherController.text) ?? 0,
          birthPlace: birthPlaceFatherController.text,
          nationality: nationalityFatherController.text,
          address: addressFatherController.text,
          dob: initialDateFather,
          religion: valueReligionFather ?? "",
          job: jobFatherController.text,
          rtrw: rtFatherController.text,
        );
        mother = LetterFamily(
          name: nameMotherController.text,
          nik: int.tryParse(nikMotherController.text) ?? 0,
          birthPlace: birthPlaceMotherController.text,
          nationality: nationalityMotherController.text,
          address: addressMotherController.text,
          dob: initialDateMother,
          religion: valueReligionMother ?? "",
          job: jobMotherController.text,
          rtrw: rtMotherController.text,
        );
      }

      if (type == LetterType.skrr) {
        activity = LetterActivity(
          activity: activityController.text,
          address: activityAddressController.text,
          time: initialDateActivity,
          rtrw: rtActivityController.text,
        );
      }
      if (type == LetterType.skk) {
        rip = LetterRip(
          name: nameRipController.text,
          age: int.tryParse(ageRipController.text) ?? 0,
          address: addressRipController.text,
          deathTime: initialDateRip,
          location: locationRipController.text,
          reason: reasonRipController.text,
          rtrw: rtRipController.text,
        );
      }

      if (widget.args.crud == Crud.create) {
        if (kDebugMode) {
          print("type: $type");
        }
        context.read<AddLetterCubit>().addLetter(LetterModel(
              id: const Uuid().v4(),
              type: type!,
              name: namaController.text,
              nik: int.tryParse(nikController.text) ?? 0,
              kk: int.tryParse(kkController.text) ?? 0,
              birthPlace: birthPlaceController.text,
              job: jobController.text,
              gender: valueGender == "Laki-laki" ? Gender.male : Gender.female,
              nationality: nationalityController.text,
              religion: valueReligion ?? "",
              address: addressController.text,
              informations: informationController.text,
              statusMarried: statusMarried ?? "",
              status: StatusLetter.progress,
              dob: initialDate,
              createdAt: DateTime.now(),
              mother: mother,
              father: father,
              activity: activity,
              rip: rip,
              rtrw: rtController.text,
            ));
      } else {
        context.read<AddLetterCubit>().updateLetter(LetterModel(
              id: widget.args.model?.id ?? "",
              type: type!,
              name: namaController.text,
              nik: int.tryParse(nikController.text) ?? 0,
              kk: int.tryParse(kkController.text) ?? 0,
              birthPlace: birthPlaceController.text,
              job: jobController.text,
              gender: valueGender == "Laki-laki" ? Gender.male : Gender.female,
              nationality: nationalityController.text,
              religion: valueReligion ?? "",
              address: addressController.text,
              informations: informationController.text,
              statusMarried: statusMarried ?? "",
              status: status ?? StatusLetter.progress,
              dob: initialDate,
              createdAt: DateTime.now(),
              mother: mother,
              father: father,
              activity: activity,
              rip: rip,
              rtrw: rtController.text,
              userId: widget.args.model?.userId ?? "",
            ));
      }
    }
  }

  /// Menambahkan Keterangan
  bool _submitSku() {
    if (namaController.text == "") {
      Fluttertoast.showToast(
          msg: "Nama tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (valueGender == null) {
      Fluttertoast.showToast(
          msg: "Pilih jenis kelamin", backgroundColor: Colors.red);
      return true;
    } else if (birthPlaceController.text == "") {
      Fluttertoast.showToast(
          msg: "Tempat lahir tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (initialDate == null) {
      Fluttertoast.showToast(
          msg: "Tanggal lahir tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (valueReligion == null) {
      Fluttertoast.showToast(
          msg: "Pilih jenis Agama", backgroundColor: Colors.red);
      return true;
    } else if (jobController.text == "") {
      Fluttertoast.showToast(
          msg: "Pekerjaan tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (addressController.text == "") {
      Fluttertoast.showToast(
          msg: "Alamat tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (informationController.text == "") {
      Fluttertoast.showToast(
        msg: "Keterangan tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (statusMarried == null) {
      Fluttertoast.showToast(
          msg: "Pilih status perkawinan", backgroundColor: Colors.red);
      return true;
    }
    return false;
  }

  /// Menambahkan Keterangan
  bool _submitSkck() {
    if (namaController.text == "") {
      Fluttertoast.showToast(
          msg: "Nama tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (nikController.text.length != 16) {
      Fluttertoast.showToast(
          msg: "NIK harus 16 angka", backgroundColor: Colors.red);
      return true;
    } else if (valueGender == null) {
      Fluttertoast.showToast(
          msg: "Pilih jenis kelamin", backgroundColor: Colors.red);
      return true;
    } else if (birthPlaceController.text == "") {
      Fluttertoast.showToast(
          msg: "Tempat lahir tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (initialDate == null) {
      Fluttertoast.showToast(
          msg: "Tanggal lahir tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (valueReligion == null) {
      Fluttertoast.showToast(
          msg: "Pilih jenis Agama", backgroundColor: Colors.red);
      return true;
    } else if (jobController.text == "") {
      Fluttertoast.showToast(
          msg: "Pekerjaan tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (addressController.text == "") {
      Fluttertoast.showToast(
          msg: "Alamat tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (informationController.text == "") {
      Fluttertoast.showToast(
        msg: "Keterangan tidak boleh kosong", backgroundColor: Colors.red
      );
      return true;
    } else if (statusMarried == null) {
      Fluttertoast.showToast(
          msg: "Pilih status perkawinan", backgroundColor: Colors.red);
      return true;
    }
    return false;
  }

  /// Menambahkan Keterangan
  bool _submitSktm() {
    if (namaController.text == "") {
      Fluttertoast.showToast(
          msg: "Nama tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (nikController.text.length != 16) {
      Fluttertoast.showToast(
          msg: "NIK harus 16 angka", backgroundColor: Colors.red);
      return true;
    } else if (valueGender == null) {
      Fluttertoast.showToast(
          msg: "Pilih jenis kelamin", backgroundColor: Colors.red);
      return true;
    } else if (birthPlaceController.text == "") {
      Fluttertoast.showToast(
          msg: "Tempat lahir tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (initialDate == null) {
      Fluttertoast.showToast(
          msg: "Tanggal lahir tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (valueReligion == null) {
      Fluttertoast.showToast(
          msg: "Pilih jenis Agama", backgroundColor: Colors.red);
      return true;
    } else if (jobController.text == "") {
      Fluttertoast.showToast(
          msg: "Pekerjaan tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (addressController.text == "") {
      Fluttertoast.showToast(
          msg: "Alamat tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (informationController.text == "") {
      Fluttertoast.showToast(
        msg: "Keterangan tidak boleh kosong", backgroundColor: Colors.red
      );
      return true;
    } else if (statusMarried == null) {
      Fluttertoast.showToast(
          msg: "Pilih status perkawinan", backgroundColor: Colors.red);
      return true;
    }
    return false;
  }

  bool _submitSkdt() {
    if (namaController.text == "") {
      Fluttertoast.showToast(
          msg: "Nama tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (nikController.text.length != 16) {
      Fluttertoast.showToast(
          msg: "NIK harus 16 angka", backgroundColor: Colors.red);
      return true;
    } else if (valueGender == null) {
      Fluttertoast.showToast(
          msg: "Pilih jenis kelamin", backgroundColor: Colors.red);
      return true;
    } else if (birthPlaceController.text == "") {
      Fluttertoast.showToast(
          msg: "Tempat lahir tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (initialDate == null) {
      Fluttertoast.showToast(
          msg: "Tanggal lahir tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (valueReligion == null) {
      Fluttertoast.showToast(
          msg: "Pilih jenis Agama", backgroundColor: Colors.red);
      return true;
    } else if (jobController.text == "") {
      Fluttertoast.showToast(
          msg: "Pekerjaan tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (addressController.text == "") {
      Fluttertoast.showToast(
          msg: "Alamat tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (statusMarried == null) {
      Fluttertoast.showToast(
          msg: "Pilih status perkawinan", backgroundColor: Colors.red);
      return true;
    }
    return false;
  }

  bool _submitSkbm() {
    if (namaController.text == "") {
      Fluttertoast.showToast(
          msg: "Nama tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (nikController.text.length != 16) {
      Fluttertoast.showToast(
          msg: "NIK harus 16 angka", backgroundColor: Colors.red);
      return true;
    } else if (valueGender == null) {
      Fluttertoast.showToast(
          msg: "Pilih jenis kelamin", backgroundColor: Colors.red);
      return true;
    } else if (birthPlaceController.text == "") {
      Fluttertoast.showToast(
          msg: "Tempat lahir tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (initialDate == null) {
      Fluttertoast.showToast(
          msg: "Tanggal lahir tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (valueReligion == null) {
      Fluttertoast.showToast(
          msg: "Pilih jenis Agama", backgroundColor: Colors.red);
      return true;
    } else if (addressController.text == "") {
      Fluttertoast.showToast(
          msg: "Alamat tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    }
    return false;
  }

  bool _submitSktps() {
    if (namaController.text == "") {
      Fluttertoast.showToast(
          msg: "Nama tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (nikController.text.length != 16) {
      Fluttertoast.showToast(
          msg: "NIK harus 16 angka", backgroundColor: Colors.red);
      return true;
    } else if (kkController.text.length != 16) {
      Fluttertoast.showToast(
          msg: "No. KK harus 16 angka", backgroundColor: Colors.red);
    } else if (valueGender == null) {
      Fluttertoast.showToast(
          msg: "Pilih jenis kelamin", backgroundColor: Colors.red);
      return true;
    } else if (birthPlaceController.text == "") {
      Fluttertoast.showToast(
          msg: "Tempat lahir tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (initialDate == null) {
      Fluttertoast.showToast(
          msg: "Tanggal lahir tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (valueReligion == null) {
      Fluttertoast.showToast(
          msg: "Pilih jenis Agama", backgroundColor: Colors.red);
      return true;
    } else if (jobController.text == "") {
      Fluttertoast.showToast(
          msg: "Pekerjaan tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (addressController.text == "") {
      Fluttertoast.showToast(
          msg: "Alamat tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (statusMarried == null) {
      Fluttertoast.showToast(
          msg: "Pilih status perkawinan", backgroundColor: Colors.red);
      return true;
    }
    return false;
  }

  bool _submitSpn() {
    if (namaController.text == "") {
      Fluttertoast.showToast(
          msg: "Nama tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (nikController.text.length != 16) {
      Fluttertoast.showToast(
          msg: "NIK harus 16 angka", backgroundColor: Colors.red);
      return true;
    } else if (valueGender == null) {
      Fluttertoast.showToast(
          msg: "Pilih jenis kelamin", backgroundColor: Colors.red);
      return true;
    } else if (birthPlaceController.text == "") {
      Fluttertoast.showToast(
          msg: "Tempat lahir tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (initialDate == null) {
      Fluttertoast.showToast(
          msg: "Tanggal lahir tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (valueReligion == null) {
      Fluttertoast.showToast(
          msg: "Pilih jenis Agama", backgroundColor: Colors.red);
      return true;
    } else if (jobController.text == "") {
      Fluttertoast.showToast(
          msg: "Pekerjaan tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (addressController.text == "") {
      Fluttertoast.showToast(
          msg: "Alamat tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    }
    return false;
  }

  bool _submitSkrr() {
    if (namaController.text == "") {
      Fluttertoast.showToast(
          msg: "Nama tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (birthPlaceController.text == "") {
      Fluttertoast.showToast(
          msg: "Tempat lahir tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (initialDate == null) {
      Fluttertoast.showToast(
          msg: "Tanggal lahir tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (valueReligion == null) {
      Fluttertoast.showToast(msg: "Pilih Agama", backgroundColor: Colors.red);
      return true;
    } else if (jobController.text == "") {
      Fluttertoast.showToast(
          msg: "Pekerjaan tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (addressController.text == "") {
      Fluttertoast.showToast(
          msg: "Alamat tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (activityController.text == "") {
      Fluttertoast.showToast(
          msg: "Nama kegiatan boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (activityAddressController.text == "") {
      Fluttertoast.showToast(
          msg: "Alamat kegiatan boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (initialDateActivity == null) {
      Fluttertoast.showToast(
          msg: "Tanggal kegiatan boleh kosong", backgroundColor: Colors.red);
      return true;
    }

    return false;
  }

  bool _submitSkk() {
    if (namaController.text == "") {
      Fluttertoast.showToast(
          msg: "Nama tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (addressController.text == "") {
      Fluttertoast.showToast(
          msg: "Alamat tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (nameRipController.text == "") {
      Fluttertoast.showToast(
          msg: "Nama warga meninggal tidak boleh kosong",
          backgroundColor: Colors.red);
      return true;
    } else if (addressRipController.text == "") {
      Fluttertoast.showToast(
          msg: "Alamat warga meninggal tidak boleh kosong",
          backgroundColor: Colors.red);
      return true;
    } else if (ageRipController.text == "") {
      Fluttertoast.showToast(
          msg: "Umur warga meninggal tidak boleh kosong",
          backgroundColor: Colors.red);
      return true;
    } else if (locationRipController.text == "") {
      Fluttertoast.showToast(
          msg: "Lokasi warga meninggal tidak boleh kosong",
          backgroundColor: Colors.red);
      return true;
    } else if (reasonRipController.text == "") {
      Fluttertoast.showToast(
          msg: "Disebabkan karena tidak boleh kosong",
          backgroundColor: Colors.red);
      return true;
    }

    return false;
  }

  bool _submitSkkl() {
    if (namaController.text == "") {
      Fluttertoast.showToast(
          msg: "Nama tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (initialDate == null) {
      Fluttertoast.showToast(
          msg: "Tanggal lahir tidak boleh kosong", backgroundColor: Colors.red);
      return true;
    } else if (valueGender == null) {
      Fluttertoast.showToast(
          msg: "Pilih jenis kelamin", backgroundColor: Colors.red);
      return true;
    }
    return false;
  }

  @override
  void dispose() {
    kkController.dispose();
    namaController.dispose();
    nikController.dispose();
    birthPlaceController.dispose();
    jobController.dispose();
    nationalityController.dispose();
    addressController.dispose();
    informationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          'Form Surat',
          style: FontsUtils.poppins(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocListener<GetCitizenCubit, GetCitizenState>(
        listener: (context, state) {
          if (state is GetCitizenSuccess) {
            if (state.searchData.isNotEmpty) {
              debugPrint(
                  "GetCitizenSuccess: ${state.searchData.first.toJson()}");
              final data = state.searchData.first;
              switch (state.type) {
                case SearchType.main:
                  kkController.text = data.kk.toString();
                  nikController.text = data.nik.toString();
                  namaController.text = data.name;
                  birthPlaceController.text = data.birthPlace;
                  jobController.text = data.job;
                  addressController.text = data.address;
                  informationController.text = data.informations;
                  nationalityController.text = "Indonesia";
                  valueGender = data.gender;
                  valueDatebirth =
                      "${data.dob.day} - ${data.dob.month} - ${data.dob.year}";
                  valueReligion = data.religion;
                  statusMarried = data.statusMarried;
                  rtController.text = data.rtrw;
                  initialDate = data.dob;
                  setState(() {});
                  break;
                case SearchType.father:
                  nameFatherController.text = data.name;
                  nikFatherController.text = data.nik.toString();
                  birthPlaceFatherController.text = data.birthPlace;
                  nationalityFatherController.text = "Indonesia";
                  jobFatherController.text = data.job;
                  addressFatherController.text = data.address;
                  rtFatherController.text = data.rtrw;
                  informationController.text = data.informations;
                  valueReligionFather = data.religion;
                  initialDateFather = data.dob;
                  valueDatebirthFather =
                      "${data.dob.day} - ${data.dob.month} - ${data.dob.year}";
                  setState(() {});
                  break;
                case SearchType.mother:
                  nameMotherController.text = data.name;
                  nikMotherController.text = data.nik.toString();
                  birthPlaceMotherController.text = data.birthPlace;
                  nationalityMotherController.text = "Indonesia";
                  jobMotherController.text = data.job;
                  addressMotherController.text = data.address;
                  rtMotherController.text = data.rtrw;
                  informationController.text = data.informations;
                  valueReligionMother =
                      data.religion == "" ? null : data.religion;
                  initialDateMother = data.dob;
                  valueDatebirthMother =
                      "${data.dob.day} - ${data.dob.month} - ${data.dob.year}";
                  setState(() {});

                  break;
                default:
              }
            } else {
              Fluttertoast.showToast(
                  msg: "NIK belum terdaftar silahkan isi manual");
            }
          }
        },
        child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  DropDownLetterType<LetterType>(
                    value: type,
                    items: letterTypes,
                    isEdit: isEdit,
                    onChange: widget.args.crud == Crud.read
                        ? (value) {}
                        : (value) {
                            setState(() {
                              type = value;
                            });
                          },
                    title: 'Type',
                  ),
                  if (widget.args.crud == Crud.update)
                    DropDownLetterType<StatusLetter>(
                      value: status,
                      items: statusList,
                      isEdit: isEdit,
                      onChange: (value) {
                        setState(() {
                          status = value;
                        });
                      },
                      title: 'Status',
                    ),
                  if (type != null) ...[
                    switch (type) {
                      LetterType.spn => formFieldSpn(),
                      LetterType.skrr => formFieldSkrr(),
                      LetterType.skk => formFieldSkk(),
                      LetterType.skkl => formFieldSkkl(),
                      _ => formField(),
                    },
                    // if (type == LetterType.spn) formFieldSpn() else formField(),
                    if (widget.args.crud == Crud.create ||
                        widget.args.crud == Crud.update)
                      SizedBox(
                        width: 150,
                        height: 40,
                        child: BlocConsumer<AddLetterCubit, AddLetterState>(
                          listener: (context, state) {
                            if (state is AddLetterSuccess) {
                              // Fluttertoast.showToast(
                              // msg: "Success ditambahkan",
                              // backgroundColor: Colors.lightGreen);
                              Navigator.pushNamedAndRemoveUntil(
                                  context, Routes.main, (context) => false,
                                  arguments: 0);
                            } else if (state is AddLetterError) {
                              Fluttertoast.showToast(
                                  msg: state.message,
                                  backgroundColor: Colors.red);
                            }
                          },
                          builder: (context, state) {
                            if (state is AddLetterLoading) {
                              return ElevatedButton(
                                onPressed: null,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: ColorsUtils.bgScaffold,
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                      side: const BorderSide(
                                          color: Colors.black)),
                                ),
                                child: const SizedBox(
                                    height: 20,
                                    width: 20,
                                    child: CircularProgressIndicator()),
                              );
                            }
                            return ElevatedButton(
                              onPressed: _onSubmit,
                              style: ElevatedButton.styleFrom(
                                backgroundColor: ColorsUtils.bgScaffold,
                                elevation: 2,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                    side:
                                        const BorderSide(color: Colors.black)),
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
                  ]
                ],
              ),
            )),
      ),
    );
  }

  Widget formField() => Column(
        children: [
          TextFieldBorder(
            title: 'NIK',
            controller: nikController,
            keyboardType: TextInputType.number,
            maxLength: 16,
            enabled: _isSearching ? !isEdit : isEdit,
            textInputAction: TextInputAction.search,
            suffixIcon: IconButton(
              onPressed: _performSearch,
              icon: const Icon(Icons.search),
            ),
            onFieldSubmitted: (value) {
              _performSearch();
            },
          ),
          if (type == LetterType.sktps)
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
          if (type != LetterType.sktm)
            TextFieldBorder(
              title: 'Kewarganegaraan',
              controller: nationalityController,
              enabled: _isSearching ? !isEdit : isEdit,
            ),
          if (type != LetterType.skbm)
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
          if (type != LetterType.skbm)
            TextFieldBorder(
              title: 'Pekerjaan',
              controller: jobController,
              enabled: _isSearching ? !isEdit : isEdit,
            ),
          RtTextField(
            controller: rtController,
            isEdit: _isSearching ? !isEdit : isEdit,
          ),
          TextFieldBorder(
            title: 'Alamat',
            controller: addressController,
            enabled: _isSearching ? !isEdit : isEdit,
            maxLines: 4,
            // maxLength: 300,
          ),
          TextFieldBorder(
            title: 'Keterangan',
            controller: informationController,
            enabled: _isSearching ? !isEdit : isEdit,
            maxLines: 4,
          ),
        ],
      );

  Widget formFieldSkrr() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldBorder(
            title: 'NIK',
            controller: nikController,
            keyboardType: TextInputType.number,
            maxLength: 16,
            enabled: _isSearching ? !isEdit : isEdit,
            textInputAction: TextInputAction.search,
            suffixIcon: IconButton(
              onPressed: _performSearch,
              icon: const Icon(Icons.search),
            ),
            onFieldSubmitted: (value) {
              _searchSubmit();
            },
          ),
          TextFieldBorder(
            title: 'Nama',
            controller: namaController,
            enabled: _isSearching ? !isEdit : isEdit,
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
          TextFieldBorder(
            title: 'Kewarganegaraan',
            controller: nationalityController,
            enabled: _isSearching ? !isEdit : isEdit,
          ),
          if (type != LetterType.skbm)
            TextFieldBorder(
              title: 'Pekerjaan',
              controller: jobController,
              enabled: _isSearching ? !isEdit : isEdit,
            ),

          RtTextField(
            controller: rtController,
            isEdit: _isSearching ? !isEdit : isEdit,
          ),
          TextFieldBorder(
            title: 'Alamat',
            controller: addressController,
            enabled: _isSearching ? !isEdit : isEdit,
            maxLines: 4,
            // maxLength: 300,
          ),
          const SizedBox(height: 24),

          /// Kegiatan
          Text(
            'Kegiatan',
            style:
                FontsUtils.poppins(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          TextFieldBorder(
            title: 'Nama Kegiatan',
            controller: activityController,
            enabled: _isSearching ? !isEdit : isEdit,
          ),
          DatebirthField(
            value: valueDatebirthActivity,
            isEdit: _isSearching ? !isEdit : isEdit,
            title: "Tanggal",
            onTap: () async {
              final datePick = await showDatePicker(
                context: context,
                initialDate: initialDate ?? DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2100),
              );
              if (datePick != null) {
                initialDateActivity = datePick;
                valueDatebirthActivity =
                    "${datePick.day} - ${datePick.month} - ${datePick.year}";
              }
              setState(() {});
            },
          ),
          RtTextField(
            controller: rtActivityController,
            isEdit: _isSearching ? !isEdit : isEdit,
          ),
          TextFieldBorder(
            title: 'Alamat',
            controller: activityAddressController,
            enabled: _isSearching ? !isEdit : isEdit,
            maxLines: 4,
            // maxLength: 300,
          ),
          const SizedBox(height: 24),
        ],
      );

  Widget formFieldSkk() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldBorder(
            title: 'Nama',
            controller: namaController,
            enabled: _isSearching ? !isEdit : isEdit,
          ),
          RtTextField(
            controller: rtRipController,
            isEdit: _isSearching ? !isEdit : isEdit,
          ),
          TextFieldBorder(
            title: 'Alamat',
            controller: addressController,
            enabled: _isSearching ? !isEdit : isEdit,
            maxLines: 4,
            // maxLength: 300,
          ),
          const SizedBox(height: 24),

          /// Warga meninggal
          Text(
            'Warga Meninggal',
            style:
                FontsUtils.poppins(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          TextFieldBorder(
            title: 'Nama',
            controller: nameRipController,
            enabled: _isSearching ? !isEdit : isEdit,
          ),
          TextFieldBorder(
            title: 'Alamat',
            controller: addressRipController,
            enabled: _isSearching ? !isEdit : isEdit,
            maxLines: 4,
            // maxLength: 300,
          ),
          TextFieldBorder(
            title: 'Umur',
            controller: ageRipController,
            enabled: _isSearching ? !isEdit : isEdit,
            keyboardType: TextInputType.number,
          ),

          DatebirthField(
            value: valueDatebirthRip,
            isEdit: _isSearching ? !isEdit : isEdit,
            title: "Tanggal",
            onTap: () async {
              final datePick = await showDatePicker(
                context: context,
                initialDate: initialDateRip ?? DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (datePick != null) {
                initialDateRip = datePick;
                valueDatebirthRip =
                    "${datePick.day} - ${datePick.month} - ${datePick.year}";
              }
              setState(() {});
            },
          ),

          TextFieldBorder(
            title: 'Lokasi',
            controller: locationRipController,
            enabled: _isSearching ? !isEdit : isEdit,
          ),
          TextFieldBorder(
            title: 'Disebabkan Karena',
            controller: reasonRipController,
            enabled: isEdit,
          ),

          const SizedBox(height: 24),
        ],
      );

  Widget formFieldSpn() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFieldBorder(
            title: 'NIK',
            controller: nikController,
            keyboardType: TextInputType.number,
            maxLength: 16,
            enabled: _isSearching ? !isEdit : isEdit,
            textInputAction: TextInputAction.search,
            suffixIcon: IconButton(
              onPressed: _performSearch,
              icon: const Icon(Icons.search),
            ),
            onFieldSubmitted: (value) {
              _performSearch();
            },
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
          if (type != LetterType.sktm)
            TextFieldBorder(
              title: 'Kewarganegaraan',
              controller: nationalityController,
              enabled: _isSearching ? !isEdit : isEdit,
            ),
          if (type != LetterType.skbm)
            TextFieldBorder(
              title: 'Pekerjaan',
              controller: jobController,
              enabled: _isSearching ? !isEdit : isEdit,
            ),
          RtTextField(
            controller: rtController,
            isEdit: _isSearching ? !isEdit : isEdit,
          ),
          TextFieldBorder(
            title: 'Alamat',
            controller: addressController,
            enabled: _isSearching ? !isEdit : isEdit,
            maxLines: 4,
            // maxLength: 300,
          ),
          const SizedBox(height: 24),

          /// AYAH
          Text(
            'Ayah',
            style:
                FontsUtils.poppins(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          TextFieldBorder(
            title: 'NIK',
            controller: nikFatherController,
            keyboardType: TextInputType.number,
            maxLength: 16,
            enabled: _isSearching ? !isEdit : isEdit,
            textInputAction: TextInputAction.search,
            suffixIcon: IconButton(
              onPressed: _performSearchFather,
              icon: const Icon(Icons.search),
            ),
            onFieldSubmitted: (value) {
              _searchSubmitFather();
            },
          ),
          TextFieldBorder(
            title: 'Nama',
            controller: nameFatherController,
            enabled: _isSearching ? !isEdit : isEdit,
          ),
          TextFieldBorder(
            title: 'Tempat\nLahir',
            controller: birthPlaceFatherController,
            enabled: _isSearching ? !isEdit : isEdit,
          ),
          DatebirthField(
            value: valueDatebirthFather,
            isEdit: _isSearching ? !isEdit : isEdit,
            onTap: () async {
              final datePick = await showDatePicker(
                context: context,
                initialDate: initialDate ?? DateTime(1945, 1, 1),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (datePick != null) {
                initialDateFather = datePick;
                valueDatebirthFather =
                    "${datePick.day} - ${datePick.month} - ${datePick.year}";
              }
              setState(() {});
            },
          ),
          AddUserDropDownn(
            title: "Agama",
            value: valueReligionFather,
            items: religions,
            isEdit: _isSearching ? !isEdit : isEdit,
            onChange: (value) {
              setState(() {
                valueReligionFather = value;
              });
            },
          ),
          TextFieldBorder(
            title: 'Kewarganegaraan',
            controller: nationalityFatherController,
            enabled: _isSearching ? !isEdit : isEdit,
          ),
          TextFieldBorder(
            title: 'Pekerjaan',
            controller: jobFatherController,
            enabled: _isSearching ? !isEdit : isEdit,
          ),
          RtTextField(
            controller: rtFatherController,
            isEdit: _isSearching ? !isEdit : isEdit,
          ),
          TextFieldBorder(
            title: 'Alamat',
            controller: addressFatherController,
            enabled: _isSearching ? !isEdit : isEdit,
            maxLines: 4,
            // maxLength: 300,
          ),

          /// IBU
          Text(
            'Ibu',
            style:
                FontsUtils.poppins(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          TextFieldBorder(
            title: 'NIK',
            controller: nikMotherController,
            keyboardType: TextInputType.number,
            maxLength: 16,
            enabled: _isSearching ? !isEdit : isEdit,
            textInputAction: TextInputAction.search,
            suffixIcon: IconButton(
              onPressed: _performSearchMother,
              icon: const Icon(Icons.search),
            ),
            onFieldSubmitted: (value) {
              _searchSubmitMother();
            },
          ),
          TextFieldBorder(
            title: 'Nama',
            controller: nameMotherController,
            enabled: _isSearching ? !isEdit : isEdit,
          ),
          TextFieldBorder(
            title: 'Tempat\nLahir',
            controller: birthPlaceMotherController,
            enabled: _isSearching ? !isEdit : isEdit,
          ),
          DatebirthField(
            value: valueDatebirthMother,
            isEdit: _isSearching ? !isEdit : isEdit,
            onTap: () async {
              final datePick = await showDatePicker(
                context: context,
                initialDate: initialDate ?? DateTime(1945, 1, 1),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (datePick != null) {
                initialDateMother = datePick;
                valueDatebirthMother =
                    "${datePick.day} - ${datePick.month} - ${datePick.year}";
              }
              setState(() {});
            },
          ),
          AddUserDropDownn(
            title: "Agama",
            value: valueReligionMother,
            items: religions,
            isEdit: _isSearching ? !isEdit : isEdit,
            onChange: (value) {
              setState(() {
                valueReligionMother = value;
              });
            },
          ),
          TextFieldBorder(
            title: 'Kewarganegaraan',
            controller: nationalityMotherController,
            enabled: _isSearching ? !isEdit : isEdit,
          ),
          TextFieldBorder(
            title: 'Pekerjaan',
            controller: jobMotherController,
            enabled: _isSearching ? !isEdit : isEdit,
          ),
          RtTextField(
            controller: rtMotherController,
            isEdit: _isSearching ? !isEdit : isEdit,
          ),
          TextFieldBorder(
            title: 'Alamat',
            controller: addressMotherController,
            enabled: _isSearching ? !isEdit : isEdit,
            maxLines: 4,
            // maxLength: 300,
          ),
        ],
      );

  Widget formFieldSkkl() => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 24),

          /// Anak
          Text(
            'Anak',
            style:
                FontsUtils.poppins(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),

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
          DatebirthField(
            value: valueDatebirth,
            isEdit: _isSearching ? !isEdit : isEdit,
            onTap: () async {
              final datePick = await showDatePicker(
                context: context,
                initialDate: initialDate ?? DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (datePick != null) {
                initialDate = datePick;
                valueDatebirth =
                    "${datePick.day} - ${datePick.month} - ${datePick.year}";
              }
              setState(() {});
            },
          ),

          const SizedBox(height: 24),

          /// AYAH
          Text(
            'Ayah',
            style:
                FontsUtils.poppins(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          TextFieldBorder(
            title: 'NIK',
            controller: nikFatherController,
            keyboardType: TextInputType.number,
            maxLength: 16,
            enabled: _isSearching ? !isEdit : isEdit,
            textInputAction: TextInputAction.search,
            suffixIcon: IconButton(
              onPressed: _performSearchFather,
              icon: const Icon(Icons.search),
            ),
            onFieldSubmitted: (value) {
              _searchSubmitFather();
            },
          ),

          TextFieldBorder(
            title: 'Nama',
            controller: nameFatherController,
            enabled: _isSearching ? !isEdit : isEdit,
          ),
          TextFieldBorder(
            title: 'Tempat\nLahir',
            controller: birthPlaceFatherController,
            enabled: _isSearching ? !isEdit : isEdit,
          ),
          DatebirthField(
            value: valueDatebirthFather,
            isEdit: _isSearching ? !isEdit : isEdit,
            onTap: () async {
              final datePick = await showDatePicker(
                context: context,
                initialDate: initialDate ?? DateTime(1945, 1, 1),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (datePick != null) {
                initialDateFather = datePick;
                valueDatebirthFather =
                    "${datePick.day} - ${datePick.month} - ${datePick.year}";
              }
              setState(() {});
            },
          ),
          AddUserDropDownn(
            title: "Agama",
            value: valueReligionFather,
            items: religions,
            isEdit: _isSearching ? !isEdit : isEdit,
            onChange: (value) {
              setState(() {
                valueReligionFather = value;
              });
            },
          ),
          TextFieldBorder(
            title: 'Kewarganegaraan',
            controller: nationalityFatherController,
            enabled: _isSearching ? !isEdit : isEdit,
          ),
          TextFieldBorder(
            title: 'Pekerjaan',
            controller: jobFatherController,
            enabled: _isSearching ? !isEdit : isEdit,
          ),
          RtTextField(
            controller: rtFatherController,
            isEdit: _isSearching ? !isEdit : isEdit,
          ),
          TextFieldBorder(
            title: 'Alamat',
            controller: addressFatherController,
            enabled: _isSearching ? !isEdit : isEdit,
            maxLines: 4,
            // maxLength: 300,
          ),

          /// IBU
          Text(
            'Ibu',
            style:
                FontsUtils.poppins(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 24),
          TextFieldBorder(
            title: 'NIK',
            controller: nikMotherController,
            keyboardType: TextInputType.number,
            maxLength: 16,
            enabled: _isSearching ? !isEdit : isEdit,
            textInputAction: TextInputAction.search,
            suffixIcon: IconButton(
              onPressed: _performSearchMother,
              icon: const Icon(Icons.search),
            ),
            onFieldSubmitted: (value) {
              _searchSubmitMother();
            },
          ),

          TextFieldBorder(
            title: 'Nama',
            controller: nameMotherController,
            enabled: _isSearching ? !isEdit : isEdit,
          ),
          TextFieldBorder(
            title: 'Tempat\nLahir',
            controller: birthPlaceMotherController,
            enabled: _isSearching ? !isEdit : isEdit,
          ),
          DatebirthField(
            value: valueDatebirthMother,
            isEdit: _isSearching ? !isEdit : isEdit,
            onTap: () async {
              final datePick = await showDatePicker(
                context: context,
                initialDate: initialDate ?? DateTime(1945, 1, 1),
                firstDate: DateTime(1900),
                lastDate: DateTime.now(),
              );
              if (datePick != null) {
                initialDateMother = datePick;
                valueDatebirthMother =
                    "${datePick.day} - ${datePick.month} - ${datePick.year}";
              }
              setState(() {});
            },
          ),
          AddUserDropDownn(
            title: "Agama",
            value: valueReligionMother,
            items: religions,
            isEdit: _isSearching ? !isEdit : isEdit,
            onChange: (value) {
              setState(() {
                valueReligionMother = value;
              });
            },
          ),
          TextFieldBorder(
            title: 'Kewarganegaraan',
            controller: nationalityMotherController,
            enabled: _isSearching ? !isEdit : isEdit,
          ),
          TextFieldBorder(
            title: 'Pekerjaan',
            controller: jobMotherController,
            enabled: _isSearching ? !isEdit : isEdit,
          ),
          RtTextField(
            controller: rtMotherController,
            isEdit: _isSearching ? !isEdit : isEdit,
          ),
          TextFieldBorder(
            title: 'Alamat',
            controller: addressMotherController,
            enabled: _isSearching ? !isEdit : isEdit,
            maxLines: 4,
            // maxLength: 300,
          ),
          TextFieldBorder(
            title: 'Keterangan',
            controller: informationController,
            enabled: _isSearching ? !isEdit : isEdit,
            maxLines: 4,
          ),
        ],
      );
}

class DropDownLetterType<T> extends StatelessWidget {
  final String title;
  final T? value;
  final Function(T?)? onChange;
  final bool isEdit;
  final List<T> items;
  const DropDownLetterType({
    super.key,
    this.isEdit = true,
    required this.items,
    required this.onChange,
    required this.title,
    this.value,
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
                borderRadius: BorderRadius.circular(4),
                border:
                    isEdit ? Border.all() : Border.all(color: Colors.black12),
              ),
              child: DropdownButton<T>(
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
                      (e) => DropdownMenuItem<T>(
                        value: e,
                        enabled: isEdit,
                        child: Text(
                          e.toString().enumUpperCase(),
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

class LetterDetailViewArgs {
  final LetterModel? model;
  final Crud crud;

  const LetterDetailViewArgs({this.model, this.crud = Crud.create});
}
