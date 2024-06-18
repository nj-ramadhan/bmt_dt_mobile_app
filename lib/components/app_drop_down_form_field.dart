import 'package:flutter/material.dart';
import 'app_drop_down_items.dart';

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

class AppDropdownFormBank extends StatelessWidget {
  const AppDropdownFormBank({
    required this.future,
    required this.labelText,
    this.value,
    this.onChanged,
    this.dropdownColor,
    this.hint,
    super.key,
    this.onItemSelected,
  });

  final Future<List<DropdownItemsStringIdModel>> future;
  final String labelText;
  final String? value;
  final void Function(String?)? onChanged;
  final Color? dropdownColor;
  final String? hint;
  final void Function(String)? onItemSelected;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DropdownItemsStringIdModel>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: labelText,
              labelStyle: const TextStyle(
                fontSize: 16,
                color: Colors.black, // Set label color to black
              ),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Colors.black), // Set underline color to black
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(
                    color: Colors
                        .black), // Set underline color to black when focused
              ),
              contentPadding: const EdgeInsets.symmetric(
                  vertical: 8.0, horizontal: 12.0), // Adjust padding
              fillColor: Colors.transparent, // Make background transparent
              filled: false, // Do not fill background
            ),
            value: value,
            dropdownColor: Colors.white, // Set dropdown menu background color
            isExpanded: true,
            hint: Text(hint ?? 'Pilih Salah Satu'),
            items: snapshot.data!.map((e) {
              return DropdownMenuItem<String>(
                value: e.id.toString(),
                child: Text(e.title),
              );
            }).toList(),
            onChanged: (selectedValue) {
              if (onChanged != null) {
                onChanged!(selectedValue);
              }
              if (onItemSelected != null) {
                var selectedItem = snapshot.data!
                    .firstWhere((e) => e.id.toString() == selectedValue);
                onItemSelected!(selectedItem.title);
              }
            },
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
