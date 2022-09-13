import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_example/bloc/contact_bloc.dart';
import 'package:flutter_example/model/contact_model.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class AddContactScreen extends StatelessWidget {
  const AddContactScreen({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController controllerId = TextEditingController();
    TextEditingController controllerName = TextEditingController();
    TextEditingController controllerEmail = TextEditingController();

    Widget inputField(String field, TextEditingController controller) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FormBuilder(
            child: Column(
              children: [
                FormBuilderTextField(
                  controller: controller,
                  name: field,
                  validator: FormBuilderValidators.email(),
                  autovalidateMode: AutovalidateMode.always,
                  decoration: InputDecoration(labelText: field),
                ),
              ],
            ),
          )
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Contact'),
      ),
      body: BlocListener<ContactBloc, ContactState>(
        listener: (context, state) {
          if (state is ContactLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Data has been Added'),
            ));
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
                    context.read<ContactBloc>().add(
                          AddContacts(contact: contact),
                        );
                    Navigator.pushNamedAndRemoveUntil(
                        context, '/', (route) => false);
                  },
                  child: const Text('Add Data'),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
