
#Change working directory#

###If it is an initial start###

For example to Data-Science-Specialization

     $ cd ~/Documents/GitHub/Data-Science-Specialization

###If you want to change to a directory that inside your folder###

For example you want to use repo as your master 

     $ cd repo

#Clone the repo to local computer#

http://github.com/Borye/repo.git is the url of your repo

     $ git clone http://github.com/Borye/repo.git

#List  your files#

     $ ls

#Check on your remote#

     $ git remote -v

#Add remote#

     $ git remote add origin http://github.com/Borye/repo.git 

#Add a Markdown file#

     $ touch new.md

#Url of mark down file editor#
 
The markdown live editor is in [here][1]

#See the status of the files#

You can find out which file is tracked and which file is modified or unmodified

     $ git status

#Stage the files for committing#

This is a command that you can add all of the files to committed

     $ git add .

#Commit files#

You can add some change for committing files

     $ git commit -m "Add the message for changing"

#Pull the changes to local computer#

If there are some changes in github but not in local computer, you have to pull it before push. 

     $ git pull origin master

#Push the changes to github#

     $ git push origin master

[1]: http://jrmoran.com/playground/markdown-live-editor/


</markdown></p>
