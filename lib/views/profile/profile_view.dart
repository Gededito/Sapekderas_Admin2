import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sapekderas/models/services/hive_services.dart';

import '../../routes/routes.dart';
import '../../utils/utils.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          'Profil',
          style: FontsUtils.poppins(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Container(
              height: 140,
              width: 140,
              margin: const EdgeInsets.fromLTRB(0, 24, 0, 10),
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('assets/images/user.png'),
                  fit: BoxFit.cover,
                ),
                // color: Colors.green,
                shape: BoxShape.circle,
              ),
            ),
          ),
          Center(
            child: SizedBox(
              width: 120,
              height: 40,
              child: ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: ColorsUtils.bgScaffold,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4),
                      side: const BorderSide(color: Colors.black)),
                ),
                child: Text(
                  'Edit Profil',
                  style: FontsUtils.poppins(
                      fontSize: 14, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 35, 22, 0),
            child: Column(
              children: [
                // Row(
                //   children: [
                //     const Icon(Icons.help_outline, size: 30),
                //     const SizedBox(width: 10),
                //     Text(
                //       "Bantuan",
                //       style: FontsUtils.poppins(
                //           fontSize: 18, fontWeight: FontWeight.normal),
                //     ),
                //   ],
                // ),
                const SizedBox(height: 15),
                InkWell(
                  onTap: () =>
                      Navigator.pushNamed(context, Routes.notification),
                  child: Row(
                    children: [
                      const Icon(Icons.notifications, size: 30),
                      const SizedBox(width: 10),
                      Text(
                        "Notifikasi",
                        style: FontsUtils.poppins(
                            fontSize: 18, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 30),
                InkWell(
                  onTap: () {
                    HiveServices(Hive).deleteAll();
                    Navigator.pushNamedAndRemoveUntil(
                        context, Routes.login, (context) => false);
                  },
                  child: Row(
                    children: [
                      const Icon(Icons.logout, size: 30),
                      const SizedBox(width: 10),
                      Text(
                        "Log out",
                        style: FontsUtils.poppins(
                            fontSize: 18, fontWeight: FontWeight.normal),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
