#!/bin/bash

# GitHub Workflow Tutorial Generator 

# --- Colors ---
GREEN=$(tput setaf 2)
RED=$(tput setaf 1)
YELLOW=$(tput setaf 3)
BLUE=$(tput setaf 4)
RESET=$(tput sgr0)

# --- Helper functions ---
success() { echo "${GREEN}✅ $1${RESET}"; }
error()   { echo "${RED}❌ $1${RESET}"; }
info()    { echo "${BLUE}ℹ $1${RESET}"; }

continue_or_exit() {
    while true; do
        read -p "👉 Do you want to continue to the next lesson? (y/n): " choice
        case "$choice" in
            y|Y ) echo; break ;;
            n|N ) echo "👋 Exiting tutorial. See you next time!"; exit 0 ;;
            * ) echo "Please type y or n." ;;
        esac
    done
}


clear
echo "${YELLOW}============================================${RESET}"
echo "${YELLOW}   Welcome to GitHub Workflow Tutorial ${RESET}"
echo "${YELLOW}============================================${RESET}"
echo
echo "You will learn Git step-by-step. Each lesson explains a concept,"
echo "then you practice by typing the correct command."
echo


info "Lesson 1: Initialize a Git repository"
echo " 'git init' creates a new Git repository in the current folder."
echo "It sets up a hidden '.git' directory where Git stores all version history."
echo "This is the very first step in starting version control for any project."
echo
while true; do
    read -p "Run: git init : " cmd

   
    if [ "$cmd" = "git init" ]; then
        eval "$cmd"
        if [ -d ".git" ]; then
            success "Repository initialized!"
            continue_or_exit
            break
        else
            error "Failed to initialize repository. Try again."
            sleep 1
            continue
        fi
    fi

    error "Please type exactly: git init"
    sleep 1
done
echo

info " Check repo status (before staging)"
echo " 'git status' shows the state of your working directory."
echo "Right after 'git init', files appear as 'untracked'."
echo
while true; do
    read -p "Run: git status : " cmd
    if [ "$cmd" = "git status" ]; then
        eval "$cmd"
        success "You saw the status! Files are untracked at this stage."
        continue_or_exit
        break
    else
        error "Please type: git status"
        sleep 1
    fi
done
echo

# Lesson 2: git add .
info "Lesson 2: Stage your files"
echo " 'git add .' stages all the changes in your project."
echo "Staging means preparing files to be part of the next commit."
echo "Think of it like a shopping cart — you add items before checkout."
echo
while true; do
    read -p "Run: git add . : " cmd
    if [ "$cmd" = "git add ." ]; then
        eval "$cmd"
    else
        error "Please type exactly: git add . "
        sleep 1
        continue
    fi

    staged=$(git diff --cached --name-only)
    if [ -n "$staged" ]; then
        success "Files staged successfully!"
        continue_or_exit
        break
    else
        error "No files staged yet. Make sure you added files or staged changes."
        sleep 1
    fi
    done

info " Check repo status (after staging)"
echo " After 'git add .', files are staged for commit."
echo "Now 'git status' will show them under 'Changes to be committed'."
echo
while true; do
    read -p "Run: git status : " cmd
    if [ "$cmd" = "git status" ]; then
        eval "$cmd"
        success "You saw the status! Files are staged and ready to commit."
        continue_or_exit
        break
    else
        error "Please type: git status"
        sleep 1
    fi
done
echo


# Lesson 3: git commit -m "first commit"
info "Lesson 3: Make your first commit"
echo " 'git commit' permanently saves your staged changes."
echo "Each commit is like a snapshot in time, with a message explaining the change."
echo "Here we make our first commit with message: 'first commit'."
echo
while true; do
    read -p "Run: git commit -m \"first commit\"  " cmd

    if [ "$cmd" = "git commit -m \"first commit\"" ]; then
        eval "$cmd"
    else
        error "Please type exactly: git commit -m \"first commit\" "
        sleep 1
        continue
    fi

    commits=$(git rev-list --count HEAD 2>/dev/null || echo 0)
    if [ "$commits" -ge 1 ]; then
        success "First commit created!"
        continue_or_exit
        break
    else
        error "No commit detected yet."
        sleep 1
    fi
done
echo

info " Check repo status (after commit)"
echo " After committing, your working directory is clean."
echo
while true; do
    read -p "Run: git status : " cmd
    if [ "$cmd" = "git status" ]; then
        eval "$cmd"
        success "Working tree is clean now."
        continue_or_exit
        break
    else
        error "Please type: git status"
        sleep 1
    fi
done
echo

# Lesson 4: git rm <file>
info "Lesson 4: Remove a tracked file"
echo "'git rm <file>' removes a file from your project and stages its deletion."
echo "This is how you delete files while keeping Git history updated."
echo
echo " Creating a dummy file 'deleteme.txt' to demonstrate..."
echo "Delete me" > deleteme.txt
git add deleteme.txt
git commit -m "add deleteme file" >/dev/null 2>&1
while true; do
    read -p "Run: git rm deleteme.txt : " cmd
    if [ "$cmd" = "git rm deleteme.txt" ]; then
        eval "$cmd"
        success "File removed and staged for commit!"
        continue_or_exit
        break
    else
        error "Please type: git rm deleteme.txt"
        sleep 1
    fi
