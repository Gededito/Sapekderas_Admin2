import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../view_model/auth/cubit/login_cubit.dart';
import '../view_model/citizen/add_citizen/add_citizen_cubit.dart';
import '../view_model/notification/cubit/notification_cubit.dart';
import '../views/add_user/add_user_view.dart';
import '../views/letter/letter_detail_view.dart';
import '../views/letter/letter_form_view.dart';
import '../views/letter/letter_table_view.dart';
import '../views/login/login_view.dart';
import '../views/main/main_view.dart';
import '../views/notification/notification_view.dart';

class Routes {
  static const login = "login";
  static const main = "main";
  static const addUser = "add-user";
  static const letterTable = "letter-table";
  static const letterDetail = "letter-detail";
  static const notification = "notification";
  static const letterDetail2 = "letter-detail-";
}

class AppRoutes {
  static Route<dynamic>? generateRoute(RouteSettings settings) {
    final args = settings.arguments;
    final settingsUri = Uri.parse(settings.name ?? "/login");
    switch (settingsUri.path) {
      case Routes.login:
        return MaterialPageRoute(
          settings: RouteSettings(name: Routes.login, arguments: args),
          builder: (_) => BlocProvider(
            create: (context) => LoginCubit(),
            child: const LoginView(),
          ),
        );
      case Routes.main:
        return MaterialPageRoute(
          settings: RouteSettings(name: Routes.main, arguments: args),
          builder: (_) {
            final args = settings.arguments as int?;
            return MainView(
              initialPage: args ?? 0,
            );
          },
        );
      case Routes.addUser:
        return MaterialPageRoute(
            settings: RouteSettings(name: Routes.addUser, arguments: args),
            builder: (_) {
              final args = settings.arguments as AddUserViewArgs?;

              return BlocProvider(
                create: (context) => AddCitizenCubit(),
                child: AddUserView(args: args ?? const AddUserViewArgs()),
              );
            });
      case Routes.letterTable:
        return MaterialPageRoute(
            settings: RouteSettings(name: Routes.letterTable, arguments: args),
            builder: (_) {
              final args = settings.arguments as LetterTableViewArgs?;

              return LetterTableView(args: args ?? const LetterTableViewArgs());
            });

      case Routes.letterDetail:
        return MaterialPageRoute(
            settings: RouteSettings(name: Routes.letterDetail, arguments: args),
            builder: (_) {
              final args = settings.arguments as LetterDetailViewArgs?;

              return LetterFormView(args: args ?? const LetterDetailViewArgs());
            });
      case Routes.notification:
        return MaterialPageRoute(
            settings: RouteSettings(name: Routes.letterDetail, arguments: args),
            builder: (_) {
              // final args = settings.arguments as LetterDetailViewArgs?;

              return BlocProvider(
                create: (context) =>
                    NotificationCubit()..getNotificationByAdmin(),
                child: const NotificationView(),
              );
            });

      case Routes.letterDetail2:
        return MaterialPageRoute(
            settings:
                RouteSettings(name: Routes.letterDetail2, arguments: args),
            builder: (_) {
              final args = settings.arguments as int?;

              return LetterDetailView2(index: args ?? 0);
            });
      default:
        return null;
    }
  }
}
