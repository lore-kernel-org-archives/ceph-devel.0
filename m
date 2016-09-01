From: NeilBrown <neilb@suse.com>
Subject: Re: [PATCH 1/2] cephfs: ignore error from invalidate_inode_pages2_range() in direct write.
Date: Thu, 01 Sep 2016 11:01:26 +1000
Message-ID: <87pooocu1l.fsf@notabene.neil.brown.name>
References: <874m61eje0.fsf@notabene.neil.brown.name> <871t15ej9y.fsf@notabene.neil.brown.name> <1472651257.5795.5.camel@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:40423 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753885AbcIABBg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 31 Aug 2016 21:01:36 -0400
In-Reply-To: <1472651257.5795.5.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On Wed, Aug 31 2016, Jeff Layton wrote:
>
> Good catch. Even better might be to just declare a int ret2 and not
> clobber "ret" at all.

Like the following?  Must better, yes.

>
> Clearly, mixing buffered and direct I/O is gross, but I suppose you
> could hit the occasional problem here with a real workload
> occasionally.
>
> Should this go to stable? The patch seems safe enough.

Hardly seems worth it, but certainly safe enough.

>
> Reviewed-by: Jeff Layton <jlayton@redhat.com>

Thanks,
NeilBrown

From: NeilBrown <neilb@suse.com>
Subject: [PATCH] cephfs: ignore error from invalidate_inode_pages2_range() =
in
 direct write.

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

So use separate 'ret2' instead of overloading 'ret'

Signed-off-by: NeilBrown <neilb@suse.com>
Reviewed-by: Jeff Layton <jlayton@redhat.com>
=2D--
 fs/ceph/file.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/file.c b/fs/ceph/file.c
index 0f5375d8e030..395c7fcb1cea 100644
=2D-- a/fs/ceph/file.c
+++ b/fs/ceph/file.c
@@ -902,10 +902,10 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov=
_iter *iter,
 		return ret;
=20
 	if (write) {
=2D		ret =3D invalidate_inode_pages2_range(inode->i_mapping,
+		int ret2 =3D invalidate_inode_pages2_range(inode->i_mapping,
 					pos >> PAGE_SHIFT,
 					(pos + count) >> PAGE_SHIFT);
=2D		if (ret < 0)
+		if (ret2 < 0)
 			dout("invalidate_inode_pages2_range returned %d\n", ret);
=20
 		flags =3D CEPH_OSD_FLAG_ORDERSNAP |
=2D-=20
2.9.3


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXx33nAAoJEDnsnt1WYoG5iFwP/jZFQjDuoiArGy9Qdg5FL8o1
mASXtdnjPNw5cu2iDCvWEcN83bWRkAsgStQzAHjc0rp7fI/b/CC50RFG4olYh+M3
fwcSZ0/GVPkBALPjHeIvLbneqRDiwK/iEb3XoVxGNmZYOGe/asd3MMSAxX7kF2ZA
OFUlLAEuMvcgtTb6steSGyJC8ZmoOEiSobRHYDcimcONeK7MwIqs0lIhmuqEAisf
TaIUOwuC9f7SqRnZRFZGqyEH0rN66ME5t69A0RRRGZLb+P3pvzxsHUumlDm5jMLC
FNd6nVi7EgIoVgiuQ5O2SSw6Kf+gzCHrEFcXQYhjtvoe+XdX/m7cGa64T9sfUpWp
VhcdC7dims8tkPH4pnqHSqu9X1+U7EW6WdroaojcMKu7jrKpgyxbsNmuCbmYMGUd
a00LbGCVBoe0joWiaJzCHPAjLt2BjDeYMSpa7YDG6aMamxZrmsxXr/W4K4/xHITP
vDLbU813uGgGYzroGEQuQBZR8w40I5rB+TUqabwo7bnz8Byns4rE0HAMRL8+Lkuq
yd/Pii8W368/J+Ekf87GjvMaQB2fgWHRHWEIx+sTr/4kQe0aLbvSZV+UI+C+BSwV
D7D+7rTkt0/UJjz9gFcfJWEPkvbrwKGjnWiVgIr7+czyeiZHVBJs64+om5bdUUTY
gcsP5D4xaTwLC7hMrLU+
=zvVr
-----END PGP SIGNATURE-----
--=-=-=--
