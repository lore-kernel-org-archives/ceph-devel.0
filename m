From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: [PATCH 19/19] crush: fix crush_choose_firstn comment
Date: Mon, 23 Dec 2013 19:09:50 +0200
Message-ID: <1387818590-30483-20-git-send-email-ilya.dryomov@inktank.com>
References: <1387818590-30483-1-git-send-email-ilya.dryomov@inktank.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f53.google.com ([74.125.83.53]:33870 "EHLO
	mail-ee0-f53.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757723Ab3LWRLQ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 23 Dec 2013 12:11:16 -0500
Received: by mail-ee0-f53.google.com with SMTP id b57so2481878eek.12
        for <ceph-devel@vger.kernel.org>; Mon, 23 Dec 2013 09:11:15 -0800 (PST)
In-Reply-To: <1387818590-30483-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Sage Weil <sage@inktank.com>, ilya.dryomov@inktank.com

Reflects ceph.git commit 8b38f10bc2ee3643a33ea5f9545ad5c00e4ac5b4.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/crush/mapper.c |    6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/net/ceph/crush/mapper.c b/net/ceph/crush/mapper.c
index 71ce4f12a7c9..b703790b4e44 100644
--- a/net/ceph/crush/mapper.c
+++ b/net/ceph/crush/mapper.c
@@ -290,7 +290,11 @@ static int is_out(const struct crush_map *map,
  * @type: the type of item to choose
  * @out: pointer to output vector
  * @outpos: our position in that vector
- * @recurse_to_leaf: true if we want one device under each item of given type
+ * @tries: number of attempts to make
+ * @recurse_tries: number of attempts to have recursive chooseleaf make
+ * @local_tries: localized retries
+ * @local_fallback_tries: localized fallback retries
+ * @recurse_to_leaf: true if we want one device under each item of given type (chooseleaf instead of choose)
  * @out2: second output vector for leaf items (if @recurse_to_leaf)
  */
 static int crush_choose_firstn(const struct crush_map *map,
-- 
1.7.10.4

