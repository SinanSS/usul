# usul

**usul** is a Flutter boilerplate repository used as a base for new projects.

It includes only core infrastructure and shared components.
No features, no business logic.

---

## What is included?

- App theme and colors
- Core UI widgets (loader, error, empty, etc.)
- Dependency injection (get_it)
- Bloc setup
- Network base
- Logger setup
- Clean project structure

The app builds and runs with a simple empty home screen.

---

## What is NOT included?

- No feature modules
- No screens
- No API endpoints
- No business logic

This is intentional.

---

## How to use usul

When starting a new project:

```bash
git clone <this-repo-url> my_new_project
cd my_new_project
rm -rf .git
git init
git add .
git commit -m "Initial commit"
```
