From: Alex Elder <elder@linaro.org>
Subject: [PATCH 2/7] messenger: add some clarifying comments
Date: Mon, 27 Apr 2015 12:13:10 -0500
Message-ID: <1430154795-17123-3-git-send-email-elder@linaro.org>
References: <1430154795-17123-1-git-send-email-elder@linaro.org>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f178.google.com ([209.85.192.178]:35372 "EHLO
	mail-pd0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753470AbbD0RNV (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Apr 2015 13:13:21 -0400
Received: by pdbqd1 with SMTP id qd1so134961682pdb.2
        for <ceph-devel@vger.kernel.org>; Mon, 27 Apr 2015 10:13:21 -0700 (PDT)
Received: from shibby.corp.google.com ([104.135.1.105])
        by mx.google.com with ESMTPSA id ff10sm12124675pab.13.2015.04.27.10.13.20
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Apr 2015 10:13:20 -0700 (PDT)
In-Reply-To: <1430154795-17123-1-git-send-email-elder@linaro.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

In con_sock_closed() we test *and* clear the socket closed connection
flag.  It's not immediately obvious why the flag needs to be cleared.
Add a comment so that's a little clearer.

Similarly, we only want to do backoff processing once each time the
backoff flag is set.  Add a comment about that as well.

Signed-off-by: Alex Elder <elder@linaro.org>
---
 net/ceph/messenger.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 9dfdb20..37b0fa7 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -2733,6 +2733,10 @@ static void cancel_con(struct ceph_connection *con)
 
 static bool con_sock_closed(struct ceph_connection *con)
 {
+	/*
+	 * We want to handle the event of the socket being
+	 * closed once, so clear the flag in case it is set.
+	 */
 	if (!con_flag_test_and_clear(con, CON_FLAG_SOCK_CLOSED))
 		return false;
 
@@ -2764,6 +2768,11 @@ static bool con_backoff(struct ceph_connection *con)
 {
 	int ret;
 
+	/*
+	 * See if we need to back off.  We only want to do this
+	 * processing once each time the flag is set, so clear the
+	 * flag after it's tested.
+	 */
 	if (!con_flag_test_and_clear(con, CON_FLAG_BACKOFF))
 		return false;
 
-- 
2.1.0

