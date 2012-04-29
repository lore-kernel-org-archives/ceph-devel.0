From: Xi Wang <xi.wang@gmail.com>
Subject: [PATCH 2/3] libceph: fix overflow in osdmap_decode()
Date: Sun, 29 Apr 2012 02:59:24 -0400
Message-ID: <1335682765-1643-2-git-send-email-xi.wang@gmail.com>
References: <1335682765-1643-1-git-send-email-xi.wang@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f46.google.com ([209.85.216.46]:50911 "EHLO
	mail-qa0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682Ab2D2HBE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 29 Apr 2012 03:01:04 -0400
Received: by mail-qa0-f46.google.com with SMTP id m19so988683qat.19
        for <ceph-devel@vger.kernel.org>; Sun, 29 Apr 2012 00:01:04 -0700 (PDT)
In-Reply-To: <1335682765-1643-1-git-send-email-xi.wang@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@dreamhost.com>, Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org, Xi Wang <xi.wang@gmail.com>

On 32-bit systems, a large `n' would overflow `n * sizeof(u32)' and bypass
the check ceph_decode_need(p, end, n * sizeof(u32), bad).  It would also
overflow the subsequent kmalloc() size, leading to out-of-bounds write.

Signed-off-by: Xi Wang <xi.wang@gmail.com>
---
 net/ceph/osdmap.c |    3 +++
 1 files changed, 3 insertions(+), 0 deletions(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index f80afc3..774eac6 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -670,6 +670,9 @@ struct ceph_osdmap *osdmap_decode(void **p, void *end)
 		ceph_decode_need(p, end, sizeof(u32) + sizeof(u64), bad);
 		ceph_decode_copy(p, &pgid, sizeof(pgid));
 		n = ceph_decode_32(p);
+		err = -EINVAL;
+		if (n > (UINT_MAX - sizeof(*pg)) / sizeof(u32))
+			goto bad;
 		ceph_decode_need(p, end, n * sizeof(u32), bad);
 		err = -ENOMEM;
 		pg = kmalloc(sizeof(*pg) + n*sizeof(u32), GFP_NOFS);
-- 
1.7.5.4

