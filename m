Received: from mail-router1.rz.tu-ilmenau.de (mail-router1.rz.tu-ilmenau.de [141.24.179.34])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF63034C989
	for <ceph-devel@vger.kernel.org>; Wed, 22 Apr 2026 08:48:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=141.24.179.34
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1776847709; cv=none; b=aqjUi+HYczkcy8GEOoJt09SiM4YLI8iOmOfwjHIy7YQW+/V56LNkybAmX4Y6k5qaeSmLV/k2NGl95jvJPVgr43Y7M0tovICo43fsexBGYJcrL+RBDMrpWbubee2KrizHlXjA01xnCaT2MrYt3CAMRPg+cC7z2roffMKOh7SkkHI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1776847709; c=relaxed/simple;
	bh=WVkeaIjszcuakhjojuDkjf9Tx/e9/71wxK74g3G4X94=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=FxG3L/pEq1/REcMEn695T0BLieLTER0rOkCHoD7N4/0EbNX/Q/iIxt1qnLfjhRteOytuHmLjaAxbSD0U7D8wYmVdbPNXJ9lOb8wbPFcGneQHYyiWArJEgs8OgO9ABRTAvWm/wgdZlgimIpElaU9twqyloXQLva+Z/cnN5i4rRh4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de; spf=pass smtp.mailfrom=tu-ilmenau.de; dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b=KHCa/35n; arc=none smtp.client-ip=141.24.179.34
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tu-ilmenau.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tu-ilmenau.de header.i=@tu-ilmenau.de header.b="KHCa/35n"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=tu-ilmenau.de;
 i=@tu-ilmenau.de; q=dns/txt; s=tuil-dkim-1; t=1776847706; h=from : to
 : cc : subject : date : message-id : mime-version :
 content-transfer-encoding : from;
 bh=WVkeaIjszcuakhjojuDkjf9Tx/e9/71wxK74g3G4X94=;
 b=KHCa/35naDoaMBcbaNtdK5Hpi3IvcnvrpN/x7kXWdUj4rpz9My362BhuuoykT0+ubG+V5
 hlRMpbUrVSMJwwzZrdqvVg023yuiwoZThGhOYMuGaYKKan7eUyLXlZFgtIItjlJH3V5hNcd
 +rlUzRit7SJ5TUP7oIwiDfnWtcF3TGjyiPQ/kS8qsqgYGOkGK2NXp2oOOFXj/AAuWaDvu2D
 TSVdLi5myJPJJKDNzXGu4gfVX8flnbgAs2paB4AE90hkF/dDDkhb8Nwj9DhyJPO3PvBrAnI
 QnAZbaBOzCMOPSgVetihEp1p1aQfeLwP6zKOyAEHcvyfRmRZOBvHDHbrW35Q==
Received: from mail-front1.rz.tu-ilmenau.de (mail-front1.rz.tu-ilmenau.de [141.24.179.32])
	by mail-router1.rz.tu-ilmenau.de (Postfix) with ESMTPS id 41EAA60196;
	Wed, 22 Apr 2026 10:48:26 +0200 (CEST)
Received: from majestix.prakinf.tu-ilmenau.de (unknown [141.24.212.106])
	by mail-front1.rz.tu-ilmenau.de (Postfix) with ESMTPSA id 171CD5FB7B;
	Wed, 22 Apr 2026 10:48:26 +0200 (CEST)
From: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
To: Ilya Dryomov <idryomov@gmail.com>,
	Alex Markuze <amarkuze@redhat.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>
Cc: ceph-devel@vger.kernel.org,
	Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
Subject: [PATCH v3] libceph: Fix potential out-of-bounds access in crush_decode()
Date: Wed, 22 Apr 2026 10:47:13 +0200
Message-ID: <20260422084713.472133-1-raphael.zimmer@tu-ilmenau.de>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: ceph-devel@vger.kernel.org
List-Id: <ceph-devel.vger.kernel.org>
List-Subscribe: <mailto:ceph-devel+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:ceph-devel+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A message of type CEPH_MSG_OSD_MAP containing a crush map with at least
one bucket has two fields holding the bucket algorithm. If the values
in these two fields differ, an out-of-bounds access can occur. This is
the case because the first algorithm field (alg) is used to allocate
the correct amount of memory for a bucket of this type, while the second
algorithm field inside the bucket (b->alg) is used in the subsequent
processing.

This patch fixes the issue by adding a check that compares alg and
b->alg and aborts the processing in case they differ. Furthermore,
b->alg is set to 0 in this case, because the destruction of the crush
map also uses this field to determine the bucket type, which can again
result in an out-of-bounds access when trying to free the memory pointed
to by the fields of the bucket. To correctly free the memory allocated
for the bucket in such a case, the corresponding call to kfree is moved
from the algorithm-specific crush_destroy_bucket functions to the
generic crush_destroy_bucket().

Signed-off-by: Raphael Zimmer <raphael.zimmer@tu-ilmenau.de>
---
 net/ceph/crush/crush.c | 6 +-----
 net/ceph/osdmap.c      | 4 ++++
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/net/ceph/crush/crush.c b/net/ceph/crush/crush.c
index 254ded0b05f6..521aec1d5fc0 100644
--- a/net/ceph/crush/crush.c
+++ b/net/ceph/crush/crush.c
@@ -47,7 +47,6 @@ int crush_get_bucket_item_weight(const struct crush_bucket *b, int p)
 void crush_destroy_bucket_uniform(struct crush_bucket_uniform *b)
 {
 	kfree(b->h.items);
-	kfree(b);
 }
 
 void crush_destroy_bucket_list(struct crush_bucket_list *b)
@@ -55,14 +54,12 @@ void crush_destroy_bucket_list(struct crush_bucket_list *b)
 	kfree(b->item_weights);
 	kfree(b->sum_weights);
 	kfree(b->h.items);
-	kfree(b);
 }
 
 void crush_destroy_bucket_tree(struct crush_bucket_tree *b)
 {
 	kfree(b->h.items);
 	kfree(b->node_weights);
-	kfree(b);
 }
 
 void crush_destroy_bucket_straw(struct crush_bucket_straw *b)
@@ -70,14 +67,12 @@ void crush_destroy_bucket_straw(struct crush_bucket_straw *b)
 	kfree(b->straws);
 	kfree(b->item_weights);
 	kfree(b->h.items);
-	kfree(b);
 }
 
 void crush_destroy_bucket_straw2(struct crush_bucket_straw2 *b)
 {
 	kfree(b->item_weights);
 	kfree(b->h.items);
-	kfree(b);
 }
 
 void crush_destroy_bucket(struct crush_bucket *b)
@@ -99,6 +94,7 @@ void crush_destroy_bucket(struct crush_bucket *b)
 		crush_destroy_bucket_straw2((struct crush_bucket_straw2 *)b);
 		break;
 	}
+	kfree(b);
 }
 
 /**
diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index c89e66d4fcb7..a87268058e61 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -516,6 +516,10 @@ static struct crush_map *crush_decode(void *pbyval, void *end)
 		b->id = ceph_decode_32(p);
 		b->type = ceph_decode_16(p);
 		b->alg = ceph_decode_8(p);
+		if (b->alg != alg) {
+			b->alg = 0;
+			goto bad;
+		}
 		b->hash = ceph_decode_8(p);
 		b->weight = ceph_decode_32(p);
 		b->size = ceph_decode_32(p);
-- 
2.47.3

