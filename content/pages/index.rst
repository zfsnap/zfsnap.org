zfsnap
#########################
:url:
:save_as: index.html

zfsnap is a free and open source script designed to make rolling ZFS snapshots
easy. It is written in portable /bin/sh, and our aim is for zfsnap to run
wherever ZFS is supported.

zfsnap follows the "Unix Philosophy." All the information it needs is stored
directly in the snapshot's name; no database or special ZFS properties are
needed. Care is taken to work *with* ZFS's utilties — rather than reimpliment
them.

zfsnap is fast, and can check tens-of-thousands of snapshots in seconds.
