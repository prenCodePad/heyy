import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:heyy/common/app_mixin.dart';
import 'package:heyy/controllers/controllers.dart';
import 'package:heyy/pages/pages.dart';
import 'package:heyy/routing/routes.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

class LoginScreen extends StatelessWidget with AppMixin {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: LoginBackground(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const CircleAvatar(
                radius: 100,
                backgroundColor: Colors.transparent,
                backgroundImage: AssetImage('assets/images/headIcon.jpeg'),
              ),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  'Heyy',
                  style: theme.hwHero(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "connect & socialise",
                  textAlign: TextAlign.center,
                  style: theme.displayTitle2(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 4.0),
                child: Text(
                  "chat with your friends by signing into our app quite quickly and easily",
                  textAlign: TextAlign.center,
                  style: theme.displayHead1(color: Colors.white),
                ),
              ),
              const SizedBox(height: 50),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: SizedBox(
                  height: 72,
                  child: IntlPhoneField(
                    textAlignVertical: TextAlignVertical.center,
                    style: theme.bodySmall(color: Colors.black),
                    initialCountryCode: 'IN',
                    decoration: InputDecoration(
                      fillColor: Colors.white,
                      filled: true,
                      hintText: 'Enter Phone Number',
                      contentPadding: const EdgeInsets.all(8.0),
                      border: OutlineInputBorder(
                        borderSide: BorderSide.none,
                        borderRadius: BorderRadius.circular(25.0),
                      ),
                    ),
                    controller: snc.phoneController,
                    keyboardType: TextInputType.number,
                    onChanged: (ph) => snc.onPhoneNumberChanged(ph.completeNumber),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Button(
                    text: 'SignIn',
                    onPressed: () async {
                      // await snc.getOtp(onComplete: (_) {}).then((value) {});
                      // Navigator.of(context).pop();
                      if (snc.phoneNo.value.isEmpty) {
                        Get.snackbar("Error", "Please provide phone number", backgroundColor: Colors.white);
                        return;
                      }
                      snc.loginView.value = LoginView.otpView;
                      await snc.getOtp(onComplete: (_) {});
                      Navigator.pushNamed(context, Routes.otpPage);
                    }),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
