From: Christoph Hellwig <hch@lst.de>
Subject: backing_dev_info cleanups & lifetime rule fixes
Date: Thu,  8 Jan 2015 18:45:21 +0100
Message-ID: <1420739133-27514-1-git-send-email-hch@lst.de>
Return-path: <owner-linux-mm@kvack.org>
Sender: owner-linux-mm@kvack.org
To: Jens Axboe <axboe@fb.com>
Cc: David Howells <dhowells@redhat.com>, Tejun Heo <tj@kernel.org>, linux-fsdevel@vger.kernel.org, linux-mm@kvack.org, linux-mtd@lists.infradead.org, linux-nfs@vger.kernel.org, ceph-devel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

The first 8 patches are unchanged from the series posted a week ago and
cleans up how we use the backing_dev_info structure in preparation for
fixing the life time rules for it.  The most important change is to
split the unrelated nommu mmap flags from it, but it also remove a
backing_dev_info pointer from the address_space (and thus the inode)
and cleans up various other minor bits.

The remaining patches sort out the issues around bdi_unlink and now
let the bdi life until it's embedding structure is freed, which must
be equal or longer than the superblock using the bdi for writeback,
and thus gets rid of the whole mess around reassining inodes to new
bdis.

--
To unsubscribe, send a message with 'unsubscribe linux-mm' in
the body to majordomo@kvack.org.  For more info on Linux MM,
see: http://www.linux-mm.org/ .
Don't email: <a href=mailto:"dont@kvack.org"> email@kvack.org </a>
