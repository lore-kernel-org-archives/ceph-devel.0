From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: inconsistent rados semantics between automake/cmake builds
Date: Thu, 21 Jan 2016 21:49:35 -0500
Message-ID: <20160122024935.GA15962@ultraspiritum.redhat.com>
References: <CAB2gnbUxzE7z6ec39=cPg2sqNOtMc6cS8_GN9ybxxdvB7zXW+g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="pf9I7BMVVzbSWLtt"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40930 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752448AbcAVCtg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 21 Jan 2016 21:49:36 -0500
Content-Disposition: inline
In-Reply-To: <CAB2gnbUxzE7z6ec39=cPg2sqNOtMc6cS8_GN9ybxxdvB7zXW+g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noahwatkins@gmail.com>
Cc: The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>


--pf9I7BMVVzbSWLtt
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21/01/2016, Noah Watkins wrote:
> I'm seeing an anomaly of semantics between Ceph built with Automake
> and with CMake. I've not been lucky so far tracking this down so I
> thought I'd toss it out here.

All right.  Commit 9717714cf62eeb7db979b0e6b509ef305cb757eb in=20
github.com/cohortfsllc/cohort-ceph should have this. It's the top entry on =
the
mtime branch in that repository. If you like things web-style,
https://github.com/cohortfsllc/cohortfs-ceph/commit/9717714cf62eeb7db979b0e=
6b509ef305cb757eb

Casey chased this down to the encode/decode functions and once I took a loo=
k at
them I realized the cast was screwy. It now passes your unit test reliably =
(at
least it worked a few times) under cmake.

--=20
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9

--pf9I7BMVVzbSWLtt
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQF8BAEBCgBmBQJWoZi0XxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXREMUY1QjNFRjgyQTI1NjIxNkVERDQxQUNF
OEIyRUY4QzA3NUU1RTIzAAoJEOiy74wHXl4jqgEH/2daDIfFCRATJW2GDIOm5vRi
Rt+lKx/Wv+b8IzNQ7O87cgEX3NAEuOvH0FgQMfl4uoiMt0RQfJMWFpDKd5AB5Bfu
yGMZ4d1S3309+NKzWNxJfoGgtLyVIrLfVUIkLCI6Xvjp60bwGGOQLbO5ME/oQ+uZ
pKRmVgA6tSKAuBtUyYwmIcEwOR8nWXV6HxXFOk4flfKTfgCpn9UugRioizkl9T2R
clb7eWyWBjlFlMAqt01IDoDYu7gAmpKXscv9Nb8m8QPq5mpTQsqd4Wvk2g8jqwDM
e3RhSydscvChM07H8dOILjkCE7RGxhcwvQlO44qRSirmWVbEPwjO16OrL/7XljA=
=aGOI
-----END PGP SIGNATURE-----

--pf9I7BMVVzbSWLtt--
