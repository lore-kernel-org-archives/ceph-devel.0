From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 14/19] crush: add SET_CHOOSE_TRIES rule step
Date: Mon, 23 Dec 2013 19:09:45 +0200
Message-ID: <1387818590-30483-15-git-send-email-ilya.dryomov@inktank.com>
References: <1387818590-30483-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ea0-f180.google.com ([209.85.215.180]:48128 "EHLO
	mail-ea0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757677Ab3LWRLH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Dec 2013 12:11:07 -0500
Received: by mail-ea0-f180.google.com with SMTP id f15so2475320eak.11
        for <ceph-devel@vger.kernel.org>; Mon, 23 Dec 2013 09:11:06 -0800 (PST)
In-Reply-To: <1387818590-30483-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, ilya.dryomov@inktank.com

Since we can specify the recursive retries in a rule, we may as well also
specify the non-recursive tries too for completeness.

Reflects ceph.git commit d1b97462cffccc871914859eaee562f2786abfd1.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 include/linux/crush/crush.h |    3 ++-
 net/ceph/crush/mapper.c     |    5 +++++
 2 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/include/linux/crush/crush.h b/include/linux/crush/crush.h
index 07b8fd4f81fc..5f95969347ec 100644
--- a/include/linux/crush/crush.h
+++ b/include/linux/crush/crush.h
@@ -47,7 +47,8 @@ enum {
 	CRUSH_RULE_CHOOSE_LEAF_FIRSTN = 6,
 	CRUSH_RULE_CHOOSE_LEAF_INDEP = 7,
 
-	CRUSH_RULE_SET_CHOOSE_LEAF_TRIES = 9,
+	CRUSH_RULE_SET_CHOOSE_TRIES = 8, /* override choose_total_tries */
+	CRUSH_RULE_SET_CHOOSE_LEAF_TRIES = 9, /* override chooseleaf_descend_once */
 };
 
 /*
diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
index c34320518c8b..a1acdea935bf 100644
--- a/net/ceph/crush/mapper.c
+++ b/net/ceph/crush/mapper.c
@@ -661,6 +661,11 @@ int crush_do_rule(const struct crush_map *map,
 			wsize = 1;
 			break;
 
+		case CRUSH_RULE_SET_CHOOSE_TRIES:
+			if (curstep->arg1 > 0)
+				choose_tries = curstep->arg1;
+			break;
+
 		case CRUSH_RULE_SET_CHOOSE_LEAF_TRIES:
 			if (curstep->arg1 > 0)
 				choose_leaf_tries = curstep->arg1;
-- 
1.7.10.4

