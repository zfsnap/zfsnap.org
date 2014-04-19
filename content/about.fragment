about
#####
:url:
:save_as: about.html

zfsnap was written during a brief respite from the howling wind and torrential
rain as the eye of a hurricane passed overhead (i.e. it was written by
sysadmins).

zfsnap is intended to be a portable and performant solution to the problem of
easily creating, managing, and deleting rolling ZFS snapshots.

What is the snapshot name format?
*********************************

The format is simple and human readable: pool/fs@[prefix]datetime--ttl. The
prefix is optional, and is quite useful for filtering::

  jackknife/home@weekly-2014-04-17_11.01.00--6w

Why zfsnap?
***********

There certainly is no shortage of scripts available which attempt to tackle the
problem of rolling ZFS snapshots — with varied success. zfsnap aims to provide
a simple, focused solution to the problem. No databases, embedded ZFS
properties, or dependency-heavy scripting languages.

Scripts are written with flexibility in mind, so they can be adapted to a wide
variety of situations. Core functionality is split into functions in a core
library so that, if the need arises, others may easily work with
zfsnap-generated-snapshots in their own site-specific scripts.

zfsnap is reliable. OS-specific checks are avoided, and the code-path is the
same for every plaform. A test suite with over 240 tests (and growing)
helps ensure reliability.

Is it open source?
******************

zfsnap is distributed under the BSD-3-Clause open source license, and is
developed on `GitHub`_.

Who wrote zfsnap?
*****************

Being an open source project, there's a cast of people who have contributed to
the project — both directly and indirectly. zfsnap was started by Aldis Berjoza
in 2010, and Alex Waite became a co-maintainer of the project in 2014.

.. _GitHub: https://github.com/zfsnap/zfsnap
