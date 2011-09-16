From: Jim Schutt <jaschut@sandia.gov>
Subject: [PATCH] libceph: initialize ack_stamp to avoid unnecessary connection reset
Date: Fri, 16 Sep 2011 08:27:31 -0600
Message-ID: <1316183251-18945-1-git-send-email-jaschut@sandia.gov>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from sentry-two.sandia.gov ([132.175.109.14]:36127 "EHLO
	sentry-two.sandia.gov" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752616Ab1IPO1q (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 16 Sep 2011 10:27:46 -0400
Received: from interceptor2.sandia.gov (interceptor2.sandia.gov [132.175.109.18])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by sentry-two.sandia.gov (Postfix) with ESMTP id 1A635269CBD
	for <ceph-devel@vger.kernel.org>; Fri, 16 Sep 2011 08:27:43 -0600 (MDT)
Received: from mailgate.sandia.gov (mailgate.sandia.gov [132.175.109.1]) by interceptor2.sandia.gov (RSA Interceptor) for <ceph-devel@vger.kernel.org>; Fri, 16 Sep 2011 08:27:34 -0600
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Jim Schutt <jaschut@sandia.gov>

Commit 4cf9d544631c recorded when an outgoing ceph message was ACKed,
in order to avoid unnecessary connection resets when an OSD is busy.

However, ack_stamp is uninitialized, so there is a window between
when the message is sent and when it is ACKed in which handle_timeout()
interprets the unitialized value as an expired timeout, and resets
the connection unnecessarily.

Close the window by initializing ack_stamp.

Signed-off-by: Jim Schutt <jaschut@sandia.gov>
---
 net/ceph/messenger.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index e6d4857..f56aca3 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2308,6 +2308,7 @@ struct ceph_msg *ceph_msg_new(int type, int front_len, gfp_t flags,
 	m->front_max = front_len;
 	m->front_is_vmalloc = false;
 	m->more_to_follow = false;
+	m->ack_stamp = 0;
 	m->pool = NULL;
 
 	/* middle */
-- 
1.7.1

