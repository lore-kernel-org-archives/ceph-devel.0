From: Ioana Ciornei <ciorneiioana@gmail.com>
Subject: [PATCH] net: ceph: osd_client: change osd_req_op_data() macro
Date: Thu, 22 Oct 2015 18:06:07 +0300
Message-ID: <1445526367-8258-1-git-send-email-ciorneiioana@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f171.google.com ([209.85.212.171]:36190 "EHLO
	mail-wi0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754507AbbJVPGQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 Oct 2015 11:06:16 -0400
Received: by wicfx6 with SMTP id fx6so140135022wic.1
        for <ceph-devel@vger.kernel.org>; Thu, 22 Oct 2015 08:06:15 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Ioana Ciornei <ciorneiioana@gmail.com>

This patch changes the osd_req_op_data() macro to not evaluate
parameters more than once in order to follow the kernel coding style.

Signed-off-by: Ioana Ciornei <ciorneiioana@gmail.com>
Reviewed-by: Alex Elder <elder@linaro.org>
---
 net/ceph/osd_client.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index a362d7e..856e8f8 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -120,10 +120,12 @@ static void ceph_osd_data_bio_init(struct ceph_osd_data *osd_data,
 }
 #endif /* CONFIG_BLOCK */
 
-#define osd_req_op_data(oreq, whch, typ, fld)	\
-	({						\
-		BUG_ON(whch >= (oreq)->r_num_ops);	\
-		&(oreq)->r_ops[whch].typ.fld;		\
+#define osd_req_op_data(oreq, whch, typ, fld)	          \
+	({						  \
+		struct ceph_osd_request *__oreq = (oreq); \
+		unsigned int __whch = (whch);               \
+		BUG_ON(__whch >= __oreq->r_num_ops);	  \
+		&__oreq->r_ops[__whch].typ.fld;		  \
 	})
 
 static struct ceph_osd_data *
-- 
2.1.4

