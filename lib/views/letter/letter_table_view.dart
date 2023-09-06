import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sapekderas/models/letter_model.dart';
import 'package:sapekderas/view_model/letter/get_letter/get_letter_cubit.dart';
import 'package:sapekderas/views/letter/letter_form_view.dart';

import '../../models/enums.dart';
import '../../routes/routes.dart';
import '../../utils/utils.dart';
import '../home/widgets/widgets.dart';

class LetterTableViewArgs {
  final String titleApp;
  final StatusLetter status;

  const LetterTableViewArgs(
      {this.titleApp = "", this.status = StatusLetter.progress});
}

class LetterTableView extends StatelessWidget {
  final LetterTableViewArgs args;
  const LetterTableView({super.key, required this.args});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // automaticallyImplyLeading: false,
        title: GestureDetector(
          onTap: () {
            // if (kDebugMode) {
            //   context.read<AddLetterCubit>();
            // }
          },
          child: Text(
            args.titleApp,
            style:
                FontsUtils.poppins(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(12, 10, 12, 0),
        child: BlocBuilder<GetLetterCubit, GetLetterState>(
          builder: (context, state) {
            if (state is GetLetterSuccess) {
              // return HomeTable(
              //   models: args.status == StatusLetter.error
              //       ? state.errorData
              //       : args.status == StatusLetter.progress
              //           ? state.progressData
              //           : args.status == StatusLetter.success
              //               ? state.successData
              //               : state.allData,
              //   titleApp: args.titleApp,
              //   fontSize: 25,
              //   withTitleApp: false,
              // );
              return LetterSearch(
                models: args.status == StatusLetter.error
                    ? state.errorData
                    : args.status == StatusLetter.progress
                        ? state.progressData
                        : args.status == StatusLetter.success
                            ? state.successData
                            : state.allData,
                title: args.titleApp,
              );
            }
            return LetterSearch(
              models: const [],
              title: args.titleApp,
            );
          },
        ),
        //
      ),
    );
  }
}

class LetterSearch extends StatefulWidget {
  final List<LetterModel> models;
  final String title;
  const LetterSearch({super.key, required this.models, required this.title});

  @override
  State<LetterSearch> createState() => _LetterSearchState();
}

class _LetterSearchState extends State<LetterSearch> {
  final searchController = TextEditingController();
  List<LetterModel> data = [];

  @override
  void initState() {
    super.initState();
    data = widget.models;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Expanded(
                child: SizedBox(
                  height: 45,
                  child: TextField(
                    controller: searchController,
                    onChanged: (value) {
                      data = widget.models
                          .where((element) => element.name
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList();
                      setState(() {});
                    },
                    decoration: const InputDecoration(
                      suffixIcon: Icon(Icons.search),
                      hintText: "Search",
                    ),
                  ),
                ),
              ),
              GestureDetector(
                  onTap: () => Navigator.pushNamed(context, Routes.letterDetail,
                      arguments: const LetterDetailViewArgs(crud: Crud.create)),
                  child: Row(
                    children: [
                      Container(
                        height: 30,
                        width: 30,
                        margin: const EdgeInsets.only(right: 5, left: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(2),
                          color: Colors.black,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 26,
                        ),
                      ),
                      Container(
                          height: 40,
                          padding: const EdgeInsets.symmetric(horizontal: 5),
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.black, width: 2),
                          ),
                          child: Text('Tambah data baru',
                              style: FontsUtils.poppins(
                                  fontSize: 12, fontWeight: FontWeight.bold)))
                    ],
                  )),
            ],
          ),
          HomeTable(
            models: data,
            titleApp: widget.title,
            fontSize: 25,
            withTitleApp: false,
          ),
        ],
      ),
    );
  }
}
