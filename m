From: xiubli@redhat.com
Subject: [PATCH] ceph: fix use-after-free for fsc->mdsc
Date: Thu, 23 Jul 2020 15:32:25 +0800
Message-ID: <20200723073225.340115-1-xiubli@redhat.com>
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:44611 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725911AbgGWHnj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 23 Jul 2020 03:43:39 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: jlayton@kernel.org
Cc: idryomov@gmail.com, zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org, Xiubo Li <xiubli@redhat.com>

From: Xiubo Li <xiubli@redhat.com>

If the ceph_mdsc_init() fails, it will free the mdsc already.

Reported-by: syzbot+b57f46d8d6ea51960b8c@syzkaller.appspotmail.com
URL: https://tracker.ceph.com/issues/46684
Signed-off-by: Xiubo Li <xiubli@redhat.com>
---
 fs/ceph/mds_client.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index af7221d1c610..590822fab767 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -4453,7 +4453,6 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
 		goto err_mdsc;
 	}
 
-	fsc->mdsc = mdsc;
 	init_completion(&mdsc->safe_umount_waiters);
 	init_waitqueue_head(&mdsc->session_close_wq);
 	INIT_LIST_HEAD(&mdsc->waiting_for_map);
@@ -4508,6 +4507,8 @@ int ceph_mdsc_init(struct ceph_fs_client *fsc)
 
 	strscpy(mdsc->nodename, utsname()->nodename,
 		sizeof(mdsc->nodename));
+
+	fsc->mdsc = mdsc;
 	return 0;
 
 err_mdsmap:
-- 
2.18.4
