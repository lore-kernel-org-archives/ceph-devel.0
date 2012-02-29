From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 2/4] libceph: encapsulate some messenger cleanup code
Date: Tue, 28 Feb 2012 20:46:32 -0800
Message-ID: <4F4DADA8.4090508@dreamhost.com>
References: <4F4DAD34.2030202@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:48675 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S965408Ab2B2Eqd (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 23:46:33 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id DB89C24318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 20:46:32 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id C3A8724314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 20:46:32 -0800 (PST)
In-Reply-To: <4F4DAD34.2030202@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Define a helper function to perform various cleanup operations.  Use
it both in the exit routine and in the init routine in the event of
an error.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  net/ceph/messenger.c |   38 ++++++++++++++++++++------------------
  1 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 9c0f73a..2e496e2 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -99,6 +99,20 @@ static void encode_my_addr(struct ceph_messenger *msgr)
   */
  static struct workqueue_struct *ceph_msgr_wq;

+void _ceph_msgr_exit(void)
+{
+	if (ceph_msgr_wq)
+		destroy_workqueue(ceph_msgr_wq);
+
+	BUG_ON(zero_page_address == NULL);
+	zero_page_address = NULL;
+
+	BUG_ON(zero_page == NULL);
+	kunmap(zero_page);
+	__free_page(zero_page);
+	zero_page = NULL;
+}
+
  int ceph_msgr_init(void)
  {
  	BUG_ON(zero_page != NULL);
@@ -111,33 +125,21 @@ int ceph_msgr_init(void)
  	zero_page_address = kmap(zero_page);

  	ceph_msgr_wq = alloc_workqueue("ceph-msgr", WQ_NON_REENTRANT, 0);
-	if (!ceph_msgr_wq) {
-		pr_err("msgr_init failed to create workqueue\n");
-
-		zero_page_address = NULL;
-		kunmap(zero_page);
-		__free_page(zero_page);
-		zero_page = NULL;
+	if (ceph_msgr_wq)
+		return 0;

-		return -ENOMEM;
-	}
+	pr_err("msgr_init failed to create workqueue\n");
+	_ceph_msgr_exit();

-	return 0;
+	return -ENOMEM;
  }
  EXPORT_SYMBOL(ceph_msgr_init);

  void ceph_msgr_exit(void)
  {
  	BUG_ON(ceph_msgr_wq == NULL);
-	destroy_workqueue(ceph_msgr_wq);

-	BUG_ON(zero_page_address == NULL);
-	zero_page_address = NULL;
-
-	BUG_ON(zero_page == NULL);
-	kunmap(zero_page);
-	__free_page(zero_page);
-	zero_page = NULL;
+	_ceph_msgr_exit();
  }
  EXPORT_SYMBOL(ceph_msgr_exit);

-- 
1.7.5.4

