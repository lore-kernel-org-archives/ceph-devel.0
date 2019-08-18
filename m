From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH v8 15/20] fs: ceph: Initialize filesystem timestamp ranges
Date: Sun, 18 Aug 2019 09:58:12 -0700
Message-ID: <20190818165817.32634-16-deepa.kernel@gmail.com>
References: <20190818165817.32634-1-deepa.kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190818165817.32634-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, y2038@lists.linaro.org, arnd@arndb.de, zyan@redhat.com, sage@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Fill in the appropriate limits to avoid inconsistencies
in the vfs cached inode times when timestamps are
outside the permitted range.

According to the disscussion in
https://patchwork.kernel.org/patch/8308691/ we agreed to use
unsigned 32 bit timestamps on ceph.
Update the limits accordingly.

Signed-off-by: Deepa Dinamani <deepa.kernel@gmail.com>
Cc: zyan@redhat.com
Cc: sage@redhat.com
Cc: idryomov@gmail.com
Cc: ceph-devel@vger.kernel.org
---
 fs/ceph/super.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/fs/ceph/super.c b/fs/ceph/super.c
index 4406ec7018bb..2aa052b7bda7 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -907,6 +907,8 @@ static int ceph_set_super(struct super_block *s, struct fs_context *fc)
 	s->s_export_op = &ceph_export_ops;
 
 	s->s_time_gran = 1;
+	s->s_time_min = 0;
+	s->s_time_max = U32_MAX;
 
 	ret = set_anon_super_fc(s, fc);
 	if (ret != 0)
-- 
2.17.1
