part of 'widgets.dart';

// class HomeTableVerify extends StatelessWidget {
//   final List<UserModel> model;
//   final String titleApp;
//   final double? fontSize;
//   final bool withTitleApp;
//
//   const HomeTableVerify({
//     super.key,
//     this.titleApp = "",
//     this.fontSize,
//     this.withTitleApp = true,
//     required this.model,
//   });
//
//   @override
//   Widget build(BuildContext context) {     final userCubit = context.watch<GetUserCubit>();
//     final List<UserModel> users = userCubit as List<UserModel>;
//
//     const title = [
//       "Nama",
//       "Status",
//       "Action",
//     ];
//
//     const example = ["1", "2", ""];
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (withTitleApp)
//           Text(
//             titleApp,
//             style: FontsUtils.poppins(
//                 fontSize: fontSize ?? 16, fontWeight: FontWeight.bold),
//           ),
//         const SizedBox(height: 10),
//         Table(
//           // defaultColumnWidth: FlexColumnWidth(2),
//           border: TableBorder.all(borderRadius: BorderRadius.circular(4)),
//           children: [
//             TableRow(
//                 children: title
//                     .map((e) => Container(
//                         height: 30,
//                         color: Colors.blueAccent,
//                         alignment: Alignment.center,
//                         child: Text(e,
//                             style: FontsUtils.poppins(
//                                 fontSize: 12, fontWeight: FontWeight.bold))))
//                     .toList()),
//             ...List.generate(
//               users.length,
//               (index) => TableRow(
//                   children: example
//                       .map((e) => e == ""
//                           ? Container(
//                               height: 30,
//                               alignment: Alignment.center,
//                               child: Row(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   InkWell(
//                                     onTap: () {
//                                       final width =
//                                           MediaQuery.sizeOf(context).width;
//                                       showGeneralDialog(
//                                           context: context,
//                                           barrierLabel: "Delete Citizen",
//                                           barrierDismissible: true,
//                                           barrierColor: Colors.black54,
//                                           transitionDuration:
//                                               const Duration(milliseconds: 300),
//                                           transitionBuilder:
//                                               (_, anim, __, child) {
//                                             return SlideTransition(
//                                               position: Tween(
//                                                       begin: const Offset(0, 1),
//                                                       end: const Offset(0, 0))
//                                                   .animate(anim),
//                                               child: child,
//                                             );
//                                           },
//                                           pageBuilder: (_, __, ___) {
//                                             return Column(
//                                               crossAxisAlignment:
//                                                   CrossAxisAlignment.center,
//                                               mainAxisAlignment:
//                                                   MainAxisAlignment.center,
//                                               children: [
//                                                 Container(
//                                                   width: double.infinity,
//                                                   margin:
//                                                       const EdgeInsets.fromLTRB(
//                                                           24, 20, 24, 25),
//                                                   padding:
//                                                       const EdgeInsets.fromLTRB(
//                                                           24, 20, 24, 15),
//                                                   decoration: BoxDecoration(
//                                                     color: Colors.white,
//                                                     borderRadius:
//                                                         BorderRadius.circular(
//                                                             20),
//                                                   ),
//                                                 ),
//                                                 const SizedBox(height: 10),
//                                               ],
//                                             );
//                                           });
//                                     },
//                                     child: const Padding(
//                                       padding:
//                                           EdgeInsets.symmetric(horizontal: 2),
//                                       child: Icon(Icons.delete_forever,
//                                           color: Colors.redAccent),
//                                     ),
//                                   ),
//                                   InkWell(
//                                     onTap: () {},
//                                     // onTap: () => Navigator.pushNamed(
//                                     //     context, Routes.letterDetail,
//                                     //     arguments: LetterDetailViewArgs(
//                                     //       crud: Crud.update,
//                                     //       model: models[index],
//                                     //     )),
//                                     child: const Padding(
//                                       padding:
//                                           EdgeInsets.symmetric(horizontal: 2),
//                                       child: Icon(Icons.edit,
//                                           color: Colors.blueGrey),
//                                     ),
//                                   ),
//                                   InkWell(
//                                     onTap: () {
//                                       // context
//                                       //     .read<LetterDonwloadCubit>()
//                                       //     .donwload(models[index]);
//                                     },
//                                     child: const Padding(
//                                       padding:
//                                           EdgeInsets.symmetric(horizontal: 2),
//                                       child: Icon(Icons.download,
//                                           color: Colors.blueGrey),
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                             )
//                           : GestureDetector(
//                               // onTap: () => Navigator.pushNamed(
//                               //     context, Routes.letterDetail,
//                               //     arguments: LetterDetailViewArgs(
//                               //       crud: Crud.read,
//                               //       model: models[index],
//                               //     )),
//                               child: Container(
//                                   height: 50,
//                                   alignment: Alignment.center,
//                                   child: Text(
//                                       e == "1"
//                                           ? users[index].name
//                                           : users[index].isVerified.toString(),
//                                       style: FontsUtils.poppins(
//                                           fontSize: 12,
//                                           fontWeight: FontWeight.normal))),
//                             ))
//                       .toList()),
//             ),
//           ],
//         ),
//         const SizedBox(height: 30),
//       ],
//     );
//   }
// }

