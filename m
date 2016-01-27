From: Ioana Ciornei <ciorneiioana@gmail.com>
Subject: [PATCH 2/2] net: ceph: messenger: replace BUG_ON() with WARN_ON() in con_flag_* functions
Date: Wed, 27 Jan 2016 14:52:28 +0200
Message-ID: <45e6d497cd2e5470fcf40c9ed38f538ffaa3d886.1453898892.git.ciorneiioana@gmail.com>
References: <cover.1453898892.git.ciorneiioana@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33426 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754296AbcA0Kwl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 27 Jan 2016 05:52:41 -0500
Received: by mail-wm0-f68.google.com with SMTP id r129so2581848wmr.0
        for <ceph-devel@vger.kernel.org>; Wed, 27 Jan 2016 02:52:40 -0800 (PST)
In-Reply-To: <cover.1453898892.git.ciorneiioana@gmail.com>
In-Reply-To: <cover.1453898892.git.ciorneiioana@gmail.com>
References: <cover.1453898892.git.ciorneiioana@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: elder@ieee.org, Ioana Ciornei <ciorneiioana@gmail.com>

This patch replaces BUG_ON() with WARN_ON() and an appropriate warning
message and exit since the condition verified is not influenced by user
input.

Signed-off-by: Ioana Ciornei <ciorneiioana@gmail.com>
---
 net/ceph/messenger.c | 25 ++++++++++++++++++++-----
 1 file changed, 20 insertions(+), 5 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 9a5e54c..1e5aac6 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -116,21 +116,30 @@ static bool con_flag_valid(unsigned long con_flag)
 
 static void con_flag_clear(struct ceph_connection *con, unsigned long con_flag)
 {
-	BUG_ON(!con_flag_valid(con_flag));
+	if (WARN_ON(!con_flag_valid(con_flag))) {
+		pr_warn("con_flag_clear called with an invalid flag\n");
+		return;
+	}
 
 	clear_bit(con_flag, &con->flags);
 }
 
 static void con_flag_set(struct ceph_connection *con, unsigned long con_flag)
 {
-	BUG_ON(!con_flag_valid(con_flag));
+	if (WARN_ON(!con_flag_valid(con_flag))) {
+		pr_warn("con_flag_set called with an invalid flag\n");
+		return;
+	}
 
 	set_bit(con_flag, &con->flags);
 }
 
 static bool con_flag_test(struct ceph_connection *con, unsigned long con_flag)
 {
-	BUG_ON(!con_flag_valid(con_flag));
+	if (WARN_ON(!con_flag_valid(con_flag))) {
+		pr_warn("con_flag_test called with an invalid flag\n");
+		return false;
+	}
 
 	return test_bit(con_flag, &con->flags);
 }
@@ -138,7 +147,10 @@ static bool con_flag_test(struct ceph_connection *con, unsigned long con_flag)
 static bool con_flag_test_and_clear(struct ceph_connection *con,
 					unsigned long con_flag)
 {
-	BUG_ON(!con_flag_valid(con_flag));
+	if (WARN_ON(!con_flag_valid(con_flag))) {
+		pr_warn("con_flag_test_and_clear called with an invalid flag\n");
+		return false;
+	}
 
 	return test_and_clear_bit(con_flag, &con->flags);
 }
@@ -146,7 +158,10 @@ static bool con_flag_test_and_clear(struct ceph_connection *con,
 static bool con_flag_test_and_set(struct ceph_connection *con,
 					unsigned long con_flag)
 {
-	BUG_ON(!con_flag_valid(con_flag));
+	if (WARN_ON(!con_flag_valid(con_flag))) {
+		pr_warn("con_flag_test_and_set called with an invalid flag\n");
+		return false;
+	}
 
 	return test_and_set_bit(con_flag, &con->flags);
 }
-- 
2.6.4

