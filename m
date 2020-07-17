From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] ceph: ceph_features.h: drop duplicated word in a comment
Date: Fri, 17 Jul 2020 16:36:04 -0700
Message-ID: <37c50064-e4ee-d79f-5a9f-2824479b01ca@infradead.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726634AbgGQXgK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Jul 2020 19:36:10 -0400
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: LKML <linux-kernel@vger.kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Drop the doubled word "the" in a comment.

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>
Cc: ceph-devel@vger.kernel.org
---
 include/linux/ceph/ceph_features.h |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- linux-next-20200714.orig/include/linux/ceph/ceph_features.h
+++ linux-next-20200714/include/linux/ceph/ceph_features.h
@@ -58,7 +58,7 @@
  *    because 10.2.z (jewel) did not care if its peers advertised this
  *    feature bit.
  *
- *  - In the second phase we stop advertising the the bit and call it
+ *  - In the second phase we stop advertising the bit and call it
  *    RETIRED.  This can normally be done in the *next* major release
  *    following the one in which we marked the feature DEPRECATED.  In
  *    the above example, for 12.0.z (luminous) we can say:
