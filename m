From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH] ceph: don't allow copy_file_range when stripe_count != 1
Date: Thu, 31 Oct 2019 11:49:39 +0000
Message-ID: <20191031114939.24462-1-lhenriques@suse.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, "Yan, Zheng" <zyan@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Luis Henriques <lhenriques@suse.com>
List-Id: ceph-devel.vger.kernel.org

copy_file_range tries to use the OSD 'copy-from' operation, which simply
performs a full object copy.  Unfortunately, the implementation of this
system call assumes that stripe_count is always set to 1 and doesn't take
into account that the data may be striped across an object set.  If the
file layout has stripe_count different from 1, then the destination file
data will be corrupted.

For example:

Consider a 8 MiB file with 4 MiB object size, stripe_count of 2 and
stripe_size of 2 MiB; the first half of the file will be filled with 'A's
and the second half will be filled with 'B's:

               0      4M     8M       Obj1     Obj2
               +------+------+       +----+   +----+
        file:  | AAAA | BBBB |       | AA |   | AA |
               +------+------+       |----|   |----|
                                     | BB |   | BB |
                                     +----+   +----+

If we copy_file_range this file into a new file (which needs to have the
same file layout!), then it will start by copying the object starting at
file offset 0 (Obj1).  And then it will copy the object starting at file
offset 4M -- which is Obj1 again.

Unfortunately, the solution for this is to not allow remote object copies
to be performed when the file layout stripe_count is not 1 and simply
fallback to the default (VFS) copy_file_range implementation.

Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
Hi Jeff,

I hope my understanding of the whole file striping in CephFS is correct;
I had to go re-read the whole thing to refresh my memory.

Anyway, I guess that this is not really the only solution to this
problem, but it's definitely the simplest one.  copy_file_range is
already way more complex that I had ever anticipated.  I would rather
keep this simple solution instead of adding more complexity and cover
more corner cases.  But yeah, we may want to revisit this in the
future...

[OOT: files layout is probably one of the biggest headaches to sort out
 the day we want to implement something like FIEMAP on CephFS ;-) ]

Cheers,
--
Luis

 fs/ceph/file.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index d277f71abe0b..3b0e6f9eb6a6 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1957,9 +1957,12 @@ static ssize_t __ceph_copy_file_range(struct file *src_file, loff_t src_off,
 		return -EOPNOTSUPP;
 
 	if ((src_ci->i_layout.stripe_unit != dst_ci->i_layout.stripe_unit) ||
-	    (src_ci->i_layout.stripe_count != dst_ci->i_layout.stripe_count) ||
-	    (src_ci->i_layout.object_size != dst_ci->i_layout.object_size))
+	    (src_ci->i_layout.stripe_count != 1) ||
+	    (dst_ci->i_layout.stripe_count != 1) ||
+	    (src_ci->i_layout.object_size != dst_ci->i_layout.object_size)) {
+		dout("Invalid src/dst files layout\n");
 		return -EOPNOTSUPP;
+	}
 
 	if (len < src_ci->i_layout.object_size)
 		return -EOPNOTSUPP; /* no remote copy will be done */
