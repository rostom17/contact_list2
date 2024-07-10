import 'package:contact_list2/utilities/app_constants.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _nameTEc = TextEditingController();
  final TextEditingController _phoneNumberTEc = TextEditingController();
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final List<Map<String, dynamic>> _contactList = [];

  void _addToContactList() {
    _contactList.add({
      'name': _nameTEc.text,
      'phoneNumber': _phoneNumberTEc.text,
    });
  }

  void _onPressedAddButton() {
    if (_formKey.currentState!.validate()) {
      _addToContactList();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Number added Successfully"),
          backgroundColor: Colors.green,
        ),
      );
      if (mounted) {
        setState(() {});
      }
      _nameTEc.clear();
      _phoneNumberTEc.clear();
    }
  }

  void onPressedDeleteButton(int index) {
    _contactList.removeAt(index);
    Navigator.of(context).pop();
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    _nameTEc.dispose();
    _phoneNumberTEc.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    final screenWidth = screenSize.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppConstants.myColor,
        title: const Center(
          child: Text(
            'Contact List',
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _nameTEc,
                validator: (String? value) {
                  if (value?.trim().isEmpty == true) {
                    return 'Enter your name';
                  } else {
                    return null;
                  }
                },
                decoration: _buildInputDecoration('Name'),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _phoneNumberTEc,

                validator: (String? value) {
                  if (value?.trim().isEmpty == true) {
                    return 'Enter your phoneNumber';
                  }
                  else if (value?.trim().length != 11 ) {
                    return 'Enter Valid Phone Number';
                  }
                  else {
                    return null;
                  }
                },
                keyboardType: TextInputType.number,
                decoration: _buildInputDecoration('Number'),
              ),
              const SizedBox(
                height: 10,
              ),
              ElevatedButton(
                onPressed: _onPressedAddButton,
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  minimumSize: const Size(double.maxFinite, 40),
                  backgroundColor: AppConstants.myColor,
                ),
                child: const Text(
                  'Add',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                child: _buildListView(screenWidth),
              ),
            ],
          ),
        ),
      ),
    );
  }

  ListView _buildListView(double screenWidth) {
    return ListView.builder(
        itemCount: _contactList.length,
        itemBuilder: (context, index) {
          return GestureDetector(
            onLongPress: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                      ),
                      title: const Text(
                        'Confirmation',
                        style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      content: const Text(
                        'Are you sure for Delete?',
                        style: TextStyle(fontSize: 18),
                      ),
                      actions: [
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Icon(
                              Icons.no_sim_outlined,
                              color: Colors.blue,
                            ),
                            const SizedBox(
                              width: 20,
                            ),
                            IconButton(
                              onPressed: () {
                                onPressedDeleteButton(index);
                              },
                              icon: const Icon(
                                Icons.delete_outline,
                                color: Colors.blue,
                              ),
                            ),
                          ],
                        )
                      ],
                    );
                  });
            },
            child: Card(
              color: Colors.grey.shade100,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    height: 70,
                    width: (1.5 / 10) * screenWidth,
                    child: const Icon(
                      Icons.person,
                      size: 30,
                      color: Colors.brown,
                    ),
                  ),
                  Container(
                    height: 70,
                    width: (6 / 10) * screenWidth,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            _contactList[index]['name'],
                            style: const TextStyle(
                              color: Colors.red,
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            _contactList[index]['phoneNumber'],
                            style: const TextStyle(fontSize: 15),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    width: (1.2 / 10) * screenWidth,
                    child: const Icon(
                      Icons.phone,
                      color: Colors.blue,
                      size: 30,
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }

  InputDecoration _buildInputDecoration( String nameOrNumber) {
    return InputDecoration(
      hintText: nameOrNumber,
        hintStyle: TextStyle(
          color: Colors.grey.shade500,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(4),
          borderSide: const BorderSide(width: 4, color: Color(0xFF677483)),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(width: 2, color: Color(0xFF677483)),
        ));
  }
}
