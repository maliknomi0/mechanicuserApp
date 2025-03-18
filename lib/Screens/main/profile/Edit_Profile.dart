import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:repair/Screens/main/profile/DeleteProfileScreen%20.dart';
import 'package:repair/config.dart';
import 'package:repair/controller/edit_profile_controller.dart';
import 'package:repair/themes/theme_constants.dart';

class EditProfile extends StatefulWidget {
  const EditProfile({super.key});

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final EditProfileController controller = EditProfileController();
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    controller.loadUserData();
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
   appBar: AppBar(
        title: Text("Edit Profile"),
      ),
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 20),

                  // ✅ Profile Picture
                  GestureDetector(
                    onTap: () => controller.pickImage(context, setState),
                    child: Stack(
                      alignment: Alignment.bottomRight,
                      children: [
                        Container(
                          width: 100,
                          height: 100,
                          decoration: BoxDecoration(
                            color: Colors.grey,
                            shape: BoxShape.circle,
                            image: controller.selectedImage != null
                                ? DecorationImage(
                                    image: FileImage(controller.selectedImage!),
                                    fit: BoxFit.cover,
                                  )
                                : DecorationImage(
                                    image: CachedNetworkImageProvider(
                                        '${Configs.baseUrl}${controller.profileImage}'),
                                    fit: BoxFit.cover,
                                  ),
                          ),
                        ),
                        Positioned(
                          right: 5,
                          bottom: 5,
                          child: CircleAvatar(
                            radius: 14,
                            backgroundColor: Colors.white,
                            child: Icon(Icons.camera_alt,
                                color: Colors.black, size: 18),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 20),

                  // ✅ Input Fields
                  _buildTextField("Name", controller.nameController),
                  _buildTextField("E-mail", controller.emailController,
                      isReadOnly: true),
                  _buildTextField("Phone Number", controller.phoneController),
                  _buildGenderDropdown(), // ✅ Gender as Dropdown
                  _buildTextField("Address", controller.addresscontroller),
                  const SizedBox(height: 20),

                  // ✅ Save & Delete Buttons
                  _buildSaveButton(),
                  const SizedBox(height: 10),
                  _buildDeleteAccountButton(),
                ],
              ),
            ),
    );
  }

  // ✅ Custom TextField Widget
  Widget _buildTextField(String label, TextEditingController controller,
      {bool isReadOnly = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black54),
          ),
          TextField(
            controller: controller,
            readOnly: isReadOnly,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.black12),
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Gender Dropdown
  Widget _buildGenderDropdown() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Gender",
            style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: Colors.black54),
          ),
          DropdownButtonFormField<String>(
            value: controller.selectedGender,
            items: ["Male", "Female", "Other"]
                .map((gender) => DropdownMenuItem(
                      value: gender,
                      child: Text(gender),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                controller.selectedGender = value!;
              });
            },
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(color: Colors.black12),
              ),
              filled: true,
              fillColor: Colors.grey.shade100,
            ),
          ),
        ],
      ),
    );
  }

  // ✅ Save Button (Updates Profile)
  Widget _buildSaveButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          padding: EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () async {
          await controller.updateProfile(context, setState);
          Navigator.pop(context);
        },
        child:
            Text("Save", style: TextStyle(fontSize: 16, color: Colors.white)),
      ),
    );
  }

  // ✅ Delete Account Button
  Widget _buildDeleteAccountButton() {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.red,
          padding: EdgeInsets.symmetric(vertical: 15),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
        onPressed: () async {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => DeleteProfileScreen()),
          );
        },
        child: Text("Delete your Account",
            style: TextStyle(fontSize: 16, color: Colors.white)),
      ),
    );
  }
}