done
git commit -m "remove deleteme.txt" >/dev/null 2>&1
echo "✅ Commit recorded for file removal."
echo


# Lesson 5: git branch -M main
info "Lesson 5: Rename branch to main"
echo " Branches are like alternate timelines of your code."
echo "By default, Git creates 'master'. Modern convention is to call it 'main'."
echo "This command renames the current branch to 'main'."
echo
while true; do
    read -p "Run: git branch -M main : " cmd
    if [ -n "$cmd" ]; then
        if [[ "$cmd" =~ ^(git\ branch\ -M\ main|git\ checkout\ -b\ main|git\ switch\ -c\ main|git\ checkout\ main|git\ switch\ main)$ ]]; then
            eval "$cmd"
        else
            error "Please type: git branch -M main ."
            sleep 1
            continue
        fi
    fi

    branch=$(git branch --show-current 2>/dev/null | tr -d '\r')
    if [ "$branch" = "main" ]; then
        success "Branch renamed to main!"
        continue_or_exit
        break
    else
        error "Branch is not 'main' yet."
        sleep 1
    fi
done
echo

# Lesson 6: git remote add origin 
info "Lesson 6: Add remote origin "
echo " A remote is a link to a repository hosted online (like GitHub)."
echo "By adding 'origin', you connect your local project to the GitHub repo URL."
echo "This allows you to push and pull changes between your machine and GitHub."
echo
while true; do
    read -p "Run: git remote add origin https://github.com/username/repo.git : " cmd

    if [[ "$cmd" = "git remote add origin https://github.com/username/repo.git" ]]; then
        success "✅  Remote 'origin' would be added."
        echo "ℹ️  In real life, this links your local repo with GitHub."
        continue_or_exit
        break
    else
        error "Please type: git remote add origin https://github.com/username/repo.git ."
        sleep 1
    fi
done

# Lesson 7: git fetch 
info "Lesson 7: Fetch updates from remote "
echo " 'git fetch' downloads changes from a remote repo but does not merge them."
echo "This is how you stay updated without altering your local branch."
echo
while true; do
    read -p "Run: git fetch origin : " cmd
    if [ "$cmd" = "git fetch origin" ]; then
        success "✅  Changes would be fetched from origin."
        echo "ℹ️  In real life, you would see 'remote: Counting objects...' etc."
        continue_or_exit
        break
    else
        error "Please type: git fetch origin"
        sleep 1
    fi
done
echo

# Lesson 8: git pull 
info "Lesson 8: Pull updates from remote ."
echo " 'git pull' is like running 'git fetch' + 'git merge'."
echo "It updates your local branch with the latest changes from the remote."
echo
while true; do
    read -p "Run: git pull origin main : " cmd
    if [ "$cmd" = "git pull origin main" ]; then
        success "✅  Code would be pulled and merged from origin/main."
        echo "ℹ️  In real life, you’d see merge output or 'Already up to date.'"
        continue_or_exit
        break
    else
        error "Please type: git pull origin main"
        sleep 1
    fi
done
echo

# Lesson 9: git push -u origin main 
info "Lesson 9: Push to GitHub "
echo " 'git push' uploads your local commits to GitHub."
echo "The '-u origin main' part tells Git to push the 'main' branch to 'origin' (your remote)."
echo "This is how your code gets shared online for collaboration."
echo
while true; do
    read -p "Run: git push -u origin main : " cmd
    if [ "$cmd" = "git push -u origin main" ]; then
        success "✅  Code would be pushed to GitHub."
        echo "ℹ️  In real life, this uploads commits to your GitHub repo."
        continue_or_exit
        break
    else
        error "Please type: git push -u origin main"
        sleep 1
    fi
done
echo

# Lesson 10: git clone 
info "Lesson 10: Clone a repository "
echo " 'git clone' copies a remote repo from GitHub to your computer."
echo "This gives you a local working copy of someone else’s code."
echo "It’s the command you use most often when starting to work on a new project."
echo
while true; do
    read -p "Run: git clone https://github.com/username/repo.git : " cmd

    if [ "$cmd" = "git clone https://github.com/username/repo.git" ]; then
        # run the command (silently) — if you prefer simulation only, remove eval
        eval "$cmd" >/dev/null 2>&1 || true

        success "✅ Repository cloned .."
        echo "ℹ️  In real life, this makes a local copy of the remote repository."
        echo "📂 Example structure of a cloned repo:"
        echo "   cloned_repo/"
        echo "     ├── README.md"
        echo "     ├── .gitignore"
        echo "     └── git_tutorial.sh"
        continue_or_exit

        
        break
    else
        error "Please type exactly: git clone https://github.com/username/repo.git"
        sleep 1
    fi
done
echo
# Lesson 11: git log --oneline --graph --all
info "Lesson 11: Visualize history"
echo " 'git log --oneline --graph --all' shows a visual history."
echo "It displays commits from all branches in a compact graph format."
echo
while true; do
    read -p "Run: git log --oneline --graph --all : " cmd
    if [ "$cmd" = "git log --oneline --graph --all" ]; then
        eval "$cmd"
        success "You viewed the commit history with a graph!"
        break
    else
        error "Please type: git log --oneline --graph --all"
        sleep 1
    fi
done
echo

echo
echo "${GREEN} Congratulations! You completed the full GitHub workflow tutorial!${RESET}"
echo "Now you know: init, add, commit, branch, remote, push, pull, fetch, clone."