// class HomeTableVerify extends StatelessWidget {
//   final List<UserModel> model;
//   final String titleApp;
//   final double? fontSize;
//   final bool withTitleApp;
//
//   const HomeTableVerify({
//     Key? key,
//     this.titleApp = "",
//     this.fontSize,
//     this.withTitleApp = true,
//     required this.model,
//   }) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//
//     const title = [
//       "Nama",
//       "Status",
//       "Action",
//     ];
//
//     const example = ["1", "2", ""];
//
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         if (withTitleApp)
//           Text(
//             titleApp,
//             style: FontsUtils.poppins(
//                 fontSize: fontSize ?? 16, fontWeight: FontWeight.bold),
//           ),
//         const SizedBox(height: 10),
//         Table(
//           border: TableBorder.all(
//               borderRadius: BorderRadius.circular(4),
//               color: Colors.blueAccent), // Tambahkan warna border
//           children: [
//             TableRow(
//               children: title
//                   .map(
//                     (e) => Container(
//                   height: 30,
//                   color: Colors.blueAccent,
//                   alignment: Alignment.center,
//                   child: Text(
//                     e,
//                     style: FontsUtils.poppins(
//                       fontSize: 12,
//                       fontWeight: FontWeight.bold,
//                       color: Colors.white, // Tambahkan warna teks
//                     ),
//                   ),
//                 ),
//               )
//                   .toList(),
//             ),
//             ...List.generate(
//               model.length,
//                   (index) => TableRow(
//                 children: example
//                     .map(
//                       (e) => e == ""
//                       ? Container(
//                     height: 30,
//                     alignment: Alignment.center,
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: [
//                         InkWell(
//                           onTap: () {
//                             final width =
//                                 MediaQuery.sizeOf(context).width;
//                             showGeneralDialog(
//                                 context: context,
//                                 barrierLabel: "Delete Citizen",
//                                 barrierDismissible: true,
//                                 barrierColor: Colors.black54,
//                                 transitionDuration:
//                                 const Duration(milliseconds: 300),
//                                 transitionBuilder:
//                                     (_, anim, __, child) {
//                                   return SlideTransition(
//                                     position: Tween(
//                                         begin: const Offset(0, 1),
//                                         end: const Offset(0, 0))
//                                         .animate(anim),
//                                     child: child,
//                                   );
//                                 },
//                                 pageBuilder: (_, __, ___) {
//                                   return Column(
//                                     crossAxisAlignment:
//                                     CrossAxisAlignment.center,
//                                     mainAxisAlignment:
//                                     MainAxisAlignment.center,
//                                     children: [
//                                       Container(
//                                         width: double.infinity,
//                                         margin:
//                                         const EdgeInsets.fromLTRB(
//                                             24, 20, 24, 25),
//                                         padding:
//                                         const EdgeInsets.fromLTRB(
//                                             24, 20, 24, 15),
//                                         decoration: BoxDecoration(
//                                           color: Colors.white,
//                                           borderRadius:
//                                           BorderRadius.circular(
//                                               20),
//                                         ),
//                                         child: Column(
//                                           children: [
//                                             Center(
//                                               child: Text(
//                                                 "Anda yakin ingin menghapus ${model[index].name}",
//                                                 textAlign:
//                                                 TextAlign.center,
//                                                 style: Theme.of(
//                                                     context)
//                                                     .textTheme
//                                                     .bodyLarge!
//                                                     .copyWith(
//                                                     fontSize: 14,
//                                                     color: ColorsUtils
//                                                         .textColor,
//                                                     fontWeight:
//                                                     FontWeight
//                                                         .bold),
//                                               ),
//                                             ),
//                                             const SizedBox(
//                                                 height: 10),
//                                             Row(
//                                               mainAxisAlignment:
//                                               MainAxisAlignment
//                                                   .spaceBetween,
//                                               children: [
//                                                 GestureDetector(
//                                                   onTap: () {
//                                                     // context
//                                                     //     .read<
//                                                     //     GetUserCubit>()
//                                                     //     .deleteData(
//                                                     //     model[
//                                                     //     index]);
//                                                     // Navigator.pop(
//                                                     //     context);
//                                                   },
//                                                   child: Container(
//                                                     width: (width -
//                                                         (24 *
//                                                             4)) /
//                                                         2,
//                                                     color: Colors
//                                                         .transparent,
//                                                     alignment:
//                                                     Alignment
//                                                         .center,
//                                                     padding:
//                                                     const EdgeInsets
//                                                         .symmetric(
//                                                         vertical:
//                                                         10),
//                                                     child: Text(
//                                                       "Ya",
//                                                       style: Theme.of(
//                                                           context)
//                                                           .textTheme
//                                                           .bodyLarge!
//                                                           .copyWith(
//                                                           fontSize:
//                                                           14,
//                                                           color: ColorsUtils
//                                                               .textColor,
//                                                           fontWeight:
//                                                           FontWeight.bold),
//                                                     ),
//                                                   ),
//                                                 ),
//                                                 GestureDetector(
//                                                   onTap: () {
//                                                     // Navigator.pop(
//                                                     //     context);
//                                                   },
//                                                   child: Container(
//                                                     width: (width -
//                                                         (24 *
//                                                             4)) /
//                                                         2,
//                                                     color: Colors
//                                                         .transparent,
//                                                     alignment:
//                                                     Alignment
//                                                         .center,
//                                                     padding:
//                                                     const EdgeInsets
//                                                         .symmetric(
//                                                         vertical:
//                                                         10),
//                                                     child: Text(
//                                                       "Tidak",
//                                                       style: Theme.of(
//                                                           context)
//                                                           .textTheme
//                                                           .bodyLarge!
//                                                           .copyWith(
//                                                           fontSize:
//                                                           14,
//                                                           color: ColorsUtils
//                                                               .contentColorRed,
//                                                           fontWeight:
//                                                           FontWeight.bold),
//                                                     ),
//                                                   ),
//                                                 ),
//                                               ],
//                                             )
//                                           ],
//                                         ),
//                                       ),
//                                       const SizedBox(height: 10),
//                                     ],
//                                   );
//                                 });
//                           },
//                           child: const Padding(
//                             padding:
//                             EdgeInsets.symmetric(horizontal: 2),
//                             child: Icon(Icons.delete_forever,
//                                 color: Colors.redAccent),
//                           ),
//                         ),
//                         InkWell(
//                           onTap: () {},
//                           // onTap: () => Navigator.pushNamed(
//                           //     context, Routes.letterDetail,
//                           //     arguments: LetterDetailViewArgs(
//                           //       crud: Crud.update,
//                           //       model: models[index],
//                           //     )),
//                           child: const Padding(
//                             padding:
//                             EdgeInsets.symmetric(horizontal: 2),
//                             child: Icon(Icons.edit,
//                                 color: Colors.blueGrey),
//                           ),
//                         ),
//                         InkWell(
//                           onTap: () {
//                             // context
//                             //     .read<LetterDonwloadCubit>()
//                             //     .donwload(models[index]);
//                           },
//                           child: const Padding(
//                             padding:
//                             EdgeInsets.symmetric(horizontal: 2),
//                             child: Icon(Icons.download,
//                                 color: Colors.blueGrey),
//                           ),
//                         ),
//                       ],
//                     ),
//                   )
//                       : GestureDetector(
//                         onTap: () {
//                           // if (kDebugMode) {
//                           //   context.read<AddLetterCubit>();
//                           // }
//                         },
//                     child: Container(
//                       height: 50,
//                       alignment: Alignment.center,
//                       child: Text(
//                         e == "1"
//                             ? model[index].name
//                             : model[index].isVerified.toString(),
//                         style: FontsUtils.poppins(
//                           fontSize: 12,
//                           fontWeight: FontWeight.normal,
//                         ),
//                       ),
//                     ),
//                   ),
//                 )
//                     .toList(),
//               ),
//             ),
//           ],
//         ),
//         const SizedBox(height: 30),
//       ],
//     );
//   }
// }

class HomeTableVerify extends StatelessWidget {
  final List<UserModel> model;
  final String titleApp;
  final double? fontSize;
  final bool withTitleApp;

  const HomeTableVerify({
    Key? key,
    this.titleApp = "Verifikasi Pendaftar",
    this.fontSize,
    this.withTitleApp = true,
    required this.model,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetUserCubit, GetUserState>(
      builder: (context, state) {
        if (state is GetUserSuccess) {
          final model = state.allData; // Ganti dengan cara Anda mendapatkan model dari state

          const title = [
            "Nama",
            "Email",
            "Action",
          ];

          const example = ["1", "2", ""];

          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (withTitleApp)
                Text(
                  titleApp,
                  style: FontsUtils.poppins(
                      fontSize: fontSize ?? 16, fontWeight: FontWeight.bold),
                ),
              const SizedBox(height: 10),
              Table(
                border: TableBorder.all(
                    borderRadius: BorderRadius.circular(4),
                    color: Colors.black),
                children: [
                  TableRow(
                    children: title
                        .map(
                          (e) => Container(
                        height: 30,
                        color: Colors.blueAccent,
                        alignment: Alignment.center,
                        child: Text(
                          e,
                          style: FontsUtils.poppins(
                            fontSize: 12,
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    )
                        .toList(),
                  ),
                  ...List.generate(model.length, (index) => TableRow(
                      children: example.map((e) {
                        if (e == "") {
                           bool isVerified = model[index].isVerified;

                          return Container(
                            height: 30,
                            alignment: Alignment.center,
                            child: isVerified
                              ? Text("Sudah Verifikasi", style: FontsUtils.poppins(fontSize: 12, fontWeight: FontWeight.normal))
                              : ElevatedButton(
                              onPressed: isVerified
                                ? null
                                : () {
                                // Lakukan Verifikasi di sini
                                model[index].isVerified = true;
                                BlocProvider.of<GetUserCubit>(context);
                              },
                              child: const Text("Verifikasi"),
                            ),
                          );
                        } else {
                          return GestureDetector(
                            onTap: () {},
                            child: Container(
                              height: 50,
                              alignment: Alignment.center,
                              child: Text(
                                e == "1"
                                    ? model[index].name
                                    : model[index].email,
                                style: FontsUtils.poppins(
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal,
                                ),
                              ),
                            ),
                          );
                        }
                      }).toList(),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),
            ],
          );
        } else {
          if (state is GetUserLoading) {
          // Tampilkan loading indicator atau pesan loading
          return const CircularProgressIndicator();
        } else if (state is GetUserError) {
          // Tampilkan pesan error
          return const Text("Error");
        } else {
          // Tampilkan widget lain jika perlu
          return const SizedBox.shrink();
        }
        }
      },
    );
  }
}
