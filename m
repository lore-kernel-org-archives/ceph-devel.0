From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 1/4] libceph: don't bail early from try_read() when skipping a message
Date: Sat, 20 Feb 2016 17:45:26 +0100
Message-ID: <1455986729-12544-2-git-send-email-idryomov@gmail.com>
References: <1455986729-12544-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f49.google.com ([74.125.82.49]:35593 "EHLO
	mail-wm0-f49.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757719AbcBTQpz (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 20 Feb 2016 11:45:55 -0500
Received: by mail-wm0-f49.google.com with SMTP id c200so116208266wme.0
        for <ceph-devel@vger.kernel.org>; Sat, 20 Feb 2016 08:45:55 -0800 (PST)
In-Reply-To: <1455986729-12544-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Varada Kari <Varada.Kari@sandisk.com>

The contract between try_read() and try_write() is that when called
each processes as much data as possible.  When instructed by osd_client
to skip a message, try_read() is violating this contract by returning
after receiving and discarding a single message instead of checking for
more.  try_write() then gets a chance to write out more requests,
generating more replies/skips for try_read() to handle, forcing the
messenger into a starvation loop.

Cc: stable@vger.kernel.org # 3.10+
Reported-by: Varada Kari <Varada.Kari@sandisk.com>
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
Tested-by: Varada Kari <Varada.Kari@sandisk.com>
---
 net/ceph/messenger.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 9cfedf565f5b..fec20819a5ea 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2337,7 +2337,7 @@ static int read_partial_message(struct ceph_connection *con)
 		con->in_base_pos = -front_len - middle_len - data_len -
 			sizeof(m->footer);
 		con->in_tag = CEPH_MSGR_TAG_READY;
-		return 0;
+		return 1;
 	} else if ((s64)seq - (s64)con->in_seq > 1) {
 		pr_err("read_partial_message bad seq %lld expected %lld\n",
 		       seq, con->in_seq + 1);
@@ -2363,7 +2363,7 @@ static int read_partial_message(struct ceph_connection *con)
 				sizeof(m->footer);
 			con->in_tag = CEPH_MSGR_TAG_READY;
 			con->in_seq++;
-			return 0;
+			return 1;
 		}
 
 		BUG_ON(!con->in_msg);
-- 
2.4.3

