import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_example/bloc/contact_bloc.dart';

import '../model/contact_model.dart';

class UpdateContactScreen extends StatelessWidget {
  final ContactModel contact;
  const UpdateContactScreen({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    TextEditingController controllerId =
        TextEditingController(text: contact.id);
    TextEditingController controllerName =
        TextEditingController(text: contact.name);
    TextEditingController controllerEmail =
        TextEditingController(text: contact.email);

    Widget inputField(String field, TextEditingController controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('$field : '),
          Container(
            height: 50,
            margin: const EdgeInsets.only(bottom: 10),
            width: double.infinity,
            child: TextFormField(
              controller: controller,
            ),
          )
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Contact'),
      ),
      body: BlocListener<ContactBloc, ContactState>(
        listener: (context, state) {
          if (state is ContactLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Data has been Update'),
              ),
            );
          }
        },
        child: Card(
          child: Padding(
            padding: const EdgeInsets.all(8),
            child: Column(
              children: [
                inputField('ID', controllerId),
                inputField('Name', controllerName),
                inputField('Email', controllerEmail),
                ElevatedButton(
                  onPressed: () {
                    var contact = ContactModel(
                      id: controllerId.value.text,
                      name: controllerName.value.text,
                      email: controllerEmail.value.text,
                    );
                    context
                        .read<ContactBloc>()
                        .add(UpdateContacts(contact: contact));
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (route) => false);
                  },
                  child: const Text('Update Data'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
