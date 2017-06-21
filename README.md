# Lazy Packages

#rstats package installation for lazy people.

## Description

We all get a bit lazy sometimes, especially when performing data analyses on the fly. If you've installed a whole suite of add-on packages for a particular project, there's no guarantee your collaborators will have done the same thing. A principled way to approach this issue could be to develop data analyses as R packages themselves (e.g. XXX), or to use [docker](https://www.docker.com/) (check out the awesome [rocker](https://github.com/rocker-org/rocker)), where it will be made explicit upfront what packages are required to run your analysis.

But you didn't do this. Or you started collaborating with someone who didn't this. Whatev. Here's where these couple of scripts hacked together will help your lazy self (or your colleague, but don't tell them I said that).

So, ask yourself the following questions:

- Do your scripts contain whole heap of `library` and `require` calls to attach packages to whatever you're doing?
- Are you too lazy to:
    - Write a proper R package and specify all your dependencies;
    - Use another add-on library such as [pacman](https://github.com/trinker/pacman), and remember new syntax to load/install packages (e.g. `pacman::p_load(cool_package)`); and
    - Run your analysis inside a docker container?
	
If you answered yes to these questions, then these scripts will be of interest!

## Usage

This is pretty simple. You can do these steps in a Makefile (best, see the example provided), or you can just do them via the terminal. The R folder in this repository contains some example scripts that do nothing but try to attach some packages.

First, make the `strip_libs.sh` bash script executable (`chmod u+x strip_libs.sh`); then, assuming you are in the scripts directory, to extract the packages that are being called in the R scripts, and store them in the text file `installs.txt`, do the following:

```bash
$ ./strip_libs ../R/ installs.txt
```

This will extract all the packages, sort them, and remove duplicates; see [this post](http://stevelane.github.io/blog/2017/05/17/awk-packages) for more information on the script itself. If you did this on the example files, you should see that the scripts directory now contains `installs.txt`, with the following contents:

```
dplyr
ggplot2
lme4
tidyr
```

Now that you have a list of packages that your data analysis is trying to make use of, do the following (from the terminal still, within the scripts directory) to check if they're installed, and install them if not:

```bash
$ Rscript --no-save --no-restore ipak.R insts=installs.txt
```

Any packages that are missing will be installed (with dependencies).

## Makefile

Of course, it is better to have all of this wrapped up in a Makefile as part of your analysis work --- if you use Makefiles, that is. If you don't use Makefiles, check them out, or look up [`remake`](https://github.com/richfitz/remake) which will help you do some of this stuff straight from R.

Something like the following should work in your Makefile (assuming `strip_libs.sh` and `ipak.R` are in the scripts directory, and your R scripts are in the R directory):

```Makefile
install-packages: scripts/strip-libs.sh scripts/ipak.R
	chmod u+x scripts/strip-libs.sh; \
	./scripts/strip-libs.sh R/ scripts/installs.txt; \
	Rscript --no-save --no-restore scripts/ipak.R insts=installs.txt
```

I would keep this as a separate part of the Makefile flow. I think that it's polite to not install packages on people without asking. So if you keep this out of your `all` rule, then running `make` should error out if there's packages missing, and the use can then run `make install-packages` to install them.
