From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH] ceph: reset i_requested_max_size if file write is not wanted
Date: Mon, 30 Mar 2020 19:56:37 +0800
Message-ID: <20200330115637.31019-1-zyan@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-74.mimecast.com ([63.128.21.74]:44597 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729989AbgC3L4s (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 30 Mar 2020 07:56:48 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: jlayton@kernel.org, "Yan, Zheng" <zyan@redhat.com>

write can stuck at waiting for larger max_size in following sequence of
events:

- client opens a file and writes to position 'A' (larger than unit of
  max size increment)
- client closes the file handle and updates wanted caps (not wanting
  file write caps)
- client opens and truncates the file, writes to position 'A' again.

At the 1st event, client set inode's requested_max_size to 'A'. At the
2nd event, mds removes client's writable range, but client does not reset
requested_max_size. At the 3rd event, client does not request max size
because requested_max_size is already larger than 'A'.

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/caps.c | 29 +++++++++++++++++++----------
 1 file changed, 19 insertions(+), 10 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index f8b51d0c8184..61808793e0c0 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -1363,8 +1363,12 @@ static void __prep_cap(struct cap_msg_args *arg, s=
truct ceph_cap *cap,
 	arg->size =3D inode->i_size;
 	ci->i_reported_size =3D arg->size;
 	arg->max_size =3D ci->i_wanted_max_size;
-	if (cap =3D=3D ci->i_auth_cap)
-		ci->i_requested_max_size =3D arg->max_size;
+	if (cap =3D=3D ci->i_auth_cap) {
+		if (want & CEPH_CAP_ANY_FILE_WR)
+			ci->i_requested_max_size =3D arg->max_size;
+		else
+			ci->i_requested_max_size =3D 0;
+	}
=20
 	if (flushing & CEPH_CAP_XATTR_EXCL) {
 		arg->old_xattr_buf =3D __ceph_build_xattrs_blob(ci);
@@ -3343,10 +3347,6 @@ static void handle_cap_grant(struct inode *inode,
 				ci->i_requested_max_size =3D 0;
 			}
 			wake =3D true;
-		} else if (ci->i_wanted_max_size > ci->i_max_size &&
-			   ci->i_wanted_max_size > ci->i_requested_max_size) {
-			/* CEPH_CAP_OP_IMPORT */
-			wake =3D true;
 		}
 	}
=20
@@ -3422,9 +3422,18 @@ static void handle_cap_grant(struct inode *inode,
 			fill_inline =3D true;
 	}
=20
-	if (le32_to_cpu(grant->op) =3D=3D CEPH_CAP_OP_IMPORT) {
+	if (ci->i_auth_cap =3D=3D cap &&
+	    le32_to_cpu(grant->op) =3D=3D CEPH_CAP_OP_IMPORT) {
 		if (newcaps & ~extra_info->issued)
 			wake =3D true;
+
+		if (ci->i_requested_max_size > max_size ||
+		    !(le32_to_cpu(grant->wanted) & CEPH_CAP_ANY_FILE_WR)) {
+			/* re-request max_size if necessary */
+			ci->i_requested_max_size =3D 0;
+			wake =3D true;
+		}
+
 		ceph_kick_flushing_inode_caps(session, ci);
 		spin_unlock(&ci->i_ceph_lock);
 		up_read(&session->s_mdsc->snap_rwsem);
@@ -3882,9 +3891,6 @@ static void handle_cap_import(struct ceph_mds_clien=
t *mdsc,
 		__ceph_remove_cap(ocap, (ph->flags & CEPH_CAP_FLAG_RELEASE));
 	}
=20
-	/* make sure we re-request max_size, if necessary */
-	ci->i_requested_max_size =3D 0;
-
 	*old_issued =3D issued;
 	*target_cap =3D cap;
 }
@@ -4318,6 +4324,9 @@ int ceph_encode_inode_release(void **p, struct inod=
e *inode,
 				cap->issued &=3D ~drop;
 				cap->implemented &=3D ~drop;
 				cap->mds_wanted =3D wanted;
+				if (cap =3D=3D ci->i_auth_cap &&
+				    !(wanted & CEPH_CAP_ANY_FILE_WR))
+					ci->i_requested_max_size =3D 0;
 			} else {
 				dout("encode_inode_release %p cap %p %s"
 				     " (force)\n", inode, cap,
--=20
2.21.1
