part of 'widgets.dart';

// class PieChartSample1 extends StatefulWidget {
//   const PieChartSample1({super.key});

//   @override
//   State<StatefulWidget> createState() => PieChartSample1State();
// }

// class PieChartSample1State extends State {
//   int touchedIndex = -1;

//   static const _letters = ["SKU", "SKCK", "SKTM", "SKDT"];
//   final colors = [
//     ColorsUtils.contentColorBlue,
//     ColorsUtils.contentColorYellow,
//     ColorsUtils.contentColorPink,
//     ColorsUtils.contentColorGreen,
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return AspectRatio(
//       aspectRatio: 1.3,
//       child: Column(
//         children: <Widget>[
//           const SizedBox(
//             height: 28,
//           ),
//           Row(
//               mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//               children: List.generate(
//                 4,
//                 (index) => Indicator(
//                   color: colors[index],
//                   text: _letters[index],
//                   isSquare: false,
//                   size: touchedIndex == index ? 18 : 16,
//                   textColor: touchedIndex == index
//                       ? ColorsUtils.textColor
//                       : ColorsUtils.mainTextColor3,
//                 ),
//               )),
//           const SizedBox(
//             height: 18,
//           ),
//           BlocBuilder<GetLetterCubit, GetLetterState>(
//             builder: (context, state) {
//               if (state is GetLetterSuccess) {
//                 return Expanded(
//                   child: AspectRatio(
//                     aspectRatio: 1,
//                     child: PieChart(
//                       PieChartData(
//                         pieTouchData: PieTouchData(
//                           touchCallback:
//                               (FlTouchEvent event, pieTouchResponse) {
//                             setState(() {
//                               if (!event.isInterestedForInteractions ||
//                                   pieTouchResponse == null ||
//                                   pieTouchResponse.touchedSection == null) {
//                                 touchedIndex = -1;

//                                 return;
//                               }
//                               touchedIndex = pieTouchResponse
//                                   .touchedSection!.touchedSectionIndex;
//                             });
//                           },
//                         ),
//                         startDegreeOffset: 180,
//                         borderData: FlBorderData(
//                           show: false,
//                         ),
//                         sectionsSpace: 1,
//                         centerSpaceRadius: 0,
//                         sections: showingSections(state.allData),
//                       ),
//                     ),
//                   ),
//                 );
//               }
//               return const SizedBox();
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   List<PieChartSectionData> showingSections(List<LetterModel> letters) {
//     if (letters.isEmpty) {
//       return [
//         PieChartSectionData(
//           color: Colors.white,
//           value: 1,
//           title: '',
//           radius: 80,
//           titlePositionPercentageOffset: 0.55,
//           borderSide:
//               BorderSide(color: ColorsUtils.contentColorWhite.withOpacity(0)),
//         )
//       ];
//     }
//     List<int> total = [0, 0, 0, 0];
//     final length = letters.length;

//     for (var element in letters) {
//       switch (element.type) {
//         case LetterType.sku:
//           total[0] = total[0] + 1;
//           break;
//         case LetterType.skck:
//           total[1] = total[1] + 1;

//           break;
//         case LetterType.sktm:
//           total[2] = total[2] + 1;

//           break;
//         case LetterType.skdt:
//           total[3] = total[3] + 1;

//           break;
//         default:
//       }
//     }

//     return List.generate(
//       4,
//       (i) {
//         return PieChartSectionData(
//           color: colors[i],
//           value: total[i] * 100 / length,
//           title: total[i].toString(),
//           radius: 80,
//           titlePositionPercentageOffset: 0.55,
//           borderSide: i == touchedIndex
//               ? const BorderSide(color: ColorsUtils.contentColorWhite, width: 6)
//               : BorderSide(color: ColorsUtils.contentColorWhite.withOpacity(0)),
//         );
//       },
//     );
//   }
// }

class Indicator extends StatelessWidget {
  const Indicator({
    super.key,
    required this.color,
    required this.text,
    required this.isSquare,
    this.size = 16,
    this.textColor,
  });
  final Color color;
  final String text;
  final bool isSquare;
  final double size;
  final Color? textColor;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: isSquare ? BoxShape.rectangle : BoxShape.circle,
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: textColor,
          ),
        )
      ],
    );
  }
}
