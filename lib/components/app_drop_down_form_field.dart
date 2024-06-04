import 'package:flutter/material.dart';
import 'dropdown_V2.dart';

class AppDropdownFormField extends StatelessWidget {
  const AppDropdownFormField({
    required this.future,
    required this.labelText,
    this.value,
    this.onChanged,
    this.dropdownColor,
    this.hint,
    super.key,
  });

  final Future<List<DropdownItemsModel>> future;
  final String labelText;
  final String? value;
  final void Function(String?)? onChanged;
  final Color? dropdownColor;
  final String? hint;
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DropdownItemsModel>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return DropdownButtonFormField<String>(
            padding: const EdgeInsets.only(bottom: 20),
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: const TextStyle(fontSize: 16, color: Colors.grey),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 1,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12),
                borderSide: const BorderSide(
                  color: Colors.grey,
                  width: 2,
                ),
              ),
            ),
            value: value,
            dropdownColor: dropdownColor,
            isExpanded: true,
            hint: Text(hint ?? 'Pilih Salah Satu'),
            items: snapshot.data!.map((e) {
              return DropdownMenuItem<String>(
                value: e.id.toString(),
                child: Text(e.title),
              );
            }).toList(),
            onChanged: onChanged,
          );
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else {
          return const CircularProgressIndicator();
        }
      },
    );
  }
}

class AppDropdownList extends StatelessWidget {
  const AppDropdownList({
    required this.items,
    required this.labelText,
    this.value,
    this.onChanged,
    this.dropdownColor,
    this.hint,
    super.key,
  });

  final List<String> items;
  final String labelText;
  final String? value;
  final void Function(String?)? onChanged;
  final Color? dropdownColor;
  final String? hint;

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<String>(
      padding: const EdgeInsets.only(bottom: 20),
      decoration: InputDecoration(
        labelText: labelText,
        labelStyle: const TextStyle(fontSize: 16, color: Colors.grey),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(
            color: Colors.grey,
            width: 2,
          ),
        ),
      ),
      value: value,
      dropdownColor: dropdownColor,
      isExpanded: true,
      hint: Text(hint ?? 'Pilih Salah Satu'),
      items: items.map((String value) {
        return DropdownMenuItem<String>(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: onChanged,
    );
  }
}
