From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 3/5] libceph: get rid of zero_page_address
Date: Mon, 12 Mar 2012 17:40:23 -0500
Message-ID: <4F5E7B57.7060606@dreamhost.com>
References: <4F5E79C6.6040301@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:58514 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757554Ab2CLWkU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Mar 2012 18:40:20 -0400
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 4AA5F243A2
	for <ceph-devel@vger.kernel.org>; Mon, 12 Mar 2012 15:40:54 -0700 (PDT)
Received: from [172.22.22.4] (c-71-195-31-37.hsd1.mn.comcast.net [71.195.31.37])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 1E6252439E
	for <ceph-devel@vger.kernel.org>; Mon, 12 Mar 2012 15:40:54 -0700 (PDT)
In-Reply-To: <4F5E79C6.6040301@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

There's not a lot of benefit to zero_page_address, which basically
holds a mapping of the zero page through the life of the messenger
module.  Even with our own mapping, the sendpage interface where
it's used may need to kmap() it again.  It's almost certain to
be in low memory anyway.

So stop treating the zero page specially in write_partial_msg_pages()
and just get rid of zero_page_address entirely.

Signed-off-by: Alex Elder <elder@dreamhost.com>
---
  net/ceph/messenger.c |   11 ++---------
  1 files changed, 2 insertions(+), 9 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index adca1e6..4f1714c 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -61,7 +61,6 @@ static char addr_str[ADDR_STR_COUNT][MAX_ADDR_STR_LEN];
  static atomic_t addr_str_seq = ATOMIC_INIT(0);

  static struct page *zero_page;		/* used in certain error cases */
-static void *zero_page_address;		/* kernel virtual addr of zero_page */

  const char *ceph_pr_addr(const struct sockaddr_storage *ss)
  {
@@ -111,9 +110,6 @@ void _ceph_msgr_exit(void)
  		ceph_msgr_wq = NULL;
  	}

-	BUG_ON(zero_page_address == NULL);
-	zero_page_address = NULL;
-
  	BUG_ON(zero_page == NULL);
  	kunmap(zero_page);
  	page_cache_release(zero_page);
@@ -126,9 +122,6 @@ int ceph_msgr_init(void)
  	zero_page = ZERO_PAGE(0);
  	page_cache_get(zero_page);

-	BUG_ON(zero_page_address != NULL);
-	zero_page_address = kmap(zero_page);
-
  	ceph_msgr_wq = alloc_workqueue("ceph-msgr", WQ_NON_REENTRANT, 0);
  	if (ceph_msgr_wq)
  		return 0;
@@ -889,7 +882,7 @@ static int write_partial_msg_pages(struct 
ceph_connection *con)
  		} else {
  			page = zero_page;
  			if (do_datacrc)
-				kaddr = zero_page_address;
+				kaddr = kmap(page);
  		}
  		len = min_t(int, max_write - con->out_msg_pos.page_pos,
  			    total_max_write);
@@ -908,7 +901,7 @@ static int write_partial_msg_pages(struct 
ceph_connection *con)
  				      con->out_msg_pos.page_pos + page_shift,
  				      len, 1);

-		if (do_datacrc && kaddr != zero_page_address)
+		if (do_datacrc)
  			kunmap(page);

  		if (ret <= 0)
-- 
1.7.5.4

