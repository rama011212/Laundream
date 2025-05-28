import 'package:flutter/material.dart';
import 'package:laundream/presentation/login/login_page.dart';

class RegisterPage extends StatefulWidget {
  @override
  _RegisterPageState createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isObscure = true;

  void _toggleObscure() {
    setState(() {
      _isObscure = !_isObscure;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Image.asset(
            'images/water.png',
            fit: BoxFit.cover,
          ),
          Center(
            child: Padding(
              padding: const EdgeInsets.all(25.0),
              child: Container(
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: Offset(0, 10), // Offset 20 ke bawah
                    ),
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 0,
                      blurRadius: 10,
                      offset: Offset(5, 0), // Offset 10 ke kanan
                    ),
                  ],
                ),
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildFormTextField(
                        labelText: 'Enter your name',
                        prefixIcon: Icons.person,
                        keyboardType: TextInputType.text
                      ),
                      SizedBox(height: 20),
                      _buildFormTextField(
                        labelText: 'Enter your e-mail',
                        prefixIcon: Icons.email,
                        keyboardType: TextInputType.emailAddress
                      ),
                      SizedBox(height: 20),
                      _buildFormTextField(
                        labelText: 'Enter your phone number',
                        prefixIcon: Icons.phone,
                        keyboardType: TextInputType.phone,
                      ),
                      SizedBox(height: 20),
                      _buildPasswordField(),
                      SizedBox(height: 20),
                      _buildConfirmPasswordField(),
                      SizedBox(height: 40),
                      _buildRegisterButton(),
                      SizedBox(height: 20),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => LoginPage()),
                          );
                        },
                        child: Text(
                          'Already have an account? Please Login',
                          style: TextStyle(color: Colors.blue, decoration: TextDecoration.underline),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFormTextField({
    required String labelText,
    required IconData prefixIcon,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return TextFormField(
      decoration: InputDecoration(
        labelText: labelText,
        prefixIcon: Icon(prefixIcon, color: Colors.grey),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.blue),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.blue),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
      keyboardType: keyboardType,
    );
  }

  Widget _buildPasswordField() {
    return TextFormField(
      obscureText: _isObscure,
      decoration: InputDecoration(
        labelText: 'Password',
        prefixIcon: Icon(Icons.lock, color: Colors.grey),
        suffixIcon: IconButton(
          onPressed: _toggleObscure,
          icon: Icon(
            _isObscure ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
            size: 20, // Ukuran ikon disesuaikan di sini
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.blue),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.blue),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  Widget _buildConfirmPasswordField() {
    return TextFormField(
      obscureText: _isObscure,
      decoration: InputDecoration(
        labelText: 'Confirm Password',
        prefixIcon: Icon(Icons.lock_outline, color: Colors.grey),
        suffixIcon: IconButton(
          onPressed: _toggleObscure,
          icon: Icon(
            _isObscure ? Icons.visibility : Icons.visibility_off,
            color: Colors.grey,
            size: 20, // Ukuran ikon disesuaikan di sini
          ),
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.blue),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.blue),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      ),
    );
  }

  Widget _buildRegisterButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {},
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue.shade800,
          minimumSize: Size(double.infinity, 50),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
        ),
        child: Text(
          'Register',
          style: TextStyle(fontSize: 16, color: Colors.white),
        ),
      ),
    );
  }
}
