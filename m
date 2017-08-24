From: Alfredo Deza <adeza@redhat.com>
Subject: osd fails to start, cannot mount the journal
Date: Thu, 24 Aug 2017 13:51:58 -0400
Message-ID: <CAC-Np1zijh2F+jv2pAigBH6fAaxLV=ByGF+NfYaWWNaLPBYyQQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f47.google.com ([74.125.82.47]:38219 "EHLO
        mail-wm0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751475AbdHXRwA (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Aug 2017 13:52:00 -0400
Received: by mail-wm0-f47.google.com with SMTP id z132so1003018wmg.1
        for <ceph-devel@vger.kernel.org>; Thu, 24 Aug 2017 10:51:59 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

I'm using the tip of luminous and encountering an inconsistent problem
with journals (using filestore).

The deployment goes well, the single OSD comes up and everything goes
well. After rebooting I can find that the OSD fails to start. The logs
complain like this:

Aug 24 20:33:06 ceph-osd0 ceph-osd[17772]: 2017-08-24 20:33:06.415820
7fbb10a08e00 -1 journal FileJournal::open: ondisk fsid
00000000-0000-0000-0000-000000000000 doesn't match expected
56501dc6-6c0a-482f-8252-4406705f1b67, invalid (someone else's?)
journal
Aug 24 20:33:06 ceph-osd0 ceph-osd[17772]: 2017-08-24 20:33:06.415952
7fbb10a08e00 -1 filestore(/var/lib/ceph/osd/ceph-0) mount(1821):
failed to open journal /var/lib/ceph/osd/ceph-0/journal: (22) Invalid
argument
Aug 24 20:33:06 ceph-osd0 ceph-osd[17772]: 2017-08-24 20:33:06.416625
7fbb10a08e00 -1 osd.0 0 OSD:init: unable to mount object store
Aug 24 20:33:06 ceph-osd0 ceph-osd[17772]: 2017-08-24 20:33:06.416632
7fbb10a08e00 -1  ** ERROR: osd init failed: (22) Invalid argument

At this point /var/lib/ceph/osd/ceph-0 is mounted, with ceph:ceph as
owner, and the journal is linked too. Permissions there look correct
to me:

# ls -alh /var/lib/ceph/osd/ceph-0
total 44K
drwxr-xr-x  3 ceph ceph  194 Aug 24 20:34 .
drwxr-xr-x  3 ceph ceph 4.0K Aug 24 20:22 ..
-rw-r--r--  1 ceph ceph  195 Aug 24 20:23 activate.monmap
-rw-r--r--  1 ceph ceph   37 Aug 24 20:23 ceph_fsid
drwxr-xr-x 20 ceph ceph  321 Aug 24 20:23 current
-rw-r--r--  1 ceph ceph   37 Aug 24 20:23 fsid
lrwxrwxrwx  1 ceph ceph    8 Aug 24 20:23 journal -> /dev/sdc
-rw-------  1 ceph ceph   56 Aug 24 20:23 keyring
-rw-r--r--  1 ceph ceph   21 Aug 24 20:23 magic
-rw-r--r--  1 ceph ceph    6 Aug 24 20:23 ready
-rw-r--r--  1 ceph ceph    4 Aug 24 20:23 store_version
-rw-r--r--  1 ceph ceph   53 Aug 24 20:23 superblock
-rw-r--r--  1 ceph ceph   10 Aug 24 20:23 type
-rw-r--r--  1 ceph ceph    2 Aug 24 20:23 whoami

Checking /dev/sdc/ permissions look OK to me as well:

# ls -alh /dev/sdc
brw-rw---- 1 ceph ceph 8, 32 Aug 24 20:25 /dev/sdc


The OSD logs seem to suggest it can read/write to the journal:

2017-08-24 20:34:47.661578 7f4f06178e00  0
filestore(/var/lib/ceph/osd/ceph-0) mount(1758): enabling WRITEAHEAD
journal mode: checkpoint is not enabled
2017-08-24 20:34:47.661816 7f4f06178e00  1 journal _open
/var/lib/ceph/osd/ceph-0/journal fd 30: 11534336000 bytes, block size
4096 bytes, directio = 1, aio = 1
2017-08-24 20:34:47.661921 7f4f06178e00 -1 journal FileJournal::open:
ondisk fsid 00000000-0000-0000-0000-000000000000 doesn't match
expected 56501dc6-6c0a-482f-8252-4406705f1b67, invalid (someone
else's?) journal
2017-08-24 20:34:47.661927 7f4f06178e00  1 journal close
/var/lib/ceph/osd/ceph-0/journal

But immediately after it sees it can't mount, failing to start the OSD:

2017-08-24 20:34:47.662030 7f4f06178e00 -1
filestore(/var/lib/ceph/osd/ceph-0) mount(1821): failed to open
journal /var/lib/ceph/osd/ceph-0/journal: (22) Invalid argument
2017-08-24 20:34:47.662552 7f4f06178e00  4 rocksdb:
[/build/ceph-12.1.4-113-gd79b443/src/rocksdb/db/db_impl.cc:217]
Shutdown: canceling all background work
2017-08-24 20:34:47.662694 7f4f06178e00  4 rocksdb:
[/build/ceph-12.1.4-113-gd79b443/src/rocksdb/db/db_impl.cc:343]
Shutdown complete
2017-08-24 20:34:47.662728 7f4f06178e00 -1 osd.0 0 OSD:init: unable to
mount object store



Not sure what else to try at this point. Any ideas?
