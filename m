From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 1/3] libceph: unlink from o_linger_requests when clearing r_osd
Date: Wed,  5 Nov 2014 20:33:22 +0300
Message-ID: <1415208804-10163-2-git-send-email-idryomov@redhat.com>
References: <1415208804-10163-1-git-send-email-idryomov@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f44.google.com ([209.85.215.44]:45735 "EHLO
	mail-la0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754590AbaKERdq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Nov 2014 12:33:46 -0500
Received: by mail-la0-f44.google.com with SMTP id gf13so1094729lab.31
        for <ceph-devel@vger.kernel.org>; Wed, 05 Nov 2014 09:33:43 -0800 (PST)
Received: from localhost ([109.110.66.36])
        by mx.google.com with ESMTPSA id ql6sm1546994lbb.31.2014.11.05.09.33.39
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=RC4-SHA bits=128/128);
        Wed, 05 Nov 2014 09:33:40 -0800 (PST)
In-Reply-To: <1415208804-10163-1-git-send-email-idryomov@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Requests have to be unlinked from both osd->o_requests (normal
requests) and osd->o_linger_requests (linger requests) lists when
clearing req->r_osd.  Otherwise __unregister_linger_request() gets
confused and we trip over a !list_empty(&osd->o_linger_requests)
assert in __remove_osd().

Reproducer, MON=1 OSD=1:

    # cat remove-osd.sh
    #!/bin/bash
    rbd create --size 1 test
    DEV=$(rbd map test)
    ceph osd out 0
    sleep 3
    rbd map bar/b # obtain a new osdmap as a side effect
    rbd unmap $DEV & # will block
    sleep 3
    ceph osd in 0

Signed-off-by: Ilya Dryomov <idryomov@redhat.com>
---
 net/ceph/osd_client.c |    1 +
 1 file changed, 1 insertion(+)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 5a75395fe0ff..ce09da2cf32b 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -1395,6 +1395,7 @@ static int __map_request(struct ceph_osd_client *osdc,
 	if (req->r_osd) {
 		__cancel_request(req);
 		list_del_init(&req->r_osd_item);
+		list_del_init(&req->r_linger_osd_item);
 		req->r_osd = NULL;
 	}
 
-- 
1.7.10.4

