import 'package:flutter/material.dart';
import 'package:otp_text_field_v2/otp_field_v2.dart';

class OtpScreen extends StatefulWidget {
  final String selectedNo;
  final String phoneCode;
  const OtpScreen({
    super.key,
    required this.selectedNo,
    required this.phoneCode,
  });

  @override
  State<OtpScreen> createState() => _OtpScreenState();
}

class _OtpScreenState extends State<OtpScreen> {
  TextEditingController _controller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        centerTitle: true,
        title: Text(
          "Verify +${widget.phoneCode} ${widget.selectedNo}",
          style: TextStyle(
            color: Colors.teal,
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        actions: [
          IconButton(onPressed: () {}, icon: Icon(Icons.more_vert_outlined, color: Colors.grey,)),
        ],
      ),
      body: Container(
        padding: EdgeInsets.all(10),
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.white,
        child: Column(
          children: [
            SizedBox(height: 15),
            RichText(
              textAlign: TextAlign.center,
              text: TextSpan(
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
                children: [
                  TextSpan(
                    text:
                        'Waiting to automatically detect an SMS sent to +${widget.phoneCode} ${widget.selectedNo}. ',
                    style: TextStyle(fontWeight: FontWeight.w700),
                  ),
                  TextSpan(
                    text: "Wrong number?",
                    style: TextStyle(color: Colors.lightBlueAccent),
                  ),
                ],
              ),
            ),
            SizedBox(height: 10),
            OTPCode(),
            SizedBox(height: 10),
            Text(
              "Enter 6-Digit code",
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            ListTile(
              leading: Icon(Icons.message, color: Colors.grey),
              title: Text(
                'Resend SMS',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 15),
              ),
              trailing: Text(
                '03:00',
                style: TextStyle(fontWeight: FontWeight.w700),
              ),
            ),
            Divider(),
            ListTile(
              leading: Icon(Icons.call, color: Colors.teal),
              title: Text(
                'Call me',
                style: TextStyle(color: Colors.teal, fontSize: 15),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget OTPCode() {
    return OTPTextFieldV2(
      //textFieldAlignment: MainAxisAlignment.spaceAround,
      length: 6,
      width: MediaQuery.of(context).size.width - 100,
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldWidth: 45,
      fieldStyle: FieldStyle.underline,
      outlineBorderRadius: 15,
      style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
      onChanged: (pin) {
        print("Changed: " + pin);
      },
      onCompleted: (pin) {
        print("Completed: " + pin);
      },
    );
  }

  // Widget otpCode() {
  //   return Container(
  //     width: MediaQuery.of(context).size.width / 2,
  //     padding: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
  //     decoration: BoxDecoration(
  //       border: Border(bottom: BorderSide(color: Colors.teal, width: 1.8)),
  //     ),
  //     child: Center(
  //       child: TextFormField(
  //         controller: _controller,
  //         keyboardType: TextInputType.number,
  //         decoration: InputDecoration(
  //           hint: Center(
  //             child: Text(
  //               '- - -  - - -',
  //               style: TextStyle(fontSize: 50, color: Colors.grey),
  //             ),
  //           ),
  //           border: InputBorder.none,
  //           contentPadding: EdgeInsets.only(bottom: -22),
  //         ),
  //       ),
  //     ),
  //   );
  // }
}
