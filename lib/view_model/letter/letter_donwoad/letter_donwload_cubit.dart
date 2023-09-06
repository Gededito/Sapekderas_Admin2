import 'dart:io';

import 'package:docx_template/docx_template.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:sapekderas/utils/extension.dart';

import '../../../models/letter_model.dart';
import 'package:spreadsheet_decoder/spreadsheet_decoder.dart';

part 'letter_donwload_state.dart';

class LetterDonwloadCubit extends Cubit<LetterDonwloadState> {
  LetterDonwloadCubit() : super(LetterDonwloadInitial());

  void donwload(LetterModel data) {
    switch (data.type) {
      case LetterType.skck:
        _donwloadSkck(data);
        break;
      case LetterType.sktm:
        _donwloadSktm(data);
      case LetterType.sku:
        _donwloadSku(data);
        break;
      case LetterType.skdt:
        donwloadSkdt(data);
        break;
      case LetterType.skbm:
        donwloadSkbm(data);
        break;
      case LetterType.sktps:
        donwloadSktps(data);
        break;
      case LetterType.spn:
        donwloadSpn(data);
        break;
      case LetterType.skrr:
        donwloadSkrr(data);
        break;
      case LetterType.skk:
        donwloadSkk(data);

      case LetterType.skkl:
        donwloadSkkl(data);
        break;

      default:
        Fluttertoast.showToast(msg: "Type surat tahap develop");
    }
  }

  void _donwloadSku(LetterModel model) async {
    emit(LetterDonwloadLoading());

    try {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      final data = await rootBundle.load('assets/files/sku.docx');
      final bytes = data.buffer.asUint8List();

      final docx = await DocxTemplate.fromBytes(bytes);

      Content content = Content();
      content
        ..add(TextContent("keyname", model.name))
        ..add(TextContent("keynik", model.nik))
        ..add(TextContent(
            "keyttl", "${model.birthPlace}, ${model.dob.dateString()}"))
        ..add(TextContent("keygender",
            model.gender == Gender.male ? "Laki-laki" : "Perempuan"))
        ..add(TextContent("keyrelogion/nationality",
            "${model.religion}/${model.nationality}"))
        ..add(TextContent("keymaritalstatus", model.statusMarried))
        ..add(TextContent("keyjob", model.job))
        ..add(TextContent("keyaddress", model.address));

      final docGenerated = await docx.generate(content);
      String filePath = "/storage/emulated/0/Download/SKU ${model.name}.docx";

      final fileGenerated = File(filePath);

      if (docGenerated != null) {
        await fileGenerated.writeAsBytes(docGenerated);
        Fluttertoast.showToast(msg: "File berhasil di download");

        emit(LetterDonwloadSuccess());
      } else {
        Fluttertoast.showToast(msg: "File gagal di donwload");

        emit(const LetterDonwloadError("cant donwload"));
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "File gagal di donwload");
      emit(LetterDonwloadError(e.toString()));
    }
  }

  void _donwloadSktm(LetterModel model) async {
    emit(LetterDonwloadLoading());

    try {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      final data = await rootBundle.load('assets/files/sktm.docx');
      final bytes = data.buffer.asUint8List();

      final docx = await DocxTemplate.fromBytes(bytes);

      Content content = Content();
      content
        ..add(TextContent("keyname", model.name))
        ..add(TextContent("keynik", model.nik))
        ..add(TextContent(
            "keyttl", "${model.birthPlace}, ${model.dob.dateString()}"))
        ..add(TextContent("keygender",
            model.gender == Gender.male ? "Laki-laki" : "Perempuan"))
        ..add(TextContent("keyrelogion", model.religion))
        ..add(TextContent("keystatus", model.statusMarried))
        ..add(TextContent("keyjob", model.job))
        ..add(TextContent("keyaddress", model.address));

      final docGenerated = await docx.generate(content);
      String filePath = "/storage/emulated/0/Download/SKTM ${model.name}.docx";

      final fileGenerated = File(filePath);

      if (docGenerated != null) {
        await fileGenerated.writeAsBytes(docGenerated);
        Fluttertoast.showToast(msg: "File berhasil di download");

        emit(LetterDonwloadSuccess());
      } else {
        Fluttertoast.showToast(msg: "File gagal di donwload");

        emit(const LetterDonwloadError("cant donwload"));
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "File gagal di donwload");
      emit(LetterDonwloadError(e.toString()));
    }
  }

