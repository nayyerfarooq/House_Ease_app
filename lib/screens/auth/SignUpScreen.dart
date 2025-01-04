import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shift_ease_fyp/Apis/SignUpApi.dart';
import 'package:shift_ease_fyp/Controllers/PasswordViewController.dart';
import 'package:shift_ease_fyp/widgets/CustomTextWidget.dart';
import 'package:shift_ease_fyp/widgets/custom_snakbar.dart';
import '../../Controllers/SignUpController.dart';
import '../../routes/app_routes.dart';
import '../../utils/custom_clipper.dart';
import '../../widgets/social_media_button.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';

class SignUpScreen extends StatelessWidget {
  final SignupController signupController = Get.put(SignupController());
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();
  final PasswordViewController _viewController=Get.put(PasswordViewController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/login_image3.jpg',
              fit: BoxFit.cover,
            ),
          ),
          SingleChildScrollView(
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  Stack(
                    children: [
                      // Purple background
                      Container(
                        height: 280,
                        color: Colors.blue.shade800,
                      ),
                      // White curve
                      ClipPath(
                        clipper: CurveClipper(),
                        child: Container(
                          height: 250,
                          color: Colors.white,
                        ),
                      ),
                      Positioned(
                        top: 50,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Image.asset(
                            'assets/images/applogo.png',
                            height: 150,
                          ),
                        ),
                      ),
                      const Positioned(
                        top: 220,
                        left: 0,
                        right: 0,
                        child: Center(
                          child: Text(
                            'SignUp Here',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Form fields
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CustomTextField(
                            label: 'Full Name',
                            hint: 'Enter your full name',
                            controller: _nameController,
                          ),
                          const SizedBox(height: 20),
                          CustomTextField(
                            label: 'Email Address',
                            hint: 'Enter your email',
                            keyboardType: TextInputType.emailAddress,
                            controller: _emailController,
                          ),
                          const SizedBox(height: 20),
                          Obx((){
                            return TextFormField(
                              keyboardType: TextInputType.text,
                              controller: _passwordController,
                              obscureText: _viewController.show.value,
                              decoration: InputDecoration(
                                labelText: 'Password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: (){
                                    _viewController.show_password();
                                  },
                                  icon: _viewController.show.value==true?const Icon(Icons.remove_red_eye_outlined):Icon(Icons.remove_red_eye),
                                ),
                              ),
                            );
                          }),
                          const SizedBox(height: 20),
                          Obx((){
                            return TextFormField(
                              keyboardType: TextInputType.text,
                              controller: _confirmPasswordController,
                              obscureText: _viewController.show.value,
                              decoration: InputDecoration(
                                labelText: 'Confirm Password',
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                suffixIcon: IconButton(
                                  onPressed: (){
                                    _viewController.show_password();
                                  },
                                  icon: _viewController.show.value==true?const Icon(Icons.remove_red_eye_outlined):Icon(Icons.remove_red_eye),
                                ),
                              ),
                            );
                          }),
                          const SizedBox(height: 30),
                           Obx((){
                             return signupController.isLoading.value?
                                 const CircularProgressIndicator():
                             CustomButton(
                               text: 'Create New Account',
                               backgroundColor: Colors.blue.shade800,
                               onPressed: () async {
                                 try{
                                  if(_passwordController.text == _confirmPasswordController.text){
                                    await signupController.signupUser(
                                      email: _emailController.text,
                                      password: _passwordController.text,
                                      fullName: _nameController.text,
                                    );
                                    _emailController.clear();
                                    _passwordController.clear();
                                    _nameController.clear();
                                    _confirmPasswordController.clear();
                                  }else{
                                    showErrorSnackbar('Password Is not Same');
                                  }
                                 }catch(e){
                                   showErrorSnackbar(e.toString());
                                 }finally
                                 {
                                       signupController.isLoading.value=false;
                                     }
                               },
                             );
                           }),
                          const SizedBox(height: 20),
                          Text.rich(
                            TextSpan(
                              text: "Already a member? ",
                              children: [
                                TextSpan(
                                  text: "Log in now",
                                  style: const TextStyle(
                                    color: Colors.orange,
                                    fontWeight: FontWeight.bold,
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Get.toNamed(AppRoutes.login);
                                    },
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 25),
                          const CustomTextWidget(
                           title:  'Or continue with',
                            size: 14, weight: FontWeight.bold),
                          const SizedBox(height: 13),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SocialMediaButton(
                                icon: Icons.g_translate,
                                color: Colors.red,
                                onTap: () {},
                              ),
                              const SizedBox(width: 20),
                              SocialMediaButton(
                                icon: Icons.apple,
                                color: Colors.black,
                                onTap: () {},
                              ),
                              const SizedBox(width: 20),
                              SocialMediaButton(
                                icon: Icons.facebook,
                                color: Colors.blue,
                                onTap: () {},
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}