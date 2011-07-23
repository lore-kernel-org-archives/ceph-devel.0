From: Sage Weil <sage@newdream.net>
Subject: [PATCH 00/23] Ceph queue for v3.0
Date: Fri, 22 Jul 2011 17:02:39 -0700
Message-ID: <1311379382-9218-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:44305 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753985Ab1GWAFx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jul 2011 20:05:53 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@newdream.net>

Here is the current queue of patches for v3.0.  There are a few things 
worth nothing here:

 - rbd requests will be a bit larger now (512kb), which should improve 
   performance
 - readahead size is begin set properly, which helps read performance 
   (but is not the complete solution)
 - There was an audit of all d_parent accesses that resulted in a whole 
   bunch of patches.  Basically any d_parent use needs to be proteted by 
   the parent directory i_mutex or d_lock or suffer the consequences of 
   a race with rename.
 - open intents are fixed

I hope to send this to Linus in a few days.  Let me know if you see any 
problems here!

Thanks-
sage

 
Greg Farnum (1):
  ceph: report f_bfree based on kb_avail rather than diffing.

Josh Durgin (1):
  rbd: set blk_queue request sizes to object size

Sage Weil (19):
  ceph: add flags field to file_info
  ceph: add F_SYNC file flag to force sync (non-O_DIRECT) io
  ceph: use flag bit for at_end readdir flag
  ceph: fix snap writeback when racing with writes
  ceph: only queue capsnap if caps are dirty
  libceph: don't time out osd requests that haven't been received
  ceph: avoid carrying Fw cap during write into page cache
  ceph: fix bad parent_inode calc in ceph_lookup_open
  ceph: only link open operations to directory unsafe list if
    O_CREAT|O_TRUNC
  ceph: fix ceph_lookup_open intent usage
  ceph: ignore lease mask
  ceph: set dir complete frag after adding capability
  ceph: handle racing calls to ceph_init_dentry
  ceph: protect access to d_parent
  ceph: protect d_parent access in ceph_d_revalidate
  ceph: avoid d_parent in ceph_dentry_hash; fix ceph_encode_fh()
    hashing bug
  ceph: document locking for ceph_set_dentry_offset
  ceph: explicitly reference rename old_dentry parent dir in request
  ceph: document unlocked d_parent accesses

Yehuda Sadeh (2):
  rbd: cancel watch request when releasing the device
  ceph: set up readahead size when rsize is not passed

 drivers/block/rbd.c            |   46 ++++++++++++++++-
 fs/ceph/debugfs.c              |    2 +-
 fs/ceph/dir.c                  |  114 +++++++++++++++++++++++++---------------
 fs/ceph/export.c               |   23 +++++---
 fs/ceph/file.c                 |   61 ++++++++++++++++------
 fs/ceph/inode.c                |   48 +++++++++-------
 fs/ceph/ioctl.c                |   15 +++++-
 fs/ceph/ioctl.h                |    1 +
 fs/ceph/mds_client.c           |   56 +++++++++++---------
 fs/ceph/mds_client.h           |    3 +-
 fs/ceph/snap.c                 |   25 +++++++--
 fs/ceph/super.c                |    7 ++-
 fs/ceph/super.h                |   20 +++----
 fs/ceph/xattr.c                |    8 ++-
 include/linux/ceph/messenger.h |    1 +
 net/ceph/messenger.c           |   12 ++---
 net/ceph/osd_client.c          |    6 ++
 17 files changed, 304 insertions(+), 144 deletions(-)