  void _donwloadSkck(LetterModel model) async {
    emit(LetterDonwloadLoading());

    try {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      final data = await rootBundle.load('assets/files/skck.docx');
      final bytes = data.buffer.asUint8List();

      final docx = await DocxTemplate.fromBytes(bytes);

      Content content = Content();
      content
        ..add(TextContent("keyname", model.name))
        ..add(TextContent("keynik", model.nik))
        ..add(TextContent("keyttl", model.dob.dateString()))
        ..add(TextContent("keygender",
            model.gender == Gender.male ? "Laki-laki" : "Perempuan"))
        ..add(TextContent("keycountry", "Indonesia"))
        ..add(TextContent("keystatusmarried", model.statusMarried))
        ..add(TextContent("keyjob", model.job))
        ..add(TextContent("keyaddress", model.address));

      final docGenerated = await docx.generate(content);
      String filePath = "/storage/emulated/0/Download/SKCK ${model.name}.docx";

      final fileGenerated = File(filePath);

      if (docGenerated != null) {
        // final file =
        await fileGenerated.writeAsBytes(docGenerated);
        // final PdfDocument document =
        // PdfDocument(inputBytes: file.readAsBytesSync());
        // File("/storage/emulated/0/Download/SKCK ${model.name}.pdf")
        // .writeAsBytes(await document.save());
        // document.dispose();

        Fluttertoast.showToast(msg: "File berhasil di download");

        emit(LetterDonwloadSuccess());
      } else {
        Fluttertoast.showToast(msg: "File gagal di donwload");

        emit(const LetterDonwloadError("cant donwload"));
      }
    } catch (e, s) {
      debugPrint("error: ${e.toString()}\nStackrace: $s");
      Fluttertoast.showToast(msg: "File gagal di donwload");
      emit(LetterDonwloadError(e.toString()));
    }
  }

  /// SKDT (Surat Keteranngan Domisili Tinggal)
  void donwloadSkdt(LetterModel model) async {
    emit(LetterDonwloadLoading());

    try {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      final data = await rootBundle.load('assets/files/skdt.docx');
      final bytes = data.buffer.asUint8List();

      final docx = await DocxTemplate.fromBytes(bytes);
      if (kDebugMode) {
        print("model.dob.dateString()1: ${model.dob.dateString()}");
        print("model.dob.dateString()2: ${model.dob}");
      }

      Content content = Content();
      content
        ..add(TextContent("keyname", model.name))
        ..add(TextContent("keynik", model.nik))
        // ..add(TextContent("keyttl", "27-02-2002"))
        ..add(TextContent(
            "keyttl", "${model.birthPlace}, ${model.dob.dateString()}"))
        ..add(TextContent("keygender",
            model.gender == Gender.male ? "Laki-laki" : "Perempuan"))
        ..add(TextContent("keyreligion", model.religion))
        ..add(TextContent("keycountry",
            model.nationality == "" ? "Indonesia" : model.nationality))
        ..add(TextContent("keystatusmarried", model.statusMarried))
        ..add(TextContent("keyjob", model.job))
        ..add(TextContent("keyaddress", model.address));

      final docGenerated = await docx.generate(content);
      String filePath = "/storage/emulated/0/Download/SKDT ${model.name}.docx";

      final fileGenerated = File(filePath);

      if (docGenerated != null) {
        await fileGenerated.writeAsBytes(docGenerated);
        Fluttertoast.showToast(msg: "File berhasil di download");

        emit(LetterDonwloadSuccess());
      } else {
        Fluttertoast.showToast(msg: "File gagal di donwload");

        emit(const LetterDonwloadError("cant donwload"));
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "File gagal di donwload");
      emit(LetterDonwloadError(e.toString()));
    }
  }

