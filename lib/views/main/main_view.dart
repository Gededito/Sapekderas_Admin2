import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sapekderas/utils/utils.dart';
import 'package:sapekderas/view_model/citizen/get_citizen/get_citizen_cubit.dart';

import '../../view_model/letter/get_letter/get_letter_cubit.dart';
import '../citizens/citizens_view.dart';
import '../home/home_view.dart';
import '../letter/letter_view.dart';
import '../profile/profile_view.dart';

class MainView extends StatefulWidget {
  final int initialPage;
  const MainView({super.key, required this.initialPage});

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  late PageController pageController;
  final listIcon = <IconData>[
    Icons.home,
    Icons.supervised_user_circle,
    Icons.edit_document,
    Icons.person,
  ];

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: widget.initialPage);
    currentIndex = widget.initialPage;
    context.read<GetCitizenCubit>().getAllCitizen();
    context.read<GetLetterCubit>().getAllData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
        controller: pageController,
        physics: const NeverScrollableScrollPhysics(),
        onPageChanged: (index) {
          setState(() {
            currentIndex = index;
          });
        },
        children: const [
          HomeView(),
          CitizensView(),
          LetterView(),
          ProfileView(),
        ],
      ),
      bottomNavigationBar: Material(
        elevation: 5,
        child: Container(
          height: 65,
          width: double.infinity,
          color: ColorsUtils.bgScaffold,
          child: Row(
            children: List.generate(
              listIcon.length,
              (index) => BottomIcon(
                icon: listIcon[index],
                isActive: currentIndex == index,
                onTap: () {
                  setState(() {
                    currentIndex = index;
                  });
                  pageController.jumpToPage(
                    currentIndex,
                  );
                },
              ),
            ),
          ),
        ),
      ),
      // floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      // floatingActionButton: Material(
      //   elevation: 5,
      //   child: SizedBox(
      //     height: 65,
      //     width: double.infinity,
      //     child: Row(
      //       children: List.generate(
      //         6,
      //         (index) => BottomIcon(
      //           icon: listIcon[index],
      //           isActive: currentIndex == index,
      //           onTap: () {
      //             setState(() {
      //               currentIndex = index;
      //             });
      //             pageController.jumpToPage(
      //               currentIndex,
      //             );
      //           },
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
    );
  }
}

class BottomIcon extends StatelessWidget {
  final IconData icon;
  final bool isActive;
  final VoidCallback? onTap;
  const BottomIcon(
      {super.key, required this.icon, this.isActive = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.sizeOf(context).width;
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 65,
        width: width / 4,
        child: Icon(
          icon,
          color: isActive ? Colors.black : Colors.grey,
        ),
      ),
    );
  }
}
