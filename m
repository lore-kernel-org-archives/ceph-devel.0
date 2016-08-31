From: NeilBrown <neilb@suse.com>
Subject: [PATCH 2/2] cephfs: remove warning when ceph_releasepage() is called on
 dirty page.
Date: Wed, 31 Aug 2016 12:59:29 +1000
Message-ID: <87y43dd4oe.fsf@notabene.neil.brown.name>
References: <874m61eje0.fsf@notabene.neil.brown.name>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="=-=-=";
        micalg=pgp-sha256; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:44366 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752194AbcHaC7h (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 30 Aug 2016 22:59:37 -0400
In-Reply-To: <874m61eje0.fsf@notabene.neil.brown.name>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org

--=-=-=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable


If O_DIRECT writes are racing with buffered writes, then
the call to invalidate_inode_pages2_range() can call ceph_releasepage()
on dirty pages.

Most filesystems hold inode_lock() across O_DIRECT writes so they do not
suffer this race, but cephfs deliberately drops the lock, and opens a window
for the race.

This race can be triggered with the generic/036 test from the xfstests
test suite.  It doesn't happen every time, but it does happen often.

As the possibilty is expected, remove the warning, and instead include
the PageDirty() status in the debug message.

Signed-off-by: NeilBrown <neilb@suse.com>
=2D--
 fs/ceph/addr.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index d5b6f959a3c3..f657da7d12ff 100644
=2D-- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -175,9 +175,8 @@ static void ceph_invalidatepage(struct page *page, unsi=
gned int offset,
=20
 static int ceph_releasepage(struct page *page, gfp_t g)
 {
=2D	dout("%p releasepage %p idx %lu\n", page->mapping->host,
=2D	     page, page->index);
=2D	WARN_ON(PageDirty(page));
+	dout("%p releasepage %p idx %lu (%sdirty)\n", page->mapping->host,
+	     page, page->index, PageDirty(page) ? "" : "not ");
=20
 	/* Can we release the page from the cache? */
 	if (!ceph_release_fscache_page(page, g))
=2D-=20
2.9.3


--=-=-=
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQIcBAEBCAAGBQJXxkgRAAoJEDnsnt1WYoG50nwP/jKweeuaz5XgsRLq98lF1I9L
BQLUinU1xAKD6HG8jCqii+RS42c1D2uSUeVEj7s4ig0GGvRcCtJ5pyZbldnXqD3o
mlAbXpoPv4lcWM+bVRBMisSZWbVnAipZcTzwlb1R/8w0I1ndTkDs8pwcK0gKy/Js
oNM/9FAfeOLyFDsCB+kKnicoWJcXkp9sWx/zx7GMPGVEUc4IBJA3yqmThjJ1RtGQ
u0NBzyB4f5xAnrxml3R6cva+KY59SYXOiXvxTTvELhan8qlW+yVnY57RhhSeJIbk
tOKw9e+XnjC+slRcQ3VWSVLaDo0iMfMOqWVhppk9fgU2lPHoV6gr4iCpesDudsHP
CpQ2bf4uTG1Kv32cj5ZCRBjXoONAaPBpZdL/nz/kWHg5amf5iaBr7TL33ddY1xhI
jLXwWKAneRe1+WD0lpKOGrSHDTX+ZNNlKN9aHq45GaiVzd2/DvvfKjl7v/WQDIV6
3OXAfXFNsc6rXJYHFjJl8O3p2pefpzORj4eGzVa4vo5ZtSLcLhd2YdwxN5+ITdTt
V3kfeTd+FYWWgEECcieVaH2N5mOvAy/Rxy99woWz2Qm8W2I30RPe7kNxyX8Tx8n7
doIQiIRxvhb4usu29lrHNHjz2BUpQmp2a6R4SAUO1raU7qVuw55JLCVZCuF6Le8B
nY1yXI2DTkjC6lugfWcS
=2D+2
-----END PGP SIGNATURE-----
--=-=-=--
