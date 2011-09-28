From: Sage Weil <sage@newdream.net>
Subject: [PATCH 1/5] libceph: initialize ack_stamp to avoid unnecessary connection reset
Date: Wed, 28 Sep 2011 10:26:27 -0700
Message-ID: <1317230791-6642-2-git-send-email-sage@newdream.net>
References: <1317230791-6642-1-git-send-email-sage@newdream.net>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:46488 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752996Ab1I1R0i (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 28 Sep 2011 13:26:38 -0400
In-Reply-To: <1317230791-6642-1-git-send-email-sage@newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Jim Schutt <jaschut@sandia.gov>, Sage Weil <sage@newdream.net>

From: Jim Schutt <jaschut@sandia.gov>

Commit 4cf9d544631c recorded when an outgoing ceph message was ACKed,
in order to avoid unnecessary connection resets when an OSD is busy.

However, ack_stamp is uninitialized, so there is a window between
when the message is sent and when it is ACKed in which handle_timeout()
interprets the unitialized value as an expired timeout, and resets
the connection unnecessarily.

Close the window by initializing ack_stamp.

Signed-off-by: Jim Schutt <jaschut@sandia.gov>
Signed-off-by: Sage Weil <sage@newdream.net>
---
 net/ceph/messenger.c |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index c340e2e..9918e9e 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2307,6 +2307,7 @@ struct ceph_msg *ceph_msg_new(int type, int front_len, gfp_t flags)
 	m->front_max = front_len;
 	m->front_is_vmalloc = false;
 	m->more_to_follow = false;
+	m->ack_stamp = 0;
 	m->pool = NULL;
 
 	/* middle */
-- 
1.7.0

