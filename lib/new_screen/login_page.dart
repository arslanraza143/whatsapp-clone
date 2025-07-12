import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:whatsapp_clone/new_screen/otp_screen.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController _controller = TextEditingController();
  // Default country (can be any country, here Pakistan)
  Country _selectedCountry = Country(
    name: 'Pakistan',
    countryCode: 'PK',
    phoneCode: '92',
    e164Sc: 0,
    geographic: false,
    level: 0,
    example: '',
    displayName: '',
    displayNameNoCountryCode: '',
    e164Key: '',
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          'Enter your phone number',
          style: TextStyle(
            color: Colors.teal,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.more_vert_outlined, color: Colors.grey),
          ),
        ],
      ),
      body: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 15),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(color: Colors.black, fontSize: 17),
                children: [
                  TextSpan(
                    text:
                        'WhatsApp will send an SMS message to verify your phone number. ',
                  ),
                  TextSpan(
                    text: "What's my number?",
                    style: TextStyle(color: Colors.greenAccent[700]),
                  ),
                ],
              ),
            ),
            SizedBox(height: 15),
            countryCard(context),
            // (${_selectedCountry.phoneCode})
            phoneNumber(),
            // Add your Phone number field and next button here
            //Spacer(),
            //SizedBox(height: 50),
            Expanded(child: Container()),
            InkWell(
              onTap: () {
                if (_controller.text.length < 10 ||
                    _controller.text.length > 10) {
                  showMyDialogueNo();
                } else {
                  showMyDialogue();
                }
              },
              child: Container(
                color: Colors.teal,
                height: 40,
                width: 70,
                child: Center(
                  child: Text(
                    "NEXT",
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 50),
          ],
        ),
      ),
    );
  }

  Widget phoneNumber() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 18),
          child: Container(
            width: MediaQuery.of(context).size.width / 8,

            decoration: BoxDecoration(
              border: Border(
                bottom: BorderSide(color: Colors.teal, width: 1.8),
              ),
            ),
            child: Center(
              child: Text(
                ("+ ${_selectedCountry.phoneCode}"),
                style: TextStyle(fontSize: 20),
              ),
            ),
          ),
        ),
        SizedBox(width: 20),

        Container(
          width: MediaQuery.of(context).size.width / 2,
          //padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
          decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.teal, width: 1.8)),
          ),
          child: TextFormField(
            controller: _controller,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hint: Text('phone number', style: TextStyle(fontSize: 20)),
              border: InputBorder.none,
              contentPadding: EdgeInsets.only(bottom: -17),
            ),
          ),
        ),
      ],
    );
  }

  // Country card widget
  Widget countryCard(BuildContext context) {
    return GestureDetector(
      onTap: () {
        // Show the country picker dialog
        showCountryPicker(
          context: context,
          showPhoneCode: true, // Show phone code along with country name
          onSelect: (Country country) {
            setState(() {
              _selectedCountry = country; // Update the selected country
            });
          },
        );
      },
      child: Container(
        width: MediaQuery.of(context).size.width / 1.5,
        padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.teal, width: 1.8)),
        ),
        child: Row(
          children: [
            // Display the flag emoji of the selected country
            Text(
              _selectedCountry.flagEmoji ??
                  '🇵🇰', // Default to Pakistan flag if null
              style: TextStyle(fontSize: 30),
            ),
            SizedBox(width: 10),
            // Display country name and phone code
            Expanded(
              child: Text(
                _selectedCountry.name,
                style: TextStyle(fontSize: 20),
              ),
            ),
            // Drop down arrow icon
            Icon(Icons.arrow_drop_down, color: Colors.teal),
          ],
        ),
      ),
    );
  }

  Future<void> showMyDialogueNo() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              children: [Text('The number you entered is not correct')],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK', style: TextStyle(color: Colors.teal)),
            ),
          ],
        );
      },
    );
  }

  Future<void> showMyDialogue() {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('You entered the phone number:'),
                SizedBox(height: 10),
                Text(
                  "+${_selectedCountry.phoneCode} ${_controller.text}",
                  style: TextStyle(fontWeight: FontWeight.w600),
                ),
                SizedBox(height: 10),
                Text('Is this OK, or would you like to edit the number?'),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('EDIT', style: TextStyle(color: Colors.teal)),
            ),
            TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (builder) => OtpScreen(
                      selectedNo: _controller.text,
                      phoneCode: _selectedCountry.phoneCode,
                    ),
                  ),
                );
              },
              child: Text('OK', style: TextStyle(color: Colors.teal)),
            ),
          ],
        );
      },
    );
  }
}
