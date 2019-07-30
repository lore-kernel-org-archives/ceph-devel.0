From: Deepa Dinamani <deepa.kernel@gmail.com>
Subject: [PATCH 15/20] fs: ceph: Initialize filesystem timestamp ranges
Date: Mon, 29 Jul 2019 18:49:19 -0700
Message-ID: <20190730014924.2193-16-deepa.kernel@gmail.com>
References: <20190730014924.2193-1-deepa.kernel@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190730014924.2193-1-deepa.kernel@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
To: viro@zeniv.linux.org.uk, linux-kernel@vger.kernel.org
Cc: linux-fsdevel@vger.kernel.org, arnd@arndb.de, y2038@lists.linaro.org, zyan@redhat.com, sage@redhat.com, idryomov@gmail.com, ceph-devel@vger.kernel.org
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
index d57fa60dcd43..6cf3a4fceac1 100644
--- a/fs/ceph/super.c
+++ b/fs/ceph/super.c
@@ -981,6 +981,8 @@ static int ceph_set_super(struct super_block *s, void *data)
 	s->s_export_op = &ceph_export_ops;
 
 	s->s_time_gran = 1000;  /* 1000 ns == 1 us */
+	s->s_time_min = 0;
+	s->s_time_max = U32_MAX;
 
 	ret = set_anon_super(s, NULL);  /* what is that second arg for? */
 	if (ret != 0)
-- 
2.17.1
