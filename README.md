# DotNet8Migration

## Upgrade all TargetFramework

Upgrade all ``TargetFramework`` and ``runtime`` to .Net 8

## Upgrade runtime to .Net 8 (TF)
The ```DotNet8Migration.sh``` script helps with steps 1 and 2. 

## Update CI/CD settings to use .Net 8

Update ``--runtime=ubuntu-x64`` to ``--runtime=linux-x64``

Until this step, we have done the very basics of migrating a service to .Net 8. The following steps would help to improve the health of the service without spending much time on it.

## Step 4 - Upgrade .net libraries 
Using this command you can create a list of Microsoft libraries that require upgrade. I start with those that have the major version of 6.x.x.
> dotnet list package --outdated | grep -i Microsoft | grep -i 6. > LibrariesToUpdate.txt

>dotnet list package --outdated | grep -i Microsoft > LibrariesToUpdate.txt

## Step 4 - gitignore
Sometime we want to migrate some services that could do with major solution level changes such as formatting and removing of unused usings.  
To do these changes, apply the changes in a seperate PR. Review the changes are as you expected. Do not trust fully on the result of commands such as ``$ dotnet format``.

To ensure the changes do not pollute the git blame, add a gitignore file and add the git commit hash of the merged PR to the file. See the example file in this repository.

## File scoped namespaces

.Net 8 supports [file scoped namespaces](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/proposals/csharp-10.0/file-scoped-namespaces).
Make the changes in a separate PR and add the git commit hash to gitignore file.

## Step 5 - Upgrade libraries
 Upgrade libraries as much as possible. Specially those with vulnerability.

## Step 7 - Update ReadMe 
This is a good opportunity to review the ReadMe and ensure it provides basic information for a new developer to know 
* the aim of the service  
* how to run and test it locally
* find related links such as monitoring & CI/CD
