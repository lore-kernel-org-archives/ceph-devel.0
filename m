From: Wei Yongjun <weiyj.lk@gmail.com>
Subject: [PATCH -next] ceph: use list_move instead of list_del/list_add
Date: Sat, 13 Aug 2016 09:10:28 +0000
Message-ID: <1471079428-9951-1-git-send-email-weiyj.lk@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f68.google.com ([209.85.220.68]:36263 "EHLO
	mail-pa0-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751299AbcHMJKf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 13 Aug 2016 05:10:35 -0400
Received: by mail-pa0-f68.google.com with SMTP id ez1so658012pab.3
        for <ceph-devel@vger.kernel.org>; Sat, 13 Aug 2016 02:10:35 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yan Zheng <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: Wei Yongjun <weiyj.lk@gmail.com>, ceph-devel@vger.kernel.org

Using list_move() instead of list_del() + list_add().

Signed-off-by: Wei Yongjun <weiyj.lk@gmail.com>
---
 fs/ceph/mds_client.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index f72d4ae..d55df51 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -1150,8 +1150,7 @@ static int remove_session_caps_cb(struct inode *inode, struct ceph_cap *cap,
 		while (!list_empty(&ci->i_cap_flush_list)) {
 			cf = list_first_entry(&ci->i_cap_flush_list,
 					      struct ceph_cap_flush, i_list);
-			list_del(&cf->i_list);
-			list_add(&cf->i_list, &to_remove);
+			list_move(&cf->i_list, &to_remove);
 		}
 
 		spin_lock(&mdsc->cap_dirty_lock);



