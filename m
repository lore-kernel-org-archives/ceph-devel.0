From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 4/5] crush: decode and initialize chooseleaf_stable
Date: Wed,  3 Feb 2016 15:23:20 +0100
Message-ID: <1454509401-19734-5-git-send-email-idryomov@gmail.com>
References: <1454509401-19734-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f43.google.com ([74.125.82.43]:35296 "EHLO
	mail-wm0-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753257AbcBCOXd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 3 Feb 2016 09:23:33 -0500
Received: by mail-wm0-f43.google.com with SMTP id r129so167476373wmr.0
        for <ceph-devel@vger.kernel.org>; Wed, 03 Feb 2016 06:23:32 -0800 (PST)
In-Reply-To: <1454509401-19734-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sweil@redhat.com>

Also add missing \n while at it.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/osdmap.c | 19 ++++++++++++++-----
 1 file changed, 14 insertions(+), 5 deletions(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 7d8f581d9f1f..243574c8cf33 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -342,23 +342,32 @@ static struct crush_map *crush_decode(void *pbyval, void *end)
         c->choose_local_tries = ceph_decode_32(p);
         c->choose_local_fallback_tries =  ceph_decode_32(p);
         c->choose_total_tries = ceph_decode_32(p);
-        dout("crush decode tunable choose_local_tries = %d",
+        dout("crush decode tunable choose_local_tries = %d\n",
              c->choose_local_tries);
-        dout("crush decode tunable choose_local_fallback_tries = %d",
+        dout("crush decode tunable choose_local_fallback_tries = %d\n",
              c->choose_local_fallback_tries);
-        dout("crush decode tunable choose_total_tries = %d",
+        dout("crush decode tunable choose_total_tries = %d\n",
              c->choose_total_tries);
 
 	ceph_decode_need(p, end, sizeof(u32), done);
 	c->chooseleaf_descend_once = ceph_decode_32(p);
-	dout("crush decode tunable chooseleaf_descend_once = %d",
+	dout("crush decode tunable chooseleaf_descend_once = %d\n",
 	     c->chooseleaf_descend_once);
 
 	ceph_decode_need(p, end, sizeof(u8), done);
 	c->chooseleaf_vary_r = ceph_decode_8(p);
-	dout("crush decode tunable chooseleaf_vary_r = %d",
+	dout("crush decode tunable chooseleaf_vary_r = %d\n",
 	     c->chooseleaf_vary_r);
 
+	/* skip straw_calc_version, allowed_bucket_algs */
+	ceph_decode_need(p, end, sizeof(u8) + sizeof(u32), done);
+	*p += sizeof(u8) + sizeof(u32);
+
+	ceph_decode_need(p, end, sizeof(u8), done);
+	c->chooseleaf_stable = ceph_decode_8(p);
+	dout("crush decode tunable chooseleaf_stable = %d\n",
+	     c->chooseleaf_stable);
+
 done:
 	dout("crush_decode success\n");
 	return c;
-- 
2.4.3

