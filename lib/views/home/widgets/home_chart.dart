part of 'widgets.dart';

class HomeChart2 extends StatefulWidget {
  const HomeChart2({super.key});

  @override
  State<HomeChart2> createState() => _HomeChart2State();
}

class _HomeChart2State extends State<HomeChart2> {
  int? touchedIndex;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetLetterCubit, GetLetterState>(
      builder: (context, state) {
        if (state is GetLetterSuccess) {
          return Column(
            children: [
              Wrap(
                  spacing: 10,
                  runSpacing: 10,
                  alignment: WrapAlignment.center,
                  children: state.pieList
                      .map((e) => Indicator(
                            color: e.color ?? Colors.transparent,
                            text: e.x,
                            isSquare: false,
                            size: touchedIndex == e.index ? 18 : 16,
                            textColor: touchedIndex == e.index
                                ? ColorsUtils.textColor
                                : ColorsUtils.mainTextColor3,
                          ))
                      .toList()),
              Center(
                child: SfCircularChart(
                  series: <CircularSeries>[
                    PieSeries<ChartData, String>(
                        dataSource: state.pieList,
                        pointColorMapper: (ChartData data, _) => data.color,
                        xValueMapper: (ChartData data, _) => data.x,
                        yValueMapper: (ChartData data, _) => data.y,
                        dataLabelMapper: (ChartData data, _) =>
                            data.y.ceil().toString(),
                        onPointTap: (data) {
                          setState(() {
                            touchedIndex = data.pointIndex;
                            Navigator.pushNamed(context, Routes.letterDetail2,
                                arguments: touchedIndex);
                          });
                        },
                        dataLabelSettings: const DataLabelSettings(
                          isVisible: true,
                        ),
                        explode: true,
                        // name: "sad",
                        explodeIndex: touchedIndex,
                        initialSelectedDataIndexes: [1, 2, 34])
                  ],
                ),
              ),
            ],
          );
        }
        return Container();
      },
    );
  }
}

class ChartData {
  final String x;
  final double y;
  final Color? color;
  final int index;
  const ChartData({this.x = "", this.y = 0, this.color, this.index = 0});
}
