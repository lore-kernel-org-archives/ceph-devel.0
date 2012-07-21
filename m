From: Sage Weil <sage@inktank.com>
Subject: [PATCH 2/9] libceph: support crush tunables
Date: Fri, 20 Jul 2012 17:41:41 -0700
Message-ID: <1342831308-18815-3-git-send-email-sage@inktank.com>
References: <1342831308-18815-1-git-send-email-sage@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46560 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752571Ab2GUAdK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 20 Jul 2012 20:33:10 -0400
In-Reply-To: <1342831308-18815-1-git-send-email-sage@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: caleb miles <caleb.miles@inktank.com>

From: caleb miles <caleb.miles@inktank.com>

The server side recently added support for tuning some magic
crush variables. Decode these variables if they are present, or use the
default values if they are not present.

Corresponds to ceph.git commit 89af369c25f274fe62ef730e5e8aad0c54f1e5a5.

Signed-off-by: caleb miles <caleb.miles@inktank.com>
Reviewed-by: Sage Weil <sage@inktank.com>
---
 include/linux/ceph/ceph_features.h |    4 ++-
 include/linux/crush/crush.h        |    8 +++++++
 net/ceph/crush/mapper.c            |   13 ++++++-----
 net/ceph/osdmap.c                  |   39 ++++++++++++++++++++++++++++++++++++
 4 files changed, 57 insertions(+), 7 deletions(-)

diff --git a/include/linux/ceph/ceph_features.h b/include/linux/ceph/ceph_features.h
index 342f93d..df25dcf 100644
--- a/include/linux/ceph/ceph_features.h
+++ b/include/linux/ceph/ceph_features.h
@@ -12,12 +12,14 @@
 #define CEPH_FEATURE_MONNAMES       (1<<5)
 #define CEPH_FEATURE_RECONNECT_SEQ  (1<<6)
 #define CEPH_FEATURE_DIRLAYOUTHASH  (1<<7)
+#define CEPH_FEATURE_CRUSH_TUNABLES (1<<18)
 
 /*
  * Features supported.
  */
 #define CEPH_FEATURES_SUPPORTED_DEFAULT  \
-	(CEPH_FEATURE_NOSRCADDR)
+	(CEPH_FEATURE_NOSRCADDR |	 \
+	 CEPH_FEATURE_CRUSH_TUNABLES)
 
 #define CEPH_FEATURES_REQUIRED_DEFAULT   \
 	(CEPH_FEATURE_NOSRCADDR)
diff --git a/include/linux/crush/crush.h b/include/linux/crush/crush.h
index 7c47508..25baa28 100644
--- a/include/linux/crush/crush.h
+++ b/include/linux/crush/crush.h
@@ -154,6 +154,14 @@ struct crush_map {
 	__s32 max_buckets;
 	__u32 max_rules;
 	__s32 max_devices;
+
+	/* choose local retries before re-descent */
+	__u32 choose_local_tries;
+	/* choose local attempts using a fallback permutation before
+	 * re-descent */
+	__u32 choose_local_fallback_tries;
+	/* choose attempts before giving up */ 
+	__u32 choose_total_tries;
 };
 
 
diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
index d7edc24..35fce75 100644
--- a/net/ceph/crush/mapper.c
+++ b/net/ceph/crush/mapper.c
@@ -306,7 +306,6 @@ static int crush_choose(const struct crush_map *map,
 	int item = 0;
 	int itemtype;
 	int collide, reject;
-	const unsigned int orig_tries = 5; /* attempts before we fall back to search */
 
 	dprintk("CHOOSE%s bucket %d x %d outpos %d numrep %d\n", recurse_to_leaf ? "_LEAF" : "",
 		bucket->id, x, outpos, numrep);
@@ -351,8 +350,9 @@ static int crush_choose(const struct crush_map *map,
 					reject = 1;
 					goto reject;
 				}
-				if (flocal >= (in->size>>1) &&
-				    flocal > orig_tries)
+				if (map->choose_local_fallback_tries > 0 &&
+				    flocal >= (in->size>>1) &&
+				    flocal > map->choose_local_fallback_tries)
 					item = bucket_perm_choose(in, x, r);
 				else
 					item = crush_bucket_choose(in, x, r);
@@ -422,13 +422,14 @@ reject:
 					ftotal++;
 					flocal++;
 
-					if (collide && flocal < 3)
+					if (collide && flocal <= map->choose_local_tries)
 						/* retry locally a few times */
 						retry_bucket = 1;
-					else if (flocal <= in->size + orig_tries)
+					else if (map->choose_local_fallback_tries > 0 &&
+						 flocal <= in->size + map->choose_local_fallback_tries)
 						/* exhaustive bucket search */
 						retry_bucket = 1;
-					else if (ftotal < 20)
+					else if (ftotal <= map->choose_total_tries)
 						/* then retry descent */
 						retry_descent = 1;
 					else
diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 9600674..3124b71 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -135,6 +135,21 @@ bad:
 	return -EINVAL;
 }
 
+static int skip_name_map(void **p, void *end)
+{
+        int len;
+        ceph_decode_32_safe(p, end, len ,bad);
+        while (len--) {
+                int strlen;
+                *p += sizeof(u32);
+                ceph_decode_32_safe(p, end, strlen, bad);
+                *p += strlen;
+}
+        return 0;
+bad:
+        return -EINVAL;
+}
+
 static struct crush_map *crush_decode(void *pbyval, void *end)
 {
 	struct crush_map *c;
@@ -143,6 +158,7 @@ static struct crush_map *crush_decode(void *pbyval, void *end)
 	void **p = &pbyval;
 	void *start = pbyval;
 	u32 magic;
+	u32 num_name_maps;
 
 	dout("crush_decode %p to %p len %d\n", *p, end, (int)(end - *p));
 
@@ -150,6 +166,11 @@ static struct crush_map *crush_decode(void *pbyval, void *end)
 	if (c == NULL)
 		return ERR_PTR(-ENOMEM);
 
+        /* set tunables to default values */
+        c->choose_local_tries = 2;
+        c->choose_local_fallback_tries = 5;
+        c->choose_total_tries = 19;
+
 	ceph_decode_need(p, end, 4*sizeof(u32), bad);
 	magic = ceph_decode_32(p);
 	if (magic != CRUSH_MAGIC) {
@@ -297,7 +318,25 @@ static struct crush_map *crush_decode(void *pbyval, void *end)
 	}
 
 	/* ignore trailing name maps. */
+        for (num_name_maps = 0; num_name_maps < 3; num_name_maps++) {
+                err = skip_name_map(p, end);
+                if (err < 0)
+                        goto done;
+        }
+
+        /* tunables */
+        ceph_decode_need(p, end, 3*sizeof(u32), done);
+        c->choose_local_tries = ceph_decode_32(p);
+        c->choose_local_fallback_tries =  ceph_decode_32(p);
+        c->choose_total_tries = ceph_decode_32(p);
+        dout("crush decode tunable choose_local_tries = %d",
+             c->choose_local_tries);
+        dout("crush decode tunable choose_local_fallback_tries = %d",
+             c->choose_local_fallback_tries);
+        dout("crush decode tunable choose_total_tries = %d",
+             c->choose_total_tries);
 
+done:
 	dout("crush_decode success\n");
 	return c;
 
-- 
1.7.9

