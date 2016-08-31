From: NeilBrown <neilb@suse.com>
Subject: [PATCH 1/2] cephfs: ignore error from invalidate_inode_pages2_range() in
 direct write.
Date: Wed, 31 Aug 2016 12:58:49 +1000
Message-ID: <871t15ej9y.fsf@notabene.neil.brown.name>
References: <874m61eje0.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44314 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752194AbcHaC65 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 30 Aug 2016 22:58:57 -0400
In-Reply-To: <874m61eje0.fsf@notabene.neil.brown.name>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


This call can fail if there are dirty pages.  The preceding call to
filemap_write_and_wait_range() will normally remove dirty pages, but
as inode_lock() is not held over calls to ceph_direct_read_write(), it
could race with non-direct writes and pages could be dirtied
immediately after filemap_write_and_wait_range() returns

If there are dirty pages, they will be removed by the subsequent call
to truncate_inode_pages_range(), so having them here is not a problem.

If the 'ret' value is left holding an error, then in the async IO case
(aio_req is not NULL) the loop that would normally call
ceph_osdc_start_request() will see the error in 'ret' and abort all
requests.  This doesn't seem like correct behaviour.

So clear 'ret' and ignore the error (other than the dout() message).

Signed-off-by: NeilBrown <neilb@suse.com>
=2D--
 fs/ceph/file.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 0f5375d8e030..1ca6e29edcc9 100644
=2D-- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -905,8 +905,14 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_=
iter *iter,
 		ret =3D invalidate_inode_pages2_range(inode->i_mapping,
 					pos >> PAGE_SHIFT,
 					(pos + count) >> PAGE_SHIFT);
=2D		if (ret < 0)
+		if (ret < 0) {
 			dout("invalidate_inode_pages2_range returned %d\n", ret);
+			/*
+			 * Error is not fatal as we truncate_inode_pages_range()
+			 * below.
+			 */
+			ret =3D 0;
+		}
=20
 		flags =3D CEPH_OSD_FLAG_ORDERSNAP |
 			CEPH_OSD_FLAG_ONDISK |
=2D-=20
2.9.3


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXxkfpAAoJEDnsnt1WYoG5svkQAMFMcy28R+DU7lavEhDJLggf
Jvi9Zis6vd4U6LUWSq+sNJhM1Pzz2MKVqEi+omDJ/yFL5udm8p0QBdp3VsqHTesP
B5LTlI5Y/9Bm5sDDBq6Jp73rC3nbaUPFBN4t4y4ok/zYqm0IoUKn8dzc52uM1ntb
cYqRRIQ6UJUPJXAgePYl12MLOpUMIquCEzXhtPw3o30edt1X96z0o7nAbzpD0xII
bCoyED+DZ6E1n1M4XmGyUh/oFZHLFAK0uktfNi73zqZD1+PGSSvY0N3KMDUoW8bs
FUErBwZ46Sdt4OMuymhz0NApHJmM4P6+8uLlOJ5iHEOlq19uGI8lg/YASZ7UZrtX
87P/U4D5O7VQTHuzckf1JFPcjOJ801sp8xIsA/hKjf9ttSzOuH2D4YOp0XfByLjQ
ZK1a6ECVep9u6estaCN94U9AoFg+xO8gIEOsguqnqmbZAms93scVP9TO97b51fW2
PoN/76RvG06YAxgD22v3TmDI+T/PREPbForvVB1TIGV7SBelcQBFQS4jMIlACge/
OojsFOD/5gPpk4YAkmfrsytWdf47Axirqa93Y/5nuC6mtvcYP/Gsl4lta0HJWwhx
RnDkpGFkZyC+Cuk8aTauG/3zcnkQwboACgi+cWzuxsirau++LzAUB8ojzfKyDrJp
fB78TWa1+4XccZw14g4c
=QhJd
-----END PGP SIGNATURE-----
--=-=-=--
