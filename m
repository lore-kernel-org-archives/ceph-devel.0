From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 15/19] crush: CHOOSE_LEAF -> CHOOSELEAF throughout
Date: Mon, 23 Dec 2013 19:09:46 +0200
Message-ID: <1387818590-30483-16-git-send-email-ilya.dryomov@inktank.com>
References: <1387818590-30483-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f50.google.com ([74.125.83.50]:56782 "EHLO
	mail-ee0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757701Ab3LWRLJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Dec 2013 12:11:09 -0500
Received: by mail-ee0-f50.google.com with SMTP id c41so2436241eek.37
        for <ceph-devel@vger.kernel.org>; Mon, 23 Dec 2013 09:11:08 -0800 (PST)
In-Reply-To: <1387818590-30483-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, ilya.dryomov@inktank.com

This aligns the internal identifier names with the user-visible names in
the decompiled crush map language.

Reflects ceph.git commit caa0e22e15e4226c3671318ba1f61314bf6da2a6.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 include/linux/crush/crush.h |    6 +++---
 net/ceph/crush/mapper.c     |   10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/include/linux/crush/crush.h b/include/linux/crush/crush.h
index 5f95969347ec..7b0fc4aba75b 100644
--- a/include/linux/crush/crush.h
+++ b/include/linux/crush/crush.h
@@ -44,11 +44,11 @@ enum {
 				      /* arg2 = type */
 	CRUSH_RULE_CHOOSE_INDEP = 3,  /* same */
 	CRUSH_RULE_EMIT = 4,          /* no args */
-	CRUSH_RULE_CHOOSE_LEAF_FIRSTN = 6,
-	CRUSH_RULE_CHOOSE_LEAF_INDEP = 7,
+	CRUSH_RULE_CHOOSELEAF_FIRSTN = 6,
+	CRUSH_RULE_CHOOSELEAF_INDEP = 7,
 
 	CRUSH_RULE_SET_CHOOSE_TRIES = 8, /* override choose_total_tries */
-	CRUSH_RULE_SET_CHOOSE_LEAF_TRIES = 9, /* override chooseleaf_descend_once */
+	CRUSH_RULE_SET_CHOOSELEAF_TRIES = 9, /* override chooseleaf_descend_once */
 };
 
 /*
diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
index a1acdea935bf..e9256a30e60d 100644
--- a/net/ceph/crush/mapper.c
+++ b/net/ceph/crush/mapper.c
@@ -666,25 +666,25 @@ int crush_do_rule(const struct crush_map *map,
 				choose_tries = curstep->arg1;
 			break;
 
-		case CRUSH_RULE_SET_CHOOSE_LEAF_TRIES:
+		case CRUSH_RULE_SET_CHOOSELEAF_TRIES:
 			if (curstep->arg1 > 0)
 				choose_leaf_tries = curstep->arg1;
 			break;
 
-		case CRUSH_RULE_CHOOSE_LEAF_FIRSTN:
+		case CRUSH_RULE_CHOOSELEAF_FIRSTN:
 		case CRUSH_RULE_CHOOSE_FIRSTN:
 			firstn = 1;
 			/* fall through */
-		case CRUSH_RULE_CHOOSE_LEAF_INDEP:
+		case CRUSH_RULE_CHOOSELEAF_INDEP:
 		case CRUSH_RULE_CHOOSE_INDEP:
 			if (wsize == 0)
 				break;
 
 			recurse_to_leaf =
 				curstep->op ==
-				 CRUSH_RULE_CHOOSE_LEAF_FIRSTN ||
+				 CRUSH_RULE_CHOOSELEAF_FIRSTN ||
 				curstep->op ==
-				CRUSH_RULE_CHOOSE_LEAF_INDEP;
+				CRUSH_RULE_CHOOSELEAF_INDEP;
 
 			/* reset output */
 			osize = 0;
-- 
1.7.10.4

