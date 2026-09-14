Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DFEF3AA1BA
	for <ceph-devel@vger.kernel.org>; Mon, 14 Sep 2026 23:58:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789430335; cv=none; b=oG5D8eli+d6Rb+8mDX24SsZS+gpZnMV81aJTcpnx1w82D0tUhl0h7K9ivPA06jq9bBAU6lkl+pVNFXkeIBqkJ8MYXsiTQnHoJFth7P83/y/Ze/z7oTFpildPHaSi+LYhHypLbrsNixyrbPVBcWC8wKhqU02wau76YgoIl6hyVLc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789430335; c=relaxed/simple;
	bh=kgtunNoYwwCAm6y3NSUdRGJispWAfvkidg+V7IU4oPc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ys1OzPi+ffdG+ewoR064CAIUx/AzSGBjKtZlah0XZ6gXF5cbv9o7JCMNLwLk7+Z8Bm3wn/BaSui3JpNRdbrF8lNYLjkOZ5hqOrqS2pFdYKc8OEwMf/jdBpe1HgD000mEp4Pn43wzUjck67zUZHjYBe+1w5oHYazeUyuqIhZdpCo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OAZZno5n; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OAZZno5n"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-86265451beeso2533041b3a.0
        for <ceph-devel@vger.kernel.org>; Mon, 14 Sep 2026 16:58:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789430333; x=1790035133; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YzsctFqkOBFUYw9zm4+MompLDHDbIIVkNGKXNCOiv6Q=;
        b=OAZZno5nDVDOA/myvVGGmoQ/IxK5+fXF4ZLzDZIwKX7zZwaFrK+D2UUQmNnvk6wVZ+
         wv0y9/UqaPMTza79ksr/0+oASXn5AmJEBwQ6/Vlu5jA2sow2KbaFx09Ug9OHeQNgcaeS
         KpFIfihRJ59RZGcgHPL8RQwhfj7AF5V0IQwECjyGKUxoq6jKUgFv2YJrsfGixMbjhMKE
         CEEvR27xlp1Nd1BaaGtN16DC/odXGf024DH4dCcaUqtTDBOSXG4wVFtJV10DpqCiw9qc
         x+d9EB3rI/HMEio8XgY/Xo6bRMu6ThSiYbzbwDwmezyzEy8inGh2zEUr+AuYW9A3aHx2
         NFhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789430333; x=1790035133;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YzsctFqkOBFUYw9zm4+MompLDHDbIIVkNGKXNCOiv6Q=;
        b=Nzi25NorHRiHtXQtVJQr6zlJivW0iU3ggHVOZXOCqatMEm68jyGOy/GXJodxmZoiZk
         FyDQp2aGM2Giur28tlAeW8oeNhapUiw6Urm7O/oh8te+ZXjRA6kBBQ2VWXYN9sYNZVvE
         PHM8YPrcvRhN+/7QZaRLuXmvJiXB8HTUYO8RFCqBDtgMsI+GBCZC4GZuAFkqInYw5Uaq
         /iEd5+ROINaigta+L83p29bz85rZM6thxgB4Wop1kQ2zX012l2mfI6Xu3I6C5svuvb72
         qr395NmwS2n4/jVcIujn806XrXzmbUy01jEketdcjJT6kNeP8YZabYfZpp5QHZPOurtf
         hZRw==
X-Forwarded-Encrypted: i=1; AKwUvBymrAQkx+DsQ+UMlUvyAm72OT3q+gK9lmdQIS8AqCMj04wb52ojjfyjE4fgvhwiVsz0UfbFzijZx9yU@vger.kernel.org
X-Gm-Message-State: AFuF++kt3CzdUi7JH/US8OV/I445PXzfKaCj7cDzlMz5jhUqvwuVPobX
	jTAvx6gkVc/hxxWWZRD5TmwTtV5P0T4ZJv1F1jxWVkRAjMV3eiqfjGKs
