From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH] ceph: check negative offsets on ceph_llseek()
Date: Fri, 28 Jul 2017 11:56:40 +0100
Message-ID: <20170728105640.16268-1-lhenriques@suse.com>
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Luis Henriques <lhenriques@suse.com>
List-Id: ceph-devel.vger.kernel.org

When a user requests SEEK_HOLE or SEEK_DATA with a negative offset
ceph_llseek should return -ENXIO.  Currently -EINVAL is being returned for
SEEK_DATA and 0 for SEEK_HOLE.

Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 fs/ceph/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 3d48c415f3cb..e1912e67843f 100644
--- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -1481,13 +1481,13 @@ static loff_t ceph_llseek(struct file *file, loff_t offset, int whence)
 		offset += file->f_pos;
 		break;
 	case SEEK_DATA:
-		if (offset >= i_size) {
+		if (offset < 0 || offset >= i_size) {
 			ret = -ENXIO;
 			goto out;
 		}
 		break;
 	case SEEK_HOLE:
-		if (offset >= i_size) {
+		if (offset < 0 || offset >= i_size) {
 			ret = -ENXIO;
 			goto out;
 		}
