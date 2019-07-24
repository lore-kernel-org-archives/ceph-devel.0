From: john.hubbard@gmail.com
Subject: [PATCH 11/12] 9p/net: convert put_page() to put_user_page*()
Date: Tue, 23 Jul 2019 21:25:17 -0700
Message-ID: <20190724042518.14363-12-jhubbard@nvidia.com>
References: <20190724042518.14363-1-jhubbard@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190724042518.14363-1-jhubbard@nvidia.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Anna Schumaker <anna.schumaker@netapp.com>, "David S . Miller" <davem@davemloft.net>, Dominique Martinet <asmadeus@codewreck.org>, Eric Van Hensbergen <ericvh@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>, Latchesar Ionkov <lucho@ionkov.net>, "Michael S . Tsirkin" <mst@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Trond Myklebust <trond.myklebust@hammerspace.com>, Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, ceph-devel@vger.kernel.org, kvm@vger.kernel.org, linux-block@vger.kernel.org, linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.orglinu
List-Id: ceph-devel.vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

For pages that were retained via get_user_pages*(), release those pages
via the new put_user_page*() routines, instead of via put_page().

This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
("mm: introduce put_user_page*(), placeholder versions").

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-block@vger.kernel.org
Cc: linux-mm@kvack.org
Cc: v9fs-developer@lists.sourceforge.net
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
Cc: Boaz Harrosh <boaz@plexistor.com>
Cc: Eric Van Hensbergen <ericvh@gmail.com>
Cc: Latchesar Ionkov <lucho@ionkov.net>
Cc: Dominique Martinet <asmadeus@codewreck.org>
---
 net/9p/trans_common.c | 14 ++++++++++----
 net/9p/trans_common.h |  3 ++-
 net/9p/trans_virtio.c | 18 +++++++++++++-----
 3 files changed, 25 insertions(+), 10 deletions(-)

diff --git a/net/9p/trans_common.c b/net/9p/trans_common.c
index 3dff68f05fb9..e5c359c369a6 100644
--- a/net/9p/trans_common.c
+++ b/net/9p/trans_common.c
@@ -19,12 +19,18 @@
 /**
  *  p9_release_pages - Release pages after the transaction.
  */
-void p9_release_pages(struct page **pages, int nr_pages)
+void p9_release_pages(struct page **pages, int nr_pages, bool from_gup)
 {
 	int i;
 
-	for (i = 0; i < nr_pages; i++)
-		if (pages[i])
-			put_page(pages[i]);
+	if (from_gup) {
+		for (i = 0; i < nr_pages; i++)
+			if (pages[i])
+				put_user_page(pages[i]);
+	} else {
+		for (i = 0; i < nr_pages; i++)
+			if (pages[i])
+				put_page(pages[i]);
+	}
 }
 EXPORT_SYMBOL(p9_release_pages);
diff --git a/net/9p/trans_common.h b/net/9p/trans_common.h
index c43babb3f635..dcf025867314 100644
--- a/net/9p/trans_common.h
+++ b/net/9p/trans_common.h
@@ -12,4 +12,5 @@
  *
  */
 
-void p9_release_pages(struct page **, int);
+void p9_release_pages(struct page **pages, int nr_pages, bool from_gup);
+
diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index a3cd90a74012..3714ca5ecdc2 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -306,11 +306,14 @@ static int p9_get_mapped_pages(struct virtio_chan *chan,
 			       struct iov_iter *data,
 			       int count,
 			       size_t *offs,
-			       int *need_drop)
+			       int *need_drop,
+			       bool *from_gup)
 {
 	int nr_pages;
 	int err;
 
+	*from_gup = false;
+
 	if (!iov_iter_count(data))
 		return 0;
 
@@ -332,6 +335,7 @@ static int p9_get_mapped_pages(struct virtio_chan *chan,
 		*need_drop = 1;
 		nr_pages = DIV_ROUND_UP(n + *offs, PAGE_SIZE);
 		atomic_add(nr_pages, &vp_pinned);
+		*from_gup = iov_iter_get_pages_use_gup(data);
 		return n;
 	} else {
 		/* kernel buffer, no need to pin pages */
@@ -397,13 +401,15 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 	size_t offs;
 	int need_drop = 0;
 	int kicked = 0;
+	bool in_from_gup, out_from_gup;
 
 	p9_debug(P9_DEBUG_TRANS, "virtio request\n");
 
 	if (uodata) {
 		__le32 sz;
 		int n = p9_get_mapped_pages(chan, &out_pages, uodata,
-					    outlen, &offs, &need_drop);
+					    outlen, &offs, &need_drop,
+					    &out_from_gup);
 		if (n < 0) {
 			err = n;
 			goto err_out;
@@ -422,7 +428,8 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 		memcpy(&req->tc.sdata[0], &sz, sizeof(sz));
 	} else if (uidata) {
 		int n = p9_get_mapped_pages(chan, &in_pages, uidata,
-					    inlen, &offs, &need_drop);
+					    inlen, &offs, &need_drop,
+					    &in_from_gup);
 		if (n < 0) {
 			err = n;
 			goto err_out;
@@ -504,11 +511,12 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 err_out:
 	if (need_drop) {
 		if (in_pages) {
-			p9_release_pages(in_pages, in_nr_pages);
+			p9_release_pages(in_pages, in_nr_pages, in_from_gup);
 			atomic_sub(in_nr_pages, &vp_pinned);
 		}
 		if (out_pages) {
-			p9_release_pages(out_pages, out_nr_pages);
+			p9_release_pages(out_pages, out_nr_pages,
+					 out_from_gup);
 			atomic_sub(out_nr_pages, &vp_pinned);
 		}
 		/* wakeup anybody waiting for slots to pin pages */
-- 
2.22.0
