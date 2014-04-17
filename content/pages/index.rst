zfsnap
######
:save_as: index.html

zfsnap is a Free and open source script designed to make rolling ZFS snapshots
easy. It is written in portable /bin/sh, and our aim is for zfsnap to run
wherever ZFS is supported.

zfsnap follows the "Unix Philosophy." All the information it needs is stored
directly in the snapshot's name; no database or special ZFS properties are
needed. Care is taken to work *with* ZFS's utilities — rather than reimplement
them.

zfsnap is fast and scalable. It can check tens-of-thousands of snapshots in
seconds.
