import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sapekderas/view_model/auth/cubit/get_user_cubit.dart';
import 'package:sapekderas/view_model/letter/get_letter/get_letter_cubit.dart';

import '../../utils/utils.dart';
import '../../view_model/letter/add_letter/add_letter_cubit.dart';
import 'widgets/widgets.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<GetLetterCubit>().getAllData();
        context.read<GetUserCubit>().getAllData();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: GestureDetector(
            onTap: () {
              if (kDebugMode) {
                context.read<AddLetterCubit>().addLetterInstant();
              }
            },
            child: Text(
              'Home',
              style:
                  FontsUtils.poppins(fontSize: 25, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const LetterTotal(),
                  const SizedBox(height: 24),
                  const HomeChart2(),
                  BlocBuilder<GetLetterCubit, GetLetterState>(
                    builder: (context, state) {
                      if (state is GetLetterSuccess) {
                        return HomeTable(
                            models: state.progressData,
                            titleApp: "Surat belum diambil");
                      }
                      return const HomeTable(
                          models: [], titleApp: "Surat belum diambil");
                    },
                  ),
                  const HomeTableVerify(model: []),
                  // BlocBuilder<GetUserCubit, GetUserState>(
                  //   builder: (context, state) {
                  //     if (state is GetUserSuccess) {
                  //       return HomeTableVerify(
                  //         titleApp: "Verifikasi Pengguna", model: state.isVerified,
                  //       );
                  //     }
                  //     return const HomeTableVerify(
                  //       model: [], titleApp: "Verifikasi Penggunaa",
                  //     );
                  //   },
                  // )
                ],
              ),
            )),
      ),
    );
  }
}
