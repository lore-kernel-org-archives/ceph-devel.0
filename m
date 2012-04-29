From: Xi Wang <xi.wang@gmail.com>
Subject: [PATCH 3/3] libceph: fix overflow in osdmap_apply_incremental()
Date: Sun, 29 Apr 2012 02:59:25 -0400
Message-ID: <1335682765-1643-3-git-send-email-xi.wang@gmail.com>
References: <1335682765-1643-1-git-send-email-xi.wang@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f53.google.com ([209.85.216.53]:43186 "EHLO
	mail-qa0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751682Ab2D2HBG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 29 Apr 2012 03:01:06 -0400
Received: by qadc11 with SMTP id c11so968456qad.19
        for <ceph-devel@vger.kernel.org>; Sun, 29 Apr 2012 00:01:06 -0700 (PDT)
In-Reply-To: <1335682765-1643-1-git-send-email-xi.wang@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@dreamhost.com>, Sage Weil <sage@newdream.net>
Cc: ceph-devel@vger.kernel.org, Xi Wang <xi.wang@gmail.com>

On 32-bit systems, a large `pglen' would overflow `pglen*sizeof(u32)'
and bypass the check ceph_decode_need(p, end, pglen*sizeof(u32), bad).
It would also overflow the subsequent kmalloc() size, leading to
out-of-bounds write.

Signed-off-by: Xi Wang <xi.wang@gmail.com>
---
 net/ceph/osdmap.c |    4 ++++
 1 files changed, 4 insertions(+), 0 deletions(-)

diff --git a/net/ceph/osdmap.c b/net/ceph/osdmap.c
index 774eac6..b1ea6d1 100644
--- a/net/ceph/osdmap.c
+++ b/net/ceph/osdmap.c
@@ -891,6 +891,10 @@ struct ceph_osdmap *osdmap_apply_incremental(void **p, void *end,
 
 		if (pglen) {
 			/* insert */
+			if (pglen > (UINT_MAX - sizeof(*pg)) / sizeof(u32)) {
+				err = -EINVAL;
+				goto bad;
+			}
 			ceph_decode_need(p, end, pglen*sizeof(u32), bad);
 			pg = kmalloc(sizeof(*pg) + sizeof(u32)*pglen, GFP_NOFS);
 			if (!pg) {
-- 
1.7.5.4

