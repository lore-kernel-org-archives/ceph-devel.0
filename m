From: Loic Dachary <loic@dachary.org>
Subject: Re: long running workloads/rbd_fsx_cache_writeback.yaml on hammer
Date: Fri, 08 May 2015 16:34:24 +0200
Message-ID: <554CC970.3040701@dachary.org>
References: <554C7CE5.4070600@dachary.org> <1191272410.13855776.1431088583253.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="e84CxJgJt0agbXhdJLXoV4rxmRHDdh7BK"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:59967 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752744AbbEHOe0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 8 May 2015 10:34:26 -0400
In-Reply-To: <1191272410.13855776.1431088583253.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--e84CxJgJt0agbXhdJLXoV4rxmRHDdh7BK
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi,

On 08/05/2015 14:36, Jason Dillaman wrote:
> Nice catch.  It is deadlocked in a code path between handling a watch/n=
otify error from librados and flushing the internal cache.  The issue alr=
eady appears to exist in the hammer branch.

I'm glad it helped you figure out a bug :-) From the point of view of the=
 upcoming v0.94.2, do you think we should wait until this is fixed ? Or i=
s it rare enough and can wait until v0.94.3 ? I'm asking because this bug=
 seems to be the only potential blocker for v0.94.2. It's ok either way, =
just let me know .

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--e84CxJgJt0agbXhdJLXoV4rxmRHDdh7BK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVMyXAACgkQ8dLMyEl6F21eZwCgol8moQtlygLFUqiUy7uQrJ37
AfIAn2mCym61C6dntA7IVwI3qU1Pm326
=FjE9
-----END PGP SIGNATURE-----

--e84CxJgJt0agbXhdJLXoV4rxmRHDdh7BK--