X-Gm-Gg: AYBFou2M8XIVzG2r49vD5V2mmypGV5GAOOZ8yW8yr2WmLuuLj57KHBkedTSPXP5sxny
	pNHtyN+IDjbcJhaRBBCQpB3MZpaIjo9L8wyWfuOdcOKRGv9IOV/vYcco/2vq85Wxfj4hJYl5Kwt
	iSEMzlcKC70aeFsnnMoirlcaa1HYgdyf5riX1O8d1+DR8wwCi2++DAes1GFxF6wu28dXh6K012X
	ifyxhoiAEPB3F6PkpJPWakFmqMEq3G6DAOE9TZKefDBFfiLC1mPP47K9NQ2KrB0SL/ETr2gO6hf
	Ji6Zqq9WDbodk9VUzUqqZwCKvzhdm1N0bP3gTUHjkawL1augCi0aI+7QpUthIet4esjVaGAH2u1
	5SnzEH9gUMsE+mnYgL9bkgDDetw+txn6YrGDH9J73t8XlVbhWq7n4uDnOGSVYkcuqPKZ3RLbf+G
	Sx/4NvP4G0mQHISHamC1HTHif1jt8qVb7TuV2m0AABEJnLm8KP0axdbjBzPIXf/Q9XDQLsI9nT/
	xs4EsQiJRUi
X-Received: by 2002:a05:6a00:8d2:b0:847:99bb:b6d0 with SMTP id d2e1a72fcca58-86f853f6887mr9158143b3a.15.1789430333399;
        Mon, 14 Sep 2026 16:58:53 -0700 (PDT)
Received: from ancienth-X870E-Nova-WiFi ([125.186.72.2])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b29bbdca0sm5228412b3a.45.2026.09.14.16.58.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Sep 2026 16:58:52 -0700 (PDT)
From: Daehyeon Ko <4ncienth@gmail.com>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	ceph-devel@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH] libceph: validate CRUSH bucket references before use
Date: Tue, 15 Sep 2026 08:58:17 +0900
Message-ID: <20260914235817.2201175-1-4ncienth@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

crush_decode() copies signed bucket item values directly from an OSDMap.
Nonnegative values identify devices and negative values identify buckets.
The firstn and indep mappers reject devices beyond max_devices, but index
map->buckets[-1-item] before validating a negative item's bucket index. A
malformed map can therefore cause an out-of-bounds pointer read and
dereference.

Commit 3cde4a830230 ("libceph: reject buckets with mismatched CRUSH ids")
validates an in-range bucket's own id. It does not validate the item which
selects the bucket-pointer slot.

Add a common negative-item lookup which calculates the index without signed
overflow and checks its range and pointer before use. Reuse the validated
pointer for type checks, descent and recursive choose.

An in-kernel KASAN module linked with the exact mapper reports 8-byte slab
out-of-bounds reads in firstn and indep on 3/3 fresh boots each. The fixed
mapper rejects both malformed modes in 3/3 boots without a KASAN report.
Valid firstn and indep controls remain unchanged.

Fixes: 5ecc0a0f8128 ("ceph: CRUSH mapping algorithm")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Daehyeon Ko <4ncienth@gmail.com>
---
 net/ceph/crush/mapper.c | 51 ++++++++++++++++++++++++++++-------------
 1 file changed, 35 insertions(+), 16 deletions(-)

diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
index 17b041779fb9..4815a1b243cf 100644
--- a/net/ceph/crush/mapper.c
+++ b/net/ceph/crush/mapper.c
@@ -406,6 +406,21 @@ static int crush_bucket_choose(const struct crush_bucket *in,
 	}
 }
 
+static const struct crush_bucket *
+crush_get_bucket(const struct crush_map *map, int item)
+{
+	__u32 pos;
+
+	if (item >= 0 || map->max_buckets <= 0)
+		return NULL;
+
+	pos = -1U - (__u32)item;
+	if (pos >= (__u32)map->max_buckets)
+		return NULL;
+
+	return map->buckets[pos];
+}
+
 /*
  * true if device is marked "out" (failed, fully offloaded)
  * of the cluster
@@ -476,6 +491,7 @@ static int crush_choose_firstn(const struct crush_map *map,
 	int i;
 	int item = 0;
 	int itemtype;
+	const struct crush_bucket *item_bucket;
 	int collide, reject;
 	int count = out_size;
 
@@ -520,28 +536,29 @@ static int crush_choose_firstn(const struct crush_map *map,
 						(choose_args ?
 						 &choose_args[-1-in->id] : NULL),
 						outpos);
-				if (item >= map->max_devices) {
+				item_bucket = crush_get_bucket(map, item);
+				if (item >= map->max_devices ||
+				    (item < 0 && !item_bucket)) {
 					dprintk("   bad item %d\n", item);
 					skip_rep = 1;
 					break;
 				}
 
 				/* desired type? */
