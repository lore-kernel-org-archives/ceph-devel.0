From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH v3 6/6] ceph: check all mds' caps after page writeback
Date: Fri, 28 Feb 2020 19:55:50 +0800
Message-ID: <20200228115550.6904-7-zyan@redhat.com>
References: <20200228115550.6904-1-zyan@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51869 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726809AbgB1L4Q (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 28 Feb 2020 06:56:16 -0500
In-Reply-To: <20200228115550.6904-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: jlayton@kernel.org, "Yan, Zheng" <zyan@redhat.com>

If an inode has caps from multiple mds, following case can happen.

- non-auth mds revokes Fsc. Fcb is used, so page writeback is queued.
- when writeback finishes, ceph_check_caps() is called with auth only
  flag. ceph_check_caps() invalidates pagecache, but skip checking any
  non-auth caps.

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/caps.c  | 2 +-
 fs/ceph/inode.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 49f773247044..9b3d5816c109 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -3018,7 +3018,7 @@ void ceph_put_wrbuffer_cap_refs(struct ceph_inode_i=
nfo *ci, int nr,
 	spin_unlock(&ci->i_ceph_lock);
=20
 	if (last) {
-		ceph_check_caps(ci, CHECK_CAPS_AUTHONLY, NULL);
+		ceph_check_caps(ci, 0, NULL);
 	} else if (flush_snaps) {
 		ceph_flush_snaps(ci, NULL);
 	}
diff --git a/fs/ceph/inode.c b/fs/ceph/inode.c
index 5a8fa8a2d3cf..896d30820035 100644
--- a/fs/ceph/inode.c
+++ b/fs/ceph/inode.c
@@ -1974,7 +1974,7 @@ void __ceph_do_pending_vmtruncate(struct inode *ino=
de)
 	mutex_unlock(&ci->i_truncate_mutex);
=20
 	if (wrbuffer_refs =3D=3D 0)
-		ceph_check_caps(ci, CHECK_CAPS_AUTHONLY, NULL);
+		ceph_check_caps(ci, 0, NULL);
=20
 	wake_up_all(&ci->i_cap_wq);
 }
--=20
2.21.1
