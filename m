From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 1/4] ceph: cleanup return error of try_get_cap_refs()
Date: Tue, 10 Mar 2020 19:34:18 +0800
Message-ID: <20200310113421.174873-2-zyan@redhat.com>
References: <20200310113421.174873-1-zyan@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42306 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725937AbgCJLed (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:34:33 -0400
In-Reply-To: <20200310113421.174873-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: jlayton@kernel.org, "Yan, Zheng" <zyan@redhat.com>

Returns 0 if caps were not able to be acquired (yet), 1 if succeed,
or a negative error code. There are 3 speical error codes:

-EAGAIN: need to sleep but non-blocking is specified
-EFBIG:  ask caller to call check_max_size() and try again.
-ESTALE: ask caller to call ceph_renew_caps() and try again.

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/caps.c | 25 ++++++++++++++-----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 342a32c74c64..804f4c65251a 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2530,10 +2530,11 @@ void ceph_take_cap_refs(struct ceph_inode_info *c=
i, int got,
  * Note that caller is responsible for ensuring max_size increases are
  * requested from the MDS.
  *
- * Returns 0 if caps were not able to be acquired (yet), a 1 if they wer=
e,
- * or a negative error code.
- *
- * FIXME: how does a 0 return differ from -EAGAIN?
+ * Returns 0 if caps were not able to be acquired (yet), 1 if succeed,
+ * or a negative error code. There are 3 speical error codes:
+ *  -EAGAIN: need to sleep but non-blocking is specified
+ *  -EFBIG:  ask caller to call check_max_size() and try again.
+ *  -ESTALE: ask caller to call ceph_renew_caps() and try again.
  */
 enum {
 	/* first 8 bits are reserved for CEPH_FILE_MODE_FOO */
@@ -2581,7 +2582,7 @@ static int try_get_cap_refs(struct inode *inode, in=
t need, int want,
 			dout("get_cap_refs %p endoff %llu > maxsize %llu\n",
 			     inode, endoff, ci->i_max_size);
 			if (endoff > ci->i_requested_max_size)
-				ret =3D -EAGAIN;
+				ret =3D -EFBIG;
 			goto out_unlock;
 		}
 		/*
@@ -2743,7 +2744,10 @@ int ceph_try_get_caps(struct inode *inode, int nee=
d, int want,
 		flags |=3D NON_BLOCKING;
=20
 	ret =3D try_get_cap_refs(inode, need, want, 0, flags, got);
-	return ret =3D=3D -EAGAIN ? 0 : ret;
+	/* three special error codes */
+	if (ret =3D=3D -EAGAIN || ret =3D=3D -EFBIG || ret =3D=3D -EAGAIN)
+		ret =3D 0;
+	return ret;
 }
=20
 /*
@@ -2771,17 +2775,12 @@ int ceph_get_caps(struct file *filp, int need, in=
t want,
 	flags =3D get_used_fmode(need | want);
=20
 	while (true) {
-		if (endoff > 0)
-			check_max_size(inode, endoff);
-
 		flags &=3D CEPH_FILE_MODE_MASK;
 		if (atomic_read(&fi->num_locks))
 			flags |=3D CHECK_FILELOCK;
 		_got =3D 0;
 		ret =3D try_get_cap_refs(inode, need, want, endoff,
 				       flags, &_got);
-		if (ret =3D=3D -EAGAIN)
-			continue;
 		if (!ret) {
 			struct ceph_mds_client *mdsc =3D fsc->mdsc;
 			struct cap_wait cw;
@@ -2829,6 +2828,10 @@ int ceph_get_caps(struct file *filp, int need, int=
 want,
 		}
=20
 		if (ret < 0) {
+			if (ret =3D=3D -EFBIG) {
+				check_max_size(inode, endoff);
+				continue;
+			}
 			if (ret =3D=3D -ESTALE) {
 				/* session was killed, try renew caps */
 				ret =3D ceph_renew_caps(inode, flags);
--=20
2.21.1
