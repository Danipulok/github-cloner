#!/bin/bash
# requires jq -> https://stedolan.github.io/jq/download/;
# create oath token -> https://github.com/settings/tokens;

# GitHub configuration
githubToken="<oathToken>"  
githubUser="<username>"
githubOrganization="<organisation>"

# Script configuration
targetDir="."
cloneOrgRepos=false
cloneUserRepos=false
cloneType="https"  # https / ssh / ghcli


# Script
cd $targetDir
echo "PWD: $(pwd)"

if   [[ $cloneType == "https" ]]
    then targetField="clone_url"
elif [[ $cloneType == "ssh" ]]
    then targetField="ssh_url"
elif [[ $cloneType == "ghcli" ]]
    then targetField="full_name"
else 
    echo "Invalid \`cloneType\` option. Acceptable: 'https', 'ssh', 'ghcli'. Exiting..."
    exit 1
fi

# https://docs.github.com/en/rest/repos/repos?apiVersion=2022-11-28#list-organization-repositories
listOrgReposUrl="https://api.github.com/orgs/$githubOrganization/repos?per_page=100"
if $cloneOrgRepos
then
    orgRepositories=$(curl $listOrgReposUrl -u ${githubUser}:${githubToken} | jq -r .[].${targetField})
else
    orgRepositories=""
fi

# https://docs.github.com/en/rest/repos/repos?apiVersion=2022-11-28#list-repositories-for-the-authenticated-user
listUserRepoUrl="https://api.github.com/user/repos?per_page=100&type=owner"
if $cloneUserRepos
then
    userRepositories=$(curl $listUserRepoUrl -u ${githubUser}:${githubToken} | jq -r .[].${targetField})
else
    userRepositories=""
fi

# Clone all repositories
repositories="$orgRepositories $userRepositories"
for repository in $repositories
do
    printf "\nRepository found: $repository\n"

    if [[ $cloneType == "ghcli" ]]
    then
        commandPattern="gh repo clone"
    else
        commandPattern="git clone"
    fi

    finalCommand="$commandPattern $repository"
    eval $finalCommand
done
