From: Joe Perches <joe@perches.com>
Subject: [trivial PATCH] osdmap.h: Add missing format newlines
Date: Mon, 23 Mar 2015 13:35:03 -0700
Message-ID: <1427142903.16851.39.camel@perches.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="ISO-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
List-Id: ceph-devel.vger.kernel.org

To avoid possible interleaving, add missing '\n' to formats.

Convert pr_warning to pr_warn while there.

Signed-off-by: Joe Perches <joe@perches.com>
---
 include/linux/ceph/osdmap.h | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/include/linux/ceph/osdmap.h b/include/linux/ceph/osdmap.h
index 561ea89..e55c08b 100644
--- a/include/linux/ceph/osdmap.h
+++ b/include/linux/ceph/osdmap.h
@@ -175,13 +175,12 @@ static inline int ceph_decode_pgid(void **p, void *end, struct ceph_pg *pgid)
 	__u8 version;
 
 	if (!ceph_has_room(p, end, 1 + 8 + 4 + 4)) {
-		pr_warning("incomplete pg encoding");
-
+		pr_warn("incomplete pg encoding\n");
 		return -EINVAL;
 	}
 	version = ceph_decode_8(p);
 	if (version > 1) {
-		pr_warning("do not understand pg encoding %d > 1",
+		pr_warn("do not understand pg encoding %d > 1\n",
 			(int)version);
 		return -EINVAL;
 	}
