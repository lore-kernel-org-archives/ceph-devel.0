From: Dan Carpenter <dan.carpenter@oracle.com>
Subject: [patch 3/2] libceph: create_singlethread_workqueue() doesn't return
 ERR_PTRs
Date: Thu, 15 Aug 2013 08:58:59 +0300
Message-ID: <20130815055859.GF23580@elgon.mountain>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline
Sender: netdev-owner@vger.kernel.org
To: Sage Weil <sage@inktank.com>
Cc: "David S. Miller" <davem@davemloft.net>, ceph-devel@vger.kernel.org, netdev@vger.kernel.org, kernel-janitors@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

create_singlethread_workqueue() returns NULL on error, and it doesn't
return ERR_PTRs.

I tweaked the error handling a little to be consistent with earlier in
the function.

Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index dbc0a73..02c5246 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -2257,12 +2257,10 @@ int ceph_osdc_init(struct ceph_osd_client *osdc, struct ceph_client *client)
 	if (err < 0)
 		goto out_msgpool;
 
+	err = -ENOMEM;
 	osdc->notify_wq = create_singlethread_workqueue("ceph-watch-notify");
-	if (IS_ERR(osdc->notify_wq)) {
-		err = PTR_ERR(osdc->notify_wq);
-		osdc->notify_wq = NULL;
+	if (!osdc->notify_wq)
 		goto out_msgpool;
-	}
 	return 0;
 
 out_msgpool:
