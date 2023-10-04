import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../models/citizen_model.dart';
import '../../models/enums.dart';
import '../../routes/routes.dart';
import '../../utils/utils.dart';
import '../../view_model/citizen/get_citizen/get_citizen_cubit.dart';
import '../add_user/add_user_view.dart';

class CitizensSearch extends StatefulWidget {
  const CitizensSearch({super.key});

  @override
  State<CitizensSearch> createState() => _CitizensSearchState();
}

class _CitizensSearchState extends State<CitizensSearch> {
  final searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: SizedBox(
            height: 45,
            child: TextField(
              controller: searchController,
              onChanged: (value) {
                context.read<GetCitizenCubit>().searchCitizen(value);
              },
              decoration: const InputDecoration(
                suffixIcon: Icon(Icons.search),
                hintText: "Search",
              ),
            ),
          ),
        ),
        GestureDetector(
            onTap: () => Navigator.pushNamed(context, Routes.addUser,
                arguments: const AddUserViewArgs(crud: Crud.create)),
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
    );
  }
}

class CitizensTable extends StatelessWidget {
  final int length;
  final List<CitizenModel> data;
  const CitizensTable({super.key, required this.length, required this.data});

  @override
  Widget build(BuildContext context) {
    const title = [
      "NIK",
      "No. KK",
      "Nama",
      "Action",
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(height: 30),
        Table(
          // defaultColumnWidth: FlexColumnWidth(2),
          border: TableBorder.all(borderRadius: BorderRadius.circular(4)),
          children: [
            TableRow(
                children: title
                    .map((e) => Container(
                        height: 30,
                        color: Colors.blueAccent,
                        alignment: Alignment.center,
                        child: Text(e,
                            style: FontsUtils.poppins(
                                fontSize: 12, fontWeight: FontWeight.bold))))
                    .toList()),
            ...List.generate(
              length,
              (index) => TableRow(
                children: List.generate(
                    4,
                    (dataIndex) => TableRowData(
                          data: data[index],
                          index: dataIndex,
                        )),
              ),
            ),
          ],
        ),
        const SizedBox(height: 120),
      ],
    );
  }
}

class TableRowData extends StatelessWidget {
  final int index;
  final CitizenModel data;
  const TableRowData({
    super.key,
    required this.index,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    if (index == 0) {
      return RowDataText(
        data: data,
        text: data.nik.toString(),
      );
    }
    if (index == 1) {
      return RowDataText(
        data: data,
        text: data.kk.toString(),
      );
    }
    if (index == 2) {
      return RowDataText(
        data: data,
        text: data.name,
      );
    }
    return Container(
      height: 30,
      alignment: Alignment.center,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          InkWell(
            onTap: () {
              final width = MediaQuery.sizeOf(context).width;
              showGeneralDialog(
                  context: context,
                  barrierLabel: "Delete Citizen",
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
                  pageBuilder: (_, __, ___) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          width: double.infinity,
                          margin: const EdgeInsets.fromLTRB(24, 20, 24, 25),
                          padding: const EdgeInsets.fromLTRB(24, 20, 24, 15),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Column(
                            children: [
                              Center(
                                child: Text(
                                  "Anda yakin ingin menghapus ${data.name}",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .copyWith(
                                          fontSize: 14,
                                          color: ColorsUtils.textColor,
                                          fontWeight: FontWeight.bold),
                                ),
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  GestureDetector(
                                    onTap: () {
                                      context
                                          .read<GetCitizenCubit>()
                                          .deleteCitizen(data.nik);
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      width: (width - (24 * 4)) / 2,
                                      color: Colors.transparent,
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Text(
                                        "Ya",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                fontSize: 14,
                                                color: ColorsUtils.textColor,
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: Container(
                                      width: (width - (24 * 4)) / 2,
                                      color: Colors.transparent,
                                      alignment: Alignment.center,
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 10),
                                      child: Text(
                                        "Tidak",
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyLarge!
                                            .copyWith(
                                                fontSize: 14,
                                                color:
                                                    ColorsUtils.contentColorRed,
                                                fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                        const SizedBox(height: 10),
                      ],
                    );
                  });
            },
            // onTap: () => Navigator.pushNamed(context, Routes.addUser,
            // arguments:  AddUserViewArgs(crud: Crud.delete, model: data)),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 2),
              child: Icon(Icons.delete_forever, color: Colors.redAccent),
            ),
          ),
          InkWell(
            onTap: () => Navigator.pushNamed(context, Routes.addUser,
                arguments: AddUserViewArgs(crud: Crud.update, model: data)),
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 2),
              child: Icon(Icons.edit, color: Colors.blueGrey),
            ),
          ),
        ],
      ),
    );
  }
}

class RowDataText extends StatelessWidget {
  final String text;
  final CitizenModel data;
  const RowDataText({
    Key? key,
    required this.text,
    required this.data,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.pushNamed(context, Routes.addUser,
          arguments: AddUserViewArgs(crud: Crud.read, model: data)),
      child: Container(
        height: 30,
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 2),
        child: Text(
          text,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: FontsUtils.poppins(fontSize: 12),
        ),
      ),
    );
  }
}



// class DateTimeSlider extends StatelessWidget {
//   final int selectedItem;
//   final int length;
//   final int plus;
//   final ValueChanged<int> onChanged;
//   final ScrollController? controller;
//   final String text;
//   const DateTimeSlider({
//     Key? key,
//     required this.selectedItem,
//     required this.length,
//     required this.plus,
//     required this.onChanged,
//     this.text = "",
//     this.controller,
//   }) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         const SizedBox(height: 10),
//         Text(text,
//             style: FontsStyles.nunito16.copyWith(
//               color: Styles.blackColor,
//               fontWeight: FontWeight.bold,
//             )),
//         const SizedBox(height: 20),
//         Stack(
//           alignment: Alignment.center,
//           children: [
//             Container(
//               height: 50,
//               width: 70,
//               alignment: Alignment.center,
//               decoration: const BoxDecoration(
//                 border: Border(
//                   top: BorderSide(width: 2, color: Styles.blueColor3),
//                   bottom: BorderSide(width: 2, color: Styles.blueColor3),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 150,
//               width: 100,
//               child: ListWheelScrollView.useDelegate(
//                 // controller: controller,
//                 controller: controller,
//                 itemExtent: 40,
//                 diameterRatio: 4,
//                 perspective: 0.01,
//                 squeeze: .7,
//                 physics: const FixedExtentScrollPhysics(),
//                 onSelectedItemChanged: (index) {
//                   onChanged(index);
//                 },
//                 childDelegate: ListWheelChildLoopingListDelegate(
//                   children: List<Widget>.generate(
//                     length,
//                     (index) => Center(
//                       child: Text(
//                         '${index + plus}',
//                         style: Theme.of(context).textTheme.bodyLarge!.copyWith(
//                               fontSize: 16,
//                               color: selectedItem == (index + plus)
//                                   ? Styles.blackColor
//                                   : Styles.grayColor4,
//                               fontWeight: FontWeight.bold,
//                             ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ],
//     );
//   }
// }