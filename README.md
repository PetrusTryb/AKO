# Computer Architecture
This repository contains all the code written for the Computer Architecture course at the Faculty of Electronics, Telecommunications and Informatics at Gdańsk University of Technology and some useful notes.

## Repository contents
| Folder | Description |
|--|--|
|[lab1](lab1)| Assemblation and consolidation of a program in assembly language|
|[lab2](lab2)| Processing text with use of different addressing modes|
|[lab3](lab3)| Binary numbers conversion|
|[lab4](lab4)| Mixed language programming|
|[lab5](lab5)| Floating point arithmetic|
|[lab6](lab6)| Handling interrupts|
|[notes](notes)| Answers to select questions from examplary questions etc.|

## How to run
This repository contains code written in `C`, and `MASM` - Microsoft Macro Assembler.
### Labs 1-5
Easiest way to run the code is to use `Microsoft Visual Studio` with `MASM` installed. The code can be run by creating a new project and adding the files from the selected lab to the project. Select correct architecture (`x86` or `x64`) on the top of the window. Press PPM on the project name in the Solution Explorer and select `Build Dependencies` -> `Build Customizations` and check `MASM`. Then the code can be run by pressing `F5` or `Ctrl + F5`.
### Lab 6
The code can be run by using `DOSBox` or `DOSBox-X` emulator. Script for easy compilation is provided in the `lab6` folder. Navigate to the `lab6` folder and run the `build.bat` script with name of the file as an argument. For example:
```bash
build.bat snake
```
Then run the compiled file with the same name as the source file:
```bash
snake
```
### Notes
The notes are written in `Markdown` and can be viewed in any text editor or in a web browser. The notes are written in Polish.

## Copyright requests
If you are the owner of some of the content and you want it to be removed from this repository, please contact me at e-mail address provided in my profile or open an issue in this repository.