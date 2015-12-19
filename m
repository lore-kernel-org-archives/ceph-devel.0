From: Minfei Huang <mnfhuang@gmail.com>
Subject: [PATCH] ceph: Avoid to propagate the invalid page point
Date: Sat, 19 Dec 2015 10:54:59 +0800
Message-ID: <1450493699-20983-1-git-send-email-mnfhuang@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, mhuang@redhat.com, Minfei Huang <mnfhuang@gmail.com>
List-Id: ceph-devel.vger.kernel.org

The variant pagep will still get the invalid page point, although ceph
fails in function ceph_update_writeable_page.

To fix this issue, Assigne the page to pagep until there is no failure
in function ceph_update_writeable_page.

Signed-off-by: Minfei Huang <mnfhuang@gmail.com>
---
 fs/ceph/addr.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index b7d218a..6491079 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1149,7 +1149,6 @@ static int ceph_write_begin(struct file *file, struct address_space *mapping,
 		page = grab_cache_page_write_begin(mapping, index, 0);
 		if (!page)
 			return -ENOMEM;
-		*pagep = page;
 
 		dout("write_begin file %p inode %p page %p %d~%d\n", file,
 		     inode, page, (int)pos, (int)len);
-- 
2.6.3
