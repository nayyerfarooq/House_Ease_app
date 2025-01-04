import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shift_ease_fyp/Controllers/PasswordViewController.dart';
import 'package:shift_ease_fyp/TeamPortal/Pages/TeamMemberLogin.dart';
import 'package:shift_ease_fyp/widgets/CustomElevatedButton.dart';
import 'package:shift_ease_fyp/widgets/CustomTextWidget.dart';
import 'package:shift_ease_fyp/widgets/custom_snakbar.dart';
import '../../Controllers/LoginController.dart';
import '../../routes/app_routes.dart';
import '../../widgets/custom_text_field.dart';
import '../../widgets/custom_button.dart';

class LoginScreen extends StatelessWidget {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final PasswordViewController _viewController=Get.put(PasswordViewController());
  final LoginController loginController = Get.put(LoginController());
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
            child: Container(
              height: MediaQuery.of(context).size.height,
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/applogo.png',
                      height: 200,
                    ),
                  ),
                  const SizedBox(height: 50),
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
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.forgotPassword);
                      },
                      child: const CustomTextWidget(
                        title: 'Forgot Password?',
                        color: Colors.grey
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Obx((){
                    return loginController.isLoading.value ?
                        const Center(child: CircularProgressIndicator(),):
                    CustomButton(
                      text: 'Login',
                      backgroundColor: Colors.blue.shade800,
                      onPressed:()async{
                          loginController.isLoading.value=true;
                          try{
                            await loginController.loginUser(
                                _emailController.text,
                                _passwordController.text);
                          }catch(e){
                            showErrorSnackbar(e.toString());
                          }finally{
                            loginController.isLoading.value=false;
                          }
                      },
                    );
                  }),
                  const SizedBox(height: 20),
                  const Center(
                    child: CustomTextWidget(
                     title:  'Or continue with',
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 30),
                  _buildSocialButton(
                    context,
                    'Continue with Google',
                    Icons.g_mobiledata,
                    Colors.white,
                    isGoogle: true,
                  ),
                  const SizedBox(height: 10),
                  CustomElevatedButton(
                      text: 'Login as Team Leader',
                      color: Colors.black,
                      padding: 10,
                      radius: 8,
                      backcolor: Colors.lightGreen,
                      path: (){
                        Get.to(TeamMemberLoginPage());
                      },
                  ),
                  const SizedBox(height: 10),
                  Center(
                    child: TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.signup);
                      },
                      child: const CustomTextWidget(
                       title:  "Don't have an account? Sign Up",
                          color: Colors.black,
                          weight: FontWeight.bold,
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

  Widget _buildSocialButton(BuildContext context, String text, IconData icon, Color backgroundColor, {bool isGoogle = false}) {
    return ElevatedButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: isGoogle ? null : Colors.white),
      label: CustomTextWidget(
      title:   text,
        color: isGoogle ? Colors.black : Colors.white,
      ),
      style: ElevatedButton.styleFrom(
        foregroundColor: isGoogle ? Colors.black : Colors.white,
        backgroundColor: backgroundColor,
        minimumSize: const Size(double.infinity, 50),
        side: isGoogle ? const BorderSide(color: Colors.grey) : null,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}
