import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:sapekderas/view_model/citizen/get_citizen/get_citizen_cubit.dart';

import '../../utils/utils.dart';
import 'citizen_search.dart';

class CitizensView extends StatelessWidget {
  const CitizensView({super.key});

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: () async {
        context.read<GetCitizenCubit>().getAllCitizen();
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Data Warga',
            style:
                FontsUtils.poppins(fontSize: 25, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 24),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  const CitizensSearch(),
                  BlocBuilder<GetCitizenCubit, GetCitizenState>(
                    builder: (context, state) {
                      if (state is GetCitizenSuccess) {
                        if (state.searchData.isNotEmpty) {
                          return CitizensTable(
                            data: state.searchData,
                            length: state.searchData.length,
                          );
                        } else {
                          return CitizensTable(
                            data: state.allData,
                            length: state.allData.length,
                          );
                        }
                      }
                      return const CitizensTable(
                        data: [],
                        length: 0,
                      );
                    },
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
