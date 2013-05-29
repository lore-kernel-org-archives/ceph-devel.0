From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch] ceph: tidy ceph_mdsmap_decode() a little
Date: Wed, 29 May 2013 09:22:13 +0300
Message-ID: <20130529062213.GF23932@mwanda>
References: <1369753140-28802-1-git-send-email-emilgoode@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1369753140-28802-1-git-send-email-emilgoode@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org, Emil Goode <emilgoode@gmail.com>
List-Id: ceph-devel.vger.kernel.org

I introduced a new temporary variable "info" instead of
"m->m_info[mds]".  Also I reversed the if condition and pulled
everything in one indent level.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
---
This goes on top of Emil Goode's patch.

diff --git a/fs/ceph/mdsmap.c b/fs/ceph/mdsmap.c
index d4d3897..132b64e 100644
--- a/fs/ceph/mdsmap.c
+++ b/fs/ceph/mdsmap.c
@@ -92,6 +92,7 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end)
 		u32 num_export_targets;
 		void *pexport_targets = NULL;
 		struct ceph_timespec laggy_since;
+		struct ceph_mds_info *info;
 
 		ceph_decode_need(p, end, sizeof(u64)*2 + 1 + sizeof(u32), bad);
 		global_id = ceph_decode_64(p);
@@ -126,26 +127,27 @@ struct ceph_mdsmap *ceph_mdsmap_decode(void **p, void *end)
 		     i+1, n, global_id, mds, inc,
 		     ceph_pr_addr(&addr.in_addr),
 		     ceph_mds_state_name(state));
-		if (mds >= 0 && mds < m->m_max_mds && state > 0) {
-			m->m_info[mds].global_id = global_id;
-			m->m_info[mds].state = state;
-			m->m_info[mds].addr = addr;
-			m->m_info[mds].laggy =
-				(laggy_since.tv_sec != 0 ||
-				 laggy_since.tv_nsec != 0);
-			m->m_info[mds].num_export_targets = num_export_targets;
-			if (num_export_targets) {
-				m->m_info[mds].export_targets =
-					kcalloc(num_export_targets, sizeof(u32),
-						GFP_NOFS);
-				if (m->m_info[mds].export_targets == NULL)
-					goto badmem;
-				for (j = 0; j < num_export_targets; j++)
-					m->m_info[mds].export_targets[j] =
-					       ceph_decode_32(&pexport_targets);
-			} else {
-				m->m_info[mds].export_targets = NULL;
-			}
+
+		if (mds < 0 || mds >= m->m_max_mds || state <= 0)
+			continue;
+
+		info = &m->m_info[mds];
+		info->global_id = global_id;
+		info->state = state;
+		info->addr = addr;
+		info->laggy = (laggy_since.tv_sec != 0 ||
+			       laggy_since.tv_nsec != 0);
+		info->num_export_targets = num_export_targets;
+		if (num_export_targets) {
+			info->export_targets = kcalloc(num_export_targets,
+						       sizeof(u32), GFP_NOFS);
+			if (info->export_targets == NULL)
+				goto badmem;
+			for (j = 0; j < num_export_targets; j++)
+				info->export_targets[j] =
+				       ceph_decode_32(&pexport_targets);
+		} else {
+			info->export_targets = NULL;
 		}
 	}
 
