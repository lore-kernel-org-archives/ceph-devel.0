From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 4/5] crush: add SET_CHOOSELEAF_VARY_R step
Date: Wed, 19 Mar 2014 18:09:08 +0200
Message-ID: <1395245349-4513-5-git-send-email-ilya.dryomov@inktank.com>
References: <1395245349-4513-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f43.google.com ([74.125.83.43]:64498 "EHLO
	mail-ee0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965684AbaCSQJY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Mar 2014 12:09:24 -0400
Received: by mail-ee0-f43.google.com with SMTP id e53so6793099eek.2
        for <ceph-devel@vger.kernel.org>; Wed, 19 Mar 2014 09:09:23 -0700 (PDT)
Received: from localhost ([109.110.66.126])
        by mx.google.com with ESMTPSA id e42sm43266035eev.32.2014.03.19.09.09.20
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 19 Mar 2014 09:09:22 -0700 (PDT)
In-Reply-To: <1395245349-4513-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This lets you adjust the vary_r tunable on a per-rule basis.

Reflects ceph.git commit f944ccc20aee60a7d8da7e405ec75ad1cd449fac.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 include/linux/crush/crush.h |    1 +
 net/ceph/crush/mapper.c     |    5 +++++
 2 files changed, 6 insertions(+)

diff --git a/include/linux/crush/crush.h b/include/linux/crush/crush.h
index 75f36a6c7f67..4fad5f8ee01d 100644
--- a/include/linux/crush/crush.h
+++ b/include/linux/crush/crush.h
@@ -51,6 +51,7 @@ enum {
 	CRUSH_RULE_SET_CHOOSELEAF_TRIES = 9, /* override chooseleaf_descend_once */
 	CRUSH_RULE_SET_CHOOSE_LOCAL_TRIES = 10,
 	CRUSH_RULE_SET_CHOOSE_LOCAL_FALLBACK_TRIES = 11,
+	CRUSH_RULE_SET_CHOOSELEAF_VARY_R = 12
 };
 
 /*
diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
index 947150cde297..a1ef53c04415 100644
--- a/net/ceph/crush/mapper.c
+++ b/net/ceph/crush/mapper.c
@@ -709,6 +709,11 @@ int crush_do_rule(const struct crush_map *map,
 				choose_local_fallback_retries = curstep->arg1;
 			break;
 
+		case CRUSH_RULE_SET_CHOOSELEAF_VARY_R:
+			if (curstep->arg1 >= 0)
+				vary_r = curstep->arg1;
+			break;
+
 		case CRUSH_RULE_CHOOSELEAF_FIRSTN:
 		case CRUSH_RULE_CHOOSE_FIRSTN:
 			firstn = 1;
-- 
1.7.10.4

