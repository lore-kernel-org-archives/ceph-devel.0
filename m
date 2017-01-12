From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH 2/4] ceph: fix endianness bug in frag_tree_split_cmp
Date: Thu, 12 Jan 2017 11:12:43 -0500
Message-ID: <1484237565-27423-3-git-send-email-jlayton@redhat.com>
References: <1484237565-27423-1-git-send-email-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39434 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751200AbdALQMu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 12 Jan 2017 11:12:50 -0500
In-Reply-To: <1484237565-27423-1-git-send-email-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

sparse says:

fs/ceph/inode.c:308:36: warning: incorrect type in argument 1 (different base types)
fs/ceph/inode.c:308:36:    expected unsigned int [unsigned] [usertype] a
fs/ceph/inode.c:308:36:    got restricted __le32 [usertype] frag
fs/ceph/inode.c:308:46: warning: incorrect type in argument 2 (different base types)
fs/ceph/inode.c:308:46:    expected unsigned int [unsigned] [usertype] b
fs/ceph/inode.c:308:46:    got restricted __le32 [usertype] frag

I think we need to convert these values to host-endian before calling
the comparator.

Fixes: a407846ef7c6e (ceph: don't assume frag tree splits in mds reply are sorted)
Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/inode.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 1476f54ed118..4926265f4223 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -305,7 +305,8 @@ static int frag_tree_split_cmp(const void *l, const void *r)
 {
 	struct ceph_frag_tree_split *ls = (struct ceph_frag_tree_split*)l;
 	struct ceph_frag_tree_split *rs = (struct ceph_frag_tree_split*)r;
-	return ceph_frag_compare(ls->frag, rs->frag);
+	return ceph_frag_compare(le32_to_cpu(ls->frag),
+				 le32_to_cpu(rs->frag));
 }
 
 static bool is_frag_child(u32 f, struct ceph_inode_frag *frag)
-- 
2.7.4

