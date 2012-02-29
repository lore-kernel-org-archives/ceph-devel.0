From: Alex Elder <elder@dreamhost.com>
Subject: [PATCH 2/4] ceph: kill addr_str_lock spinlock; use atomic instead
Date: Tue, 28 Feb 2012 19:12:12 -0800
Message-ID: <4F4D978C.7090704@dreamhost.com>
References: <4F4D96F4.3080707@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:44141 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1030692Ab2B2DMM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 28 Feb 2012 22:12:12 -0500
Received: from mail.hq.newdream.net (localhost [127.0.0.1])
	by mail.hq.newdream.net (Postfix) with ESMTP id 628E024318
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:12:12 -0800 (PST)
Received: from [192.168.107.136] (aon.hq.newdream.net [64.111.111.107])
	by mail.hq.newdream.net (Postfix) with ESMTPSA id 572A424314
	for <ceph-devel@vger.kernel.org>; Tue, 28 Feb 2012 19:12:12 -0800 (PST)
In-Reply-To: <4F4D96F4.3080707@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

A spinlock is used to protect a value used for selecting an array
index for a string used for formatting a socket address for human
consumption.  The index is reset to 0 if it ever reaches the maximum
index value.

Instead, use an ever-increasing atomic variable as a sequence
number, and compute the array index by masking off all but the
sequence number's lowest bits.  Make the number of entries in the
array a power of two to allow the use of such a mask (to avoid jumps
in the index value when the sequence number wraps).

The length of these strings is somewhat arbitrarily set at 60 bytes.
The worst-case length of a string produced is 54 bytes, for an IPv6
address that can't be shortened, e.g.:
     [1234:5678:9abc:def0:1111:2222:123.234.210.100]:32767
Change it so we arbitrarily use 64 bytes instead; if nothing else
it will make the array of these line up better in hex dumps.

Rename a few things to reinforce the distinction between the number
of strings in the array and the length of individual strings.

Signed-off-by: Alex Elder <elder@newdream.net>
---
  net/ceph/messenger.c |   21 ++++++++++-----------
  1 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index c9a413a..8edfd1a 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -44,13 +44,16 @@ static void con_work(struct work_struct *);
  static void ceph_fault(struct ceph_connection *con);

  /*
- * nicely render a sockaddr as a string.
+ * Nicely render a sockaddr as a string.  An array of formatted
+ * strings is used, to approximate reentrancy.
   */
-#define MAX_ADDR_STR 20
-#define MAX_ADDR_STR_LEN 60
-static char addr_str[MAX_ADDR_STR][MAX_ADDR_STR_LEN];
-static DEFINE_SPINLOCK(addr_str_lock);
-static int last_addr_str;
+#define ADDR_STR_COUNT_LOG	5	/* log2(# address strings in array) */
+#define ADDR_STR_COUNT		(1 << ADDR_STR_COUNT_LOG)
+#define ADDR_STR_COUNT_MASK	(ADDR_STR_COUNT - 1)
+#define MAX_ADDR_STR_LEN	64	/* 54 is enough */
+
+static char addr_str[ADDR_STR_COUNT][MAX_ADDR_STR_LEN];
+static atomic_t addr_str_seq = ATOMIC_INIT(0);

  static struct page *zero_page;		/* used in certain error cases */
  static void *zero_page_address;		/* kernel virtual addr of zero_page */
@@ -62,11 +65,7 @@ const char *ceph_pr_addr(const struct 
sockaddr_storage *ss)
  	struct sockaddr_in *in4 = (void *)ss;
  	struct sockaddr_in6 *in6 = (void *)ss;

-	spin_lock(&addr_str_lock);
-	i = last_addr_str++;
-	if (last_addr_str == MAX_ADDR_STR)
-		last_addr_str = 0;
-	spin_unlock(&addr_str_lock);
+	i = atomic_inc_return(&addr_str_seq) & ADDR_STR_COUNT_MASK;
  	s = addr_str[i];

  	switch (ss->ss_family) {
-- 
1.7.5.4

