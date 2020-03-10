From: "Yan, Zheng" <zyan@redhat.com>
Subject: [PATCH 3/4] ceph: don't skip updating wanted caps when cap is stale
Date: Tue, 10 Mar 2020 19:34:20 +0800
Message-ID: <20200310113421.174873-4-zyan@redhat.com>
References: <20200310113421.174873-1-zyan@redhat.com>
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52799 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726283AbgCJLei (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 10 Mar 2020 07:34:38 -0400
In-Reply-To: <20200310113421.174873-1-zyan@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: jlayton@kernel.org, "Yan, Zheng" <zyan@redhat.com>

1. try_get_cap_refs() fails to get caps and finds that mds_wanted
   does not include what it wants. It return -ESTALE.
2. ceph_get_caps() calls ceph_renew_caps(). ceph_renew_caps() finds
   that inode has cap, so it calls ceph_check_caps().
3. ceph_check_caps() finds that issued caps (without checking if it's
   stale) already includes caps wanted by open file, so it skips
   updating wanted caps.

Above events can cause infinite loop inside ceph_get_caps()

Signed-off-by: "Yan, Zheng" <zyan@redhat.com>
---
 fs/ceph/caps.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
index 295b61201d85..f63db3cb9c4f 100644
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@ -2008,8 +2008,12 @@ void ceph_check_caps(struct ceph_inode_info *ci, i=
nt flags,
 		}
=20
 		/* want more caps from mds? */
-		if (want & ~(cap->mds_wanted | cap->issued))
-			goto ack;
+		if (want & ~cap->mds_wanted) {
+			if (want & ~(cap->mds_wanted | cap->issued))
+				goto ack;
+			if (!__cap_is_valid(cap))
+				goto ack;
+		}
=20
 		/* things we might delay */
 		if ((cap->issued & ~retain) =3D=3D 0)
--=20
2.21.1
