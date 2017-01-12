From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH 1/4] ceph: fix endianness of getattr mask in ceph_d_revalidate
Date: Thu, 12 Jan 2017 11:12:42 -0500
Message-ID: <1484237565-27423-2-git-send-email-jlayton@redhat.com>
References: <1484237565-27423-1-git-send-email-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:43664 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751198AbdALQMu (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 12 Jan 2017 11:12:50 -0500
In-Reply-To: <1484237565-27423-1-git-send-email-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>
Cc: Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

    fs/ceph/dir.c:1248:50: warning: incorrect type in assignment (different base types)
    fs/ceph/dir.c:1248:50:    expected restricted __le32 [usertype] mask
    fs/ceph/dir.c:1248:50:    got int [signed] [assigned] mask

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/dir.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/dir.c b/fs/ceph/dir.c
index cd99b26de4da..d4385563b70a 100644
--- a/fs/ceph/dir.c
+++ b/fs/ceph/dir.c
@@ -1230,7 +1230,8 @@ static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
 		struct ceph_mds_client *mdsc =
 			ceph_sb_to_client(dir->i_sb)->mdsc;
 		struct ceph_mds_request *req;
-		int op, mask, err;
+		int op, err;
+		u32 mask;
 
 		if (flags & LOOKUP_RCU)
 			return -ECHILD;
@@ -1245,7 +1246,7 @@ static int ceph_d_revalidate(struct dentry *dentry, unsigned int flags)
 			mask = CEPH_STAT_CAP_INODE | CEPH_CAP_AUTH_SHARED;
 			if (ceph_security_xattr_wanted(dir))
 				mask |= CEPH_CAP_XATTR_SHARED;
-			req->r_args.getattr.mask = mask;
+			req->r_args.getattr.mask = cpu_to_le32(mask);
 
 			err = ceph_mdsc_do_request(mdsc, NULL, req);
 			switch (err) {
-- 
2.7.4

