import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Viewmodels/changepass_viewmodel.dart';
class Changepa extends StatefulWidget {
  Changepa({super.key});

  @override
  State<Changepa> createState() => _ChangepaState();
}

class _ChangepaState extends State<Changepa> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ChangePasswordViewmodel(),
      child: Consumer<ChangePasswordViewmodel>(
        builder: (context, provider, child) {
          return Scaffold(
            appBar: AppBar(
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              title: Text(
                "Change Password",
              ),
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Column(
                  children: [
                    SizedBox(
                      height: 20,
                    ),
                    Card(
                      elevation: 5,
                      child: Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                        ),
                        child: Padding(
                          padding: EdgeInsets.all(
                            15,
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              CircleAvatar(
                                radius: 40,
                                backgroundColor: Colors.blue,
                                child: Icon(
                                  Icons.lock,
                                  size: 30,
                                  color: Colors.white,
                                ),
                              ),
                              SizedBox(
                                height: 10,
                              ),
                              Text(
                                "Change Password",
                                style: TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "Update your account password",
                                style: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: provider.currentPassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Current password",
                        prefixIcon: Icon(
                          Icons.lock,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: provider.newPassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "New password",
                        prefixIcon: Icon(
                          Icons.lock,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    TextField(
                      controller: provider.reenterPassword,
                      obscureText: true,
                      decoration: InputDecoration(
                        labelText: "Re-enter password",
                        prefixIcon: Icon(
                          Icons.lock,
                        ),
                        border: OutlineInputBorder(),
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ElevatedButton(
                      onPressed: () async {
                        await provider.changePassword(
                          context,
                        );
                      },
                      style: ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(
                          Colors.blue,
                        ),
                      ),
                      child: Text(
                        "Change Password",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}