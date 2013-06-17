From: "Yan, Zheng" <zheng.z.yan@intel.com>
Subject: Re: [PATCH 9/9] ceph: move inode to proper flushing list when auth
 MDS changes
Date: Mon, 17 Jun 2013 10:45:11 +0800
Message-ID: <51BE7837.7060405@intel.com>
References: <1370315998-10418-1-git-send-email-zheng.z.yan@intel.com> <1370315998-10418-10-git-send-email-zheng.z.yan@intel.com> <alpine.DEB.2.00.1306102307090.18349@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga02.intel.com ([134.134.136.20]:31456 "EHLO mga02.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755007Ab3FQCpN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sun, 16 Jun 2013 22:45:13 -0400
In-Reply-To: <alpine.DEB.2.00.1306102307090.18349@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

updated patch, use cap->session instead of local session pointer

---
From 2675b6cc7afe25c9b7e644396df3b54bec003ab2 Mon Sep 17 00:00:00 2001
From: "Yan, Zheng" <zheng.z.yan@intel.com>
Date: Fri, 31 May 2013 16:40:24 +0800
Subject: [PATCH 1/3] ceph: move inode to proper flushing list when auth MDS
 changes

Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
---
 fs/ceph/caps.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 790f88b..9a5ccc9 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1982,8 +1982,15 @@ static void kick_flushing_inode_caps(struct ceph_mds_client *mdsc,
 	cap = ci->i_auth_cap;
 	dout("kick_flushing_inode_caps %p flushing %s flush_seq %lld\n", inode,
 	     ceph_cap_string(ci->i_flushing_caps), ci->i_cap_flush_seq);
+
 	__ceph_flush_snaps(ci, &session, 1);
+
 	if (ci->i_flushing_caps) {
+		spin_lock(&mdsc->cap_dirty_lock);
+		list_move_tail(&ci->i_flushing_item,
+			       &cap->session->s_cap_flushing);
+		spin_unlock(&mdsc->cap_dirty_lock);
+
 		delayed = __send_cap(mdsc, cap, CEPH_CAP_OP_FLUSH,
 				     __ceph_caps_used(ci),
 				     __ceph_caps_wanted(ci),
-- 
1.8.1.4