  /// SKBM (Surat Keteranngan Belum Menikah)
  void donwloadSkbm(LetterModel model) async {
    emit(LetterDonwloadLoading());

    try {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      final data = await rootBundle.load('assets/files/skbm.docx');
      final bytes = data.buffer.asUint8List();

      final docx = await DocxTemplate.fromBytes(bytes);

      Content content = Content();
      content
        ..add(TextContent("keyname", model.name))
        ..add(TextContent("keynik", model.nik))
        ..add(TextContent(
            "keyttl", "${model.birthPlace}, ${model.dob.dateString()}"))
        ..add(TextContent("keygender",
            model.gender == Gender.male ? "Laki-laki" : "Perempuan"))
        ..add(TextContent("keyreligion", model.religion))
        ..add(TextContent("keynationality",
            model.nationality == "" ? "Indonesia" : model.nationality))
        ..add(TextContent("keyjob", model.job))
        ..add(TextContent("keyaddress", model.address));

      final docGenerated = await docx.generate(content);
      String filePath = "/storage/emulated/0/Download/SKBM ${model.name}.docx";

      final fileGenerated = File(filePath);

      if (docGenerated != null) {
        await fileGenerated.writeAsBytes(docGenerated);
        Fluttertoast.showToast(msg: "File berhasil di download");

        emit(LetterDonwloadSuccess());
      } else {
        Fluttertoast.showToast(msg: "File gagal di donwload");

        emit(const LetterDonwloadError("cant donwload"));
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "File gagal di donwload");
      emit(LetterDonwloadError(e.toString()));
    }
  }

  void donwloadSpn(LetterModel model) async {
    emit(LetterDonwloadLoading());

    try {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      final data = await rootBundle.load('assets/files/spn.docx');
      final bytes = data.buffer.asUint8List();

      final docx = await DocxTemplate.fromBytes(bytes);

      Content content = Content();
      content
        ..add(TextContent("keyname", model.name))
        ..add(TextContent("keynik", model.nik))
        ..add(TextContent(
            "keyttl", "${model.birthPlace}, ${model.dob.dateString()}"))
        ..add(TextContent("keygender",
            model.gender == Gender.male ? "Laki-laki" : "Perempuan"))
        ..add(TextContent("keyreligion", model.religion))
        ..add(TextContent("keynationality",
            model.nationality == "" ? "Indonesia" : model.nationality))
        ..add(TextContent("keyaddress", model.address))
        ..add(TextContent("keystatusmarriedmale",
            model.gender == Gender.male ? "Jejaka" : ""))
        ..add(TextContent("keystatusmarriedfemale",
            model.gender == Gender.male ? " " : "Perawan"))
        //Father
        ..add(TextContent("keynamefather", model.father?.name))
        ..add(TextContent("keyinkfather", model.father?.nik))
        ..add(TextContent("keyttlfather",
            "${model.father?.birthPlace}, ${model.father?.dob.dateString()})"))
        ..add(TextContent(
            "keynationalityfather",
            model.father?.nationality == ""
                ? "Indonesia"
                : model.father?.nationality))
        ..add(TextContent("keyreligionfather", model.father?.religion))
        ..add(TextContent("keyjobfather", model.father?.job))
        ..add(TextContent("keyaddressfather", model.father?.address))

        // Mother
        ..add(TextContent("keynamemother", model.mother?.name))
        ..add(TextContent("keynikmother", model.mother?.nik))
        ..add(TextContent("keyttlmother",
            "${model.mother?.birthPlace}, ${model.mother?.dob.dateString()})"))
        ..add(TextContent(
            "keynationalitymother",
            model.mother?.nationality == ""
                ? "Indonesia"
                : model.mother?.nationality))
        ..add(TextContent("keyreligionmother", model.mother?.religion))
        ..add(TextContent("keyjomother", model.mother?.job))
        ..add(TextContent("keyaddressmother", model.mother?.address))
        ..add(TextContent("keynow", DateTime.now().dateString()));

      final docGenerated = await docx.generate(content);
      String filePath = "/storage/emulated/0/Download/SPN ${model.name}.docx";

      final fileGenerated = File(filePath);

      if (docGenerated != null) {
        await fileGenerated.writeAsBytes(docGenerated);
        Fluttertoast.showToast(msg: "File berhasil di download");

        emit(LetterDonwloadSuccess());
      } else {
        Fluttertoast.showToast(msg: "File gagal di donwload");

        emit(const LetterDonwloadError("cant donwload"));
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "File gagal di donwload");
      emit(LetterDonwloadError(e.toString()));
    }
  }

