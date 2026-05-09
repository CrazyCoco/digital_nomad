# iOS 在线打包配置指南

## 📋 前置准备

### 1. Apple Developer 账号
- 需要 Apple Developer Program 会员（$99/年）
- 访问: https://developer.apple.com/

### 2. 创建 App ID
1. 登录 [Apple Developer Console](https://developer.apple.com/account/)
2. 进入 Certificates, Identifiers & Profiles
3. 创建新的 App ID
4. Bundle ID 格式: `com.yourcompany.digitalnomad`

### 3. Codemagic 账号
- 注册: https://codemagic.io/
- 连接你的代码仓库（GitHub/GitLab/Bitbucket）

---

## 🔧 配置步骤

### 第一步：修改配置文件

编辑 `codemagic.yaml`，修改以下内容：

```yaml
environment:
  ios_signing:
    bundle_identifier: com.yourcompany.digitalnomad  # 改为你的 Bundle ID

publishing:
  email:
    recipients:
      - your_email@example.com  # 改为你的邮箱
```

### 第二步：在 Codemagic 添加环境变量

1. 进入 Codemagic 项目设置
2. 找到 **Environment variables**
3. 添加以下变量：

| 变量名 | 值 | 类型 |
|--------|-----|------|
| `APP_STORE_CONNECT_ISSUER_ID` | App Store Connect API Issuer ID | Secure ✓ |
| `APP_STORE_CONNECT_KEY_IDENTIFIER` | API Key Identifier | Secure ✓ |
| `APP_STORE_CONNECT_PRIVATE_KEY` | API Private Key (完整内容) | Secure ✓ |

**如何获取这些值：**
1. 登录 [App Store Connect](https://appstoreconnect.apple.com/)
2. 进入 Users and Access → Keys
3. 生成新的 API Key
4. 下载私钥文件（`.p8` 文件）

### 第三步：提交代码并触发构建

```bash
git add codemagic.yaml
git commit -m "Add Codemagic iOS build configuration"
git push origin main
```

Codemagic 会自动检测到推送并开始构建。

---

## 🚀 使用方式

### 自动构建
- 推送到 `main` 分支时自动触发
- 可在 `codemagic.yaml` 中修改触发规则

### 手动构建
1. 登录 Codemagic
2. 进入项目页面
3. 点击 **Start new build**
4. 选择 `ios-build-workflow`
5. 点击 **Start build**

### 下载 IPA
1. 构建完成后，进入构建详情页
2. 在 **Artifacts** 部分
3. 点击下载 `.ipa` 文件
4. 同时会下载 `.dSYM.zip`（用于崩溃分析）

---

## 📱 分发方式

### 1. TestFlight 测试
```bash
# 如需自动上传到 TestFlight，在 codemagic.yaml 添加：
scripts:
  - name: Upload to TestFlight
    script: |
      app-store-connect publish --path "$(find . -name '*.ipa')"
```

### 2. Ad Hoc 分发
修改 `codemagic.yaml`:
```yaml
ios_signing:
  distribution_type: ad_hoc
```

### 3. App Store 发布
修改 `codemagic.yaml`:
```yaml
ios_signing:
  distribution_type: app_store
```

---

## ⚙️ 高级配置

### 自定义版本号
```yaml
scripts:
  - name: Set version number
    script: |
      cd ios
      agvtool new-marketing-version "1.0.0"
      agvtool new-version -all $(($(agvtool what-version) + 1))
      cd ..
```

### 添加 Slack 通知
```yaml
publishing:
  slack:
    channel: '#builds'
    notify_on_success: true
    notify_on_failure: true
```

### 多环境配置
```yaml
workflows:
  ios-dev:
    environment:
      vars:
        ENVIRONMENT: development
  
  ios-prod:
    environment:
      vars:
        ENVIRONMENT: production
```

---

## ❓ 常见问题

### Q1: 构建失败，提示签名错误
**解决方案：**
- 检查 Bundle ID 是否正确
- 确认 Apple Developer 账号已添加该 Bundle ID
- 在 Codemagic 重新配置签名证书

### Q2: CocoaPods 依赖安装失败
**解决方案：**
```yaml
scripts:
  - name: Update CocoaPods
    script: |
      sudo gem install cocoapods
      cd ios && pod repo update && pod install && cd ..
```

### Q3: 构建时间过长
**优化建议：**
- 使用 `mac_mini_m2` 实例（更快）
- 启用 Codemagic 缓存
- 减少不必要的依赖

### Q4: 如何查看构建日志？
- 在 Codemagic 构建详情页
- 点击每个步骤展开查看详细日志
- 可下载完整日志文件

---

## 📞 技术支持

- Codemagic 文档: https://docs.codemagic.io/
- Flutter 构建指南: https://docs.flutter.dev/deployment/ios
- Apple Developer 支持: https://developer.apple.com/support/

---

## 🎯 快速开始清单

- [ ] 注册 Apple Developer 账号
- [ ] 创建 App ID 和 Bundle ID
- [ ] 注册 Codemagic 账号
- [ ] 连接代码仓库
- [ ] 修改 `codemagic.yaml` 中的 Bundle ID
- [ ] 在 Codemagic 配置环境变量
- [ ] 提交代码触发首次构建
- [ ] 下载并测试 IPA 文件

祝打包顺利！🎉
