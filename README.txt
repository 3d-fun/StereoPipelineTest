StereoPipelineTest is a comprehensive, distributed, and fully
automated test suite for the Ames Stereo Pipeline (ASP). It attempts
to cover most, if not all, of the ways in which ASP can be used, and
the test suite should be updated regularly as more functionality is
added to ASP.

StereoPipelineTest uses the Python py.test framework to run the tests.
This framework needs Python >= 2.6. It can be installed as follows:

pip install --user pytest
pip install --user pytest-xdist

or 

easy_install --prefix ~/.local -U pytest
easy_install --prefix ~/.local -U pytest-xdist

The py.test script ends up being installed either in /usr/bin, or in
~/.local/bin (on Linux) or in ~/Library/Python/2.x/bin (on OSX). In
either case, the install directory needs to be added to the path.

Usage: py.test -n <num cpu> -q -s -r a --tb=no --config <settings file> > report.txt

Here, <num cpu> is how many processes to use. 

The files conftest.py and test_run.py control the behavior of py.test.

A sample <settings file> is provided, named 'pfe.conf'. This file has:

1. The tests to run (wildcard expressions are accepted).
2. The machines to distribute the runs across (they must be accessible
   via ssh and share disk storage).
3. How many processes to use on each machine (each process in turn uses 
   multiple threads).
4. If to do strict validation (that is, not allow, vs. allow, a small
   discrepancy between current and reference runs, more below).
5. Environmental variables, such as the path to the ASP executables.

Each test needs to be in its own directory. A test is executed by
running the script 'run.sh' in that directory, which should create an
output directory named 'run'. A 'gold' directory must be present,
which has the reference run. At the conclusion of the run, the result in
the 'run' directory is compared to the reference in 'gold'. The test
will fail if the produced result is different or absent.

If a new test is added, the name of the test directory must be listed
in the settings file or match the wildcard pattern already present
there. Each test must have a 'run.sh' file, and a validation script,
named 'validate.sh'. The 'validate.sh' script must return exit status
0 on successful validation, and non-zero otherwise.

When tests fail, which is inevitable when something changes, and the
new results are deemed acceptable, the 'gold' reference directory
needs to be updated by copying the output from the 'run' directory. 

If the processes is terminated before all tests finish, the last result
for each test can be seen by running bin/check_status.py.

--== Troubleshooting ==--

If py.test is not found, try running 
source [BINARY_BUILDER_DIR]/auto_build/utils.sh


On OSX machines, debugging tools cannot be run without admin access.
SG can help set this up but you may periodically need to re-run this command
(at least on andey) to get it to work again:
 codesign -s gdb-cert /opt/local/bin/ggdb


