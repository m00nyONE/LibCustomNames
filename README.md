# LibCustomNames

**LibCustomNames** is a lightweight library for *The Elder Scrolls Online* that allows custom names for players. Originally part of **HodorReflexes**, this library was separated out to improve modularity and reduce overhead.

Whether you're a streamer, guild leader, or just want to stand out with a personalized name, this library gives you that little touch of customization — shared across all supported addons.

---

## 🔧 Features

- Assign custom names to ESO players
- Centralized and easy-to-maintain name list
- Designed for reuse in multiple addons (e.g., HodorReflexes)
- Lightweight and dependency-free

---

## 🎉 Get Your Custom Name

Want to be featured with your own custom name?

### 📝 How to participate:
- **Create a Pull Request** adding your name entry to the list.
- Or **send a donation** to `@m00nyONE` in-game (EU server) and your request will be added.

This helps support development and keep the ESO addon ecosystem fun and alive!

---

## 💡 Usage

If you're an addon developer and want to use `LibCustomNames`:

Have a look at the full documentation here: [Github Pages](https://m00nyone.github.io/LibCustomNames/)

```lua
local name = LibCustomNames.Get("@originalAccountName") or "@originalAccountName"
```
Documentation will be expanded as needed — feel free to open an issue if you need help integrating it.

## 📁 Repository Structure
PC/names/: Contains all custom name definitions for PC.
Console/names/: Contains all custom name definitions for Console.

## 🤝 Contributing
Community contributions are welcome and appreciated!

- Fork the repo
- Add your custom name to the data file
- Open a Pull Request with a short description
- Make sure to keep names appropriate and tasteful. Offensive or misleading content will not be accepted.

- INFO: for testing custom names for console, please use PC and switch to consoleFlow mode

## 🙏 Credits
<a href="https://github.com/m00nyONE/LibCustomNames/graphs/contributors">
  <img src="https://contrib.rocks/image?repo=m00nyONE/LibCustomNames" />
</a>

Made with [contrib.rocks](https://contrib.rocks).

## 📬 Contact
For questions, contributions, or donations:

GitHub: Issues & PRs