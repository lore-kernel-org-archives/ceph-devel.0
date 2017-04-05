From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 1/5] ceph: fix wrong check in ceph_renew_caps()
Date: Wed,  5 Apr 2017 09:30:15 +0800
Message-ID: <20170405013019.5032-1-zyan@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:34694 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753857AbdDEBaa (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 4 Apr 2017 21:30:30 -0400
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 6A51780474
        for <ceph-devel@vger.kernel.org>; Wed,  5 Apr 2017 01:30:30 +0000 (UTC)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: jlayton@redhat.com, "Yan, Zheng" <zyan@redhat.com>

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 579a16c..0480492 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -123,7 +123,7 @@ int ceph_renew_caps(struct inode *inode)
 	spin_lock(&ci->i_ceph_lock);
 	wanted = __ceph_caps_file_wanted(ci);
 	if (__ceph_is_any_real_caps(ci) &&
-	    (!(wanted & CEPH_CAP_ANY_WR) == 0 || ci->i_auth_cap)) {
+	    (!(wanted & CEPH_CAP_ANY_WR) || ci->i_auth_cap)) {
 		int issued = __ceph_caps_issued(ci, NULL);
 		spin_unlock(&ci->i_ceph_lock);
 		dout("renew caps %p want %s issued %s updating mds_wanted\n",
-- 
2.9.3

