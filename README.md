# iap-appbml

This repository is a collection of material designed for a 2017 IAP class at MIT titled "Applied Probabilistic Programming & Bayesian Machine Learning." It includes:

- Lecture notes (in pdf format)
- Python, R, and Stan coding exercises
- Toy Datasets (csv format)

The material is largely a "remixing" of two textbooks: Statistical Rethinking, and Bayesian Data Analysis 3.

# Installation:
Required Software:
- Git (optional)
- Python 2.7\*
- pystan
- R
- RStan.

If you have Git, you can clone this repository. If you do not, you can download this repository as a compressed folder. 
Git installation guide: https://git-scm.com/book/en/v2/Getting-Started-Installing-Git

We recommend Anaconda (https://www.continuum.io/downloads) as an OS-agnostic solution to installing Python and pystan without administrative privileges. For Windows users, Anaconda also provides a GUI. Once you have anaconda, you can install pystan without root by using:

```
> conda install -c anaconda pystan
```

If you're on Windows, see http://pystan.readthedocs.io/en/latest/windows.html for installating Pystan.

To install R without root, see here: http://unix.stackexchange.com/posts/149455

To install RStan for Linux/Mac: https://github.com/stan-dev/rstan/wiki/Installing-RStan-on-Mac-or-Linux

To install RStan for Windows: https://github.com/stan-dev/rstan/wiki/Installing-RStan-on-Windows

\* Note: Python code is written for 2.7, but is easy to convert to Python 3 compatible code if needed.
