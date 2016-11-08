From: Zhi Zhang <zhang.david2011@gmail.com>
Subject: [PATCH] ceph: fix printing wrong return variable in ceph_direct_read_write()
Date: Tue, 8 Nov 2016 17:16:24 +0800
Message-ID: <CAGkCoNJ3ie=5artOKOnNdtpx=gj=jvA26SS2XVzLBg644Zui=A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Zheng Yan <zyan@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Fix printing wrong return variable for invalidate_inode_pages2_range
in ceph_direct_read_write().

Signed-off-by: Zhi Zhang <zhang.david2011@gmail.com>
---
 fs/ceph/file.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 18630e8..0136195 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -906,7 +906,7 @@ void ceph_sync_write_wait(struct inode *inode)
                                        pos >> PAGE_SHIFT,
                                        (pos + count) >> PAGE_SHIFT);
                if (ret2 < 0)
-                       dout("invalidate_inode_pages2_range returned
%d\n", ret);
+                       dout("invalidate_inode_pages2_range returned
%d\n", ret2);

                flags = CEPH_OSD_FLAG_ORDERSNAP |
                        CEPH_OSD_FLAG_ONDISK |


Regards,
Zhi Zhang (David)
Contact: zhang.david2011@gmail.com
              zhangz.david@outlook.com
