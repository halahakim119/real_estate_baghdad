import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/strings/strings.dart';
import '../../logic/bloc/add_edit_delete_post_bloc.dart';

class AddPostFormText extends StatelessWidget {
  const AddPostFormText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Please provide accurate details and adhere to our policies when submitting your post. Select appropriate options, check relevant checkboxes, and ensure truthful descriptions, prices, and sizes.",
      style: TextStyle(fontSize: 12, color: Colors.grey),
      softWrap: true,
      textAlign: TextAlign.justify,
    );
  }
}

class AddPostFormImages extends StatelessWidget {
  const AddPostFormImages({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Text("Add image/s");
  }
}

class AddPostFormFields extends StatelessWidget {
  const AddPostFormFields({
    Key? key,
    required this.titleController,
    required this.sizeController,
    required this.priceController,
    required this.descriptionController,
  }) : super(key: key);

  final TextEditingController titleController;
  final TextEditingController sizeController;
  final TextEditingController priceController;
  final TextEditingController descriptionController;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        TextFormField(
          controller: titleController,
          keyboardType: TextInputType.text,
          decoration: const InputDecoration(
            labelText: 'Title',
            contentPadding: EdgeInsets.only(top: 5, left: 5, bottom: 5),
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter the title';
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: sizeController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Size',
            contentPadding: EdgeInsets.only(top: 5, left: 5, bottom: 5),
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter the size';
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: priceController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Price',
            contentPadding: EdgeInsets.only(top: 5, left: 5, bottom: 5),
            border: OutlineInputBorder(),
          ),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please enter the price';
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        TextFormField(
          controller: descriptionController,
          decoration: const InputDecoration(
            labelText: 'Description',
            contentPadding: EdgeInsets.only(top: 5, left: 5, bottom: 5),
            border: OutlineInputBorder(),
          ),
        ),
      ],
    );
  }
}

class AddPostFormDropdowns extends StatefulWidget {
  final ValueChanged<String?> onProvinceSelected;
  final ValueChanged<String?> onCategoryTypeSelected;

  const AddPostFormDropdowns({
    Key? key,
    required this.onProvinceSelected,
    required this.onCategoryTypeSelected,
  }) : super(key: key);

  @override
  _AddPostFormDropdownsState createState() => _AddPostFormDropdownsState();
}

class _AddPostFormDropdownsState extends State<AddPostFormDropdowns> {
  String? cityValue;
  String? categoryTypeValue;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        DropdownButtonFormField<String>(
          value: cityValue,
          onChanged: (value) {
            setState(() {
              cityValue = value;
            });
            widget.onProvinceSelected(cityValue);
          },
          decoration: const InputDecoration(
            labelText: 'Province',
            contentPadding: EdgeInsets.only(top: 5, left: 5, bottom: 5),
            border: OutlineInputBorder(),
          ),
          items: provinces
              .map(
                (city) => DropdownMenuItem(
                  value: city,
                  child: Text(city),
                ),
              )
              .toList(),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select the province';
            }
            return null;
          },
        ),
        const SizedBox(height: 10),
        DropdownButtonFormField<String>(
          value: categoryTypeValue,
          onChanged: (value) {
            setState(() {
              categoryTypeValue = value;
            });
            widget.onCategoryTypeSelected(categoryTypeValue);
          },
          decoration: const InputDecoration(
            labelText: 'Category Type',
            contentPadding: EdgeInsets.only(top: 5, left: 5, bottom: 5),
            border: OutlineInputBorder(),
          ),
          items: categoryTypes
              .map(
                (type) => DropdownMenuItem(
                  value: type,
                  child: Text(type),
                ),
              )
              .toList(),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'Please select the category type';
            }
            return null;
          },
        ),
      ],
    );
  }
}

class AddPostFormCheckboxes extends StatefulWidget {
  final ValueChanged<bool> onGarageChecked;
  final ValueChanged<bool> onGardenChecked;
  final ValueChanged<bool> onElectricity24HChecked;
  final ValueChanged<bool> onWater24HChecked;
  final ValueChanged<bool> onInstalledACChecked;

  const AddPostFormCheckboxes({
    Key? key,
    required this.onGarageChecked,
    required this.onGardenChecked,
    required this.onElectricity24HChecked,
    required this.onWater24HChecked,
    required this.onInstalledACChecked,
  }) : super(key: key);

  @override
  _AddPostFormCheckboxesState createState() => _AddPostFormCheckboxesState();
}

