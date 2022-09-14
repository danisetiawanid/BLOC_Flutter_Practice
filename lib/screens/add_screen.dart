import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_example/bloc/contact_bloc.dart';
import 'package:flutter_example/model/contact_model.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:form_builder_validators/form_builder_validators.dart';

class AddScreen extends StatelessWidget {
  const AddScreen({super.key});
  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormBuilderState>();
    final idFieldKey = GlobalKey<FormBuilderFieldState>();
    final emailFieldKey = GlobalKey<FormBuilderFieldState>();
    final nameFieldKey = GlobalKey<FormBuilderFieldState>();
    final phoneFieldKey = GlobalKey<FormBuilderFieldState>();
    TextEditingController controllerId = TextEditingController();
    TextEditingController controllerName = TextEditingController();
    TextEditingController controllerPhone = TextEditingController();
    TextEditingController controllerEmail = TextEditingController();

    // Widget inputField(String field, TextEditingController controller) {
    //   return Column(
    //     crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [],
    //   );
    // }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Contact'),
      ),
      body: BlocListener<ContactBloc, ContactState>(
        listener: (context, state) {
          if (state is ContactLoaded) {
            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
              content: Text('Data has been added'),
            ));
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Failed')),
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
                        key: idFieldKey,
                        controller: controllerId,
                        name: 'ID',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.integer(),
                          FormBuilderValidators.numeric(
                              errorText: 'Field must Numeric')
                        ]),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                          labelText: 'ID',
                        ),
                      ),
                      FormBuilderTextField(
                        key: nameFieldKey,
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
                        keyboardType: TextInputType.phone,
                        key: phoneFieldKey,
                        controller: controllerPhone,
                        name: 'Phone',
                        validator: FormBuilderValidators.compose([
                          FormBuilderValidators.required(),
                          FormBuilderValidators.numeric()
                        ]),
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: const InputDecoration(
                          labelText: 'Phone',
                        ),
                      ),
                      FormBuilderTextField(
                        key: emailFieldKey,
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
                            context.read<ContactBloc>().add(
                                  AddContact(contact: contact),
                                );
                            Navigator.pushNamedAndRemoveUntil(
                                context, '/', (route) => false);
                          }
                        },
                        child: const Text('Save'),
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
