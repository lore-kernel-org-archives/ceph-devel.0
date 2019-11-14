From: Luis Henriques <lhenriques@suse.com>
Subject: [RFC PATCH v2 1/4] ceph: add support for TYPE_MSGR2 address decode
Date: Thu, 14 Nov 2019 10:57:33 +0000
Message-ID: <20191114105736.8636-2-lhenriques@suse.com>
References: <20191114105736.8636-1-lhenriques@suse.com>
Mime-Version: 1.0
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20191114105736.8636-1-lhenriques@suse.com>
Sender: linux-kernel-owner@vger.kernel.org
To: Jeff Layton <jlayton@kernel.org>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>, "Yan, Zheng" <zyan@redhat.com>
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org, Luis Henriques <lhenriques@suse.com>
List-Id: ceph-devel.vger.kernel.org

The new format actually includes two addresses: one the new messenger v2,
and other for the legacy v1, which is the only one currently understood
by kernel clients.  Add code to pick the legacy address and ignore the v2
one.

Signed-off-by: Luis Henriques <lhenriques@suse.com>
---
 include/linux/ceph/decode.h |  3 ++-
 net/ceph/decode.c           | 33 +++++++++++++++++++++++++++++++--
 2 files changed, 33 insertions(+), 3 deletions(-)

diff --git a/include/linux/ceph/decode.h b/include/linux/ceph/decode.h
index 450384fe487c..2a2f07dfb39c 100644
--- a/include/linux/ceph/decode.h
+++ b/include/linux/ceph/decode.h
@@ -219,7 +219,8 @@ static inline void ceph_encode_timespec64(struct ceph_timespec *tv,
  * sockaddr_storage <-> ceph_sockaddr
  */
 #define CEPH_ENTITY_ADDR_TYPE_NONE	0
-#define CEPH_ENTITY_ADDR_TYPE_LEGACY	__cpu_to_le32(1)
+#define CEPH_ENTITY_ADDR_TYPE_LEGACY	__cpu_to_le32(1) /* legacy msgr1 */
+#define CEPH_ENTITY_ADDR_TYPE_MSGR2	__cpu_to_le32(2) /* msgr2 protocol */
 
 static inline void ceph_encode_banner_addr(struct ceph_entity_addr *a)
 {
diff --git a/net/ceph/decode.c b/net/ceph/decode.c
index eea529595a7a..613a2bc6f805 100644
--- a/net/ceph/decode.c
+++ b/net/ceph/decode.c
@@ -67,16 +67,45 @@ ceph_decode_entity_addr_legacy(void **p, void *end,
 	return ret;
 }
 
+static int
+ceph_decode_entity_addr_versioned_msgr2(void **p, void *end,
+					struct ceph_entity_addr *addr)
+{
+	struct ceph_entity_addr tmp_addr;
+	struct ceph_entity_addr *paddr = addr;
+	int ret = -EINVAL;
+
+	ceph_decode_skip_32(p, end, bad); /* hard-coded '2' */
+	ceph_decode_skip_8(p, end, bad);  /* hard-coded '1' */
+
+	ret = ceph_decode_entity_addr_versioned(p, end, paddr);
+	if (ret)
+		goto bad;
+	/* If we already have a v1 address, simply skip over the other address */
+	if (paddr->type == CEPH_ENTITY_ADDR_TYPE_LEGACY)
+		paddr = &tmp_addr;
+
+	ceph_decode_skip_8(p, end, bad);  /* hard-coded '1' */
+
+	ret = ceph_decode_entity_addr_versioned(p, end, paddr);
+
+bad:
+	return ret;
+}
+
 int
 ceph_decode_entity_addr(void **p, void *end, struct ceph_entity_addr *addr)
 {
 	u8 marker;
 
 	ceph_decode_8_safe(p, end, marker, bad);
-	if (marker == 1)
+	if (marker == CEPH_ENTITY_ADDR_TYPE_MSGR2)
+		return ceph_decode_entity_addr_versioned_msgr2(p, end, addr);
+	else if (marker == CEPH_ENTITY_ADDR_TYPE_LEGACY)
 		return ceph_decode_entity_addr_versioned(p, end, addr);
-	else if (marker == 0)
+	else if (marker == CEPH_ENTITY_ADDR_TYPE_NONE)
 		return ceph_decode_entity_addr_legacy(p, end, addr);
+
 bad:
 	return -EINVAL;
 }
