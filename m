From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 3/5] libceph: drop version variable from ceph_monmap_decode()
Date: Tue, 23 May 2017 18:33:56 +0200
Message-ID: <1495557238-1077-4-git-send-email-idryomov@gmail.com>
References: <1495557238-1077-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qk0-f195.google.com ([209.85.220.195]:35438 "EHLO
        mail-qk0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S937079AbdEWQeO (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 23 May 2017 12:34:14 -0400
Received: by mail-qk0-f195.google.com with SMTP id k74so23495477qke.2
        for <ceph-devel@vger.kernel.org>; Tue, 23 May 2017 09:34:14 -0700 (PDT)
Received: from orange.brq.redhat.com. (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id o15sm784055qki.47.2017.05.23.09.34.12
        for <ceph-devel@vger.kernel.org>
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 May 2017 09:34:13 -0700 (PDT)
In-Reply-To: <1495557238-1077-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

It's set but not used: CEPH_FEATURE_MONNAMES feature bit isn't
advertised, which guarantees a v1 MonMap.

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/mon_client.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index 29a0ef351c5e..250f11f78609 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -43,15 +43,13 @@ struct ceph_monmap *ceph_monmap_decode(void *p, void *end)
 	int i, err = -EINVAL;
 	struct ceph_fsid fsid;
 	u32 epoch, num_mon;
-	u16 version;
 	u32 len;
 
 	ceph_decode_32_safe(&p, end, len, bad);
 	ceph_decode_need(&p, end, len, bad);
 
 	dout("monmap_decode %p %p len %d\n", p, end, (int)(end-p));
-
-	ceph_decode_16_safe(&p, end, version, bad);
+	p += sizeof(u16);  /* skip version */
 
 	ceph_decode_need(&p, end, sizeof(fsid) + 2*sizeof(u32), bad);
 	ceph_decode_copy(&p, &fsid, sizeof(fsid));
-- 
2.4.3

