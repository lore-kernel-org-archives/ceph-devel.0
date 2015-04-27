From: Alex Elder <elder@linaro.org>
Subject: [PATCH 1/7] messenger: update state diagram
Date: Mon, 27 Apr 2015 12:13:09 -0500
Message-ID: <1430154795-17123-2-git-send-email-elder@linaro.org>
References: <1430154795-17123-1-git-send-email-elder@linaro.org>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f177.google.com ([209.85.192.177]:35966 "EHLO
	mail-pd0-f177.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753467AbbD0RNU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 Apr 2015 13:13:20 -0400
Received: by pdea3 with SMTP id a3so134950557pde.3
        for <ceph-devel@vger.kernel.org>; Mon, 27 Apr 2015 10:13:20 -0700 (PDT)
Received: from shibby.corp.google.com ([104.135.1.105])
        by mx.google.com with ESMTPSA id ff10sm12124675pab.13.2015.04.27.10.13.19
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-SHA bits=128/128);
        Mon, 27 Apr 2015 10:13:19 -0700 (PDT)
In-Reply-To: <1430154795-17123-1-git-send-email-elder@linaro.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Update the fabulous state diagram in "messenger.c" to reflect the
way the code operates.  Two new transitions are added:

    CLOSED -> CLOSED
    CLOSING -> CLOSING

Signed-off-by: Alex Elder <elder@linaro.org>
---
 net/ceph/messenger.c | 51 +++++++++++++++++++++++++--------------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
index 967080a..9dfdb20 100644
--- a/net/ceph/messenger.c
+++ b/net/ceph/messenger.c
@@ -46,32 +46,31 @@
  *          | con_sock_state_init()
  *          v
  *      ----------
- *      | CLOSED |  initialized, but no socket (and no
- *      ----------  TCP connection)
- *       ^      \
- *       |       \ con_sock_state_connecting()
- *       |        ----------------------
- *       |                              \
- *       + con_sock_state_closed()       \
- *       |+---------------------------    \
- *       | \                          \    \
- *       |  -----------                \    \
- *       |  | CLOSING |  socket event;  \    \
- *       |  -----------  await close     \    \
- *       |       ^                        \   |
- *       |       |                         \  |
- *       |       + con_sock_state_closing() \ |
- *       |      / \                         | |
- *       |     /   ---------------          | |
- *       |    /                   \         v v
- *       |   /                    --------------
- *       |  /    -----------------| CONNECTING |  socket created, TCP
- *       |  |   /                 --------------  connect initiated
- *       |  |   | con_sock_state_connected()
- *       |  |   v
- *      -------------
- *      | CONNECTED |  TCP connection established
- *      -------------
+ *      | CLOSED |  initialized, but no socket (and no TCP connection)
+ *      ----------
+ *       ^   \  \  con_sock_state_connecting()
+ *       |   /   ------------------------
+ *       +<--                            \
+ *       |\  cen_sock_state_closed()      \
+ *       | +<--------------------------    \
+ *       |  \                          \    \
+ *       | -----------                  \    \
+ *       | | CLOSING |  socket event;    \    \
+ *       | -----------  await close       \    \
+ *       |    /   ^                        \    \
+ *       |    \   |                         \   |
+ *       |     -->+ con_sock_state_closing() \  |
+ *       |       / \                         |  |
+ *       |      /   ----------------------   |  |
+ *       |     /                          \  |  v
+ *       |    /                        --------------
+ *       |   /    ---------------------| CONNECTING |  socket created, TCP
+ *       |   |   /                     --------------  connect initiated
+ *       |   |   | con_sock_state_connected()
+ *       |   |   v
+ *     -------------
+ *     | CONNECTED |  TCP connection established
+ *     -------------
  *
  * State values for ceph_connection->sock_state; NEW is assumed to be 0.
  */
-- 
2.1.0

