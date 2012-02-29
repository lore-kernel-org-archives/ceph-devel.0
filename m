From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH, v2] ceph: use a shared zero page rather than one per messenger
Date: Wed, 29 Feb 2012 09:40:26 -0800
Message-ID: <4F4E630A.6040407@dreamhost.com>
References: <4F4D962E.7020304@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:40128 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752388Ab2B2Rkt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Feb 2012 12:40:49 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 95DDAC06B
	for <ceph-devel@vger.kernel.org>; Wed, 29 Feb 2012 09:40:42 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 147A5C068
	for <ceph-devel@vger.kernel.org>; Wed, 29 Feb 2012 09:40:30 -0800 (PST)
In-Reply-To: <4F4D962E.7020304@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Each messenger allocates a page to be used when writing zeroes
out in the event of error or other abnormal condition.  Instead,
use the kernel ZERO_PAGE() for that purpose.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
v2:  Updated to use kernel ZERO_PAGE()

  include/linux/ceph/messenger.h |    1
  net/ceph/messenger.c           |   43 
+++++++++++++++++++++++++++--------------
  2 files changed, 29 insertions(+), 15 deletions(-)

Index: b/include/linux/ceph/messenger.h
===================================================================
--- a/include/linux/ceph/messenger.h
+++ b/include/linux/ceph/messenger.h
@@ -54,7 +54,6 @@ struct ceph_connection_operations {
  struct ceph_messenger {
  	struct ceph_entity_inst inst;    /* my name+address */
  	struct ceph_entity_addr my_enc_addr;
-	struct page *zero_page;          /* used in certain error cases */

  	bool nocrc;

Index: b/net/ceph/messenger.c
===================================================================
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -52,6 +52,9 @@ static char addr_str[MAX_ADDR_STR][MAX_A
  static DEFINE_SPINLOCK(addr_str_lock);
  static int last_addr_str;

+static struct page *zero_page;		/* used in certain error cases */
+static void *zero_page_address;		/* kernel virtual addr of zero_page */
+
  const char *ceph_pr_addr(const struct sockaddr_storage *ss)
  {
  	int i;
@@ -99,18 +102,41 @@ struct workqueue_struct *ceph_msgr_wq;

  int ceph_msgr_init(void)
  {
+	BUG_ON(zero_page != NULL);
+	zero_page = ZERO_PAGE(0);
+	page_cache_get(zero_page);
+
+	BUG_ON(zero_page_address != NULL);
+	zero_page_address = kmap(zero_page);
+
  	ceph_msgr_wq = alloc_workqueue("ceph-msgr", WQ_NON_REENTRANT, 0);
  	if (!ceph_msgr_wq) {
  		pr_err("msgr_init failed to create workqueue\n");
+
+		zero_page_address = NULL;
+		kunmap(zero_page);
+		page_cache_release(zero_page);
+		zero_page = NULL;
+
  		return -ENOMEM;
  	}
+
  	return 0;
  }
  EXPORT_SYMBOL(ceph_msgr_init);

  void ceph_msgr_exit(void)
  {
+	BUG_ON(ceph_msgr_wq == NULL);
  	destroy_workqueue(ceph_msgr_wq);
+
+	BUG_ON(zero_page_address == NULL);
+	zero_page_address = NULL;
+
+	BUG_ON(zero_page == NULL);
+	kunmap(zero_page);
+	page_cache_release(zero_page);
+	zero_page = NULL;
  }
  EXPORT_SYMBOL(ceph_msgr_exit);

@@ -841,9 +867,9 @@ static int write_partial_msg_pages(struc
  			max_write = bv->bv_len;
  #endif
  		} else {
-			page = con->msgr->zero_page;
+			page = zero_page;
  			if (crc)
-				kaddr = page_address(con->msgr->zero_page);
+				kaddr = zero_page_address;
  		}
  		len = min_t(int, max_write - con->out_msg_pos.page_pos,
  			    total_max_write);
@@ -914,7 +940,7 @@ static int write_partial_skip(struct cep

  	while (con->out_skip > 0) {
  		struct kvec iov = {
-			.iov_base = page_address(con->msgr->zero_page),
+			.iov_base = zero_page_address,
  			.iov_len = min(con->out_skip, (int)PAGE_CACHE_SIZE)
  		};

@@ -2222,15 +2248,6 @@ struct ceph_messenger *ceph_messenger_cr

  	spin_lock_init(&msgr->global_seq_lock);

-	/* the zero page is needed if a request is "canceled" while the message
-	 * is being written over the socket */
-	msgr->zero_page = __page_cache_alloc(GFP_KERNEL | __GFP_ZERO);
-	if (!msgr->zero_page) {
-		kfree(msgr);
-		return ERR_PTR(-ENOMEM);
-	}
-	kmap(msgr->zero_page);
-
  	if (myaddr)
  		msgr->inst.addr = *myaddr;

@@ -2247,8 +2264,6 @@ EXPORT_SYMBOL(ceph_messenger_create);
  void ceph_messenger_destroy(struct ceph_messenger *msgr)
  {
  	dout("destroy %p\n", msgr);
-	kunmap(msgr->zero_page);
-	__free_page(msgr->zero_page);
  	kfree(msgr);
  	dout("destroyed messenger %p\n", msgr);
  }

