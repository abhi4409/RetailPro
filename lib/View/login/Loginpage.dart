import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Viewmodels/login_viewmodel.dart';

class Log extends StatefulWidget {
  Log({
    super.key,
  });

  @override
  State<Log> createState() => _LogState();
}

class _LogState extends State<Log> {
  @override
  Widget build(
      BuildContext context,
      ) {
    var provider = Provider.of<LoginViewmodel>(
      context,
    );

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 20,
            ),
            child: Column(
              children: [
                SizedBox(
                  height: 10,
                ),
                Container(
                  height: 220,
                  width: 240,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage(
                        "lib/images/logo.png",
                      ),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
                Text(
                  "Welcome Back",
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Login to manage your inventory",
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.grey.shade400,
                  ),
                ),
                SizedBox(
                  height: 25,
                ),
                Container(
                  width: double.infinity,
                  padding: EdgeInsets.all(
                    22,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      22,
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          "Admin Login",
                          style: TextStyle(
                            fontSize: 21,
                            fontWeight: FontWeight.bold,
                            color: Colors.blue,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Text(
                        "Email",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      TextFormField(
                        controller: provider.email,
                        keyboardType: TextInputType.emailAddress,
                        decoration: InputDecoration(
                          hintText: "Enter your email",
                          prefixIcon: Icon(
                            Icons.email_outlined,
                            color: Colors.blue,
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              12,
                            ),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 18,
                      ),
                      Text(
                        "Password",
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      SizedBox(
                        height: 7,
                      ),
                      TextFormField(
                        controller: provider.pass,
                        obscureText: !provider.showPassword,
                        decoration: InputDecoration(
                          hintText: "Enter your password",
                          prefixIcon: Icon(
                            Icons.lock_outline,
                            color: Colors.blue,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              provider.passwordShow();
                            },
                            icon: Icon(
                              provider.showPassword
                                  ? Icons.visibility_off
                                  : Icons.visibility,
                            ),
                          ),
                          filled: true,
                          fillColor: Colors.grey.shade100,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(
                              12,
                            ),
                            borderSide: BorderSide.none,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 28,
                      ),
                      SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: ElevatedButton(
                          onPressed: provider.loading
                              ? null
                              : () async {
                            await provider.adminLogin(
                              context,
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                12,
                              ),
                            ),
                          ),
                          child: provider.loading
                              ? SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                              : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                Icons.login,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Login",
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 40,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}