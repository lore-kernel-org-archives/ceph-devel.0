From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v4 0/5] ceph: clean up some unsafe dentry->d_parent accesses
Date: Thu, 15 Dec 2016 06:34:24 -0500
Message-ID: <1481801669-4916-1-git-send-email-jlayton@redhat.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com, linux-fsdevel@vger.kernel.org, dhowells@redhat.com, viro@ZenIV.linux.org.uk
List-Id: ceph-devel.vger.kernel.org

v4: handle r_locked_dir correctly in __choose_mds
    rename rdirino to rdiri

v3: use parent inode information more widely when we have it

v2: use r_locked_dir in __choose_mds if it's available
    handle NULL d_inode_rcu(parent) properly

In several places, the kcephfs client accesses dentry->d_parent without
holding appropriate locking. This is not safe, as you can race with
renames that can morph the tree such that is changes and dentries found
previously can end up freed. This patchset fixes these places to access
the parent(s) safely, mostly using the rcu_read_lock().

Note that I'm not aware of any specific bug reports in this area --
these were just discovered by inspection (mostly by Zheng). This passes
xfstests at least up to test generic/095, where we hit an unrelated
softlockup in the splice write code (http://tracker.ceph.com/issues/18130).

Tracker bug link: http://tracker.ceph.com/issues/18148


*** BLURB HERE ***

clone of "ceph-4.10"

Jeff Layton (5):
  ceph: clean up unsafe d_parent access in __choose_mds
  ceph: clean up unsafe d_parent accesses in build_dentry_path
  ceph: pass parent dir ino info to build_dentry_path
  ceph: fix unsafe dcache access in ceph_encode_dentry_release
  ceph: pass parent inode info to ceph_encode_dentry_release if we have
    it

 fs/ceph/caps.c       |  8 ++++-
 fs/ceph/mds_client.c | 92 ++++++++++++++++++++++++++++++++++------------------
 fs/ceph/super.h      |  1 +
 3 files changed, 69 insertions(+), 32 deletions(-)

-- 
2.7.4

