import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Viewmodels/profile_viewmodel.dart';

class Myprof extends StatefulWidget {
  Myprof({
    super.key,
  });

  @override
  State<Myprof> createState() => _MyprofState();
}

class _MyprofState extends State<Myprof> {
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
          "Your Profile",
        ),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: provider.loading
          ? Center(
        child: CircularProgressIndicator(),
      )
          : SingleChildScrollView(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 20,
            ),
            Center(
              child: Stack(
                children: [
                  CircleAvatar(
                    radius: 55,
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
                      size: 70,
                      color: Colors.blue,
                    )
                        : null,
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: GestureDetector(
                      onTap: provider.imageUploading
                          ? null
                          : () async {
                        await provider.pickProfileImage(
                          context,
                        );
                      },
                      child: CircleAvatar(
                        backgroundColor: Colors.blue,
                        radius: 20,
                        child: provider.imageUploading
                            ? SizedBox(
                          height: 18,
                          width: 18,
                          child: CircularProgressIndicator(
                            strokeWidth: 2,
                            color: Colors.white,
                          ),
                        )
                            : Icon(
                          Icons.camera_alt,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: 20,
            ),
            TextField(
              controller: provider.name,
              readOnly: !provider.edit,
              decoration: InputDecoration(
                labelText: "Name",
                prefixIcon: Icon(
                  Icons.person,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: provider.phone,
              readOnly: !provider.edit,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: "Mob",
                prefixIcon: Icon(
                  Icons.phone,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: provider.email,
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Email",
                prefixIcon: Icon(
                  Icons.email,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            TextField(
              controller: provider.role,
              readOnly: true,
              decoration: InputDecoration(
                labelText: "Role",
                prefixIcon: Icon(
                  Icons.verified,
                ),
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(
              height: 30,
            ),
            GestureDetector(
              onTap: () async {
                if (!provider.edit) {
                  provider.enableEdit();
                } else {
                  await provider.updateProfile(
                    context,
                  );
                }
              },
              child: Container(
                height: 45,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  borderRadius: BorderRadius.circular(
                    8,
                  ),
                ),
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        provider.edit ? Icons.save : Icons.edit,
                        color: Colors.white,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        provider.edit ? "Save Profile" : "Edit Profile",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
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