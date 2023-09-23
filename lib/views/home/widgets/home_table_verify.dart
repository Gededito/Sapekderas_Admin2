part of 'widgets.dart';

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
          final model = state
              .allData; // Ganti dengan cara Anda mendapatkan model dari state

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
                  ...List.generate(
                    model.length,
                    (index) => TableRow(
                      children: example.map((e) {
                        if (e == "") {
                          bool isVerified = model[index].isVerified;

                          return Container(
                            height: 30,
                            alignment: Alignment.center,
                            child: isVerified
                                ? Text("Sudah Verifikasi",
                                    style: FontsUtils.poppins(
                                        fontSize: 12,
                                        fontWeight: FontWeight.normal))
                                : ElevatedButton(
                                    onPressed: isVerified
                                        ? null
                                        : () {
                                            // Lakukan Verifikasi di sini
                                            context
                                                .read<GetUserCubit>()
                                                .verifyUser(model[index]
                                                    .copyWith(
                                                        isVerified: true));
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
