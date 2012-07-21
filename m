From: Sage Weil <sage@inktank.com>
Subject: [PATCH 7/9] ceph: close old con before reopening on mds reconnect
Date: Fri, 20 Jul 2012 17:41:46 -0700
Message-ID: <1342831308-18815-8-git-send-email-sage@inktank.com>
References: <1342831308-18815-1-git-send-email-sage@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46572 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752957Ab2GUAdL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Jul 2012 20:33:11 -0400
In-Reply-To: <1342831308-18815-1-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>

When we detect a mds session reset, close the old ceph_connection before
reopening it.  This ensures we clean up the old socket properly and keep
the ceph_connection state correct.

Signed-off-by: Sage Weil <sage@inktank.com>
---
 fs/ceph/mds_client.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 39b76d6..a5a7354 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -2518,6 +2518,7 @@ static void send_mds_reconnect(struct ceph_mds_client *mdsc,
 	session->s_state = CEPH_MDS_SESSION_RECONNECTING;
 	session->s_seq = 0;
 
+	ceph_con_close(&session->s_con);
 	ceph_con_open(&session->s_con,
 		      CEPH_ENTITY_TYPE_MDS, mds,
 		      ceph_mdsmap_get_addr(mdsc->mdsmap, mds));
-- 
1.7.9

