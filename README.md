# github-cloner
## _Clone All Your `Github` Repositories At Once_

`github-cloner` is a simple, easy to use script, which helps you to copy all repositories at once.

- Works with both users and organisations
- Has 3 types of git clone: `https` / `ssh` / `ghcli`
- Easy to setup

## Installation
`github-clone` requires `bash` and [jq](https://stedolan.github.io/jq/download/) to run.

Install the dependencies and clone the repository. Edit `cloneall.sh` & run the script.

```sh
cd github-cloner
nano cloneall.sh
chmod +x ./cloneall.sh
./cloneall.sh
```

## Config
There are only a few options to configure, which makes this script easy to use & flexible.

| Option          | Type    | README                                            |
| --------------- | ------- | ------------------------------------------------- |
| gitUser         | string  | `Github` username                                 |
| gitToken        | string  | `Github` [oath token](https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/creating-a-personal-access-token) from [settings](https://github.com/settings/tokens) |
| gitOrganization | string  | `Github` organisation name                        |
| cloneOrgRepos   | boolean | Whether to clone organisation repositories or no  |
| cloneUserRepos  | boolean | Whether to clone user repositories or no          |
| cloneType       | enum    | One of `https` / `ssh` / `ghcli`                  |
