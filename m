From: Chengguang Xu <cgxu519@icloud.com>
Subject: [PATCH] libceph: fix misjudgement of maximum monitor number
Date: Sun, 11 Feb 2018 09:33:28 +0800
Message-ID: <1518312808-34839-1-git-send-email-cgxu519@icloud.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mr11p00im-asmtp004.me.com ([17.110.69.135]:41988 "EHLO
        mr11p00im-asmtp004.me.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750909AbeBKBdn (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Sat, 10 Feb 2018 20:33:43 -0500
Received: from process-dkim-sign-daemon.mr11p00im-asmtp004.me.com by
 mr11p00im-asmtp004.me.com
 (Oracle Communications Messaging Server 8.0.1.2.20170607 64bit (built Jun  7
 2017)) id <0P3Y00B00PDYT500@mr11p00im-asmtp004.me.com> for
 ceph-devel@vger.kernel.org; Sun, 11 Feb 2018 01:33:42 +0000 (GMT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: idryomov@gmail.com, zyan@redhat.com
Cc: ceph-devel@vger.kernel.org, Chengguang Xu <cgxu519@icloud.com>

num_mon should allow up to CEPH_MAX_MON in ceph_monmap_decode().

Signed-off-by: Chengguang Xu <cgxu519@icloud.com>
---
 net/ceph/mon_client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index 1547107..b3dac24 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -60,7 +60,7 @@ struct ceph_monmap *ceph_monmap_decode(void *p, void *end)
 	num_mon = ceph_decode_32(&p);
 	ceph_decode_need(&p, end, num_mon*sizeof(m->mon_inst[0]), bad);
 
-	if (num_mon >= CEPH_MAX_MON)
+	if (num_mon > CEPH_MAX_MON)
 		goto bad;
 	m = kmalloc(sizeof(*m) + sizeof(m->mon_inst[0])*num_mon, GFP_NOFS);
 	if (m == NULL)
-- 
1.8.3.1

