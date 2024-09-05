# DotNet8Migration

Large number of projects are not .net 8 and from Nov 2024 the older versions wont be supported.

```org:XX path:*.csproj NOT "<TargetFramework>net8.0</TargetFramework>"```

## Understand project
For the first step, analyse the project to understand the migration requirements ahead of the work.
Identify the existing target frameworks in the solution using the following regular expression search:
``<TargetFramework>.*</TargetFramework>``

## Upgrade all TargetFramework

Upgrade all ``TargetFramework`` and ``runtime`` to .Net 8

## Upgrade runtime to .Net 8 (TF)
The ```DotNet8Migration.sh``` script helps with steps 1 and 2. 

## Update CI/CD settings to use .Net 8

Update ``--runtime=ubuntu-x64`` to ``--runtime=linux-x64``

Until this step, we have done the very basics of migrating a service to .Net 8. The following steps would help to improve the health of the service without spending much time on it.

## Step 4 - Upgrade .net libraries 
Using this command you can create a list of Microsoft libraries that require upgrade. 

Find all the microsoft packages
> find . -name "*.csproj" -exec grep -H '<PackageReference Include="Microsoft.*" Version="6' {} +

I start with those that have the major version of 6.x.x.


> dotnet list package --outdated | grep -i Microsoft | grep -i 6. > LibrariesToUpdate.txt

>dotnet list package --outdated | grep -i Microsoft > LibrariesToUpdate.txt

upgrade the Microsoft.* packages that are on v6 to v8

## Step 4 - gitignore
Sometime we want to migrate some services that could do with major solution level changes such as formatting and removing of unused usings.  
To do these changes, apply the changes in a seperate PR. Review the changes are as you expected. Do not trust fully on the result of commands such as ``$ dotnet format``.

To ensure the changes do not pollute the git blame, add a gitignore file and add the git commit hash of the merged PR to the file. See the example file in this repository.

## File scoped namespaces

.Net 8 supports [file scoped namespaces](https://learn.microsoft.com/en-us/dotnet/csharp/language-reference/proposals/csharp-10.0/file-scoped-namespaces).
Make the changes in a separate PR and add the git commit hash to gitignore file.

After making the changes locally, do this regular expression search to ensure all files are changed as expected:

``^\s*namespace\s+.*[^;]\s*$``

## Step 5 - Upgrade libraries
 Upgrade libraries as much as possible. Specially those with vulnerability.

## Step 7 - Update ReadMe 
This is a good opportunity to review the ReadMe and ensure it provides basic information for a new developer to know 
* the aim of the service  
* how to run and test it locally
* find related links such as monitoring & CI/CD

## Librayr update

Update Nunit to version 4+ could require legacy assertion syntaxes update, such as:
```
Assert.IsTrue
Assert.True
Assert.AreEqual
```

Following reg expressions could help with some large changes

```
Assert.IsFalse\((.*), (.*)\);   ---> Assert.That($1, Is.False, $2);
Assert.IsFalse\((.*)\);         ---> Assert.That($1, Is.False);
Assert.False\((.*)\);           ---> Assert.That($1, Is.False);
Assert.IsTrue\((.*), (.*)\);    ---> Assert.That($1, Is.True, $2);
Assert.IsTrue\((.*)\);          ---> Assert.That($1, Is.True);
Assert.True\((.*)\);            ---> Assert.That($1, Is.True);
Assert.IsNotNull\((.*), (.*)\); ---> Assert.That($1, Is.Not.Null, $2);
Assert.IsNotNull\((.*)\);       ---> Assert.That($1, Is.Not.Null);
Assert.IsNull\((.*)\);          ---> Assert.That($1, Is.Null);
Assert.AreEqual\((.*), (.*)\);  ---> Assert.That($2, Is.EqualTo($1));
Assert.IsEmpty\((.*)\);         ---> Assert.That($1, Is.Empty);
Assert.IsNotEmpty\((.*)\);      ---> Assert.That($1, Is.Not.Empty);```