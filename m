From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] crush: fix a bug in tree bucket decode
Date: Mon, 29 Jun 2015 20:17:52 +0300
Message-ID: <1435598272-44621-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f45.google.com ([209.85.215.45]:34519 "EHLO
	mail-la0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752755AbbF2RSN (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 29 Jun 2015 13:18:13 -0400
Received: by lagx9 with SMTP id x9so133838470lag.1
        for <ceph-devel@vger.kernel.org>; Mon, 29 Jun 2015 10:18:11 -0700 (PDT)
Received: from localhost.localdomain ([109.110.66.238])
        by mx.google.com with ESMTPSA id o8sm10876316laf.7.2015.06.29.10.18.10
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 29 Jun 2015 10:18:10 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

struct crush_bucket_tree::num_nodes is u8, so ceph_decode_8_safe()
should be used.  -Wconversion catches this, but I guess it went
unnoticed in all the noise it spews.  The actual problem (at least for
common crushmaps) isn't the u32 -> u8 truncation though - it's the
advancement by 4 bytes insead of 1 in the crushmap buffer.

Fixes: http://tracker.ceph.com/issues/2759

Cc: stable@vger.kernel.org
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/osdmap.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 15796696d64e..4a3125836b64 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -89,7 +89,7 @@ static int crush_decode_tree_bucket(void **p, void *end,
 {
 	int j;
 	dout("crush_decode_tree_bucket %p to %p\n", *p, end);
-	ceph_decode_32_safe(p, end, b->num_nodes, bad);
+	ceph_decode_8_safe(p, end, b->num_nodes, bad);
 	b->node_weights = kcalloc(b->num_nodes, sizeof(u32), GFP_NOFS);
 	if (b->node_weights == NULL)
 		return -ENOMEM;
-- 
1.9.3

