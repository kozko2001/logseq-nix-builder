# Logseq Nix Builder

This is a utility to help build any version of logseq from source code
using nix shell


Steps:
1. make sure you have nix installed
```
which nix
```

should return a specific path, to install follow nix documentation here https://nix.dev/install-nix.html

2. enter the nix-shell

```
nix-shell
```

3. download logseq repository 
```
git clone https://github.com/logseq/logseq.git logseq
cd logseq
```

4. choose the branch you want to compile

```
git checkout feat/db
```

5. execute the build command

```
build
```

## How does it work

- Creates a nix shell with all the requirements from the github action workflows files
- executes the release commands

## Troubleshooting

1. `Out of Memory` error 

```
export _JAVA_OPTIONS="-Xmx4g"
```