  void donwloadSktps(LetterModel model) async {
    try {
      emit(LetterDonwloadLoading());

      final data = await rootBundle.load('assets/files/sktps.xlsx');
      final bytes = data.buffer.asUint8List();
      // var file = 'assets/files/sktps.xlsx';
      // var bytes = File(file).readAsBytesSync();
      var decoder = SpreadsheetDecoder.decodeBytes(bytes, update: true);
      if (kDebugMode) {
        for (var table in decoder.tables.keys) {
          print("table: $table");
          print("maxcols: ${decoder.tables[table]!.maxCols}");
          print("maxRows: ${decoder.tables[table]!.maxRows}");
          var tab = decoder.tables[table]!.rows;
          for (int i = 0; i < tab.length; i++) {
            print('${i + 1}: ${tab[i]}');
          }
        }
      }

      var now = DateTime.now();
      var getKtp = DateTime(now.year, now.month + 2, now.day);

      var sheet = decoder.tables.keys.first;
      decoder
        ..updateCell(sheet, 4, 7, ": ${model.kk}")
        ..updateCell(sheet, 4, 8, ": ${model.nik}")
        ..updateCell(
            sheet, 4, 9, ": ${model.birthPlace}, ${model.dob.dateString()}")
        ..updateCell(sheet, 4, 10, ": ${model.name}")
        ..updateCell(sheet, 4, 11, ": ${model.religion}")
        ..updateCell(sheet, 4, 12,
            ": ${model.gender == Gender.male ? "Laki-laki" : "Perempuan"}")
        ..updateCell(sheet, 4, 13, ": ${model.statusMarried}")
        ..updateCell(sheet, 4, 14, ": ${model.nationality}")
        ..updateCell(sheet, 4, 15, ": ${model.job}")
        ..updateCell(sheet, 4, 16, ": ${model.address}")
        ..updateCell(sheet, 4, 18, ": ${DateTime.now().dateString()}")
        ..updateCell(sheet, 4, 19, ": ${getKtp.dateString()}")
        ..updateCell(sheet, 0, 26, model.name);

      // File(join('test/out/${basename(file)}'))
      File("/storage/emulated/0/Download/SKTPS ${model.name}.xlsx")
        ..createSync(recursive: true)
        ..writeAsBytesSync(decoder.encode());
      if (kDebugMode) {
        print('************************************************************');
        for (var table in decoder.tables.keys) {
          print(table);
          print(decoder.tables[table]!.maxCols);
          print(decoder.tables[table]!.maxRows);
          var tab = decoder.tables[table]!.rows;
          for (int i = 0; i < tab.length; i++) {
            print('${i + 1}: ${tab[i]}');
          }
        }
      }

      Fluttertoast.showToast(msg: "File berhasil di download");

      emit(LetterDonwloadSuccess());
    } catch (e, s) {
      Fluttertoast.showToast(msg: "File gagal di donwload");
      if (kDebugMode) {
        print("error: ${e.toString()}, stackrace: $s");
      }

      emit(const LetterDonwloadError("cant donwload"));
    }
  }

  void donwloadSkrr(LetterModel model) async {
    emit(LetterDonwloadLoading());

    try {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      final data = await rootBundle.load('assets/files/skrr.docx');
      final bytes = data.buffer.asUint8List();

      final docx = await DocxTemplate.fromBytes(bytes);

      Content content = Content();
      content
        ..add(TextContent("keyname", model.name))
        ..add(TextContent(
            "keyttl", "${model.birthPlace}, ${model.dob.dateString()}"))
        ..add(TextContent("keyreligion", model.religion))
        ..add(TextContent("keynationality",
            model.nationality == "" ? "Indonesia" : model.nationality))
        ..add(TextContent("keyjob", model.job))
        ..add(TextContent("keyaddress", model.address))
        ..add(TextContent("keydayactivity",
            dayName[(model.activity?.time?.weekday) ?? "Sabtu"]))
        ..add(TextContent("keydateactivity", model.activity?.time.dateString()))
        ..add(TextContent("keyaddressactivity", model.activity?.address));

      final docGenerated = await docx.generate(content);
      String filePath = "/storage/emulated/0/Download/SKRR ${model.name}.docx";

      final fileGenerated = File(filePath);

      if (docGenerated != null) {
        await fileGenerated.writeAsBytes(docGenerated);
        Fluttertoast.showToast(msg: "File berhasil di download");

        emit(LetterDonwloadSuccess());
      } else {
        Fluttertoast.showToast(msg: "File gagal di donwload");

        emit(const LetterDonwloadError("cant donwload"));
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "File gagal di donwload");
      emit(LetterDonwloadError(e.toString()));
    }
  }

