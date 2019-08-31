From: Krzysztof Wilczynski <kw@linux.com>
Subject: [PATCH] ceph: Move static keyword to the front of declarations
Date: Sat, 31 Aug 2019 23:57:12 +0200
Message-ID: <20190831215712.10148-1-kw@linux.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>
Cc: Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

Move the static keyword to the front of declarations of
snap_handle_length, handle_length and connected_handle_length,
and resolve the following compiler warnings that can be seen
when building with warnings enabled (W=1):

fs/ceph/export.c:38:2: warning:
  ‘static’ is not at beginning of declaration [-Wold-style-declaration]

fs/ceph/export.c:88:2: warning:
  ‘static’ is not at beginning of declaration [-Wold-style-declaration]

fs/ceph/export.c:90:2: warning:
  ‘static’ is not at beginning of declaration [-Wold-style-declaration]

Signed-off-by: Krzysztof Wilczynski <kw@linux.com>
---
Related: https://lore.kernel.org/r/20190827233017.GK9987@google.com

 fs/ceph/export.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/export.c b/fs/ceph/export.c
index 020d39a85ecc..b6bfa94332c3 100644
--- a/fs/ceph/export.c
+++ b/fs/ceph/export.c
@@ -35,7 +35,7 @@ struct ceph_nfs_snapfh {
 static int ceph_encode_snapfh(struct inode *inode, u32 *rawfh, int *max_len,
 			      struct inode *parent_inode)
 {
-	const static int snap_handle_length =
+	static const int snap_handle_length =
 		sizeof(struct ceph_nfs_snapfh) >> 2;
 	struct ceph_nfs_snapfh *sfh = (void *)rawfh;
 	u64 snapid = ceph_snap(inode);
@@ -85,9 +85,9 @@ static int ceph_encode_snapfh(struct inode *inode, u32 *rawfh, int *max_len,
 static int ceph_encode_fh(struct inode *inode, u32 *rawfh, int *max_len,
 			  struct inode *parent_inode)
 {
-	const static int handle_length =
+	static const int handle_length =
 		sizeof(struct ceph_nfs_fh) >> 2;
-	const static int connected_handle_length =
+	static const int connected_handle_length =
 		sizeof(struct ceph_nfs_confh) >> 2;
 	int type;
 
-- 
2.22.1
