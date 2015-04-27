From: Alex Elder <elder@linaro.org>
Subject: [PATCH 5/7] osd_client: improve safety of osd_req_op_data() macro
Date: Mon, 27 Apr 2015 12:13:13 -0500
Message-ID: <1430154795-17123-6-git-send-email-elder@linaro.org>
References: <1430154795-17123-1-git-send-email-elder@linaro.org>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:36051 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S964811AbbD0RNY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Apr 2015 13:13:24 -0400
Received: by pdea3 with SMTP id a3so134952176pde.3
        for <ceph-devel@vger.kernel.org>; Mon, 27 Apr 2015 10:13:23 -0700 (PDT)
Received: from shibby.corp.google.com ([104.135.1.105])
        by mx.google.com with ESMTPSA id ff10sm12124675pab.13.2015.04.27.10.13.22
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Apr 2015 10:13:23 -0700 (PDT)
In-Reply-To: <1430154795-17123-1-git-send-email-elder@linaro.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

The osd_req_op_data() macro uses (and thus evaluates) two of its
parameters more than once.  This isn't guaranteed safe.  Define and
use some local variables to fix that.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 net/ceph/osd_client.c | 11 +++++++----
 1 file changed, 7 insertions(+), 4 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 6539dfc..4602442 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -120,10 +120,13 @@ static void ceph_osd_data_bio_init(struct ceph_osd_data *osd_data,
 }
 #endif /* CONFIG_BLOCK */
 
-#define osd_req_op_data(oreq, whch, typ, fld)	\
-	({						\
-		BUG_ON(whch >= (oreq)->r_num_ops);	\
-		&(oreq)->r_ops[whch].typ.fld;		\
+#define osd_req_op_data(oreq, whch, typ, fld)				\
+	({								\
+		struct ceph_osd_request *__oreq = (oreq);		\
+		unsigned int __whch = (whch);				\
+									\
+		BUG_ON(__whch >= __oreq->r_num_ops);			\
+		&__oreq->r_ops[__whch].typ.fld;				\
 	})
 
 static struct ceph_osd_data *
-- 
2.1.0

