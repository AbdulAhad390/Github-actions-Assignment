# Github-actions-Assignment

This repository is an assignment demonstrating GitHub Actions workflows: one for running a script, and another for running lint and test commands.

---

## 📁 Repository Structure

```

Github-actions-Assignment/
│
├── run.sh                   # Script file that prints a greeting message
├── package.json             # Node.js project metadata and scripts
├── package-lock.json        # Auto-generated lockfile for npm
│
├── .github/
│   └── workflows/
│       ├── run-script.yml      # Workflow to run run.sh
│       └── lint-and-test.yml    # Workflow to run lint & test commands
│
└── git\_tutorial.sh          # Another shell script file (purpose depends on assignment)

````

---

## 🛠️ What it does

There are two GitHub Actions workflows in this project:

1. **Run Script Workflow** (`run-script.yml`)  
   - Triggered on `push` to the `main` branch  
   - It checks out the code and runs `run.sh`  

2. **Lint & Test Workflow** (`lint-and-test.yml`)  
   - Triggered on `push` (and possibly `pull_request`) to `main`  
   - Installs dependencies  
   - Runs `npm run lint`  
   - Runs `npm test`  

---

## 🚀 How to Use Locally

If you want to test things on your local setup:

```bash
# Clone this repository
git clone https://github.com/AbdulAhad390/Github-actions-Assignment.git
cd Github-actions-Assignment

# Make sure run.sh is executable
chmod +x run.sh

# Install dependencies
npm install

# Run the greeting script
./run.sh

# Run lint
npm run lint

# Run tests
npm test
````

## 👤 Author

* **Abdul Ahad**
----
