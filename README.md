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
