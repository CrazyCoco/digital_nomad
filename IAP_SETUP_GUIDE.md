# iOS 内购配置指南

## 1. App Store Connect 配置步骤

### 1.1 创建内购产品

1. 登录 [App Store Connect](https://appstoreconnect.apple.com/)
2. 选择你的应用
3. 点击左侧菜单的 **"功能"** > **"App 内购买项目"**
4. 点击 **"+"** 按钮创建新的内购产品

### 1.2 创建消耗型产品（金币包）

需要创建以下4个产品：

| 产品名称 | 产品 ID | 价格层级 | 金币数量 |
|---------|---------|---------|---------|
| 100 Coins | `com.digitalnomad.coins.100` | Tier 1 ($0.99) | 100 |
| 500 Coins | `com.digitalnomad.coins.500` | Tier 5 ($4.99) | 500 |
| 1000 Coins | `com.digitalnomad.coins.1000` | Tier 10 ($9.99) | 1000 |
| 5000 Coins | `com.digitalnomad.coins.5000` | Tier 40 ($39.99) | 5000 |

### 1.3 填写产品信息

对于每个产品，需要填写：

1. **参考名称**: 例如 "100 Coins Package"
2. **产品 ID**: 例如 `com.digitalnomad.coins.100`
3. **类型**: 选择 **"消耗型"** (Consumable)
4. **价格**: 选择合适的价格层级
5. **语言信息**:
   - 显示名称: "100 Coins"
   - 描述: "Get 100 coins to use in the app"
6. **审核截图**: 上传内购界面的截图（必需）

### 1.4 提交审核

- 确保所有产品状态为 **"准备提交"**
- 在提交应用更新时，勾选这些内购产品一起审核

---

## 2. Xcode 配置

### 2.1 启用 In-App Purchase 能力

1. 打开 Xcode 项目
2. 选择 Target
3. 点击 **"Signing & Capabilities"**
4. 点击 **"+ Capability"**
5. 添加 **"In-App Purchase"**

### 2.2 配置 Bundle ID

确保 Bundle ID 与 App Store Connect 中的一致：
```
com.yourcompany.digitalnomad
```

---

## 3. 测试内购

### 3.1 创建沙盒测试账号

1. 登录 [App Store Connect](https://appstoreconnect.apple.com/)
2. 进入 **"用户和访问"** > **"沙盒"** > **"测试员"**
3. 点击 **"+"** 创建测试账号
4. 填写测试账号信息（使用真实的邮箱格式，但不需要真实邮箱）

### 3.2 在设备上测试

1. 在 iOS 设备上退出 Apple ID
2. 运行应用
3. 点击购买时，使用沙盒测试账号登录
4. **注意**: 沙盒环境不会真正扣费

### 3.3 常见测试问题

**问题**: "Cannot connect to iTunes Store"
- 解决: 确保设备已联网，且使用沙盒账号

**问题**: "You've already purchased this"
- 解决: 这是正常提示，点击 OK 继续

**问题**: 产品列表为空
- 解决: 
  1. 检查产品 ID 是否正确
  2. 确认产品在 App Store Connect 中状态为 "Ready to Submit" 或更高
  3. 等待几小时让 Apple 服务器同步

---

## 4. 代码中的产品 ID 映射

在 `recharge_logic.dart` 中配置的产品 ID：

```dart
static const List<String> _productIds = [
  'com.digitalnomad.coins.100',
  'com.digitalnomad.coins.500',
  'com.digitalnomad.coins.1000',
  'com.digitalnomad.coins.5000',
];

Map<String, int> get productCoinsMap => {
  'com.digitalnomad.coins.100': 100,
  'com.digitalnomad.coins.500': 500,
  'com.digitalnomad.coins.1000': 1000,
  'com.digitalnomad.coins.5000': 5000,
};
```

**重要**: 确保这里的 Product ID 与 App Store Connect 中完全一致！

---

## 5. 恢复购买功能

iOS 要求所有非订阅型内购都必须提供恢复购买功能。

### 实现位置

- UI: RechargeView 中的 "Restore Purchases" 按钮
- Logic: `restorePurchases()` 方法

### 测试恢复购买

1. 使用沙盒账号购买产品
2. 删除应用并重新安装
3. 点击 "Restore Purchases"
4. 应该能恢复之前的购买记录

---

## 6. 生产环境注意事项

### 6.1 收据验证

当前实现是客户端验证。生产环境建议：

1. 将购买收据发送到你的后端服务器
2. 后端服务器向 Apple 验证收据
3. 验证成功后再发放商品

### 6.2 安全性

- ✅ 不要在客户端存储敏感的密钥
- ✅ 使用 HTTPS 传输收据数据
- ✅ 在后端验证收据的真实性
- ✅ 防止重放攻击（记录已使用的 transaction ID）

### 6.3 用户体验

- ✅ 显示加载状态
- ✅ 处理网络错误
- ✅ 提供清晰的错误提示
- ✅ 支持离线模式（队列购买请求）

---

## 7. 常见问题

### Q: 为什么产品列表为空？
A: 可能原因：
1. 产品 ID 不匹配
2. 产品未在 App Store Connect 中配置
3. 产品状态不是 "Ready to Submit" 或更高
4. Bundle ID 不匹配
5. 未签署 In-App Purchase 协议

### Q: 沙盒测试一直失败？
A: 确保：
1. 使用沙盒测试账号（不是真实 Apple ID）
2. 设备已退出所有 Apple ID
3. 网络连接正常
4. 地区设置正确

### Q: 如何修改价格？
A: 在 App Store Connect 中修改产品的价格层级，无需更新应用。

### Q: 内购需要审核吗？
A: 是的，首次提交时需要审核。后续修改价格不需要重新审核应用。

---

## 8. 相关资源

- [Apple In-App Purchase 官方文档](https://developer.apple.com/in-app-purchase/)
- [in_app_purchase Flutter 插件](https://pub.dev/packages/in_app_purchase)
- [App Store Connect 帮助](https://help.apple.com/app-store-connect/)

---

## 9. 技术支持

如遇到问题，请检查：
1. Console 日志中的错误信息
2. App Store Connect 中的产品状态
3. Xcode 中的能力配置
4. 网络连接状态
