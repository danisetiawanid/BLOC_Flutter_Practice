import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_example/bloc/contact_bloc.dart';
import 'package:flutter_example/screens/add_screen.dart';
import 'package:flutter_example/screens/home_screen.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => ContactBloc()
            ..add(
              const ContactLoad(contacs: [
                // ContactModel(
                //   id: "1",
                //   name: 'Dani',
                //   email: 'danisetiawan@gmail.com',
                // ),
                // ContactModel(
                //   id: "2",
                //   name: 'Ikhsan',
                //   email: 'Ikhsan@gmail.com',
                // ),
              ]),
            ),
        )
      ],
      child: MaterialApp(
        supportedLocales: [
          ...FormBuilderLocalizations.delegate.supportedLocales
        ],
        localizationsDelegates: const [
          FormBuilderLocalizations.delegate,
        ],
        title: 'BLOC Flutter Practice',
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const HomeScreen(),
          '/add': (context) => const AddScreen(),
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
