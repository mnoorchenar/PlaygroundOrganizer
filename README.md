# 🎮 HTML Playground Organizer

A beautiful, intuitive web application for organizing and managing educational HTML playgrounds. Perfect for teachers, students, and developers who want to keep their HTML experiments, tutorials, and teaching materials well-organized.

![HTML Playground Organizer](https://img.shields.io/badge/HTML-Playground-purple?style=for-the-badge)
![Version](https://img.shields.io/badge/version-1.0.0-blue?style=for-the-badge)
![License](https://img.shields.io/badge/license-MIT-green?style=for-the-badge)

## ✨ Features

### 🗂️ **Hierarchical Organization**
- Organize playgrounds by **Section** (e.g., Deep Learning, Web Development)
- Further categorize with **Subsections** (e.g., Neural Networks, CSS Animations)
- Assign descriptive **Titles** to each playground

### 🔍 **Powerful Search**
- Search by title with real-time filtering
- Filter by section and subsection
- Combine multiple search criteria
- Instant results as you type

### 📝 **Full CRUD Operations**
- **Create** new HTML playgrounds with a simple form
- **Read** and preview playgrounds in an embedded iframe
- **Update** existing playgrounds with the edit feature
- **Delete** unwanted playgrounds with confirmation

### 💾 **Data Persistence**
- All data stored in browser's localStorage
- No backend required
- Data persists across sessions
- Easy export/import functionality (optional)

### 📊 **Dashboard Statistics**
- Total number of playgrounds
- Number of unique sections
- Number of unique subsections
- Visual stat cards for quick overview

### 🎨 **Beautiful UI**
- Modern gradient design
- Smooth animations and transitions
- Responsive layout (mobile-friendly)
- Clean, intuitive interface
- Color-coded badges for sections and subsections

### 🚀 **Auto-complete**
- Smart suggestions for existing sections
- Auto-suggest for subsections
- Faster data entry
- Maintains consistency

## 🖥️ Demo

[Try it live on Hugging Face Spaces](#) _(Add your deployed URL here)_

## 📋 Use Cases

### For Educators
- Organize teaching materials by subject and topic
- Quick access to interactive demonstrations
- Share specific playgrounds with students
- Build a library of educational content

### For Students
- Keep learning exercises organized
- Practice projects categorized by difficulty
- Build a portfolio of experiments
- Easy revision and reference

### For Developers
- Store code snippets and experiments
- Test and preview HTML/CSS/JS quickly
- Organize by framework or technology
- Build a personal knowledge base

## 🚀 Getting Started

### Option 1: Use Locally
1. Download the `playground-organizer.html` file
2. Open it in any modern web browser
3. Start adding your HTML playgrounds!

### Option 2: Deploy to Hugging Face Spaces

1. **Create a New Space**
   - Go to [Hugging Face Spaces](https://huggingface.co/spaces)
   - Click "Create new Space"
   - Choose a name for your space
   - Select **"Static"** as the Space SDK

2. **Upload the File**
   - Upload `playground-organizer.html`
   - Rename it to `index.html`
   - Commit the changes

3. **Access Your App**
   - Your app will be live at: `https://huggingface.co/spaces/YOUR_USERNAME/YOUR_SPACE_NAME`

### Option 3: Deploy to GitHub Pages

1. Create a new repository on GitHub
2. Upload `playground-organizer.html` and rename to `index.html`
3. Go to Settings → Pages
4. Select main branch as source
5. Your site will be live at `https://YOUR_USERNAME.github.io/REPO_NAME`

## 📖 How to Use

### Adding a New Playground

1. Click the **"➕ Add New Playground"** button
2. Fill in the form:
   - **Section**: Main category (e.g., "Deep Learning")
   - **Subsection**: Sub-category (e.g., "Neural Networks")
   - **Title**: Descriptive name (e.g., "CNN Visualization")
   - **HTML Content**: Paste your complete HTML code
3. Click **"Save Playground"**

### Searching for Playgrounds

- **By Title**: Type in the search box to filter by playground name
- **By Section**: Select a section from the dropdown
- **By Subsection**: Select a subsection from the dropdown
- **Combined**: Use multiple filters together for precise results

### Viewing a Playground

- Click on any playground card
- The HTML will render in a full-screen iframe
- Click "Close" to return to the list

### Editing a Playground

1. Click the **"Edit"** button on any playground card
2. Modify the fields as needed
3. Click **"Save Playground"** to update

### Deleting a Playground

1. Click the **"Delete"** button on any playground card
2. Confirm the deletion in the popup
3. The playground will be permanently removed

## 🏗️ Project Structure

```
html-playground-organizer/
├── index.html              # Main application file (rename from playground-organizer.html)
├── README.md              # This file
└── screenshots/           # Optional: Add screenshots here
```

## 🛠️ Technical Details

### Built With
- **HTML5** - Structure
- **CSS3** - Styling with modern gradients and animations
- **Vanilla JavaScript** - No frameworks, pure JS
- **LocalStorage API** - Data persistence

### Browser Compatibility
- Chrome/Edge (recommended)
- Firefox
- Safari
- Opera
- Any modern browser with ES6 support

### Data Storage
All playground data is stored in the browser's localStorage as a JSON array:

```javascript
[
  {
    "id": 1234567890,
    "section": "Deep Learning",
    "subsection": "Neural Networks",
    "title": "CNN Visualization",
    "content": "<!DOCTYPE html>...",
    "createdAt": "2025-01-30T12:00:00.000Z",
    "updatedAt": "2025-01-30T12:00:00.000Z"
  }
]
```

## 🔒 Privacy & Security

- **No Server Required**: Everything runs in your browser
- **No Data Collection**: Your playgrounds never leave your device
- **No Tracking**: No analytics or tracking scripts
- **Local Storage Only**: Data stored only in your browser's localStorage

## 🎯 Roadmap

Future enhancements we're considering:

- [ ] Export/Import functionality for backup
- [ ] Tagging system for additional categorization
- [ ] Favorites/Starred playgrounds
- [ ] Dark mode toggle
- [ ] Keyboard shortcuts
- [ ] Drag-and-drop file upload
- [ ] Code syntax highlighting in editor
- [ ] Share playground as URL
- [ ] Cloud sync option (optional)

## 🤝 Contributing

Contributions are welcome! Here's how you can help:

1. Fork the repository
2. Create a feature branch (`git checkout -b feature/AmazingFeature`)
3. Commit your changes (`git commit -m 'Add some AmazingFeature'`)
4. Push to the branch (`git push origin feature/AmazingFeature`)
5. Open a Pull Request

## 📝 Example Playgrounds

### Example 1: Simple HTML Page
```html
<!DOCTYPE html>
<html>
<head>
    <title>Hello World</title>
    <style>
        body { font-family: Arial; text-align: center; padding: 50px; }
        h1 { color: #667eea; }
    </style>
</head>
<body>
    <h1>Hello World!</h1>
    <p>This is a simple HTML playground.</p>
</body>
</html>
```

**Section**: Web Basics  
**Subsection**: HTML Fundamentals  
**Title**: Hello World Example

### Example 2: Interactive Button
```html
<!DOCTYPE html>
<html>
<head>
    <title>Click Counter</title>
    <style>
        body { font-family: Arial; text-align: center; padding: 50px; }
        button { padding: 20px 40px; font-size: 20px; cursor: pointer; }
    </style>
</head>
<body>
    <h1>Click Counter</h1>
    <button onclick="count++; this.textContent='Clicks: ' + count">Clicks: 0</button>
    <script>let count = 0;</script>
</body>
</html>
```

**Section**: JavaScript Basics  
**Subsection**: DOM Manipulation  
**Title**: Simple Click Counter

## 📄 License

This project is licensed under the MIT License - see below for details:

```
MIT License

Copyright (c) 2025 HTML Playground Organizer

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
```

## 👤 Author

**Your Name**
- GitHub: [@yourusername](https://github.com/yourusername)
- Hugging Face: [@yourusername](https://huggingface.co/yourusername)

## 🙏 Acknowledgments

- Inspired by the need for better organization of educational HTML content
- Built with love for educators and learners
- Thanks to the open-source community

## 📞 Support

If you have any questions or run into issues:

1. Check the [Issues](https://github.com/yourusername/repo/issues) page
2. Create a new issue with a detailed description
3. Reach out on the Hugging Face Space discussion board

---

⭐ **Star this project** if you find it helpful!

🐛 **Found a bug?** Please report it in the issues section.

💡 **Have an idea?** We'd love to hear your suggestions!