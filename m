From: Jeff Layton <jlayton@redhat.com>
Subject: [PATCH v3 7/8] ceph: call update_dentry_lease even when r_locked dir is not set
Date: Fri,  3 Feb 2017 13:04:03 -0500
Message-ID: <20170203180404.31930-8-jlayton@redhat.com>
References: <20170201114914.20808-1-jlayton@redhat.com>
 <20170203180404.31930-1-jlayton@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56162 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751040AbdBCSEL (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 3 Feb 2017 13:04:11 -0500
In-Reply-To: <20170203180404.31930-1-jlayton@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com

We don't really require that the parent be locked in order to update the
lease on a dentry. Lease info is protected by the d_lock. In the event
that the parent is not locked in ceph_fill_trace, and we have both
parent and target info, go ahead and update the dentry lease.

Signed-off-by: Jeff Layton <jlayton@redhat.com>
---
 fs/ceph/inode.c | 20 ++++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 41cbddd22091..b5de158abaaa 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1363,6 +1363,26 @@ int ceph_fill_trace(struct super_block *sb, struct ceph_mds_request *req)
 			goto done;
 		}
 		req->r_dentry = dn;  /* may have spliced */
+	} else if (rinfo->head->is_dentry) {
+		struct ceph_vino *ptvino = NULL;
+
+		if ((le32_to_cpu(rinfo->diri.in->cap.caps) & CEPH_CAP_FILE_SHARED) ||
+		    le32_to_cpu(rinfo->dlease->duration_ms)) {
+			dvino.ino = le64_to_cpu(rinfo->diri.in->ino);
+			dvino.snap = le64_to_cpu(rinfo->diri.in->snapid);
+
+			if (rinfo->head->is_target) {
+				tvino.ino = le64_to_cpu(rinfo->targeti.in->ino);
+				tvino.snap = le64_to_cpu(rinfo->targeti.in->snapid);
+				ptvino = &tvino;
+			}
+
+			update_dentry_lease(req->r_dentry, rinfo->dlease,
+				session, req->r_request_started, ptvino,
+				&dvino);
+		} else {
+			dout("%s: no dentry lease or dir cap\n", __func__);
+		}
 	}
 done:
 	dout("fill_trace done err=%d\n", err);
-- 
2.9.3

