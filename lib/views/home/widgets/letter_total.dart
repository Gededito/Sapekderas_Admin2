part of 'widgets.dart';

class LetterTotal extends StatelessWidget {
  const LetterTotal({super.key});

  @override
  Widget build(BuildContext context) {
    const title = [
      "Total permohonan",
      "Total permohonan diproses",
      "Total permohonan selesai",
      "Total permohonan gagal"
    ];
    return BlocBuilder<GetLetterCubit, GetLetterState>(
      builder: (context, state) {
        if (state is GetLetterSuccess) {
          return GridView.builder(
              shrinkWrap: true,
              addAutomaticKeepAlives: false,
              addRepaintBoundaries: false,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: 4,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  mainAxisExtent: 150,
                  crossAxisCount: 2,
                  childAspectRatio: 1,
                  crossAxisSpacing: 20),
              itemBuilder: (context, index) {
                return LetterTotalBox(
                  onTap: () {
                    switch (index) {
                      case 0:
                        Navigator.pushNamed(context, Routes.letterTable,
                            arguments: const LetterTableViewArgs(
                              titleApp: "Total Permohonan",
                              status: StatusLetter.another,
                            ));
                        break;
                      case 1:
                        Navigator.pushNamed(context, Routes.letterTable,
                            arguments: const LetterTableViewArgs(
                              titleApp: "Total Permohonan Diproses",
                              status: StatusLetter.progress,
                            ));
                        break;
                      case 2:
                        Navigator.pushNamed(context, Routes.letterTable,
                            arguments: const LetterTableViewArgs(
                              titleApp: "Total Permohonan Selesai",
                              status: StatusLetter.success,
                            ));
                        break;
                      case 3:
                        Navigator.pushNamed(context, Routes.letterTable,
                            arguments: const LetterTableViewArgs(
                              titleApp: "Total Permohonan Error",
                              status: StatusLetter.error,
                            ));
                        break;
                      default:
                    }
                  },
                  subtitle: title[index],
                  total: index == 0
                      ? state.allData.length
                      : index == 1
                          ? state.progressData.length
                          : index == 2
                              ? state.successData.length
                              : state.errorData.length,
                );
              });
        }
        return GridView.builder(
            shrinkWrap: true,
            addAutomaticKeepAlives: false,
            addRepaintBoundaries: false,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: 4,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                mainAxisExtent: 150,
                crossAxisCount: 2,
                childAspectRatio: 1,
                crossAxisSpacing: 20),
            itemBuilder: (context, index) {
              return LetterTotalBox(
                subtitle: title[index],
                total: null,
              );
            });
      },
    );
  }
}

class LetterTotalBox extends StatelessWidget {
  final int? total;
  final String subtitle;
  final VoidCallback? onTap;

  const LetterTotalBox({super.key, this.total, this.subtitle = "", this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.black, width: 2),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              total == null ? "" : total.toString(),
              style:
                  FontsUtils.poppins(fontSize: 25, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style:
                  FontsUtils.poppins(fontSize: 11, fontWeight: FontWeight.w500),
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Info lebih lanjut",
                  style: FontsUtils.poppins(
                      fontSize: 11, fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 10),
                const Icon(Icons.arrow_circle_right_outlined)
              ],
            ),
          ],
        ),
      ),
    );
  }
}
