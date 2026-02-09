# Neon File Manager

A futuristic cross-platform file manager built with Flutter, featuring a sleek neon aesthetic and powerful file management capabilities.

## 🖤 Features

### UI & Theme
- **AMOLED-friendly pure black background** with neon accent system
- **Neon Blue (#00BFFF)** and **Neon Violet (#8A2BE2)** color scheme
- **Material Design 3** with smooth micro-animations and glow effects
- **Dual-pane split explorer** layout (adaptive for mobile/desktop)
- **Responsive design** with single-pane on mobile, dual-pane on tablet & desktop

### File Operations
- **Copy, move, delete, rename** files and directories
- **Compress/uncompress** (ZIP) support
- **Batch operations** for multiple files
- **Transfer queue** with pause/resume functionality
- **Background transfers** with notifications
- **Resume interrupted transfers** automatically

### Storage Insights
- **Dashboard with circular charts** showing category-based usage
- **Real-time free space meter** with glowing gradient bars
- **Duplicate cleaner** with file previews
- **Large file finder**
- **Junk cleaner** functionality
- **Sync & transfer history logs**

### Media & Preview
- **Image/video thumbnails** with neon borders
- **Built-in media player** with translucent dark controls
- **Metadata overlays** (resolution, duration, EXIF data)
- **Document viewer** for PDF, TXT, and Office formats

### Connectivity
- **Phone ↔ HDD** (USB OTG)
- **Phone ↔ PC** (Wi-Fi, Bluetooth, USB)
- **Cloud integrations** (Google Drive, Dropbox, OneDrive, Nextcloud)
- **Network protocols** (LAN, FTP, SFTP, SMB)

### Performance & Reliability
- **Multi-threaded transfer engine**
- **Checksum verification** for file integrity
- **Offline-first architecture** - no forced internet dependency
- **Comprehensive log viewer** for errors & transfer history

### Customization
- **Accent color picker**
- **User profiles** with custom sync rules
- **AMOLED pure black toggle**
- **Plugin/extension system** support
- **Public API hooks** for automation & scripting

## 🚀 Getting Started

### Prerequisites
- Flutter SDK (>=3.10.0)
- Dart SDK (>=3.0.0)
- Android Studio / VS Code with Flutter extensions

### Installation

1. Clone the repository:
```bash
git clone https://github.com/your-username/neon-file-manager.git
cd neon-file-manager
```

2. Install dependencies:
```bash
flutter pub get
```

3. Run the app:
```bash
flutter run
```

### Build for Production

**Android:**
```bash
flutter build apk --release
```

**Windows:**
```bash
flutter build windows --release
```

## 📱 Screenshots

*(Add screenshots of the app in action)*

## 🏗️ Architecture

The app follows **Clean Architecture** principles with clear separation of concerns:

```
lib/
├── app/                    # App configuration and routing
├── core/                   # Shared utilities and services
│   ├── theme/             # App theming and colors
│   └── services/          # Core services (storage, file operations)
├── features/              # Feature modules
│   ├── explorer/          # File explorer functionality
│   ├── storage/           # Storage insights and analytics
│   ├── transfers/         # Transfer queue management
│   └── settings/          # App settings and preferences
└── main.dart             # App entry point
```

## 🎨 Design System

### Colors
- **Pure Black**: `#000000` (AMOLED background)
- **Neon Blue**: `#00BFFF` (Primary accent)
- **Neon Violet**: `#8A2BE2` (Secondary accent)
- **Neon Green**: `#00FF00` (Success states)
- **Neon Red**: `#FF0080` (Error states)

### Typography
- **Primary Font**: JetBrains Mono (monospace for hacker aesthetic)
- **Weights**: Regular (400), Semi-bold (600), Bold (700)

### Components
- **Neon cards** with glowing borders
- **Gradient progress bars** with glow effects
- **Animated transitions** and micro-interactions
- **Responsive layouts** adapting to screen size

## 🔧 Development

### State Management
- **Riverpod** for reactive state management
- **Provider pattern** for dependency injection

### Navigation
- **Go Router** for declarative routing
- **Deep linking** support

### Storage
- **SQLite** for local database
- **Shared Preferences** for settings
- **File system** for file operations

### Platform Integration
- **Permission Handler** for storage access
- **Path Provider** for directory access
- **Window Manager** for desktop features

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## 🤝 Contributing

Contributions are welcome! Please feel free to submit a Pull Request.

1. Fork the project
2. Create your feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📞 Support

For support, please contact [your-email@example.com] or create an issue on GitHub.

---

**Built with ❤️ and Flutter**
