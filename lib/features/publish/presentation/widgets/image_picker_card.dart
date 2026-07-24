import 'package:code_connect_app/core/theme/app_colors.dart';
import 'package:code_connect_app/features/publish/presentation/providers/publish_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:path/path.dart' as path;

class ImagePickerCard extends StatelessWidget {
  const ImagePickerCard({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<PublishProvider>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          GestureDetector(
            onTap: provider.pickImage,
            child: Container(
              height: 370,
              width: double.infinity,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: AppColors.grey,
              ),
              child: provider.selectedImage == null
                  ? const Icon(Icons.add_photo_alternate, size: 80)
                  : ClipRRect(
                      borderRadius: BorderRadiusGeometry.circular(12),
                      child: Image.file(
                        provider.selectedImage!,
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
            onPressed: provider.pickImage,
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

          if (provider.selectedImage != null)
            Row(
              children: [
                Expanded(
                  child: Text(path.basename(provider.selectedImage!.path)),
                ),
                IconButton(
                  onPressed: provider.removeImage,
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