class _AddPostFormCheckboxesState extends State<AddPostFormCheckboxes> {
  bool garageChecked = false;
  bool gardenChecked = false;
  bool electricity24HChecked = false;
  bool water24HChecked = false;
  bool installedACChecked = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        CheckboxListTile(
          title: const Text('Garage'),
          value: garageChecked,
          activeColor: Theme.of(context).colorScheme.secondary,
          onChanged: (value) {
            setState(() {
              garageChecked = value ?? false;
            });
            widget.onGarageChecked(garageChecked);
          },
        ),
        CheckboxListTile(
          title: const Text('Garden'),
          activeColor: Theme.of(context).colorScheme.secondary,
          value: gardenChecked,
          onChanged: (value) {
            setState(() {
              gardenChecked = value ?? false;
            });
            widget.onGardenChecked(gardenChecked);
          },
        ),
        CheckboxListTile(
          title: const Text('Electricity 24H'),
          activeColor: Theme.of(context).colorScheme.secondary,
          value: electricity24HChecked,
          onChanged: (value) {
            setState(() {
              electricity24HChecked = value ?? false;
            });
            widget.onElectricity24HChecked(electricity24HChecked);
          },
        ),
        CheckboxListTile(
          title: const Text('Water 24H'),
          activeColor: Theme.of(context).colorScheme.secondary,
          value: water24HChecked,
          onChanged: (value) {
            setState(() {
              water24HChecked = value ?? false;
            });
            widget.onWater24HChecked(water24HChecked);
          },
        ),
        CheckboxListTile(
          title: const Text('Installed AC'),
          activeColor: Theme.of(context).colorScheme.secondary,
          value: installedACChecked,
          onChanged: (value) {
            setState(() {
              installedACChecked = value ?? false;
            });
            widget.onInstalledACChecked(installedACChecked);
          },
        ),
      ],
    );
  }
}

class AddPostFormSliders extends StatefulWidget {
  final ValueChanged<int> onBedroomNumberChanged;
  final ValueChanged<int> onBathroomNumberChanged;

  const AddPostFormSliders({
    Key? key,
    required this.onBedroomNumberChanged,
    required this.onBathroomNumberChanged,
  }) : super(key: key);

  @override
  _AddPostFormSlidersState createState() => _AddPostFormSlidersState();
}

class _AddPostFormSlidersState extends State<AddPostFormSliders> {
  int bedroomNumber = 0;
  int bathroomNumber = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        const Text('Bedroom Number'),
        Slider(
          activeColor: Theme.of(context).colorScheme.secondary,
          thumbColor: Theme.of(context).colorScheme.secondary,
          inactiveColor: Colors.grey.shade200,
          value: bedroomNumber.toDouble(),
          min: 0,
          max: 10,
          label: bedroomNumber.toString(),
          divisions: 10,
          onChanged: (value) {
            setState(() {
              bedroomNumber = value.toInt();
            });
            widget.onBedroomNumberChanged(bedroomNumber);
          },
        ),
        const SizedBox(height: 10),
        const Text('Bathroom Number'),
        Slider(
          activeColor: Theme.of(context).colorScheme.secondary,
          thumbColor: Theme.of(context).colorScheme.secondary,
          inactiveColor: Colors.grey.shade200,
          value: bathroomNumber.toDouble(),
          min: 0,
          max: 10,
          label: bathroomNumber.toString(),
          divisions: 10,
          onChanged: (value) {
            setState(() {
              bathroomNumber = value.toInt();
            });
            widget.onBathroomNumberChanged(bathroomNumber);
          },
        ),
      ],
    );
  }
}
class AddPostFormRadioButtons extends StatefulWidget {
  final ValueChanged<String> onFurnishingStatusSelected;
  final ValueChanged<String> onTypeSelected;

  const AddPostFormRadioButtons({
    Key? key,
    required this.onFurnishingStatusSelected,
    required this.onTypeSelected,
  }) : super(key: key);

  @override
  _AddPostFormRadioButtonsState createState() =>
      _AddPostFormRadioButtonsState();
}

class _AddPostFormRadioButtonsState extends State<AddPostFormRadioButtons> {
  String furnishingStatus = 'furnished'; // Initialize with a default value
  String type = 'SALE'; // Initialize with a default value

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: RadioListTile<String>(
                title: const Text(
                  'Furnished',
                  style: TextStyle(fontSize: 12),
                ),
                activeColor: Theme.of(context).colorScheme.secondary,
                value: 'furnished',
                groupValue: furnishingStatus,
                onChanged: (value) {
                  setState(() {
                    furnishingStatus = value!;
                  });
                  widget.onFurnishingStatusSelected(furnishingStatus);
                },
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                title: const Text(
                  'Unfurnished',
                  style: TextStyle(fontSize: 12),
                ),
                activeColor: Theme.of(context).colorScheme.secondary,
                value: 'unfurnished',
                groupValue: furnishingStatus,
                onChanged: (value) {
                  setState(() {
                    furnishingStatus = value!;
                  });
                  widget.onFurnishingStatusSelected(furnishingStatus);
                },
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: RadioListTile<String>(
                title: const Text(
                  'SALE',
                  style: TextStyle(fontSize: 12),
                ),
                activeColor: Theme.of(context).colorScheme.secondary,
                value: 'SALE',
                groupValue: type,
                onChanged: (value) {
                  setState(() {
                    type = value!;
                  });
                  widget.onTypeSelected(type);
                },
              ),
            ),
            Expanded(
              child: RadioListTile<String>(
                title: const Text(
                  'RENT',
                  style: TextStyle(fontSize: 12),
                ),
                activeColor: Theme.of(context).colorScheme.secondary,
                value: 'RENT',
                groupValue: type,
                onChanged: (value) {
                  setState(() {
                    type = value!;
                  });
                  widget.onTypeSelected(type);
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
