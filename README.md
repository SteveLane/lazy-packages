# Lazy Packages

#rstats package installation for lazy people.

## Description

We all get a bit lazy sometimes, especially when performing data analyses on the fly. If you've installed a whole suite of add-on packages for a particular project, there's no guarantee your collaborators will have done the same thing. A principled way to approach this issue could be to develop data analyses as R packages themselves (e.g. XXX), or to use [docker](https://www.docker.com/) (check out the awesome [rocker](https://github.com/rocker-org/rocker)), where it will be made explicit upfront what packages are required to run your analysis.

But you didn't do this. Or you started collaborating with someone who didn't this. Whatev. Here's where these couple of scripts hacked together will help your lazy self (or your colleague, but don't tell them I said that).

So, ask yourself the following questions:

- Do your scripts contain whole heap of `library` and `require` calls to attach packages to whatever you're doing?
- Are you too lazy to:

	a. Write a proper R package and specify all your dependencies;
    b. Use another add-on library such as [pacman](https://github.com/trinker/pacman), and remember new syntax to load/install packages (e.g. `pacman::p_load(cool_package)`); and
	c. Run your analysis inside a docker container?
	
If you answered yes to these questions, then these scripts will be of interest!
