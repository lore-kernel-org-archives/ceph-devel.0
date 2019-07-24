From: john.hubbard@gmail.com
Subject: [PATCH 02/12] iov_iter: add helper to test if an iter would use GUP v2
Date: Tue, 23 Jul 2019 21:25:08 -0700
Message-ID: <20190724042518.14363-3-jhubbard@nvidia.com>
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

Add a helper to test if call to iov_iter_get_pages*() with a given
iter would result in calls to GUP (get_user_pages*()). We want to
use different tracking of page references if they are coming from
GUP (get_user_pages*()) and thus  we need to know when GUP is used
for a given iter.

Changes since Jérôme's original patch:

* iov_iter_get_pages_use_gup(): do not return true for the ITER_PIPE
case, because iov_iter_get_pages() calls pipe_get_pages(), which in
turn uses get_page(), not get_user_pages().

* Remove some obsolete code, as part of rebasing onto Linux 5.3.

* Fix up the kerneldoc comment to "Return:" rather than "Returns:",
and a few other grammatical tweaks.

Signed-off-by: Jérôme Glisse <jglisse@redhat.com>
Signed-off-by: John Hubbard <jhubbard@nvidia.com>
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
---
 include/linux/uio.h | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/include/linux/uio.h b/include/linux/uio.h
index ab5f523bc0df..2a179af8e5a7 100644
--- a/include/linux/uio.h
+++ b/include/linux/uio.h
@@ -86,6 +86,17 @@ static inline unsigned char iov_iter_rw(const struct iov_iter *i)
 	return i->type & (READ | WRITE);
 }
 
+/**
+ * iov_iter_get_pages_use_gup - report if iov_iter_get_pages(i) uses GUP
+ * @i: iterator
+ * Return: true if a call to iov_iter_get_pages*() with the iter provided in
+ *          the argument would result in the use of get_user_pages*()
+ */
+static inline bool iov_iter_get_pages_use_gup(const struct iov_iter *i)
+{
+	return iov_iter_type(i) == ITER_IOVEC;
+}
+
 /*
  * Total number of bytes covered by an iovec.
  *
-- 
2.22.0
