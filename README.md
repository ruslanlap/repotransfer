🚀💫 Fast Repository Cloner and Pusher

This bash script provides a quick way to clone a Git repository and push it to a new destination repository.
Features

    Clone any public or private Git repository you have access to 📥
    Automatically push the cloned repository to a new destination repository 📤
    Handles pushing the default branch, useful when cloning repositories with non-main default branches 🔀

Usage

chmod +x gitnewrepo.ssh
./gitnewrepo

When prompted:

    Enter the Git URL you want to clone from 🗄️
    Enter the destination Git URL you want to push to 🎯

The script will:

    Clone the source repository ⏬
    Update the remote to point to the destination repository 🔄
    Push the changes to the new destination repository ⏫

That's it! 🎉 The repository is now available in the new destination. 💾
Customization

    The script uses ANSI color codes to make the output more visually clear 🎨
    Feel free to customize the messages or add more functionality ➕

Overall this script saves the time of having to manually clone repositories and add remotes when migrating or backing up repositories. ⏱️⏱️⏱️