-				if (item < 0)
-					itemtype = map->buckets[-1-item]->type;
+				if (item_bucket)
+					itemtype = item_bucket->type;
 				else
 					itemtype = 0;
 				dprintk("  item %d type %d\n", item, itemtype);
 
 				/* keep going? */
 				if (itemtype != type) {
-					if (item >= 0 ||
-					    (-1-item) >= map->max_buckets) {
+					if (!item_bucket) {
 						dprintk("   bad item type %d\n", type);
 						skip_rep = 1;
 						break;
 					}
-					in = map->buckets[-1-item];
+					in = item_bucket;
 					retry_bucket = 1;
 					continue;
 				}
@@ -556,7 +573,7 @@ static int crush_choose_firstn(const struct crush_map *map,
 
 				reject = 0;
 				if (!collide && recurse_to_leaf) {
-					if (item < 0) {
+					if (item_bucket) {
 						int sub_r;
 						if (vary_r)
 							sub_r = r >> (vary_r-1);
@@ -565,7 +582,7 @@ static int crush_choose_firstn(const struct crush_map *map,
 						if (crush_choose_firstn(
 							    map,
 							    work,
-							    map->buckets[-1-item],
+							    item_bucket,
 							    weight, weight_max,
 							    x, stable ? 1 : outpos+1, 0,
 							    out2, outpos, count,
@@ -664,6 +681,7 @@ static void crush_choose_indep(const struct crush_map *map,
 	int i;
 	int item = 0;
 	int itemtype;
+	const struct crush_bucket *item_bucket;
 	int collide;
 
 	dprintk("CHOOSE%s INDEP bucket %d x %d outpos %d numrep %d\n", recurse_to_leaf ? "_LEAF" : "",
@@ -730,7 +748,9 @@ static void crush_choose_indep(const struct crush_map *map,
 					(choose_args ?
 					 &choose_args[-1-in->id] : NULL),
 					outpos);
-				if (item >= map->max_devices) {
+				item_bucket = crush_get_bucket(map, item);
+				if (item >= map->max_devices ||
+				    (item < 0 && !item_bucket)) {
 					dprintk("   bad item %d\n", item);
 					out[rep] = CRUSH_ITEM_NONE;
 					if (out2)
@@ -740,16 +760,15 @@ static void crush_choose_indep(const struct crush_map *map,
 				}
 
 				/* desired type? */
-				if (item < 0)
-					itemtype = map->buckets[-1-item]->type;
+				if (item_bucket)
+					itemtype = item_bucket->type;
 				else
 					itemtype = 0;
 				dprintk("  item %d type %d\n", item, itemtype);
 
 				/* keep going? */
 				if (itemtype != type) {
-					if (item >= 0 ||
-					    (-1-item) >= map->max_buckets) {
+					if (!item_bucket) {
 						dprintk("   bad item type %d\n", type);
 						out[rep] = CRUSH_ITEM_NONE;
 						if (out2)
@@ -758,7 +777,7 @@ static void crush_choose_indep(const struct crush_map *map,
 						left--;
 						break;
 					}
-					in = map->buckets[-1-item];
+					in = item_bucket;
 					continue;
 				}
 
@@ -774,11 +793,11 @@ static void crush_choose_indep(const struct crush_map *map,
 					break;
 
 				if (recurse_to_leaf) {
-					if (item < 0) {
+					if (item_bucket) {
 						crush_choose_indep(
 							map,
 							work,
-							map->buckets[-1-item],
+							item_bucket,
 							weight, weight_max,
 							x, 1, numrep, 0,
 							out2, rep,

base-commit: 142040037eba7ddd2de6f13067f33585451b8efe
-- 
2.55.0

