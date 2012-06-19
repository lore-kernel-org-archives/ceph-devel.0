From: Travis Rhoden <trhoden@gmail.com>
Subject: Error creating journal during mkcephfs
Date: Tue, 19 Jun 2012 13:00:01 -0400
Message-ID: <CACkq2mqsUFoqJnQNw7VgTPChd2w2b7u7ZYqNWZ7gYsLssKVeVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:45165 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751606Ab2FSRAX (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jun 2012 13:00:23 -0400
Received: by bkcji2 with SMTP id ji2so5321470bkc.19
        for <ceph-devel@vger.kernel.org>; Tue, 19 Jun 2012 10:00:22 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I almost posted this to http://tracker.newdream.net/issues/2595, but
didn't want to piggy-back on an issue marked resolved.

When I run mkcephfs, I get:

2012-06-19 09:36:29.211737 7fc7021d7780 -1 journal FileJournal::_open:
unable to open journal: open() failed: (22) Invalid argument
2012-06-19 09:36:29.211827 7fc7021d7780 -1 OSD::mkfs: FileStore::mkfs
failed with error -22
2012-06-19 09:36:29.211852 7fc7021d7780 -1  ** ERROR: error creating
empty object store in /srv/osd.0: (22) Invalid argument

I'm running 0.47.2 on Ubuntu 12.04.  Here is the osd section of my ceph.conf:

[osd]
        osd data = /srv/osd.$id
        osd journal = /tmpfs/osd.$id.journal
        osd journal size = 1000
        filestore fiemap = false
        ; uncomment the following line if you are mounting with ext4
        ; filestore xattr use omap = true
        keyring = /etc/ceph/keyring.$name


The problem arose when I was trying to move my journals onto tmpfs.  I
blew away my old cluster (I'm just testing different configs), and
then hit this when I tried to make a new one.  The reason I think this
is differen than issue # 2595 is that my mkcephfs does NOT succeed,
whereas the other user's did.  The journal file at
/tmpfs/osd.$id/journal does get created but it is 0 bytes.

# ls -al /tmpfs
total 4
drwxrwxrwt  2 root root   60 Jun 19 09:36 .
drwxr-xr-x 24 root root 4096 Jun 19 09:08 ..
-rw-r--r--  1 root root    0 Jun 19 09:36 osd.0.journal

# df -h /tmpfs
Filesystem             Size  Used Avail Use% Mounted on
tmpfs                  2.5G     0  2.5G   0% /tmpfs

My tmpfs looks like this:

# mount | grep tmpfs
tmpfs on /tmpfs type tmpfs (rw,size=2560m)

I threw debug filestore = 20 into ceph.conf and capture this in the log file:

2012-06-19 09:36:28.888220 7fc7021d7780  1 filestore(/srv/osd.0) mkfs
in /srv/osd.0
2012-06-19 09:36:28.888379 7fc7021d7780  0 filestore(/srv/osd.0) mkfs
removing old directory current
2012-06-19 09:36:28.890923 7fc7021d7780  0 filestore(/srv/osd.0) mkfs
removing old file store_version
2012-06-19 09:36:28.911798 7fc7021d7780 10 filestore(/srv/osd.0) mkfs
fsid is 52ab0ff0-bb36-472d-93d5-7a02f0dfa5e5
2012-06-19 09:36:28.911892 7fc7021d7780  2 filestore(/srv/osd.0)
BTRFS_IOC_SUBVOL_CREATE ioctl failed, trying mkdir /srv/osd.0/current
2012-06-19 09:36:29.211668 7fc7021d7780 -1 filestore(/srv/osd.0)
leveldb db created
2012-06-19 09:36:29.211700 7fc7021d7780 10 filestore(/srv/osd.0)
open_journal at /tmpfs/osd.0.journal
2012-06-19 09:36:29.211737 7fc7021d7780 -1 journal FileJournal::_open:
unable to open journal: open() failed: (22) Invalid argument
2012-06-19 09:36:29.211814 7fc7021d7780  0 filestore(/srv/osd.0)
mkjournal error creating journal on /tmpfs/osd.0.journal
2012-06-19 09:36:29.211827 7fc7021d7780 -1 OSD::mkfs: FileStore::mkfs
failed with error -22
2012-06-19 09:36:29.211852 7fc7021d7780 -1 ^[[0;31m ** ERROR: error
creating empty object store in /srv/osd.0: (22) Invalid argument^[[0m


The OSD that I am working with was used before in my old cluster, but
I blew it away first by unmounting and reformatting the partition (
just a simple 'mkfs.xfs /dev/md0' ).  The device is software RAID 0.
Again, I'm just playing with configs to see what the fastest
performance i can get out of my hardware is.  It seemed like maybe the
journal was holding me back, so I'm trying to move it to /tmpfs.

I feel like I'm missing something obvious.

 - Travis
