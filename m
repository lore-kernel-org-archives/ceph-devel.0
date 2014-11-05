From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 2/3] libceph: clear r_req_lru_item in __unregister_linger_request()
Date: Wed,  5 Nov 2014 20:33:23 +0300
Message-ID: <1415208804-10163-3-git-send-email-idryomov@redhat.com>
References: <1415208804-10163-1-git-send-email-idryomov@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f173.google.com ([209.85.217.173]:55497 "EHLO
	mail-lb0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755020AbaKERds (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Nov 2014 12:33:48 -0500
Received: by mail-lb0-f173.google.com with SMTP id n15so1095702lbi.18
        for <ceph-devel@vger.kernel.org>; Wed, 05 Nov 2014 09:33:47 -0800 (PST)
Received: from localhost ([109.110.66.36])
        by mx.google.com with ESMTPSA id xs6sm1554184lbb.13.2014.11.05.09.33.45
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 05 Nov 2014 09:33:45 -0800 (PST)
In-Reply-To: <1415208804-10163-1-git-send-email-idryomov@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

kick_requests() can put linger requests on the notarget list.  This
means we need to clear the much-overloaded req->r_req_lru_item in
__unregister_linger_request() as well, or we get an assertion failure
in ceph_osdc_release_request() - !list_empty(&req->r_req_lru_item).

AFAICT the assumption was that registered linger requests cannot be on
any of req->r_req_lru_item lists, but that's clearly not the case.

Signed-off-by: Ilya Dryomov <idryomov@redhat.com>
---
 net/ceph/osd_client.c |    2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index ce09da2cf32b..2a42c795b1ac 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1254,6 +1254,8 @@ static void __unregister_linger_request(struct ceph_osd_client *osdc,
 		if (list_empty(&req->r_osd_item))
 			req->r_osd = NULL;
 	}
+
+	list_del_init(&req->r_req_lru_item); /* can be on notarget */
 	ceph_osdc_put_request(req);
 }
 
-- 
1.7.10.4

