import 'dart:io';
import 'package:code_connect_app/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart' as path;

class ImagePickerCard extends StatelessWidget {
  final File? selectedImage;
  final VoidCallback? onPickImage;
  final VoidCallback? onRemoveImage;

  const ImagePickerCard({
    super.key,
    this.selectedImage,
    this.onPickImage,
    this.onRemoveImage,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          GestureDetector(
            onTap: onPickImage,
            child: Container(
              height: 370,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.grey,
              ),
              child: selectedImage == null
                  ? const Icon(Icons.add_photo_alternate, size: 80)
                  : ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(12),
                      child: Image.file(
                        selectedImage!,
                        fit: BoxFit.cover,
                      ),
                    ),
            ),
          ),

          const SizedBox(height: 16),

          OutlinedButton(
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(double.infinity, 51),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadiusGeometry.circular(12),
              ),
              side: const BorderSide(color: AppColors.greyMedium, width: 2),
            ),
            onPressed: onPickImage,
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'Carregar Imagem',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                SizedBox(width: 8),
                Icon(Icons.upload, size: 24, color: AppColors.greyLight),
              ],
            ),
          ),

          if (selectedImage != null)
            Row(
              children: [
                Expanded(
                  child: Text(path.basename(selectedImage!.path)),
                ),
                IconButton(
                  onPressed: onRemoveImage,
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
