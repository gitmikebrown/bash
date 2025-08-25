

#View the origin
git remote -v

#When you run "git remote -v", the below is output.
#origin  https://github.com/Housing-Records/laravel.git (fetch)
#origin  https://github.com/Housing-Records/laravel.git (push)


#View all branches
git branch -a




#pull request
git pull origin main

#This command will fetch and merge the 
#latest changes from the main branch of 
#the origin remote into your current branch.


####################
#When you develop an app on your local computer and
#want to add a repository and store it in github

#1. Initialize your local repository
git init

#2. Add your files and commit them
git add .
git commit -m "Initial commit"

#3. Add the remote origin
git remote add origin https://github.com/your-username/your-repository.git

#4. Push your code to GitHub
git push -u origin main

#The `-u` flag in the `git push -u origin main` command stands for `--set-upstream`. 
#It sets the upstream (or tracking) branch for your current local branch. This means 
#that your local branch will be linked to the specified remote branch, making future 
#pushes and pulls simpler.
#
#Here's what it does:
#- **Sets the upstream branch**: It tells Git that the local `main` 
#    branch should track the `main` branch on the `origin` remote.
#- **Simplifies future commands**: After setting the upstream branch, 
#    you can simply use `git push` or `git pull` without specifying 
#    the remote and branch name every time.
#
#For example, after running `git push -u origin main`, you can just use:
#git push
#git pull
#
#instead of:
#git push origin main
#git pull origin main

#This is especially useful for new branches or when setting up a repository for the first time. 
###################################