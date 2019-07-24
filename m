From: john.hubbard@gmail.com
Subject: [PATCH 05/12] block_dev: convert put_page() to put_user_page*()
Date: Tue, 23 Jul 2019 21:25:11 -0700
Message-ID: <20190724042518.14363-6-jhubbard@nvidia.com>
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
via the new put_user_page*() routines, instead of via put_page() or
release_pages().

This is part a tree-wide conversion, as described in commit fc1d8e7cca2d
("mm: introduce put_user_page*(), placeholder versions").

Changes from Jérôme's original patch:

* reworked to be compatible with recent bio_release_pages() changes.

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
Cc: linux-fsdevel@vger.kernel.org
Cc: linux-block@vger.kernel.org
Cc: linux-mm@kvack.org
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
---
 block/bio.c         | 13 +++++++++++++
 fs/block_dev.c      | 22 +++++++++++++++++-----
 include/linux/bio.h |  8 ++++++++
 3 files changed, 38 insertions(+), 5 deletions(-)

diff --git a/block/bio.c b/block/bio.c
index 74f9eba2583b..3b9f66e64bc1 100644
--- a/block/bio.c
+++ b/block/bio.c
@@ -1746,6 +1746,19 @@ void bio_check_pages_dirty(struct bio *bio)
 	__bio_check_pages_dirty(bio, false);
 }
 
+enum bio_rp_flags_t bio_rp_flags(struct iov_iter *iter, bool mark_dirty)
+{
+	enum bio_rp_flags_t flags = BIO_RP_NORMAL;
+
+	if (mark_dirty)
+		flags |= BIO_RP_MARK_DIRTY;
+
+	if (iov_iter_get_pages_use_gup(iter))
+		flags |= BIO_RP_FROM_GUP;
+
+	return flags;
+}
+
 void update_io_ticks(struct hd_struct *part, unsigned long now)
 {
 	unsigned long stamp;
diff --git a/fs/block_dev.c b/fs/block_dev.c
index 9fe6616f8788..d53abaf31e54 100644
--- a/fs/block_dev.c
+++ b/fs/block_dev.c
@@ -259,7 +259,7 @@ __blkdev_direct_IO_simple(struct kiocb *iocb, struct iov_iter *iter,
 	}
 	__set_current_state(TASK_RUNNING);
 
-	bio_release_pages(&bio, bio_rp_dirty_flag(should_dirty));
+	bio_release_pages(&bio, bio_rp_flags(iter, should_dirty));
 	if (unlikely(bio.bi_status))
 		ret = blk_status_to_errno(bio.bi_status);
 
@@ -295,7 +295,7 @@ static int blkdev_iopoll(struct kiocb *kiocb, bool wait)
 	return blk_poll(q, READ_ONCE(kiocb->ki_cookie), wait);
 }
 
-static void blkdev_bio_end_io(struct bio *bio)
+static void _blkdev_bio_end_io(struct bio *bio, bool from_gup)
 {
 	struct blkdev_dio *dio = bio->bi_private;
 	bool should_dirty = dio->should_dirty;
@@ -327,13 +327,23 @@ static void blkdev_bio_end_io(struct bio *bio)
 	}
 
 	if (should_dirty) {
-		bio_check_pages_dirty(bio);
+		__bio_check_pages_dirty(bio, from_gup);
 	} else {
-		bio_release_pages(bio, BIO_RP_NORMAL);
+		bio_release_pages(bio, bio_rp_gup_flag(from_gup));
 		bio_put(bio);
 	}
 }
 
+static void blkdev_bio_end_io(struct bio *bio)
+{
+	_blkdev_bio_end_io(bio, false);
+}
+
+static void blkdev_bio_from_gup_end_io(struct bio *bio)
+{
+	_blkdev_bio_end_io(bio, true);
+}
+
 static ssize_t
 __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 {
@@ -380,7 +390,9 @@ __blkdev_direct_IO(struct kiocb *iocb, struct iov_iter *iter, int nr_pages)
 		bio->bi_iter.bi_sector = pos >> 9;
 		bio->bi_write_hint = iocb->ki_hint;
 		bio->bi_private = dio;
-		bio->bi_end_io = blkdev_bio_end_io;
+		bio->bi_end_io = iov_iter_get_pages_use_gup(iter) ?
+				 blkdev_bio_from_gup_end_io :
+				 blkdev_bio_end_io;
 		bio->bi_ioprio = iocb->ki_ioprio;
 
 		ret = bio_iov_iter_get_pages(bio, iter);
diff --git a/include/linux/bio.h b/include/linux/bio.h
index d68a40c2c9d4..b9460d1a4679 100644
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@ -452,6 +452,13 @@ static inline enum bio_rp_flags_t bio_rp_dirty_flag(bool mark_dirty)
 	return mark_dirty ? BIO_RP_MARK_DIRTY : BIO_RP_NORMAL;
 }
 
+static inline enum bio_rp_flags_t bio_rp_gup_flag(bool from_gup)
+{
+	return from_gup ? BIO_RP_FROM_GUP : BIO_RP_NORMAL;
+}
+
+enum bio_rp_flags_t bio_rp_flags(struct iov_iter *iter, bool mark_dirty);
+
 void bio_release_pages(struct bio *bio, enum bio_rp_flags_t flags);
 struct rq_map_data;
 extern struct bio *bio_map_user_iov(struct request_queue *,
@@ -463,6 +470,7 @@ extern struct bio *bio_copy_kern(struct request_queue *, void *, unsigned int,
 				 gfp_t, int);
 extern void bio_set_pages_dirty(struct bio *bio);
 extern void bio_check_pages_dirty(struct bio *bio);
+void __bio_check_pages_dirty(struct bio *bio, bool from_gup);
 
 void generic_start_io_acct(struct request_queue *q, int op,
 				unsigned long sectors, struct hd_struct *part);
-- 
2.22.0
