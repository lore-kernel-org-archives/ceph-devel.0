From: Luis Henriques <lhenriques@suse.com>
Subject: [PATCH 1/4] libceph: allow ceph_buffer_put() to receive a NULL ceph_buffer
Date: Fri, 19 Jul 2019 15:32:19 +0100
Message-ID: <20190719143222.16058-2-lhenriques@suse.com>
References: <20190719143222.16058-1-lhenriques@suse.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20190719143222.16058-1-lhenriques@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Ilya Dryomov <idryomov@gmail.com>, Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Luis Henriques <lhenriques@suse.com>
List-Id: ceph-devel.vger.kernel.org

Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 include/linux/ceph/buffer.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/include/linux/ceph/buffer.h b/include/linux/ceph/buffer.h
index 5e58bb29b1a3..11cdc7c60480 100644
--- a/include/linux/ceph/buffer.h
+++ b/include/linux/ceph/buffer.h
@@ -30,7 +30,8 @@ static inline struct ceph_buffer *ceph_buffer_get(struct ceph_buffer *b)
 
 static inline void ceph_buffer_put(struct ceph_buffer *b)
 {
-	kref_put(&b->kref, ceph_buffer_release);
+	if (b)
+		kref_put(&b->kref, ceph_buffer_release);
 }
 
 extern int ceph_decode_buffer(struct ceph_buffer **b, void **p, void *end);
