# VERSION: 3
# LAST UPDATED: 2025-06-22

# Golang Project Layout

## Rules
- Don't create a directory until it's needed

## Example Project Layout Tree Structure
```
myapp/
├── api/
├── assets/
├── build/
├── cmd/
│   └── _your_app_/
│       └── main.go
├── docs/
│   ├── CHANGE_LOG.md
│   ├── CHANGE_LOG_EXAMPLE.md
│   ├── MODULE_SPEC.md
│   └── SEMANTIC_COMMITS.md
├── examples/
├── internal/
│   ├── app/
│   │   └── _your_app_/
│   └── pkg/
│       └── _your_private_lib_/
├── pkg/
│   └── _your_public_lib_/
├── scripts/
├── test/
├── tools/
├── web/
├── CONTRIBUTING.md
├── go.mod
├── go.sum
├── LICENSE
├── Makefile
├── NOTICE
└── README.md
```

## Project Paths and Usage
Ref: https://github.com/golang-standards/project-layout/tree/master

### api/
OpenAPI/Swagger specs, JSON schema files, protocol definition files.

### assets/
Other assets to go along with your repository (images, logos, etc).

### build/
Packaging and Continuous Integration.

Put your cloud (AMI), container (Docker), OS (deb, rpm, pkg) package configurations and scripts in the /build/package directory.

Put your CI (travis, circle, drone) configurations and scripts in the /build/ci directory. Note that some of the CI tools (e.g., Travis CI) are very picky about the location of their config files. Try putting the config files in the /build/ci directory linking them to the location where the CI tools expect them when possible (don't worry if it's not and if keeping those files in the root directory makes your life easier).

### cmd/
Main applications for this project.

The directory name for each application should match the name of the executable you want to have (e.g., /cmd/myapp).

Don't put a lot of code in the application directory. If you think the code can be imported and used in other projects, then it should live in the /pkg directory. If the code is not reusable or if you don't want others to reuse it, put that code in the /internal directory.

### docs/
Design and user documents (in addition to your godoc generated documentation).

### examples/
Examples for your applications and/or public libraries.

### internal/
Private application and library code. This is the code you don't want others importing in their applications or libraries. Note that this layout pattern is enforced by the Go compiler itself. See the Go 1.4 release notes for more details. Note that you are not limited to the top level internal directory. You can have more than one internal directory at any level of your project tree.

You can optionally add a bit of extra structure to your internal packages to separate your shared and non-shared internal code. It's not required (especially for smaller projects), but it's nice to have visual clues showing the intended package use. Your actual application code can go in the /internal/app directory (e.g., /internal/app/myapp) and the code shared by those apps in the /internal/pkg directory (e.g., /internal/pkg/myprivlib).

### pkg/
Library code that's ok to use by external applications (e.g., /pkg/mypubliclib). Other projects will import these libraries expecting them to work, so think twice before you put something here :-) Note that the internal directory is a better way to ensure your private packages are not importable because it's enforced by Go. The /pkg directory is still a good way to explicitly communicate that the code in that directory is safe for use by others.

### scripts/
Scripts to perform various build, install, analysis, etc operations.

These scripts keep the root level Makefile small and simple.

### test/
Additional external test apps and test data. Feel free to structure the /test directory anyway you want. For bigger projects it makes sense to have a data subdirectory. For example, you can have /test/data or /test/testdata if you need Go to ignore what's in that directory. Note that Go will also ignore directories or files that begin with "." or "_", so you have more flexibility in terms of how you name your test data directory.

### tools/
Supporting tools for this project. Note that these tools can import code from the /pkg and /internal directories.

### web/
Web application specific components: static web assets, server side templates and SPAs.
