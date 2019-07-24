From: john.hubbard@gmail.com
Subject: [PATCH 04/12] block: bio_release_pages: convert put_page() to put_user_page*()
Date: Tue, 23 Jul 2019 21:25:10 -0700
Message-ID: <20190724042518.14363-5-jhubbard@nvidia.com>
References: <20190724042518.14363-1-jhubbard@nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20190724042518.14363-1-jhubbard@nvidia.com>
Sender: netdev-owner@vger.kernel.org
To: Andrew Morton <akpm@linux-foundation.org>
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Anna Schumaker <anna.schumaker@netapp.com>, "David S . Miller" <davem@davemloft.net>, Dominique Martinet <asmadeus@codewreck.org>, Eric Van Hensbergen <ericvh@gmail.com>, Jason Gunthorpe <jgg@ziepe.ca>, Jason Wang <jasowang@redhat.com>, Jens Axboe <axboe@kernel.dk>, Latchesar Ionkov <lucho@ionkov.net>, "Michael S . Tsirkin" <mst@redhat.com>, Miklos Szeredi <miklos@szeredi.hu>, Trond Myklebust <trond.myklebust@hammerspace.com>, Christoph Hellwig <hch@lst.de>, Matthew Wilcox <willy@infradead.org>, linux-mm@kvack.org, LKML <linux-kernel@vger.kernel.org>, ceph-devel@vger.kernel.org, kvm@vger.kernel.org, linux-block@vger.kernel.org, linux-cifs@vger.kernel.org, linux-fsdevel@vger.kernel.org, linux-nfs@vger.kernel.orglinu
List-Id: ceph-devel.vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

For pages that were retained via get_user_pages*(), release those pages
via the new put_user_page*() routines, instead of via put_page() or
release_pages().

This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
("mm: introduce put_user_page*(), placeholder versions").

Changes from Jérôme's original patch:
    * reworked to be compatible with recent bio_release_pages() changes,
    * refactored slightly to remove some code duplication,
    * use an approach that changes fewer bio_check_pages_dirty()
      callers.

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Cc: Christoph Hellwig <hch@infradead.org>
Cc: Minwoo Im <minwoo.im.dev@gmail.com>
Cc: Jens Axboe <axboe@kernel.dk>
---
 block/bio.c         | 60 ++++++++++++++++++++++++++++++++++++---------
 include/linux/bio.h |  1 +
 2 files changed, 49 insertions(+), 12 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 7675e2de509d..74f9eba2583b 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -844,7 +844,11 @@ void bio_release_pages(struct bio *bio, enum bio_rp_flags_t flags)
 	bio_for_each_segment_all(bvec, bio, iter_all) {
 		if ((flags & BIO_RP_MARK_DIRTY) && !PageCompound(bvec->bv_page))
 			set_page_dirty_lock(bvec->bv_page);
-		put_page(bvec->bv_page);
+
+		if (flags & BIO_RP_FROM_GUP)
+			put_user_page(bvec->bv_page);
+		else
+			put_page(bvec->bv_page);
 	}
 }
 
@@ -1667,28 +1671,50 @@ static void bio_dirty_fn(struct work_struct *work);
 static DECLARE_WORK(bio_dirty_work, bio_dirty_fn);
 static DEFINE_SPINLOCK(bio_dirty_lock);
 static struct bio *bio_dirty_list;
+static struct bio *bio_gup_dirty_list;
 
-/*
- * This runs in process context
- */
-static void bio_dirty_fn(struct work_struct *work)
+static void __bio_dirty_fn(struct work_struct *work,
+			   struct bio **dirty_list,
+			   enum bio_rp_flags_t flags)
 {
 	struct bio *bio, *next;
 
 	spin_lock_irq(&bio_dirty_lock);
-	next = bio_dirty_list;
-	bio_dirty_list = NULL;
+	next = *dirty_list;
+	*dirty_list = NULL;
 	spin_unlock_irq(&bio_dirty_lock);
 
 	while ((bio = next) != NULL) {
 		next = bio->bi_private;
 
-		bio_release_pages(bio, BIO_RP_MARK_DIRTY);
+		bio_release_pages(bio, BIO_RP_MARK_DIRTY | flags);
 		bio_put(bio);
 	}
 }
 
-void bio_check_pages_dirty(struct bio *bio)
+/*
+ * This runs in process context
+ */
+static void bio_dirty_fn(struct work_struct *work)
+{
+	__bio_dirty_fn(work, &bio_dirty_list,     BIO_RP_NORMAL);
+	__bio_dirty_fn(work, &bio_gup_dirty_list, BIO_RP_FROM_GUP);
+}
+
+/**
+ * __bio_check_pages_dirty() - queue up pages on a workqueue to dirty them
+ * @bio: the bio struct containing the pages we should dirty
+ * @from_gup: did the pages in the bio came from GUP (get_user_pages*())
+ *
+ * This will go over all pages in the bio, and for each non dirty page, the
+ * bio is added to a list of bio's that need to get their pages dirtied.
+ *
+ * We also need to know if the pages in the bio are coming from GUP or not,
+ * as GUPed pages need to be released via put_user_page(), instead of
+ * put_page(). Please see Documentation/vm/get_user_pages.rst for details
+ * on that.
+ */
+void __bio_check_pages_dirty(struct bio *bio, bool from_gup)
 {
 	struct bio_vec *bvec;
 	unsigned long flags;
@@ -1699,17 +1725,27 @@ void bio_check_pages_dirty(struct bio *bio)
 			goto defer;
 	}
 
-	bio_release_pages(bio, BIO_RP_NORMAL);
+	bio_release_pages(bio, from_gup ? BIO_RP_FROM_GUP : BIO_RP_NORMAL);
 	bio_put(bio);
 	return;
 defer:
 	spin_lock_irqsave(&bio_dirty_lock, flags);
-	bio->bi_private = bio_dirty_list;
-	bio_dirty_list = bio;
+	if (from_gup) {
+		bio->bi_private = bio_gup_dirty_list;
+		bio_gup_dirty_list = bio;
+	} else {
+		bio->bi_private = bio_dirty_list;
+		bio_dirty_list = bio;
+	}
 	spin_unlock_irqrestore(&bio_dirty_lock, flags);
 	schedule_work(&bio_dirty_work);
 }
 
+void bio_check_pages_dirty(struct bio *bio)
+{
+	__bio_check_pages_dirty(bio, false);
+}
+
 void update_io_ticks(struct hd_struct *part, unsigned long now)
 {
 	unsigned long stamp;
diff --git a/include/linux/bio.h b/include/linux/bio.h
index 2715e55679c1..d68a40c2c9d4 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -444,6 +444,7 @@ int bio_iov_iter_get_pages(struct bio *bio, struct iov_iter *iter);
 enum bio_rp_flags_t {
 	BIO_RP_NORMAL		= 0,
 	BIO_RP_MARK_DIRTY	= 1,
+	BIO_RP_FROM_GUP		= 2,
 };
 
 static inline enum bio_rp_flags_t bio_rp_dirty_flag(bool mark_dirty)
-- 
2.22.0
