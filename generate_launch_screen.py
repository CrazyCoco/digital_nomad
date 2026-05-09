#!/usr/bin/env python3
"""
iOS Launch Screen Generator
Generates launch screen images from source image for different iPhone sizes
"""

import os
import sys
from PIL import Image

# 源图片（用户提供的设计图）
SOURCE_IMAGE = "launch_screen_design.png"
LAUNCH_DIR = "ios/Runner/Assets.xcassets/LaunchImage.imageset"

# iOS Launch Screen 需要的尺寸
LAUNCH_SIZES = {
    "LaunchImage.png": (320, 480),      # iPhone 4/4s (1x)
    "LaunchImage@2x.png": (640, 960),   # iPhone 5/5s/SE (2x)
    "LaunchImage@3x.png": (1242, 2208), # iPhone 6 Plus/6s Plus/7 Plus/8 Plus
}

def create_launch_screen():
    """从设计图生成不同尺寸的启动页"""
    
    # 检查源文件
    if not os.path.exists(SOURCE_IMAGE):
        print(f"❌ 错误：找不到源图片 {SOURCE_IMAGE}")
        print("请将启动页设计图命名为 launch_screen_design.png 并放在项目根目录")
        return False
    
    # 打开源图片
    try:
        source = Image.open(SOURCE_IMAGE)
        print(f"✅ 成功加载设计图：{SOURCE_IMAGE}")
        print(f"   原始尺寸：{source.size[0]}x{source.size[1]}")
    except Exception as e:
        print(f"❌ 错误：无法打开图片 - {e}")
        return False
    
    success_count = 0
    
    for filename, size in LAUNCH_SIZES.items():
        output_path = os.path.join(LAUNCH_DIR, filename)
        
        try:
            # 调整尺寸（使用 LANCZOS 高质量重采样）
            resized = source.resize(size, Image.LANCZOS)
            resized.save(output_path, "PNG")
            print(f"✅ {filename:25} ({size[0]}x{size[1]})")
            success_count += 1
            
        except Exception as e:
            print(f"❌ 生成失败 {filename}: {e}")
    
    return success_count == len(LAUNCH_SIZES)

if __name__ == "__main__":
    print("🔄 生成 iOS 启动页图片...\n")
    success = create_launch_screen()
    
    if success:
        print(f"\n✅ 启动页生成完成！")
        print(f"📂 位置: {LAUNCH_DIR}")
    else:
        print(f"\n❌ 启动页生成失败")
    
    sys.exit(0 if success else 1)
