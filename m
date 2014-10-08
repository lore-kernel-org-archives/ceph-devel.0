From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH] libceph: separate multiple ops with commas in debugfs output
Date: Wed,  8 Oct 2014 12:37:16 +0400
Message-ID: <1412757436-6996-1-git-send-email-idryomov@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:65256 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754449AbaJHIh1 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 8 Oct 2014 04:37:27 -0400
Received: by mail-lb0-f178.google.com with SMTP id w7so7757846lbi.9
        for <ceph-devel@vger.kernel.org>; Wed, 08 Oct 2014 01:37:26 -0700 (PDT)
Received: from localhost ([109.110.67.250])
        by mx.google.com with ESMTPSA id z5sm3677141lae.21.2014.10.08.01.37.24
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 08 Oct 2014 01:37:24 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

For requests with multiple ops, separate ops with commas instead of \t,
which is a field separator here.

Signed-off-by: Ilya Dryomov <idryomov@redhat.com>
---
 net/ceph/debugfs.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/net/ceph/debugfs.c b/net/ceph/debugfs.c
index d1a62c69a9f4..d2d525529f87 100644
--- a/net/ceph/debugfs.c
+++ b/net/ceph/debugfs.c
@@ -169,7 +169,8 @@ static int osdc_show(struct seq_file *s, void *pp)
 
 		for (i = 0; i < req->r_num_ops; i++) {
 			opcode = req->r_ops[i].op;
-			seq_printf(s, "\t%s", ceph_osd_op_name(opcode));
+			seq_printf(s, "%s%s", (i == 0 ? "\t" : ","),
+				   ceph_osd_op_name(opcode));
 		}
 
 		seq_printf(s, "\n");
-- 
1.7.10.4

