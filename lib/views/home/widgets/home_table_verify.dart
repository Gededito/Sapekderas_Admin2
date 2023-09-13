import 'package:flutter/material.dart';
import 'package:sapekderas/models/user_model.dart';
import 'package:sapekderas/utils/utils.dart';

class HomeTableVerify extends StatelessWidget {
  final List<UserModel> models;
  final String titleApp;
  final double? fontSize;
  final bool withTitleApp;

  const HomeTableVerify({
    super.key,
    required this.models,
    this.titleApp = "",
    this.fontSize,
    this.withTitleApp = true
  });

  @override
  Widget build(BuildContext context) {
    const title = [
      "Nama",
      "Status",
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
          border: TableBorder.all(borderRadius: BorderRadius.circular(4)),
          children: [
            TableRow(
              children: title.map((e) => Container(
                height: 30,
                color: Colors.blueAccent,
                alignment: Alignment.center,
                child: Text(
                  e,
                  style: FontsUtils.poppins(
                    fontSize: 12,
                    fontWeight: FontWeight.bold
                  ),
                ),
              )).toList()
            ),
            ...List.generate(
              models.length,
                (index) => TableRow(
                  children: example.map((e) => e == ""
                    ? Container(
                    height: 30,
                    alignment: Alignment.center,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {},
                          child: const Padding(
                            padding: EdgeInsets.symmetric(horizontal: 2),
                            child: Icon(
                              Icons.edit,
                              color: Colors.blueGrey,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ): GestureDetector(

                  )).toList(),
                )
            )
          ],
        ),
        const SizedBox(height: 150),
      ],
    );
  }
}