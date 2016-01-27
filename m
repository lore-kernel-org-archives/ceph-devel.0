From: Ioana Ciornei <ciorneiioana@gmail.com>
Subject: [PATCH 2/6] net: ceph: messenger: fix coding style comparison to NULL
Date: Wed, 27 Jan 2016 02:43:35 +0200
Message-ID: <0bb28068731f24986663bdd1866f7342fb5139fe.1453853617.git.ciorneiioana@gmail.com>
References: <cover.1453853617.git.ciorneiioana@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f68.google.com ([74.125.82.68]:33618 "EHLO
	mail-wm0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752758AbcAZWnv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 26 Jan 2016 17:43:51 -0500
Received: by mail-wm0-f68.google.com with SMTP id r129so22008wmr.0
        for <ceph-devel@vger.kernel.org>; Tue, 26 Jan 2016 14:43:51 -0800 (PST)
In-Reply-To: <cover.1453853617.git.ciorneiioana@gmail.com>
In-Reply-To: <cover.1453853617.git.ciorneiioana@gmail.com>
References: <cover.1453853617.git.ciorneiioana@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: elder@ieee.org, Ioana Ciornei <ciorneiioana@gmail.com>

This patch fixes the comparison to NULL format in order to follow linux
kernel coding style.

Signed-off-by: Ioana Ciornei <ciorneiioana@gmail.com>
---
 net/ceph/messenger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 424d76b..7a8bc51 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -3249,7 +3249,7 @@ struct ceph_msg *ceph_msg_new(int type, int front_len, gfp_t flags,
 	struct ceph_msg *m;
 
 	m = kmem_cache_zalloc(ceph_msg_cache, flags);
-	if (m == NULL)
+	if (!m)
 		goto out;
 
 	m->hdr.type = cpu_to_le16(type);
@@ -3263,7 +3263,7 @@ struct ceph_msg *ceph_msg_new(int type, int front_len, gfp_t flags,
 	/* front */
 	if (front_len) {
 		m->front.iov_base = ceph_kvmalloc(front_len, flags);
-		if (m->front.iov_base == NULL) {
+		if (!m->front.iov_base) {
 			dout("ceph_msg_new can't allocate %d bytes\n",
 			     front_len);
 			goto out2;
-- 
2.6.4

