import 'package:flutter/material.dart';

import '../../../../../core/strings/strings.dart';

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
          maxLength: 50,
          controller: titleController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.surface,
                width: 0.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.tertiary,
                width: 0.5,
              ),
            ),
            floatingLabelStyle:
                TextStyle(color: Theme.of(context).colorScheme.surface),
            labelText: 'Title',
            contentPadding: const EdgeInsets.only(top: 5, left: 5, bottom: 5),
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
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.surface,
                width: 0.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.tertiary,
                width: 0.5,
              ),
            ),
            floatingLabelStyle:
                TextStyle(color: Theme.of(context).colorScheme.surface),
            labelText: 'Size',
            contentPadding: const EdgeInsets.only(top: 5, left: 5, bottom: 5),
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
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.surface,
                width: 0.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.tertiary,
                width: 0.5,
              ),
            ),
            floatingLabelStyle:
                TextStyle(color: Theme.of(context).colorScheme.surface),
            labelText: 'Price',
            contentPadding: const EdgeInsets.only(top: 5, left: 5, bottom: 5),
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
          maxLength: 1000,
          controller: descriptionController,
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.surface,
                width: 0.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.tertiary,
                width: 0.5,
              ),
            ),
            floatingLabelStyle:
                TextStyle(color: Theme.of(context).colorScheme.surface),
            labelText: 'Description',
            contentPadding: const EdgeInsets.only(top: 5, left: 5, bottom: 5),
          ),
        ),
      ],
    );
  }
}

class AddPostFormDropdowns extends StatefulWidget {
  final ValueChanged<String?> onProvinceSelected;
  final ValueChanged<String?> onCategoryTypeSelected;
  final String? initialProvinceValue;
  final String? initialCategoryTypeValue;

  const AddPostFormDropdowns({
    Key? key,
    required this.onProvinceSelected,
    required this.onCategoryTypeSelected,
    this.initialProvinceValue,
    this.initialCategoryTypeValue,
  }) : super(key: key);

  @override
  _AddPostFormDropdownsState createState() => _AddPostFormDropdownsState();
}

class _AddPostFormDropdownsState extends State<AddPostFormDropdowns> {
  String? cityValue;
  String? categoryTypeValue;

  @override
  void initState() {
    super.initState();
    cityValue = widget.initialProvinceValue;
    if (cityValue != null && !provinces.contains(cityValue)) {
      cityValue = null;
    }

    categoryTypeValue = widget.initialCategoryTypeValue;
    if (categoryTypeValue != null &&
        !categoryTypes.contains(categoryTypeValue)) {
      categoryTypeValue = null;
    }
  }

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
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.surface,
                width: 0.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.tertiary,
                width: 0.5,
              ),
            ),
            floatingLabelStyle:
                TextStyle(color: Theme.of(context).colorScheme.surface),
            labelText: 'Province',
            contentPadding: const EdgeInsets.only(top: 5, left: 5, bottom: 5),
          ),
          items: provinces
              .map(
                (city) => DropdownMenuItem<String>(
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
          value: categoryTypeValue, // Set the initial category type value
          onChanged: (value) {
            setState(() {
              categoryTypeValue = value;
            });
            widget.onCategoryTypeSelected(categoryTypeValue);
          },
          decoration: InputDecoration(
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.surface,
                width: 0.5,
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color: Theme.of(context).colorScheme.tertiary,
                width: 0.5,
              ),
            ),
            floatingLabelStyle:
                TextStyle(color: Theme.of(context).colorScheme.surface),
            labelText: 'Category Type',
            contentPadding: const EdgeInsets.only(top: 5, left: 5, bottom: 5),
          ),
          items: categoryTypes
              .map(
                (type) => DropdownMenuItem<String>(
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
  final bool? initialGarageChecked;
  final bool? initialGardenChecked;
  final bool? initialElectricity24HChecked;
  final bool? initialWater24HChecked;
  final bool? initialInstalledACChecked;

  const AddPostFormCheckboxes({
    Key? key,
    required this.onGarageChecked,
    required this.onGardenChecked,
    required this.onElectricity24HChecked,
    required this.onWater24HChecked,
    required this.onInstalledACChecked,
    this.initialGarageChecked,
    this.initialGardenChecked,
    this.initialElectricity24HChecked,
    this.initialWater24HChecked,
    this.initialInstalledACChecked,
  }) : super(key: key);

  @override
  _AddPostFormCheckboxesState createState() => _AddPostFormCheckboxesState();
}

class _AddPostFormCheckboxesState extends State<AddPostFormCheckboxes> {
  late bool garageChecked;
  late bool gardenChecked;
  late bool electricity24HChecked;
  late bool water24HChecked;
  late bool installedACChecked;

  @override
  void initState() {
    super.initState();
    garageChecked = widget.initialGarageChecked ?? false;
    gardenChecked = widget.initialGardenChecked ?? false;
    electricity24HChecked = widget.initialElectricity24HChecked ?? false;
    water24HChecked = widget.initialWater24HChecked ?? false;
    installedACChecked = widget.initialInstalledACChecked ?? false;
  }

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
  final int? initialBedroomNumber;
  final int? initialBathroomNumber;

  const AddPostFormSliders({
    Key? key,
    required this.onBedroomNumberChanged,
    required this.onBathroomNumberChanged,
     this.initialBedroomNumber,
     this.initialBathroomNumber,
  }) : super(key: key);

  @override
  _AddPostFormSlidersState createState() => _AddPostFormSlidersState();
}

class _AddPostFormSlidersState extends State<AddPostFormSliders> {
  late int bedroomNumber;
  late int bathroomNumber;

  @override
  void initState() {
    super.initState();
    bedroomNumber = widget.initialBedroomNumber??0;
    bathroomNumber = widget.initialBathroomNumber??0;
  }

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
  final String? initialFurnishingStatus;
  final String? initialType;

  const AddPostFormRadioButtons({
    Key? key,
    required this.onFurnishingStatusSelected,
    required this.onTypeSelected,
    this.initialFurnishingStatus,
    this.initialType,
  }) : super(key: key);

  @override
  _AddPostFormRadioButtonsState createState() =>
      _AddPostFormRadioButtonsState();
}

class _AddPostFormRadioButtonsState extends State<AddPostFormRadioButtons> {
  late String furnishingStatus;
  late String type;

  @override
  void initState() {
    super.initState();
    furnishingStatus = widget.initialFurnishingStatus??'furnished';
    type = widget.initialType??"SALE";
  }

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
