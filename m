From: Souptick Joarder <jrdr.linux@gmail.com>
Subject: [PATCH] fs/ceph/addr.c: Convert to use vmf_error()
Date: Sat, 5 Jan 2019 01:00:29 +0530
Message-ID: <20190104193029.GA15903@jordon-HP-15-Notebook-PC>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
To: zyan@redhat.com, sage@redhat.com, idryomov@gmail.com
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, willy@infradead.org
List-Id: ceph-devel.vger.kernel.org

This code is converted to use vmf_error().

Signed-off-by: Souptick Joarder <jrdr.linux@gmail.com>
---
 fs/ceph/addr.c | 5 +----
 1 file changed, 1 insertion(+), 4 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 8eade7a..fa2a85d 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1495,10 +1495,7 @@ static vm_fault_t ceph_filemap_fault(struct vm_fault *vmf)
 		if (err < 0 || off >= i_size_read(inode)) {
 			unlock_page(page);
 			put_page(page);
-			if (err == -ENOMEM)
-				ret = VM_FAULT_OOM;
-			else
-				ret = VM_FAULT_SIGBUS;
+			ret = vmf_error(err);
 			goto out_inline;
 		}
 		if (err < PAGE_SIZE)
-- 
1.9.1
