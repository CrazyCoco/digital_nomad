import 'dart:io';

import 'package:digital_nomad/page/post/post_logic.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PostPage extends StatefulWidget {
  const PostPage({super.key});

  @override
  State<PostPage> createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  final PostLogic logic = Get.put(PostLogic());

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
        statusBarBrightness: Brightness.light,
      ),
      child: Scaffold(
        backgroundColor: const Color(0xFFE8EEF0),
        appBar: AppBar(
          backgroundColor: const Color(0xFFE8EEF0),
          elevation: 0,
          leading: IconButton(
            icon: Image.asset('images/back.png', width: 40, height: 40),
            onPressed: Get.back,
          ),
          title: const Text(
            'Post',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.w600,
            ),
          ),
          centerTitle: true,
        ),
        body: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'What happened?',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 16),
                      TextField(
                        maxLines: 6,
                        maxLength: 500,
                        onChanged: logic.updateContent,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                          counterText: '',
                          hintText: '',
                        ),
                        style: const TextStyle(fontSize: 16, color: Colors.black87),
                      ),
                      GetBuilder<PostLogic>(
                        builder: (l) {
                          return Align(
                            alignment: Alignment.centerRight,
                            child: Text(
                              '${l.content.length}/500',
                              style: const TextStyle(fontSize: 14, color: Colors.black54),
                            ),
                          );
                        },
                      ),
                      const Divider(height: 32),
                      const SizedBox(height: 16),
                      GetBuilder<PostLogic>(
                        builder: (l) {
                          return SizedBox(
                            height: 120,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: l.images.length + 1,
                              itemBuilder: (context, index) {
                                if (index < l.images.length) {
                                  return _buildImageItem(l, index);
                                }
                                return GestureDetector(
                                  onTap: l.addImage,
                                  child: Container(
                                    width: 120,
                                    height: 120,
                                    margin: const EdgeInsets.only(right: 12),
                                    decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(16),
                                    ),
                                    child: const Icon(Icons.add, size: 40, color: Color(0xFF42A5F5)),
                                  ),
                                );
                              },
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24),
              child: Column(
                children: [
                  const Row(
                    children: [
                      Text(
                        '30',
                        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500, color: Colors.black87),
                      ),
                      SizedBox(width: 4),
                      Text('🪙', style: TextStyle(fontSize: 16)),
                      SizedBox(width: 4),
                      Text(
                        'to publish a post',
                        style: TextStyle(fontSize: 16, color: Colors.black54),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  GestureDetector(
                    onTap: logic.post,
                    child: Container(
                      width: double.infinity,
                      height: 54,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(27),
                      ),
                      child: const Center(
                        child: Text(
                          'Post',
                          style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600, color: Colors.white),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Container(
                    width: 140,
                    height: 5,
                    decoration: BoxDecoration(
                      color: Colors.black.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(2.5),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildImageItem(PostLogic l, int index) {
    final imagePath = l.images[index];
    final isLocalFile = !imagePath.startsWith('http') && 
                        (imagePath.endsWith('.png') || 
                         imagePath.endsWith('.jpg') || 
                         imagePath.endsWith('.jpeg'));
    
    return Stack(
      children: [
        Container(
          width: 120,
          height: 120,
          margin: const EdgeInsets.only(right: 12),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: isLocalFile
                ? Image.file(
                    File(imagePath),
                    fit: BoxFit.cover,
                  )
                : Container(
                    color: const Color(0xFFE1F5FE),
                    child: const Center(
                      child: Icon(Icons.image, size: 50, color: Color(0xFF42A5F5)),
                    ),
                  ),
          ),
        ),
        Positioned(
          top: 4,
          right: 16,
          child: GestureDetector(
            onTap: () => l.removeImage(index),
            child: Container(
              width: 24,
              height: 24,
              decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
              child: const Icon(Icons.close, size: 16, color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    Get.delete<PostLogic>();
    super.dispose();
  }
}
