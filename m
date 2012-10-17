From: Tommi Virtanen <tv@inktank.com>
Subject: Braindump: ceph-disk-*, upstart scripts, ceph-create-keys
Date: Wed, 17 Oct 2012 13:46:50 -0700
Message-ID: <CADvuQRF0aSZNGFHDD=7VeqMYAWiRNOC_QDV_PufDdAFLDXyDAg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-oa0-f46.google.com ([209.85.219.46]:44815 "EHLO
	mail-oa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757825Ab2JQUrL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Oct 2012 16:47:11 -0400
Received: by mail-oa0-f46.google.com with SMTP id h16so7901281oag.19
        for <ceph-devel@vger.kernel.org>; Wed, 17 Oct 2012 13:47:10 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: John Wilkins <john.wilkins@inktank.com>

Alright. I've written a few braindumps on OSD hotplugging before, this
is an update on what's in place now, and will hopefully form the core
of the relevant documentation later.

New-school deployments of Ceph have OSDs consume data disks fully --
that is, admin hands off the whole disk, Ceph machinery does even the
partition table setup.

ceph-disk-prepare
=================

A disk goes from state "blank" to "prepared" with "ceph-disk-prepare".
This just marks a disk as to be used by an OSD, gives it a random
identity (uuid),  and tells it what cluster it belongs to.

$ ceph-disk-prepare --help
usage: ceph-disk-prepare [-h] [-v] [--cluster NAME] [--cluster-uuid UUID]
                         [--fs-type FS_TYPE]
                         DISK [JOURNAL]

Prepare a disk for a Ceph OSD

positional arguments:
  DISK                 path to OSD data disk block device
  JOURNAL              path to OSD journal disk block device; leave out to
                       store journal in file

optional arguments:
  -h, --help           show this help message and exit
  -v, --verbose        be more verbose
  --cluster NAME       cluster name to assign this disk to
  --cluster-uuid UUID  cluster uuid to assign this disk to
  --fs-type FS_TYPE    file system type to use (e.g. "ext4")


It initializes the partition table on the disk (ALL DATA ON DISK WILL
BE LOST) in GPT format (
http://en.wikipedia.org/wiki/GUID_Partition_Table ) and creates a
partition of type ...ceff05d ("ceph osd"). This partition gets a
filesystem created on it, based on the following config options, as
read from /etc/ceph/$cluster.conf (based on --cluster=, default
"ceph"):

osd_fs_type
osd_fs_mkfs_arguments_{fstype}  (e.g. osd_fs_mkfs_arguments_xfs)
osd_fs_mount_options_{fstype}

Current default values can be seen here:
https://github.com/ceph/ceph/blob/e8df212ba7ccd77980f5ef3590f2c2ab7b7c2f36/src/ceph-disk-prepare#L143

If the second positional argument ("JOURNAL") is not given, the
journal will be placed in a file inside the file system, in the file
"journal".

If JOURNAL is the same string as DISK, the journal will be placed in a
second partition  (of size $osd_journal_size, from config) on the same
disk as the OSD data. If journal is given and is different from DISK,
it is assumed to be a GPT-format disk and a new partition will be
created on it (of size $osd_journal_size, from config). In both cases,
the file ``journal`` in the data disk will be a symlink to
/dev/disk/by-partuuid/UUID; this will later be used to locate the
correct journal partition.

Do not run multiple ceph-disk-prepare instances with the same JOURNAL
value at the same time; disk partitioning is not safe to do
concurrently.

The following GPT partition type UUIDs are used:
89c57f98-2fe5-4dc0-89c1-f3ad0ceff2be: "ceph to be", a partition in the
process of being prepared
4fbd7e29-9d25-41b8-afd0-062c0ceff05d: "ceph osd", a partition prepared
to become osd data
45b0969e-9b03-4f30-b4c6-b4b80ceff106: "ceph log", a partition used as a journal



ceph-disk-activate
==================

Typically, you do not run ``ceph-disk-activate`` manually. Let the
``ceph-hotplug`` Upstart job do it for you.


$ ceph-disk-activate --help
usage: ceph-disk-activate [-h] [-v] [--mount] [--activate-key PATH] PATH

Activate a Ceph OSD

positional arguments:
  PATH                 path to OSD data directory, or block device if using
                       --mount

optional arguments:
  -h, --help           show this help message and exit
  -v, --verbose        be more verbose
  --mount              mount the device first
  --activate-key PATH  bootstrap-osd keyring path template (/var/lib/ceph
                       /bootstrap-osd/{cluster}.keyring)


Normally, you'd use --mount. That may be enforced later:
http://tracker.newdream.net/issues/3341 . But once again, you're not
expected to need to run ceph-disk-activate manually.

(With --mount:) Mounts the partition, confirms it's an OSD data disk,
and creates the ``ceph-osd`` state on it. At this time, a
``osd.ID``-style integer is allocated for the OSD. Moves the mount
under ``/var/lib/ceph/osd/`` and starts a ceph-osd Upstart job for it.


ceph-create-keys
================

Typically, you do not run ``ceph-create-keys`` manually. Let the
``ceph-create-keys`` Upstart job do it for you.

$ ceph-create-keys --help
usage: ceph-create-keys [-h] [-v] [--cluster NAME] --id ID

Create Ceph client.admin key when ceph-mon is ready

optional arguments:
  -h, --help      show this help message and exit
  -v, --verbose   be more verbose
  --cluster NAME  name of the cluster
  --id ID, -i ID  id of a ceph-mon that is coming up


Waits until the local monitor identified by ID is in quorum, and then
if necessary, gets/creates the ``client.admin`` and
``client.bootstrap-osd`` keys and writes them to files for later use
by miscellaneous command-line tools and ``ceph-disk-activate``.


Upstart scripts
===============

These all tend to be "instance jobs", as the term goes in Upstart (
http://upstart.ubuntu.com/cookbook/ ). That is, they are parametrized
for $cluster (default ceph) and $id, and instances with different
values for those variables can co-exist.

Monitor:
ceph-mon.conf
 - ceph-mon
ceph-mon-all.conf
- tries to be a human-friendly facade for "all the ceph-mon that this
host is supposed to run"; I'm personally not convinced it works right.
ceph-mon-all-starter.conf
- at boot time, loop through subdirectories of /var/lib/ceph/mon/ and
start all the mons
ceph-create-keys.conf
- after a ``ceph-mon`` job instance is started, run ``ceph-create-keys``

OSD:
ceph-hotplug.conf
- triggered after a OSD data partition is added, runs ``ceph-disk-activate``
ceph-osd.conf
- updates the CRUSH location of the OSD using osd_crush_location and
osd_crush_initial_weight from /etc/ceph/$cluster.conf, checks that the
journal is available (that is, if journal is external, the disk is
available) and then runs the ``ceph-osd`` daemon

Later on, there will probably be a ceph-hotplug-journal.conf that will
handle the case where the external journal disk is seen by the
operating system only after the ceph-osd has aborted (
http://tracker.newdream.net/issues/3302 ).


Others:
The -all and -starter jobs follow the ceph-mon idiom.
ceph-mds-all.conf
ceph-mds-all-starter.conf
ceph-mds.conf
radosgw-all.conf
radosgw-all-starter.conf
radosgw.conf
