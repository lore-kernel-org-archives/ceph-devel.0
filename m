From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH] libceph: dump class and method names on method calls
Date: Tue, 16 Jun 2020 10:04:14 +0200
Message-ID: <20200616080414.15534-1-idryomov@gmail.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726222AbgFPIEJ (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Jun 2020 04:04:09 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 480F5C05BD43
        for <ceph-devel@vger.kernel.org>; Tue, 16 Jun 2020 01:04:09 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id k11so20464525ejr.9
        for <ceph-devel@vger.kernel.org>; Tue, 16 Jun 2020 01:04:09 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Jeff Layton <jlayton@kernel.org>

Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/debugfs.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/net/ceph/debugfs.c b/net/ceph/debugfs.c
index 409d505ff320..2110439f8a24 100644
--- a/net/ceph/debugfs.c
+++ b/net/ceph/debugfs.c
@@ -223,6 +223,9 @@ static void dump_request(struct seq_file *s, struct ceph_osd_request *req)
 		if (op->op == CEPH_OSD_OP_WATCH)
 			seq_printf(s, "-%s",
 				   ceph_osd_watch_op_name(op->watch.op));
+		else if (op->op == CEPH_OSD_OP_CALL)
+			seq_printf(s, "-%s/%s", op->cls.class_name,
+				   op->cls.method_name);
 	}
 
 	seq_putc(s, '\n');
-- 
2.19.2
