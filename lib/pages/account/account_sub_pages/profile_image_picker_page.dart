import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:minimart/services/user_service.dart';
import 'package:minimart/utils/assets.dart';
import 'package:minimart/utils/colors.dart';

class ProfileImagePickerPage extends StatefulWidget {
  const ProfileImagePickerPage({super.key});

  @override
  State<ProfileImagePickerPage> createState() => _ProfileImagePickerPageState();
}

class _ProfileImagePickerPageState extends State<ProfileImagePickerPage> {
  final List<String> avatars = [
    avatarBoy,
    avatarGirl,
    // Add more if available in assets
  ];

  final ImagePicker _picker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        maxWidth: 512,
        maxHeight: 512,
        imageQuality: 75,
      );
      if (image != null) {
        debugPrint("Image picked: ${image.path}");
        UserService().updateProfileImage(path: image.path, isCustom: true);
        if (mounted) Navigator.pop(context, true);
      }
    } catch (e) {
      debugPrint("Error picking image: $e");
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Error picking image: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: AppBar(
        title: const Text("Choose Profile Picture",
            style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: surfaceColor,
        elevation: 0,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Custom Image",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                _buildActionButton(
                  icon: Icons.photo_library_outlined,
                  label: "Gallery",
                  onTap: () => _pickImage(ImageSource.gallery),
                ),
                const SizedBox(width: 15),
                _buildActionButton(
                  icon: Icons.camera_alt_outlined,
                  label: "Camera",
                  onTap: () => _pickImage(ImageSource.camera),
                ),
              ],
            ),
            const SizedBox(height: 30),
            const Text(
              "Predefined Avatars",
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 15),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 3,
                crossAxisSpacing: 15,
                mainAxisSpacing: 15,
              ),
              itemCount: avatars.length,
              itemBuilder: (context, index) {
                final avatar = avatars[index];
                final isSelected =
                    UserService().currentUser["profileImagePath"] == avatar;

                return GestureDetector(
                  onTap: () {
                    UserService()
                        .updateProfileImage(path: avatar, isCustom: false);
                    Navigator.pop(context, true);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: isSelected ? primaryColor : Colors.transparent,
                        width: 3,
                      ),
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                  color: primaryColor.withOpacity(0.4),
                                  blurRadius: 10)
                            ]
                          : null,
                    ),
                    child: CircleAvatar(
                      backgroundImage: AssetImage(avatar),
                      backgroundColor: Colors.transparent,
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 30),
            Center(
              child: TextButton(
                onPressed: () {
                  UserService().updateProfileImage(path: "", isCustom: false);
                  Navigator.pop(context, true);
                },
                child: Text(
                  "Reset to Default",
                  style:
                      TextStyle(color: errorColor, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionButton(
      {required IconData icon,
      required String label,
      required VoidCallback onTap}) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            color: surfaceColor,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: primaryColor.withOpacity(0.3)),
          ),
          child: Column(
            children: [
              Icon(icon, color: primaryColor, size: 32),
              const SizedBox(height: 8),
              Text(label,
                  style: const TextStyle(
                      color: Colors.white, fontWeight: FontWeight.w600)),
            ],
          ),
        ),
      ),
    );
  }
}
