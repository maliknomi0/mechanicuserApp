import 'package:flutter/material.dart';
import 'package:repair/_Configs/routes.dart';
import 'package:repair/_Configs/size_config.dart';
import 'package:repair/config.dart';
import 'package:repair/global/globle.dart';
import 'package:repair/themes/theme_constants.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  @override
  Widget build(BuildContext context) {
    final r = ResponsiveUtils(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Profile',
        ),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(p),
                  child: Container(
                      width: double.infinity,
                      height: r.height(0.17),
                      decoration: BoxDecoration(
                        color: darkPrimaryColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Center(
                                child: CircleAvatar(
                              backgroundColor: whiteColor,
                              radius: 38,
                              backgroundImage: NetworkImage(Configs.baseUrl +
                                  userSD["user"]["profileImage"]),
                              onBackgroundImageError: (_, __) => Icon(
                                Icons.error,
                                color: redColor,
                                size: 38,
                              ),
                            )),
                          ),
                          Expanded(
                            flex: 2,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.center,
                              //spacing: lagespacing,
                              children: [
                                Text(
                                  userSD["user"]["name"],
                                  style: TextStyle(
                                      fontSize: 19, color: whiteColor),
                                ),
                                Text(
                                  userSD["user"]["email"],
                                  style: TextStyle(color: whiteColor),
                                ),
                              ],
                            ),
                          )
                        ],
                      )),
                ),
                SizedBox(height: 20),
                _buildProfileMenuItem(
                  title: "Edit Profile",
                  leadingIcon: Icons.person_outlined,
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.editProfile);
                  },
                ),
                _buildProfileMenuItem(
                  title: "Change Password",
                  leadingIcon: Icons.lock_outline_rounded,
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.ChangePassword);
                  },
                ),
                _buildProfileMenuItem(
                  title: "FAQ's ",
                  leadingIcon: Icons.question_answer_outlined,
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.FAQS);
                  },
                ),
                _buildProfileMenuItem(
                  title: "Terms and Condition",
                  leadingIcon: Icons.privacy_tip_outlined,
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.TermsAndConditions);
                  },
                ),
                _buildProfileMenuItem(
                  title: "Edit Profile",
                  leadingIcon: Icons.person_outlined,
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.editProfile);
                  },
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.ChangePassword);
                  },
                  child: ListTile(
                    leading: Icon(Icons.lock_outline_rounded),
                    title: Text('Change Password'),
                    trailing: Icon(Icons.arrow_forward),
                  ),
                ),
                ListTile(
                  leading: Icon(Icons.privacy_tip_outlined),
                  title: Text('Privacy Policy'),
                  trailing: Icon(Icons.arrow_forward),
                ),
                ListTile(
                  leading: Icon(Icons.policy_outlined),
                  title: Text('Terms and Condition'),
                  trailing: Icon(Icons.arrow_forward),
                ),
                _buildProfileMenuItem(
                  trailingshow: false,
                  title: "Log Out",
                  textColor: redColor,
                  leadingIcon: Icons.logout,
                  iconColor: redColor,
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.editProfile);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // ✅ Custom Profile Menu Item Widget
  Widget _buildProfileMenuItem(
      {required IconData leadingIcon,
      required String title,
      required VoidCallback onTap,
      Color? iconColor = blackColor,
      Color? textColor = blackColor,
      bool? trailingshow = true}) {
    return GestureDetector(
      onTap: onTap,
      child: ListTile(
        leading: Icon(
          leadingIcon,
          color: iconColor,
        ),
        title: Text(
          title,
          style: TextStyle(color: textColor),
        ),
        trailing: trailingshow == true ? const Icon(Icons.arrow_forward) : null,
      ),
    );
  }
}
