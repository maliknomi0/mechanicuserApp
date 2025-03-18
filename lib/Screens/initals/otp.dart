import 'package:flutter/material.dart';
import 'package:repair/controller/otp_verification_controller.dart'; // ✅ Import Controller

import '../../themes/theme_constants.dart';

class OTPVerificationScreen extends StatefulWidget {
  const OTPVerificationScreen({super.key});

  @override
  _OTPVerificationScreenState createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  final OTPVerificationController _controller =
      OTPVerificationController(); // ✅ Controller Instance

  @override
  void initState() {
    super.initState();
    _controller.startTimer(setState); // ✅ Start Timer
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
        leading: BackButton(
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(p),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Enter OTP',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: mediumspascing),
                const Text(
                  'A 4-digit code has been sent to your email.',
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: mediumspascing),

                // ✅ OTP Input Fields
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(4, (index) {
                    return Padding(
                      padding:
                          const EdgeInsets.symmetric(horizontal: smallspascing),
                      child: SizedBox(
                        width: 50,
                        child: TextField(
                          controller: _controller.otpControllers[index],
                          focusNode: _controller.focusNodes[index],
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.center,
                          maxLength: 1,
                          onChanged: (value) {
                            if (value.isNotEmpty && index < 3) {
                              FocusScope.of(context).requestFocus(
                                  _controller.focusNodes[index + 1]);
                            } else if (value.isEmpty && index > 0) {
                              FocusScope.of(context).requestFocus(
                                  _controller.focusNodes[index - 1]);
                            }
                          },
                          decoration: const InputDecoration(
                            counterText: '',
                            filled: true,
                          ),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    );
                  }),
                ),
                const SizedBox(height: mediumspascing),

                // ✅ Verify OTP Button
                SizedBox(
                  height: buttonhight,
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: () =>
                        _controller.verifyOTP(context, setState, email),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primaryColor,
                    ),
                    child: const Text('Verify OTP',
                        style: TextStyle(color: whiteColor)),
                  ),
                ),
                const SizedBox(height: mediumspascing),

                Center(
                  child: Text(
                    _controller.canResend
                        ? 'You can resend the OTP now.'
                        : 'Resend OTP in ${_controller.remainingTime} seconds',
                  ),
                ),
                const SizedBox(height: mediumspascing),

                Center(
                  child: TextButton(
                    onPressed: _controller.canResend
                        ? () => _controller.resendOTP(context, setState, email)
                        : null,
                    child: Text(
                      'Resend OTP',
                      style: TextStyle(
                        color: _controller.canResend
                            ? lightPrimaryColor
                            : greyColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