  void donwloadSkk(LetterModel model) async {
    emit(LetterDonwloadLoading());

    try {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      final data = await rootBundle.load('assets/files/skk.docx');
      final bytes = data.buffer.asUint8List();

      final docx = await DocxTemplate.fromBytes(bytes);

      Content content = Content();
      content
        ..add(TextContent("keyname", model.name))
        ..add(TextContent("keyaddress", model.address))

        /// RIP
        ..add(TextContent("keynamedeath", model.rip?.name))
        ..add(TextContent("keyaddressdeath", model.rip?.address))
        ..add(TextContent("keyage", model.rip?.age))
        ..add(TextContent(
            "keydaydeath", dayName[model.rip?.deathTime?.weekday] ?? "Senin"))
        ..add(TextContent("keydatedeath", model.rip?.deathTime.dateString()))
        ..add(TextContent("keyatdeath", model.rip?.location))
        ..add(TextContent("keydeathbecause", model.rip?.reason))
        ..add(TextContent("keynow", model.createdAt.dateString()));
      final docGenerated = await docx.generate(content);
      String filePath = "/storage/emulated/0/Download/SKK ${model.name}.docx";

      final fileGenerated = File(filePath);

      if (docGenerated != null) {
        await fileGenerated.writeAsBytes(docGenerated);
        Fluttertoast.showToast(msg: "File berhasil di download");

        emit(LetterDonwloadSuccess());
      } else {
        Fluttertoast.showToast(msg: "File gagal di donwload");

        emit(const LetterDonwloadError("cant donwload"));
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "File gagal di donwload");
      emit(LetterDonwloadError(e.toString()));
    }
  }

  void donwloadSkkl(LetterModel model) async {
    emit(LetterDonwloadLoading());

    try {
      var status = await Permission.storage.status;
      if (!status.isGranted) {
        await Permission.storage.request();
      }
      final data = await rootBundle.load('assets/files/skkl.docx');
      final bytes = data.buffer.asUint8List();

      final docx = await DocxTemplate.fromBytes(bytes);

      Content content = Content();
      content
        ..add(TextContent("keynamechild", model.name))
        ..add(TextContent("keyttl", model.dob.dateStript()))
        ..add(TextContent("keygenderchild",
            model.gender == Gender.male ? "Laki-laki" : "Perempuan"))
        ..add(
            TextContent("keydaychild", dayName[model.dob?.weekday] ?? "Senin"))

        //Father
        ..add(TextContent("keyname2", model.father?.name))
        ..add(TextContent("keyttl2",
            "${model.father?.birthPlace}, ${model.father?.dob.dateString()})"))
        ..add(TextContent(
            "keynationality2",
            model.father?.nationality == ""
                ? "Indonesia"
                : model.father?.nationality))
        ..add(TextContent("keyreligion2", model.father?.religion))
        ..add(TextContent("keyjob2", model.father?.job))
        ..add(TextContent("keyaddress2", model.father?.address))

        // Mother
        ..add(TextContent("keyname", model.mother?.name))
        ..add(TextContent("keyttl",
            "${model.mother?.birthPlace}, ${model.mother?.dob.dateString()})"))
        ..add(TextContent(
            "keynationality",
            model.mother?.nationality == ""
                ? "Indonesia"
                : model.mother?.nationality))
        ..add(TextContent("keyreligion", model.mother?.religion))
        ..add(TextContent("keyjob", model.mother?.job))
        ..add(TextContent("keyaddress", model.mother?.address))
        ..add(TextContent("keynow", model.createdAt.dateString()));

      final docGenerated = await docx.generate(content);
      String filePath = "/storage/emulated/0/Download/SKKL ${model.name}.docx";

      final fileGenerated = File(filePath);

      if (docGenerated != null) {
        await fileGenerated.writeAsBytes(docGenerated);
        Fluttertoast.showToast(msg: "File berhasil di download");

        emit(LetterDonwloadSuccess());
      } else {
        Fluttertoast.showToast(msg: "File gagal di donwload");

        emit(const LetterDonwloadError("cant donwload"));
      }
    } catch (e) {
      Fluttertoast.showToast(msg: "File gagal di donwload");
      emit(LetterDonwloadError(e.toString()));
    }
  }
}

const dayName = {
  1: "Senin",
  2: "Selasa",
  3: "Rabu",
  4: "Kamis",
  5: "Jum'at",
  6: "Sabtu",
  7: "Minggy",
};
