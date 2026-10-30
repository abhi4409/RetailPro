import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Viewmodels/profile_viewmodel.dart';
import '../login/Loginpage.dart';
import 'Aboutus.dart';
import 'Changepass.dart';
import 'Myprofile.dart';
import 'Privacy_policy.dart';

class Prof extends StatefulWidget {
  Prof({
    super.key,
  });

  @override
  State<Prof> createState() => _ProfState();
}

class _ProfState extends State<Prof> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
          (_) {
        Provider.of<ProfileViewmodel>(
          context,
          listen: false,
        ).getProfile();
      },
    );
  }

  @override
  Widget build(
      BuildContext context,
      ) {
    var provider = Provider.of<ProfileViewmodel>(
      context,
    );

    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Profile",
        ),
        backgroundColor: Colors.lightBlueAccent,
        foregroundColor: Colors.white,
      ),
      body: provider.loading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : SingleChildScrollView(
        padding: EdgeInsets.all(
          12,
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: EdgeInsets.all(
                15,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(
                  20,
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black12,
                    blurRadius: 8,
                    offset: Offset(
                      0,
                      3,
                    ),
                  ),
                ],
              ),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundColor: Colors.cyan,
                    backgroundImage: provider.profileImage != null
                        ? MemoryImage(
                      provider.profileImage!,
                    )
                        : provider.profileImageUrl.isNotEmpty
                        ? NetworkImage(
                      provider.profileImageUrl,
                    )
                        : null,
                    child: provider.profileImage == null &&
                        provider.profileImageUrl.isEmpty
                        ? Icon(
                      Icons.person,
                      size: 55,
                      color: Colors.blue,
                    )
                        : null,
                  ),
                  SizedBox(
                    width: 18,
                  ),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          provider.name.text.isEmpty
                              ? "Admin"
                              : provider.name.text,
                          style: TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Text(
                          provider.role.text,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 14,
                          ),
                        ),
                        SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.email_outlined,
                              size: 18,
                              color: Colors.grey.shade600,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Expanded(
                              child: Text(
                                provider.email.text,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 6,
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.phone,
                              size: 18,
                              color: Colors.grey.shade600,
                            ),
                            SizedBox(
                              width: 6,
                            ),
                            Expanded(
                              child: Text(
                                provider.phone.text.isEmpty
                                    ? "No phone number"
                                    : provider.phone.text,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: 13,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 25,
            ),
            Card(
              elevation: 4,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                  15,
                ),
              ),
              child: Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.blue.shade50,
                      child: Icon(
                        Icons.person,
                        color: Colors.blue,
                      ),
                    ),
                    title: Text(
                      "My Profile",
                    ),
                    subtitle: Text(
                      "View and edit your profile",
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                    onTap: () async {
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Myprof(),
                        ),
                      );

                      if (!context.mounted) return;

                      await Provider.of<ProfileViewmodel>(
                        context,
                        listen: false,
                      ).getProfile();
                    },
                  ),
                  Divider(
                    height: 1,
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.orange.shade50,
                      child: Icon(
                        Icons.lock,
                        color: Colors.orange,
                      ),
                    ),
                    title: Text(
                      "Change password",
                    ),
                    subtitle: Text(
                      "Update your password",
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Changepa(),
                        ),
                      );
                    },
                  ),
                  Divider(
                    height: 1,
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.purple.shade50,
                      child: Icon(
                        Icons.privacy_tip_outlined,
                        color: Colors.purple,
                      ),
                    ),
                    title: Text(
                      "Privacy policy",
                    ),
                    subtitle: Text(
                      "Terms & privacy policy",
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => Terms(
                            mdFilename: 'terms.md',
                          ),
                        ),
                      );
                    },
                  ),
                  Divider(
                    height: 1,
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.teal.shade50,
                      child: Icon(
                        Icons.info_outline,
                        color: Colors.teal,
                      ),
                    ),
                    title: Text(
                      "About app",
                    ),
                    subtitle: Text(
                      "Version 1.0.0",
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AboutScreen(),
                        ),
                      );
                    },
                  ),
                  Divider(
                    height: 1,
                  ),
                  ListTile(
                    leading: CircleAvatar(
                      backgroundColor: Colors.red.shade100,
                      child: Icon(
                        Icons.logout,
                        color: Colors.red,
                      ),
                    ),
                    title: Text(
                      "Logout",
                      style: TextStyle(
                        color: Colors.red,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    subtitle: Text(
                      "Sign out from your account",
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios,
                      size: 16,
                    ),
                    onTap: () {
                      showDialog(
                        context: context,
                        builder: (dialogContext) {
                          return AlertDialog(
                            title: Text(
                              "Logout",
                            ),
                            content: Text(
                              "Are you sure you want to logout?",
                            ),
                            actions: [
                              ElevatedButton(
                                onPressed: () {
                                  Navigator.pop(
                                    dialogContext,
                                  );
                                },
                                child: Text(
                                  "Cancel",
                                ),
                              ),
                              ElevatedButton(
                                onPressed: () async {
                                  Navigator.pop(
                                    dialogContext,
                                  );

                                  await provider.logout();

                                  if (!context.mounted) return;

                                  ScaffoldMessenger.of(
                                    context,
                                  ).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "Logged out successfully",
                                      ),
                                      backgroundColor: Colors.green,
                                    ),
                                  );

                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => Log(),
                                    ),
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.red,
                                  foregroundColor: Colors.white,
                                ),
                                child: Text(
                                  "Logout",
                                ),
                              ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 30,
            ),
          ],
        ),
      ),
    );
  }
}