From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] libceph: fix non static symbol warning
Date: Sat, 30 Jul 2016 00:37:31 +0000
Message-ID: <1469839051-3525-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f66.google.com ([209.85.220.66]:34988 "EHLO
	mail-pa0-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751667AbcG3Ahi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Jul 2016 20:37:38 -0400
Received: by mail-pa0-f66.google.com with SMTP id cf3so5921387pad.2
        for <ceph-devel@vger.kernel.org>; Fri, 29 Jul 2016 17:37:37 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, ceph-devel@vger.kernel.org

Fixes the following sparse warning:

net/ceph/mon_client.c:577:6: warning:
 symbol 'cancel_generic_request' was not declared. Should it be static?

Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 net/ceph/mon_client.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/ceph/mon_client.c b/net/ceph/mon_client.c
index c83326c..ef34a02 100644
--- a/net/ceph/mon_client.c
+++ b/net/ceph/mon_client.c
@@ -574,7 +574,7 @@ static void complete_generic_request(struct ceph_mon_generic_request *req)
 	put_generic_request(req);
 }
 
-void cancel_generic_request(struct ceph_mon_generic_request *req)
+static void cancel_generic_request(struct ceph_mon_generic_request *req)
 {
 	struct ceph_mon_client *monc = req->monc;
 	struct ceph_mon_generic_request *lookup_req;

