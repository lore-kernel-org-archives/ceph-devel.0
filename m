From: Jeff Layton <jlayton@redhat.com>
Subject: [RFC PATCH 03/10] ceph: initialize i_version to 0 in new ceph inodes
Date: Fri,  4 Nov 2016 07:34:26 -0400
Message-ID: <1478259273-3471-4-git-send-email-jlayton@redhat.com>
References: <1478259273-3471-1-git-send-email-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:52690 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1761180AbcKDLeh (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 4 Nov 2016 07:34:37 -0400
In-Reply-To: <1478259273-3471-1-git-send-email-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com, zyan@redhat.com, sage@redhat.com

Currently, i_version is not always initialized when inodes are
allocated, so it's possible to end up "inheriting" an i_version from a
completely different inode.

In most cases, this is not an issue, as the initialized value will end
up being clobbered when the inode metadata is set up.

Ceph is a little different here though as we always want the max value
for i_version.

For now, just initialize this to 0 in ceph_alloc_inode, but we may
eventually want to move this into inode_init_always and do it for all
filesystems.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/inode.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index ef4d04647325..f03dc579e0ec 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -514,6 +514,8 @@ struct inode *ceph_alloc_inode(struct super_block *sb)
 
 	ceph_fscache_inode_init(ci);
 
+	// FIXME: merge initialization into inode_init_always ?
+	ci->vfs_inode.i_version = 0;
 	return &ci->vfs_inode;
 }
 
-- 
2.7.4

