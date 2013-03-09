From: Alex Elder <elder@inktank.com>
Subject: [PATCH] libceph: don't clear bio_iter in prepare_write_message()
Date: Sat, 09 Mar 2013 10:36:48 -0600
Message-ID: <513B6520.8050303@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ia0-f182.google.com ([209.85.210.182]:41114 "EHLO
	mail-ia0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758510Ab3CIQgv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 9 Mar 2013 11:36:51 -0500
Received: by mail-ia0-f182.google.com with SMTP id b35so647060iac.27
        for <ceph-devel@vger.kernel.org>; Sat, 09 Mar 2013 08:36:51 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This patch is available in the branch "review/wip-msgr-refactor"
(prior to 6 other patches) in the ceph-client git repository.
That branch is based on branch "review/wip-abstract-2".

					-Alex

At one time it was necessary to clear a message's bio_iter field to
avoid a bad pointer dereference in write_partial_msg_pages().

That no longer seems to be the case.  Here's why.

The message's bio fields represent (in this case) outgoing data.
Between where the bio_iter is made NULL in prepare_write_message()
and the call in that function to prepare_message_data(), the
bio fields are never used.

In prepare_message_data(), init-bio_iter() is called, and the result
of that overwrites the value in the message's bio_iter field.

Because it gets overwritten anyway, there is no need to set it to
NULL.  So don't do it.

This resolves:
    http://tracker.ceph.com/issues/4402

Signed-off-by: Alex Elder <elder@inktank.com>
---
 net/ceph/messenger.c |    4 ----
 1 file changed, 4 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index e75a03d..17d9321 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -804,10 +804,6 @@ static void prepare_write_message(struct
ceph_connection *con)
 		m->hdr.seq = cpu_to_le64(++con->out_seq);
 		m->needs_out_seq = false;
 	}
-#ifdef CONFIG_BLOCK
-	else
-		m->bio_iter = NULL;
-#endif

 	dout("prepare_write_message %p seq %lld type %d len %d+%d+%d (%zd)\n",
 	     m, con->out_seq, le16_to_cpu(m->hdr.type),
-- 
1.7.9.5

