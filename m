From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: [PATCH 4/6] ceph: allocate cap_release message when receiving cap import
Date: Fri,  4 Jan 2013 19:34:19 +0800
Message-ID: <1357299261-20591-5-git-send-email-zheng.z.yan@intel.com>
References: <1357299261-20591-1-git-send-email-zheng.z.yan@intel.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:48663 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754479Ab3ADLed (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 4 Jan 2013 06:34:33 -0500
In-Reply-To: <1357299261-20591-1-git-send-email-zheng.z.yan@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, sage@inktank.com
Cc: "Yan, Zheng" <zheng.z.yan@intel.com>

From: "Yan, Zheng" <zheng.z.yan@intel.com>

When client wants to release an imported cap, it's possible there
is no reserved cap_release message in corresponding mds session.
so __queue_cap_release causes kernel panic.

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/caps.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index c90b245..7e90299 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2832,6 +2832,9 @@ void ceph_handle_caps(struct ceph_mds_session *session,
 	dout(" mds%d seq %lld cap seq %u\n", session->s_mds, session->s_seq,
 	     (unsigned)seq);
 
+	if (op == CEPH_CAP_OP_IMPORT)
+		ceph_add_cap_releases(mdsc, session);
+
 	/* lookup ino */
 	inode = ceph_find_inode(sb, vino);
 	ci = ceph_inode(inode);
-- 
1.7.11.7

