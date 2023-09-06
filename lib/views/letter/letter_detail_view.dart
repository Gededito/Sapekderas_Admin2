import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sapekderas/models/letter_model.dart';

import '../../utils/utils.dart';
import '../../view_model/letter/get_letter/get_letter_cubit.dart';
import 'letter_table_view.dart';
// import 'package:sapekderas/models/letter_model.dart';

class LetterDetailView2 extends StatelessWidget {
  final int index;
  const LetterDetailView2({super.key, this.index = 0});

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
            LetterType.values[index].name.toUpperCase(),
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
              return LetterSearch(
                models: state.allData
                    .where(
                      (element) => element.type == LetterType.values[index],
                    )
                    .toList(),
                title: "",
              );
            }
            return const LetterSearch(
              models: [],
              title: "",
            );
          },
        ),
        //
      ),
    );
  }
}
