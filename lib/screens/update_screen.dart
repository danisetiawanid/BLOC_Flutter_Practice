import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_example/bloc/contact_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

import '../model/contact_model.dart';

class UpdateScreen extends StatelessWidget {
  final ContactModel contact;
  const UpdateScreen({super.key, required this.contact});

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    // final idFieldKey = GlobalKey<FormBuilderFieldState>();
    // final emailFieldKey = GlobalKey<FormBuilderFieldState>();
    // final nameFieldKey = GlobalKey<FormBuilderFieldState>();
    // final phoneFieldKey = GlobalKey<FormBuilderFieldState>();
    TextEditingController controllerId =
        TextEditingController(text: contact.id);
    TextEditingController controllerName =
        TextEditingController(text: contact.name);
    TextEditingController controllerEmail =
        TextEditingController(text: contact.email);
    TextEditingController controllerPhone =
        TextEditingController(text: contact.phone);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Contact'),
      ),
      body: BlocListener<ContactBloc, ContactState>(
        listener: (context, state) {
          if (state is ContactLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Data has been updated'),
              ),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(
                content: Text('Failed'),
              ),
            );
          }
        },
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Column(
              children: [
                FormBuilder(
                  key: formKey,
                  child: Column(
                    children: [
                      FormBuilderTextField(
                        readOnly: true,
                        controller: controllerId,
                        name: 'ID',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.integer(),
                          FormBuilderValidators.numeric(
                              errorText: 'Field must numeric')
                        ]),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                          labelText: 'ID',
                        ),
                      ),
                      FormBuilderTextField(
                        controller: controllerName,
                        name: 'Name',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.maxLength(10),
                        ]),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                          labelText: 'Name',
                        ),
                      ),
                      FormBuilderTextField(
                        controller: controllerPhone,
                        name: 'Phone',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.integer(),
                          FormBuilderValidators.numeric(
                              errorText: 'Field must Numeric')
                        ]),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                          labelText: 'Phone',
                        ),
                      ),
                      FormBuilderTextField(
                        controller: controllerEmail,
                        name: 'Email',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.email(),
                          FormBuilderValidators.max(10),
                        ]),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                          labelText: 'Email',
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            var contact = ContactModel(
                                id: controllerId.value.text,
                                name: controllerName.value.text,
                                email: controllerEmail.value.text,
                                phone: controllerPhone.value.text);
                            context
                                .read<ContactBloc>()
                                .add(UpdateContact(contact: contact));
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/', (route) => false);
                          }
                        },
                        child: const Text('Save'),
                      )
                    ],
                  ),
                ),
                // ElevatedButton(
                //   onPressed: () {
                //     var contact = ContactModel(
                //       id: controllerId.value.text,
                //       name: controllerName.value.text,
                //       email: controllerEmail.value.text,
                //     );

                //     Navigator.pushNamedAndRemoveUntil(
                //         context, '/', (route) => false);
                //   },
                //   child: const Text('Update Data'),
                // )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
