From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH 0/3] ceph: clean up some unsafe dentry->d_parent accesses
Date: Tue, 13 Dec 2016 13:04:10 -0500
Message-ID: <1481652253-14780-1-git-send-email-jlayton@redhat.com>
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Sender: linux-fsdevel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com, linux-fsdevel@vger.kernel.org, dhowells@redhat.com, viro@ZenIV.linux.org.uk
List-Id: ceph-devel.vger.kernel.org

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

Jeff Layton (3):
  ceph: clean up unsafe d_parent access in __choose_mds
  ceph: clean up unsafe d_parent accesses in build_dentry_path
  ceph: fix unsafe dcache access in ceph_encode_dentry_release

 fs/ceph/caps.c       |  7 ++++--
 fs/ceph/mds_client.c | 68 +++++++++++++++++++++++++++++++++++-----------------
 2 files changed, 51 insertions(+), 24 deletions(-)

-- 
2.7.4

