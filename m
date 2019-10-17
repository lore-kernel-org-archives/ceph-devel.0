From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH] ceph: Fix use-after-free in __ceph_remove_cap
Date: Thu, 17 Oct 2019 15:46:36 +0100
Message-ID: <20191017144636.28617-1-lhenriques@suse.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Luis Henriques <lhenriques@suse.com>
List-Id: ceph-devel.vger.kernel.org

KASAN reports a use-after-free when running xfstest generic/531, with the
following trace:

[  293.903362]  kasan_report+0xe/0x20
[  293.903365]  rb_erase+0x1f/0x790
[  293.903370]  __ceph_remove_cap+0x201/0x370
[  293.903375]  __ceph_remove_caps+0x4b/0x70
[  293.903380]  ceph_evict_inode+0x4e/0x360
[  293.903386]  evict+0x169/0x290
[  293.903390]  __dentry_kill+0x16f/0x250
[  293.903394]  dput+0x1c6/0x440
[  293.903398]  __fput+0x184/0x330
[  293.903404]  task_work_run+0xb9/0xe0
[  293.903410]  exit_to_usermode_loop+0xd3/0xe0
[  293.903413]  do_syscall_64+0x1a0/0x1c0
[  293.903417]  entry_SYSCALL_64_after_hwframe+0x44/0xa9

This happens because __ceph_remove_cap() may queue a cap release
(__ceph_queue_cap_release) which can be scheduled before that cap is
removed from the inode list with

	rb_erase(&cap->ci_node, &ci->i_caps);

And, when this finally happens, the use-after-free will occur.

This can be fixed by protecting the rb_erase with the s_cap_lock spinlock,
which is used by ceph_send_cap_releases(), before the cap is freed.

Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 fs/ceph/caps.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index d3b9c9d5c1bd..21ee38cabe98 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1089,13 +1089,13 @@ void __ceph_remove_cap(struct ceph_cap *cap, bool queue_release)
 	}
 	cap->cap_ino = ci->i_vino.ino;
 
-	spin_unlock(&session->s_cap_lock);
-
 	/* remove from inode list */
 	rb_erase(&cap->ci_node, &ci->i_caps);
 	if (ci->i_auth_cap == cap)
 		ci->i_auth_cap = NULL;
 
+	spin_unlock(&session->s_cap_lock);
+
 	if (removed)
 		ceph_put_cap(mdsc, cap);
 
