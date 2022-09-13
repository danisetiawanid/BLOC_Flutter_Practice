import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_example/bloc/contact_bloc.dart';
import 'package:flutter_example/model/contact_model.dart';
import 'package:flutter_example/screens/add_contact_screen.dart';
import 'package:flutter_example/screens/contact_screen.dart';
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
              const LoadContacts(contacts: [
                ContactModel(
                  id: '1',
                  name: 'Dani',
                  email: 'danisetiawan@gmail.com',
                ),
                ContactModel(
                  id: '2',
                  name: 'Ikhsan',
                  email: 'Ikhsan@gmail.com',
                ),
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
        title: 'Flutter Demo',
        debugShowCheckedModeBanner: false,
        routes: {
          '/': (context) => const ContactScreen(),
          '/add': (context) => const AddContactScreen(),
          // '/update': (context) => const UpdateContactScreen(),
        },
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
      ),
    );
  }
}
