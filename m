From: Noah Watkins <noahwatkins@gmail.com>
Subject: [PATCH 2/2] ceph: fix memory leak
Date: Mon, 22 Aug 2011 13:49:41 -0600
Message-ID: <CAB2gnbWqq4qDh0qmK8tC1-q5KY2H0rf_fNX_kVcFUEM6ZhYo5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: ceph-devel@vger.kernel.org
Cc: LKML <linux-kernel@vger.kernel.org>, sage@newdream.net, noahwatkins@gmail.com
List-Id: ceph-devel.vger.kernel.org

kfree does not clean up indirect allocations in
ceph_fs_client and ceph_options (e.g. snapdir_name).

Signed-off-by: Noah Watkins <noahwatkins@gmail.com>
---
 fs/ceph/super.c |    4 ++--
 1 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 733674d..788f5ad 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -824,8 +824,8 @@ static struct dentry *ceph_mount(struct
file_system_type *fs_type,
 	fsc = create_fs_client(fsopt, opt);
 	if (IS_ERR(fsc)) {
 		res = ERR_CAST(fsc);
-		kfree(fsopt);
-		kfree(opt);
+		destroy_mount_options(fsopt);
+		ceph_destroy_options(opt);
 		goto out_final;
 	}

-- 
1.7.6
