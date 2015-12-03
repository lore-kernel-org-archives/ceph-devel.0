From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: cmake
Date: Thu, 3 Dec 2015 17:30:21 -0500
Message-ID: <20151203223020.GB17144@ultraspiritum.redhat.com>
References: <20151203152436.73e15e38@lembas.zaitcev.lan>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="R3G7APHDIzY6R/pk"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:39478 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751957AbbLCWaW (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 3 Dec 2015 17:30:22 -0500
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
	by mx1.redhat.com (Postfix) with ESMTPS id 51EE5C000410
	for <ceph-devel@vger.kernel.org>; Thu,  3 Dec 2015 22:30:22 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <20151203152436.73e15e38@lembas.zaitcev.lan>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Pete Zaitcev <zaitcev@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


--R3G7APHDIzY6R/pk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03/12/2015, Pete Zaitcev wrote:
> Dear All:
>=20
> I'm trying to run cmake, in order to make sure my patches do not break it
> (in particular WIP 5073 added source files). Result looks like this:
>=20
> [zaitcev@lembas ceph-tip]$ cmake src

I believe the problem is 'cmake src'

The ceph-tip/src/CMakeLists.txt file is meant to be called from the
ceph-tip/CMakeLists.txt file. I like to create a completely separate
build directory and build there. i think the most popular incantation is
something like:

  mkdir ceph-tip/build
  cd ceph-tile/build
  cmake ..
  make

--=20
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9

--R3G7APHDIzY6R/pk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQF8BAEBCgBmBQJWYMJ3XxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXREMUY1QjNFRjgyQTI1NjIxNkVERDQxQUNF
OEIyRUY4QzA3NUU1RTIzAAoJEOiy74wHXl4juREH/0T7zOPeAgO86U1lVSpilzBv
BkES22gYBsR36nHOEjowJ3f41Np3wzcpKc+sh4eAWoQe7Id9XNDOM9gqj+fR+x+k
XuB4ZZASuU4Wkm4ksiSgMJgBUEhvoYVqo4nQ7wHimnk3sGF4W+MtpjE7b1jtW55R
v6uwMptP0Ous3lNfmP3dvJP8Y8S2rFGcYmsemlXD0+CCb4QFjgvKGcgA7/dEzTRF
AvW8qTS48m2gSMcUEC9rumA17xHFzA6JNgQ2m0hf7xFGUKxH7+w7vheNwzBg7nzs
S9dvyEeRhWdCLg+unil9BbkmvWpqCj1r5BzSPe+ROapxH9eBvE0BgklAQZLzPuM=
=2Dev
-----END PGP SIGNATURE-----

--R3G7APHDIzY6R/pk--
