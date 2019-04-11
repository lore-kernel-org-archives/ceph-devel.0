From: jglisse@redhat.com
Subject: [PATCH v1 15/15] ceph: use put_user_pages() instead of ceph_put_page_vector()
Date: Thu, 11 Apr 2019 17:08:34 -0400
Message-ID: <20190411210834.4105-16-jglisse@redhat.com>
References: <20190411210834.4105-1-jglisse@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190411210834.4105-1-jglisse@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
To: linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?J=C3=A9r=C3=B4me=20Glisse?= <jglisse@redhat.com>, linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org, linux-mm@kvack.org, John Hubbard <jhubbard@nvidia.com>, Jan Kara <jack@suse.cz>, Dan Williams <dan.j.williams@intel.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Johannes Thumshirn <jthumshirn@suse.de>, Christoph Hellwig <hch@lst.de>, Jens Axboe <axboe@kernel.dk>, Ming Lei <ming.lei@redhat.com>, Dave Chinner <david@fromorbit.com>, Jason Gunthorpe <jgg@ziepe.ca>, Matthew Wilcox <willy@infradead.org>, Yan Zheng <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

From: Jérôme Glisse <jglisse@redhat.com>

When page reference were taken through GUP (get_user_page*()) we need
to drop them with put_user_pages().

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
Cc: Yan Zheng <zyan@redhat.com>
Cc: Sage Weil <sage@redhat.com>
Cc: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org
---
 fs/ceph/file.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 6c5b85f01721..5842ad3a4218 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -667,7 +667,8 @@ static ssize_t ceph_sync_read(struct kiocb *iocb, struct iov_iter *to,
 			} else {
 				iov_iter_advance(to, 0);
 			}
-			ceph_put_page_vector(pages, num_pages, false);
+			/* iov_iter_get_pages_alloc() did call GUP */
+			put_user_pages(pages, num_pages);
 		} else {
 			int idx = 0;
 			size_t left = ret > 0 ? ret : 0;
-- 
2.20.1
