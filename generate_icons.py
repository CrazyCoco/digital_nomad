#!/usr/bin/env python3
"""
iOS App Icon Generator
Generates all required icon sizes from a single source image
"""

import os
import sys
from PIL import Image

# 源图片路径
SOURCE_IMAGE = "app_icon.png"
ICON_DIR = "ios/Runner/Assets.xcassets/AppIcon.appiconset"

# 所有需要的图标尺寸
ICON_SIZES = {
    "Icon-App-20x20@1x.png": (20, 20),
    "Icon-App-20x20@2x.png": (40, 40),
    "Icon-App-20x20@3x.png": (60, 60),
    "Icon-App-29x29@1x.png": (29, 29),
    "Icon-App-29x29@2x.png": (58, 58),
    "Icon-App-29x29@3x.png": (87, 87),
    "Icon-App-40x40@1x.png": (40, 40),
    "Icon-App-40x40@2x.png": (80, 80),
    "Icon-App-40x40@3x.png": (120, 120),
    "Icon-App-60x60@2x.png": (120, 120),
    "Icon-App-60x60@3x.png": (180, 180),
    "Icon-App-76x76@1x.png": (76, 76),
    "Icon-App-76x76@2x.png": (152, 152),
    "Icon-App-83.5x83.5@2x.png": (167, 167),
    "Icon-App-1024x1024@1x.png": (1024, 1024),
}

def generate_icons():
    # 检查源文件
    if not os.path.exists(SOURCE_IMAGE):
        print(f"❌ 错误：找不到源图片 {SOURCE_IMAGE}")
        print("请将图标文件命名为 app_icon.png 并放在项目根目录")
        return False
    
    # 检查 PIL
    try:
        from PIL import Image
    except ImportError:
        print("❌ 错误：需要安装 Pillow 库")
        print("请运行：pip3 install Pillow")
        return False
    
    # 打开源图片
    try:
        source = Image.open(SOURCE_IMAGE)
        print(f"✅ 成功加载源图片：{SOURCE_IMAGE}")
        print(f"   原始尺寸：{source.size[0]}x{source.size[1]}")
    except Exception as e:
        print(f"❌ 错误：无法打开图片 - {e}")
        return False
    
    # 确保图标目录存在
    if not os.path.exists(ICON_DIR):
        print(f"❌ 错误：图标目录不存在 - {ICON_DIR}")
        return False
    
    # 生成所有尺寸
    print(f"\n🔄 开始生成图标...")
    print(f"📂 目标目录：{ICON_DIR}\n")
    
    success_count = 0
    for filename, size in ICON_SIZES.items():
        output_path = os.path.join(ICON_DIR, filename)
        
        try:
            # 调整尺寸（使用 LANCZOS 高质量重采样）
            resized = source.resize(size, Image.LANCZOS)
            resized.save(output_path, "PNG")
            print(f"✅ {filename:35} ({size[0]}x{size[1]})")
            success_count += 1
        except Exception as e:
            print(f"❌ 生成失败 {filename}: {e}")
    
    print(f"\n{'='*60}")
    print(f"✅ 完成！成功生成 {success_count}/{len(ICON_SIZES)} 个图标")
    print(f"{'='*60}")
    
    return success_count == len(ICON_SIZES)

if __name__ == "__main__":
    success = generate_icons()
    sys.exit(0 if success else 1)
