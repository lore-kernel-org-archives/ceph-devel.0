From: Nathaniel Yazdani <n1ght.4nd.d4y@gmail.com>
Subject: [PATCH] ceph: fix null pointer dereference
Date: Sun, 04 Aug 2013 21:04:30 -0700
Message-ID: <1375675470.19205.2.camel@lizardlounge>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <linux-kernel-owner@vger.kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
To: sage@inktank.com
Cc: ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
List-Id: ceph-devel.vger.kernel.org

	When register_session() is given an out-of-range argument for mds,
ceph_mdsmap_get_addr() will return a null pointer, which would be given to
ceph_con_open() & be dereferenced, causing a kernel oops. This fixes bug #4685
in the Ceph bug tracker <http://tracker.ceph.com/issues/4685>.

Signed-off-by: Nathaniel Yazdani <n1ght.4nd.d4y@gmail.com>
---
diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
index 187bf21..ddff072 100644
--- a/fs/ceph/mds_client.c
+++ b/fs/ceph/mds_client.c
@@ -414,6 +414,9 @@ static struct ceph_mds_session *register_session(struct ceph_mds_client *mdsc,
 {
 	struct ceph_mds_session *s;
 
+	if (mds >= mdsc->mdsmap->m_max_mds)
+		return ERR_PTR(-EINVAL);
+
 	s = kzalloc(sizeof(*s), GFP_NOFS);
 	if (!s)
 		return ERR_PTR(-ENOMEM);
