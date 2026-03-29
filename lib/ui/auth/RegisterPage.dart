import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {

  final _formKey = GlobalKey<FormState>();

  final _fullName = TextEditingController();
  final _login = TextEditingController();
  final _phone = TextEditingController();
  final _password = TextEditingController();
  final _confirmPassword = TextEditingController();

  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  const SizedBox(height: 10),

                  Text(
                    "Yangi hisob yaratish",
                    style: TextStyle(
                      fontSize: 26,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),

                  const SizedBox(height: 25),

                  _buildTextField(_fullName, "Ism Familiya"),

                  const SizedBox(height: 15),

                  _buildTextField(_login, "Login"),

                  const SizedBox(height: 15),

                  _buildTextField(
                    _phone,
                    "Telefon raqam",
                    keyboardType: TextInputType.phone,
                  ),

                  const SizedBox(height: 15),

                  _buildTextField(
                    _password,
                    "Parol",
                    obscureText: _obscurePassword,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscurePassword = !_obscurePassword;
                        });
                      },
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                  _buildTextField(
                    _confirmPassword,
                    "Parolni tasdiqlang",
                    obscureText: _obscureConfirmPassword,
                    suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _obscureConfirmPassword =
                          !_obscureConfirmPassword;
                        });
                      },
                      icon: Icon(
                        _obscureConfirmPassword
                            ? Icons.visibility_off_outlined
                            : Icons.visibility_outlined,
                      ),
                    ),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Parolni tasdiqlash shart";
                      }
                      if (val != _password.text) {
                        return "Parollar bir xil emas";
                      }
                      return null;
                    },
                  ),

                  SizedBox(height: size.height * 0.08),

                  SizedBox(
                    width: double.infinity,
                    height: 45,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_formKey.currentState!.validate()) {

                          var data = {
                            "fullName": _fullName.text,
                            "login": _login.text,
                            "phone": _phone.text,
                            "password": _password.text,
                          };

                          print(data); // API ga shu yerda yuborasan
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xff20B9E8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(30),
                        ),
                      ),
                      child: const Text(
                        "Ro'yxatdan o'tish",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 15),

                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(
      TextEditingController controller,
      String hint, {
        bool obscureText = false,
        Widget? suffixIcon,
        TextInputType keyboardType = TextInputType.text,
        String? Function(String?)? validator,
      }) {
    return TextFormField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      validator: validator ??
              (val) =>
          val == null || val.isEmpty ? "$hint to'ldirilishi shart" : null,
      decoration: InputDecoration(
        hintText: hint,
        isDense: true,
        contentPadding:
        const EdgeInsets.symmetric(vertical: 13, horizontal: 12),
        suffixIcon: suffixIcon,
        filled: true,
        fillColor: Colors.white,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide:
          BorderSide(color: Colors.grey.shade300, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide:
          BorderSide(color: Colors.blue.shade200, width: 1.8),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide:
          BorderSide(color: Colors.red.shade300, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(30),
          borderSide:
          BorderSide(color: Colors.red.shade400, width: 1.8),
        ),
        errorStyle: TextStyle(
          fontSize: 11,
          height: 0.8,
          color: Colors.red.shade400,
        ),
      ),
    );
  }
}