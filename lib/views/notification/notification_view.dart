import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sapekderas/models/notification.dart';
import 'package:sapekderas/view_model/notification/cubit/notification_cubit.dart';

import '../../utils/time_utils.dart';
import '../../utils/utils.dart';

class NotificationView extends StatelessWidget {
  const NotificationView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: true,
        title: Text(
          'Notificaion',
          style: FontsUtils.poppins(fontSize: 25, fontWeight: FontWeight.bold),
        ),
      ),
      body: BlocBuilder<NotificationCubit, NotificationState>(
        builder: (context, state) {
          if (state is NotificationSuccess) {
            return ListView.separated(
              padding: const EdgeInsets.only(top: 24),
              itemBuilder: (context, index) {
                return NotificationItem(
                  data: state.data[index],
                );
              },
              separatorBuilder: (context, index) => const SizedBox(height: 15),
              itemCount: state.data.length,
            );
          }

          return Container();
        },
      ),
    );
  }
}

class NotificationItem extends StatelessWidget {
  final NotificationModel data;
  const NotificationItem({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 24),
              child: Image.asset(
                "assets/images/letter.png",
                height: 40,
                width: 40,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    // "Surat SKU anda sudah berhasil",
                    data.message,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: FontsUtils.poppins(
                        fontSize: 14, fontWeight: FontWeight.w500),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    // "1 jam yang lalu",
                    DifferentTime.diff(data.createdAt!),
                    style: FontsUtils.poppins(
                        fontSize: 12, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }
}
