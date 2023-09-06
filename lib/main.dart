import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:sapekderas/routes/routes.dart';
import 'package:sapekderas/utils/utils.dart';
import 'package:sapekderas/view_model/letter/letter_donwoad/letter_donwload_cubit.dart';

import 'firebase_options.dart';
import 'models/services/hive_services.dart';
import 'view_model/citizen/get_citizen/get_citizen_cubit.dart';
import 'view_model/letter/add_letter/add_letter_cubit.dart';
import 'view_model/letter/get_letter/get_letter_cubit.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await HiveServices(Hive).init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final user = HiveServices(Hive).getUser();
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => GetCitizenCubit()),
        BlocProvider(create: (context) => LetterDonwloadCubit()),
        BlocProvider(create: (context) => AddLetterCubit()),
        BlocProvider(create: (context) => GetLetterCubit()),
      ],
      child: MaterialApp(
        title: 'Sapekderas Admin',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
            textTheme: GoogleFonts.poppinsTextTheme(),
            scaffoldBackgroundColor: ColorsUtils.bgScaffold,
            appBarTheme:
                const AppBarTheme(backgroundColor: ColorsUtils.bgScaffold)),
        initialRoute: user.id == "" ? Routes.login : Routes.main,
        onGenerateRoute: AppRoutes.generateRoute,
        onGenerateInitialRoutes: (initialRoute) {
          if (initialRoute == Routes.main) {
            return [
              AppRoutes.generateRoute(const RouteSettings(name: Routes.main))!
            ];
          }
          return [
            AppRoutes.generateRoute(const RouteSettings(name: Routes.login))!
          ];
        },
      ),
    );
  }
}
