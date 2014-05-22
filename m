From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH v3 1/4] libceph: recognize poolop requests in debugfs
Date: Thu, 22 May 2014 20:50:05 +0400
Message-ID: <1400777408-7016-2-git-send-email-ilya.dryomov@inktank.com>
References: <1400777408-7016-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f47.google.com ([74.125.82.47]:53500 "EHLO
	mail-wg0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751039AbaEVQuO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 22 May 2014 12:50:14 -0400
Received: by mail-wg0-f47.google.com with SMTP id x12so3679513wgg.30
        for <ceph-devel@vger.kernel.org>; Thu, 22 May 2014 09:50:13 -0700 (PDT)
Received: from localhost ([109.110.67.203])
        by mx.google.com with ESMTPSA id ek4sm1239007wib.9.2014.05.22.09.50.11
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Thu, 22 May 2014 09:50:12 -0700 (PDT)
In-Reply-To: <1400777408-7016-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Recognize poolop requests in debugfs monc dump, fix prink format
specifiers - tid is unsigned.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/debugfs.c |    6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/ceph/debugfs.c b/net/ceph/debugfs.c
index 10421a4b76f8..8903dcee8d8e 100644
--- a/net/ceph/debugfs.c
+++ b/net/ceph/debugfs.c
@@ -126,9 +126,11 @@ static int monc_show(struct seq_file *s, void *p)
 		req = rb_entry(rp, struct ceph_mon_generic_request, node);
 		op = le16_to_cpu(req->request->hdr.type);
 		if (op == CEPH_MSG_STATFS)
-			seq_printf(s, "%lld statfs\n", req->tid);
+			seq_printf(s, "%llu statfs\n", req->tid);
+		else if (op == CEPH_MSG_POOLOP)
+			seq_printf(s, "%llu poolop\n", req->tid);
 		else
-			seq_printf(s, "%lld unknown\n", req->tid);
+			seq_printf(s, "%llu unknown\n", req->tid);
 	}
 
 	mutex_unlock(&monc->mutex);
-- 
1.7.10.4

