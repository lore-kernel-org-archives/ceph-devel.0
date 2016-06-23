From: Colin King <colin.king@canonical.com>
Subject: [PATCH][V2] ceph: fix spelling mistake: "resgister" -> "register"
Date: Thu, 23 Jun 2016 17:04:48 +0100
Message-ID: <1466697888-4888-1-git-send-email-colin.king@canonical.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: zyan@redhat.com, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

From: Colin Ian King <colin.king@canonical.com>

trivial fix to spelling mistake in pr_err message and add newline at
end of message

Signed-off-by: Colin Ian King <colin.king@canonical.com>
---
 fs/ceph/cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/cache.c b/fs/ceph/cache.c
index 238c55b..d0f2b06 100644
--- a/fs/ceph/cache.c
+++ b/fs/ceph/cache.c
@@ -71,7 +71,7 @@ int ceph_fscache_register_fs(struct ceph_fs_client* fsc)
 					      &ceph_fscache_fsid_object_def,
 					      fsc, true);
 	if (!fsc->fscache)
-		pr_err("Unable to resgister fsid: %p fscache cookie", fsc);
+		pr_err("Unable to register fsid: %p fscache cookie\n", fsc);
 
 	return 0;
 }
-- 
2.8.1
