import 'package:flutter/material.dart';
import 'package:flutter_contact_apps/database/db_helper.dart';
import 'package:flutter_contact_apps/model/kontak.dart';

class FormKontak extends StatefulWidget {
  final Kontak? kontak;

  const FormKontak({Key? key, this.kontak}) : super(key: key);

  @override
  State<FormKontak> createState() => _FormKontakState();
}

class _FormKontakState extends State<FormKontak> {
  final DbHelper db = DbHelper();
  final _formKey = GlobalKey<FormState>();

  late TextEditingController nameController;
  late TextEditingController mobileNoController;
  late TextEditingController emailController;
  late TextEditingController companyController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(text: widget.kontak?.name ?? '');
    mobileNoController =
        TextEditingController(text: widget.kontak?.mobileNo ?? '');
    emailController = TextEditingController(text: widget.kontak?.email ?? '');
    companyController =
        TextEditingController(text: widget.kontak?.company ?? '');
  }

  @override
  void dispose() {
    nameController.dispose();
    mobileNoController.dispose();
    emailController.dispose();
    companyController.dispose();
    super.dispose();
  }

  void _saveOrUpdate() async {
    if (_formKey.currentState!.validate()) {
      Kontak kontak = Kontak(
        id: widget.kontak?.id,
        name: nameController.text,
        mobileNo: mobileNoController.text,
        email: emailController.text,
        company: companyController.text,
      );

      if (widget.kontak == null) {
        await db.saveKontak(kontak);
        Navigator.pop(context, 'save');
      } else {
        await db.updateKontak(kontak);
        Navigator.pop(context, 'update');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Text(widget.kontak == null ? 'Add Contact' : 'Edit Contact')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            TextFormField(
              controller: nameController,
              decoration: const InputDecoration(labelText: 'Name'),
              validator: (value) => value!.isEmpty ? 'Name is required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: mobileNoController,
              decoration: const InputDecoration(labelText: 'Phone Number'),
              validator: (value) =>
                  value!.isEmpty ? 'Phone Number is required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
              validator: (value) => value!.isEmpty ? 'Email is required' : null,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: companyController,
              decoration: const InputDecoration(labelText: 'Company'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveOrUpdate,
              child: Text(widget.kontak == null ? 'Save' : 'Update'),
            ),
          ],
        ),
      ),
    );
  }
}