# 🕹️ Pacman Game – Assembly Language (Irvine32)

This project is a complete recreation of the classic **Pac-Man** game implemented in **8086 Assembly Language** using the **Irvine32 library** in **Visual Studio**. It features three progressively complex levels, AI-powered ghost movements, collision detection, score tracking, file handling, and player lives.

The game includes colorful ASCII graphics, player input, AI ghost movement, level-based mechanics, and high score storage through file handling. This project emphasizes core Assembly concepts like procedures, stacks (via `PUSH`/`POP`), conditional branching, and memory manipulation.

---

## 🎯 Project Objectives

- Implement a **three-level Pac-Man game** in Assembly.
- Use **procedures** and **stack parameter passing** (`PUSH`/`POP`).
- Integrate **file handling** to store and sort player scores.
- Utilize **Irvine32** for graphics, sound, and input.
- Simulate AI movement for ghosts and incorporate increasing difficulty.
- Provide a complete user interface with menus, welcome screen, pause/resume, and instructions.

---

## 🧱 Game Levels Breakdown

### 🟢 Level 1 – The Beginning
- **Maze**: Simple layout for learning movement.
- **Ghost AI**: Basic chasing behavior.
- **Objective**: Collect all dots to win.
- **Power Pellets**: ❌ Not available.
- **Lives**: 3 lives to start.

### 🟡 Level 2 – The Challenge
- **Maze**: More complex layout with fruit bonuses.
- **Ghost AI**: Pinky joins with smarter ambush behavior.
- **Power Pellets**: ✅ Added — can eat ghosts for 20 seconds.
- **Lives**: 3 (unchanged).
- **Scoring**: Eating ghosts adds points; they reset to initial point.

### 🔴 Level 3 – The Showdown
- **Maze**: Teleportation paths, hidden shortcuts.
- **Ghost AI**: Inky & Clyde introduced, faster and more complex.
- **Power-Ups**: Cherry to gain 1 extra life.
- **Final Boss**: Boss ghost with custom behavior.
- **Lives**: 3 to start, +1 on cherry.

---

## 📁 File Handling

- Stores **player names** and their **highest scores**.
- Automatically **sorts scores** in descending order.
- All data stored in a text file using Assembly's file handling (via interrupts).

---

## 🔊 Sound Effects

- Integrated **gameplay sounds** for:
  - Collecting dots
  - Eating ghosts
  - Losing a life
  - Winning a level

---

## 💾 How to Run

> ✅ Make sure you're using **Visual Studio** with **Irvine32 library** properly set up.

1. Open the `.asm` file in Visual Studio.
2. Ensure Irvine32 is referenced correctly.
3. Compile and run (`Ctrl + F5` or `Debug > Start Without Debugging`).
4. The game will launch in a 640x480 window.
5. On startup:
   - Enter your name.
   - Navigate through the menu using arrow keys and `Enter`.
6. Play the game with the following:
   - Arrow Keys = Move Pac-Man
   - P = Pause Game
   - ESC = Exit Game

---

## 📌 Core Assembly Concepts Used

- **Procedures** and **stack-based parameter passing** (`PUSH`/`POP`)
- **Loops**, **conditional branching**, and **labels**
- **Memory-mapped game state management**
- **Keyboard input via interrupt 21h**
- **Graphics rendering** using Irvine32 macros
- **Sound output**
- **File I/O** using DOS interrupts for score tracking
- **Data Structures**: Arrays and buffers for player scores

---

## 👨‍💻 Author

Ehtisham Abid
