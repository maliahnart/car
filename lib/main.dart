import 'package:car/config/app_router.dart';
import 'package:car/config/state/parking_lot_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';
void main() async{
  // Load env file
  await dotenv.load(fileName: "assets/.env");
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
       BlocProvider<ParkingLotBloc>(create: (context) => ParkingLotBloc()), 

      ],
      child: MaterialApp.router(
        routerConfig: AppRouter.router,
        title: 'Parking Management',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          scaffoldBackgroundColor: Colors.grey[50]
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
