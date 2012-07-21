From: Sage Weil <sage@inktank.com>
Subject: [PATCH 8/9] libceph: protect ceph_con_open() with mutex
Date: Fri, 20 Jul 2012 17:41:47 -0700
Message-ID: <1342831308-18815-9-git-send-email-sage@inktank.com>
References: <1342831308-18815-1-git-send-email-sage@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46573 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752904Ab2GUAdL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Jul 2012 20:33:11 -0400
In-Reply-To: <1342831308-18815-1-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>

Take the con mutex while we are initiating a ceph open.  This is necessary
because the may have previously been in use and then closed, which could
result in a racing workqueue running con_work().

Signed-off-by: Sage Weil <sage@inktank.com>
---
 net/ceph/messenger.c |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index efa369f..65964c2 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -537,6 +537,7 @@ void ceph_con_open(struct ceph_connection *con,
 		   __u8 entity_type, __u64 entity_num,
 		   struct ceph_entity_addr *addr)
 {
+	mutex_lock(&con->mutex);
 	dout("con_open %p %s\n", con, ceph_pr_addr(&addr->in_addr));
 	set_bit(OPENING, &con->state);
 	WARN_ON(!test_and_clear_bit(CLOSED, &con->state));
@@ -546,6 +547,7 @@ void ceph_con_open(struct ceph_connection *con,
 
 	memcpy(&con->peer_addr, addr, sizeof(*addr));
 	con->delay = 0;      /* reset backoff memory */
+	mutex_unlock(&con->mutex);
 	queue_con(con);
 }
 EXPORT_SYMBOL(ceph_con_open);
-- 
1.7.9

