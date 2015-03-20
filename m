From: Taesoo Kim <tsgatesv@gmail.com>
Subject: [PATCH 1/1] ceph: properly release page upon error
Date: Fri, 20 Mar 2015 17:36:56 -0400
Message-ID: <1426887416-27312-1-git-send-email-tsgatesv@gmail.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: zyan@redhat.com, sage@redhat.com, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
Cc: taesoo@gatech.edu, changwoo@gatech.edu, sanidhya@gatech.edu, blee@gatech.edu, csong84@gatech.edu, Taesoo Kim <tsgatesv@gmail.com>
List-Id: ceph-devel.vger.kernel.org

When ceph_update_writeable_page fails (including -EAGAIN), it
unlocks (w/ unlock_page) the page but does not 'release'
(w/ page_cache_release) properly.

Upon error, properly set *pagep to NULL, indicating an error.

Signed-off-by: Taesoo Kim <tsgatesv@gmail.com>
---
 fs/ceph/addr.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index fd5599d..89091e3 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1146,6 +1146,10 @@ static int ceph_write_begin(struct file *file, struct address_space *mapping,
 		     inode, page, (int)pos, (int)len);
 
 		r = ceph_update_writeable_page(file, pos, len, page);
+		if (r) {
+			page_cache_release(page);
+			*pagep = NULL;
+		}
 	} while (r == -EAGAIN);
 
 	return r;
-- 
2.3.3
