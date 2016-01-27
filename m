From: Ioana Ciornei <ciorneiioana@gmail.com>
Subject: [PATCH 5/6] net: ceph: messenger: change printk to pr_warn
Date: Wed, 27 Jan 2016 02:43:38 +0200
Message-ID: <ec8365198a0afd9538362e68393eebbdb1e0e61e.1453853617.git.ciorneiioana@gmail.com>
References: <cover.1453853617.git.ciorneiioana@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f66.google.com ([74.125.82.66]:33643 "EHLO
	mail-wm0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752973AbcAZWny (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jan 2016 17:43:54 -0500
Received: by mail-wm0-f66.google.com with SMTP id r129so22213wmr.0
        for <ceph-devel@vger.kernel.org>; Tue, 26 Jan 2016 14:43:54 -0800 (PST)
In-Reply-To: <cover.1453853617.git.ciorneiioana@gmail.com>
In-Reply-To: <cover.1453853617.git.ciorneiioana@gmail.com>
References: <cover.1453853617.git.ciorneiioana@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: elder@ieee.org, Ioana Ciornei <ciorneiioana@gmail.com>

This patch changes the printk call into the preferred function
pr_warn(). Since the intention is to just warn the user it is the best
level of facility.

Signed-off-by: Ioana Ciornei <ciorneiioana@gmail.com>
---
 net/ceph/messenger.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 6b15876..8f1582e 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -329,7 +329,8 @@ static void con_sock_state_init(struct ceph_connection *con)
 
 	old_state = atomic_xchg(&con->sock_state, CON_SOCK_STATE_CLOSED);
 	if (WARN_ON(old_state != CON_SOCK_STATE_NEW))
-		printk("%s: unexpected old state %d\n", __func__, old_state);
+		pr_warn("%s: unexpected old state %d\n", __func__,
+			old_state);
 	dout("%s con %p sock %d -> %d\n", __func__, con, old_state,
 	     CON_SOCK_STATE_CLOSED);
 }
@@ -340,7 +341,8 @@ static void con_sock_state_connecting(struct ceph_connection *con)
 
 	old_state = atomic_xchg(&con->sock_state, CON_SOCK_STATE_CONNECTING);
 	if (WARN_ON(old_state != CON_SOCK_STATE_CLOSED))
-		printk("%s: unexpected old state %d\n", __func__, old_state);
+		pr_warn("%s: unexpected old state %d\n", __func__,
+			old_state);
 	dout("%s con %p sock %d -> %d\n", __func__, con, old_state,
 	     CON_SOCK_STATE_CONNECTING);
 }
@@ -351,7 +353,8 @@ static void con_sock_state_connected(struct ceph_connection *con)
 
 	old_state = atomic_xchg(&con->sock_state, CON_SOCK_STATE_CONNECTED);
 	if (WARN_ON(old_state != CON_SOCK_STATE_CONNECTING))
-		printk("%s: unexpected old state %d\n", __func__, old_state);
+		pr_warn("%s: unexpected old state %d\n", __func__,
+			old_state);
 	dout("%s con %p sock %d -> %d\n", __func__, con, old_state,
 	     CON_SOCK_STATE_CONNECTED);
 }
@@ -364,7 +367,8 @@ static void con_sock_state_closing(struct ceph_connection *con)
 	if (WARN_ON(old_state != CON_SOCK_STATE_CONNECTING &&
 		    old_state != CON_SOCK_STATE_CONNECTED &&
 		    old_state != CON_SOCK_STATE_CLOSING))
-		printk("%s: unexpected old state %d\n", __func__, old_state);
+		pr_warn("%s: unexpected old state %d\n", __func__,
+			old_state);
 	dout("%s con %p sock %d -> %d\n", __func__, con, old_state,
 	     CON_SOCK_STATE_CLOSING);
 }
@@ -378,7 +382,8 @@ static void con_sock_state_closed(struct ceph_connection *con)
 		    old_state != CON_SOCK_STATE_CLOSING &&
 		    old_state != CON_SOCK_STATE_CONNECTING &&
 		    old_state != CON_SOCK_STATE_CLOSED))
-		printk("%s: unexpected old state %d\n", __func__, old_state);
+		pr_warn("%s: unexpected old state %d\n", __func__,
+			old_state);
 	dout("%s con %p sock %d -> %d\n", __func__, con, old_state,
 	     CON_SOCK_STATE_CLOSED);
 }
-- 
2.6.4

