contribute
##########
:save_as: contribute.html

Want to contribute?
*******************

*Awesome.* Development primarily takes place on `github`_. Fork the repo,
create a branch, hack in your feature, and send us a Pull Request.

We ask that you take the time to read the following developer notes so that
your PR is more likely to be accepted.

Developer Notes
***************

zfsnap is written in sh. Not bash, ksh, or anything else. Good old, simple sh;
it's surprisingly powerful — and ultra-portable.

Portability
===========

Portability is key. When in doubt, if it isn't defined in POSIX, then don't
use it. Exceptions are made (such as the choice to use "local" variables), but
are rare.

Thankfully, ZFS is relatively modern (it was first introduced in Solaris 10),
so the shells supported are comparatively featureful and complete.

References
==========

Man pages are usually the best source of information when it comes to features
and portability. sh's man page for any given OS is usually available
*somewhere* on the internet.

The book "Beginning Portable Shell Scripting From Novice to Professional" is
also a great reference. It focuses on portability across Bourne and Bourne-like
shells, and has proven to be invaluable at times.

Performance
===========

As a rule, avoid calling external programs (date, grep, sed, etc). Adding a
call or two per run isn't a problem, but adding even *one* call per snapshot
checked can easily cause major slowdowns. Remember, zfsnap runs on systems with
100,000+ snapshots to check. sh's substring support is powerful enough that sed
and grep are rarely (if ever) needed for our use-case.

Also avoid spawning subshells, which are almost as bad as calling external
programs. $(), \`\`, and | each invoke subshells; if you need to return a value
from a function, use the global variable RETVAL.

Tests
=====

If submitting a feature, it is infinitely more likely to be accepted if it
comes with tests.

.. _github: https://github.com/zfsnap/zfsnap
