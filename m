From: jglisse@redhat.com
Subject: [PATCH v1 14/15] fs: use bvec_set_gup_page() where appropriate
Date: Thu, 11 Apr 2019 17:08:33 -0400
Message-ID: <20190411210834.4105-15-jglisse@redhat.com>
References: <20190411210834.4105-1-jglisse@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190411210834.4105-1-jglisse@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Johannes Thumshirn <jthumshirn@suse.de>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>, Dave Chinner <david@fromorbit.com>, Jason Gunthorpe <jgg@ziepe.ca>, Matthew Wilcox <willy@infradead.org>, Steve French <sfrench@samba.org>, linux-cifs@vger.kernel.org, samba-technical@lists.samba.org, Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>, Alex Elder <elder@kernel.org>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

When we get a page reference through get_user_page*() we want to keep
track of that and bvec now has the ability to do so. Convert code to
use bvec_set_gup_page() where appropriate.

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-block@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: John Hubbard <jhubbard@nvidia.com>
Cc: Jan Kara <jack@suse.cz>
Cc: Dan Williams <dan.j.williams@intel.com>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>
Cc: Johannes Thumshirn <jthumshirn@suse.de>
Cc: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>
Cc: Ming Lei <ming.lei@redhat.com>
Cc: Dave Chinner <david@fromorbit.com>
Cc: Jason Gunthorpe <jgg@ziepe.ca>
Cc: Matthew Wilcox <willy@infradead.org>
Cc: Steve French <sfrench@samba.org>
Cc: linux-cifs@vger.kernel.org
Cc: samba-technical@lists.samba.org
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: Sage Weil <sage@redhat.com>
Cc: Alex Elder <elder@kernel.org>
Cc: ceph-devel@vger.kernel.org
---
 fs/ceph/file.c | 3 +++
 fs/cifs/misc.c | 6 +++++-
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index d5561662b902..6c5b85f01721 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -104,6 +104,9 @@ static ssize_t __iter_get_bvecs(struct iov_iter *iter, size_t maxsize,
 				min_t(int, bytes, PAGE_SIZE - start),
 				start);
 
+			/* Is iov_iter_get_pages() using GUP ? */
+			if (iov_iter_get_pages_use_gup(iter))
+				bvec_set_gup_page(&bv, pages[idx]);
 			bvecs[bvec_idx] = bv;
 			bytes -= bv.bv_len;
 			start = 0;
diff --git a/fs/cifs/misc.c b/fs/cifs/misc.c
index bc77a4a5f1af..e10d9f0f5874 100644
--- a/fs/cifs/misc.c
+++ b/fs/cifs/misc.c
@@ -883,7 +883,11 @@ setup_aio_ctx_iter(struct cifs_aio_ctx *ctx, struct iov_iter *iter, int rw)
 
 		for (i = 0; i < cur_npages; i++) {
 			len = rc > PAGE_SIZE ? PAGE_SIZE : rc;
-			bvec_set_page(&bv[npages + i], pages[i]);
+			/* Is iov_iter_get_pages() using GUP ? */
+			if (iov_iter_get_pages_use_gup(iter))
+				bvec_set_gup_page(&bv[npages + i], pages[i]);
+			else
+				bvec_set_page(&bv[npages + i], pages[i]);
 			bv[npages + i].bv_offset = start;
 			bv[npages + i].bv_len = len - start;
 			rc -= len;
-- 
2.20.1
