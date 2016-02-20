From: Ilya Dryomov <idryomov@gmail.com>
Subject: [PATCH 3/4] libceph: don't spam dmesg with stray reply warnings
Date: Sat, 20 Feb 2016 17:45:28 +0100
Message-ID: <1455986729-12544-4-git-send-email-idryomov@gmail.com>
References: <1455986729-12544-1-git-send-email-idryomov@gmail.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f41.google.com ([74.125.82.41]:35609 "EHLO
	mail-wm0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757849AbcBTQp5 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 20 Feb 2016 11:45:57 -0500
Received: by mail-wm0-f41.google.com with SMTP id c200so116208809wme.0
        for <ceph-devel@vger.kernel.org>; Sat, 20 Feb 2016 08:45:57 -0800 (PST)
In-Reply-To: <1455986729-12544-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Varada Kari <Varada.Kari@sandisk.com>

Commit d15f9d694b77 ("libceph: check data_len in ->alloc_msg()")
mistakenly bumped the log level on the "tid %llu unknown, skipping"
message.  Turn it back into a dout() - stray replies are perfectly
normal when OSDs flap, crash, get killed for testing purposes, etc.

Cc: stable@vger.kernel.org # 4.3+
Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
---
 net/ceph/osd_client.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 7c1a5d1734c3..32355d9d0103 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -2890,8 +2890,8 @@ static struct ceph_msg *get_reply(struct ceph_connection *con,
 	mutex_lock(&osdc->request_mutex);
 	req = __lookup_request(osdc, tid);
 	if (!req) {
-		pr_warn("%s osd%d tid %llu unknown, skipping\n",
-			__func__, osd->o_osd, tid);
+		dout("%s osd%d tid %llu unknown, skipping\n", __func__,
+		     osd->o_osd, tid);
 		m = NULL;
 		*skip = 1;
 		goto out;
-- 
2.4.3

