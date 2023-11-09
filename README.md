# Folder architecture generator

## Description

This script generates a folder architecture for a project.

## Requirements

- Lua 5.3

## Usage

```bash
lua folder_architecture_generator.lua <project_name> <example.md>
```

## Example

```bash
lua folder_architecture_generator.lua my_project example.md
```

### Project under development

- [x] Create a folder architecture generator
- [x] Create a file architecture generator
- [x] Create a config file
- [x] Create a config file generator
- [ ] Create a style guide generator 🚨🚨

## Example.md

```md
    .
    ╠══ public/
    ║   ╚══ [...example files]
    ╠══ src/
    ║   ╠══ components/
    ║   ║   ╠══ ButtonStyle/
    ║   ║   ║   ╠══ Button.test.tsx
    ║   ║   ║   ╠══ Button.style.tsx
    ║   ║   ║   ╚══ index.tsx
    ║   ║   ╠══ Loading/
    ║   ║   ║   ╠══ Loading.test.tsx
    ║   ║   ║   ╠══ Loading.style.tsx
    ║   ║   ║   ╚══ index.tsx
    ║   ╠══ functions/
    ║   ║   ╠══ fetchData.ts
    ║   ║   ╠══ localStorage.ts
    ║   ║   ╠══ parseUrl.ts
    ║   ║   ╚══ __test__/
    ║   ║       ╚══ functions.test.ts
    ║   ╠══ mocks/
    ║   ║   ╚══ index.ts
    ║   ╠══ types/
    ║   ║   ╠══ children.ts
    ║   ║   ╠══ itemClothes.ts
    ║   ║   ╚══ parseURL.ts
    ║   ╚══ [...example files]
    ╚══ [...config file]
```
