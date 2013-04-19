From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH -next] ceph: fix printk format warnings in file.c
Date: Fri, 19 Apr 2013 14:20:07 -0700
Message-ID: <5171B507.4030808@infradead.org>
References: <20130419181924.a035efe6d5e73fe0db9ddb84@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Return-path: <linux-next-owner@vger.kernel.org>
In-Reply-To: <20130419181924.a035efe6d5e73fe0db9ddb84@canb.auug.org.au>
Sender: linux-next-owner@vger.kernel.org
To: Stephen Rothwell <sfr@canb.auug.org.au>
Cc: linux-next@vger.kernel.org, linux-kernel@vger.kernel.org, Sage Weil <sage@inktank.com>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

From: Randy Dunlap <rdunlap@infradead.org>

Fix printk format warnings by using %zd for 'ssize_t' variables:

fs/ceph/file.c:751:2: warning: format '%ld' expects argument of type 'long int', but argument 11 has type 'ssize_t' [-Wformat]
fs/ceph/file.c:762:2: warning: format '%ld' expects argument of type 'long int', but argument 11 has type 'ssize_t' [-Wformat]

Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc:	Sage Weil <sage@inktank.com>
Cc:	ceph-devel@vger.kernel.org
---
 fs/ceph/file.c |    4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

--- linux-next-20130419.orig/fs/ceph/file.c
+++ linux-next-20130419/fs/ceph/file.c
@@ -748,7 +748,7 @@ retry_snap:
 		goto out;
 	}
 
-	dout("aio_write %p %llx.%llx %llu~%ld getting caps. i_size %llu\n",
+	dout("aio_write %p %llx.%llx %llu~%zd getting caps. i_size %llu\n",
 	     inode, ceph_vinop(inode), pos, count, inode->i_size);
 	if (fi->fmode & CEPH_FILE_MODE_LAZY)
 		want = CEPH_CAP_FILE_BUFFER | CEPH_CAP_FILE_LAZYIO;
@@ -759,7 +759,7 @@ retry_snap:
 	if (err < 0)
 		goto out;
 
-	dout("aio_write %p %llx.%llx %llu~%ld got cap refs on %s\n",
+	dout("aio_write %p %llx.%llx %llu~%zd got cap refs on %s\n",
 	     inode, ceph_vinop(inode), pos, count, ceph_cap_string(got));
 
 	if ((got & (CEPH_CAP_FILE_BUFFER|CEPH_CAP_FILE_LAZYIO)) == 0 ||
