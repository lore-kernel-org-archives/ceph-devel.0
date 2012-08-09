From: Danny Kukawka <danny.kukawka@bisect.de>
Subject: Re: [PATCH] make mkcephfs and init-ceph osd filesystem handling more
 flexible
Date: Thu, 09 Aug 2012 19:03:18 +0200
Message-ID: <5023ED56.9070102@bisect.de>
References: <1344526971-17035-1-git-send-email-danny.kukawka@bisect.de> <CADvuQRGLUpPT=RxYqptGq+9Ku2dNiKLsdY8a=KjjfoquucBc7w@mail.gmail.com> <5023E96E.30209@sandia.gov> <CADvuQRG9DrG6irjuD8ZZcAz_grgS=9i6M6GDV0-gYWfAyje4uw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig6006CA25125F32CF82A6A904"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:44935 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751396Ab2HIRD2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Aug 2012 13:03:28 -0400
In-Reply-To: <CADvuQRG9DrG6irjuD8ZZcAz_grgS=9i6M6GDV0-gYWfAyje4uw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Tommi Virtanen <tv@inktank.com>, Jim Schutt <jaschut@sandia.gov>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig6006CA25125F32CF82A6A904
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 09.08.2012 18:53, schrieb Tommi Virtanen:
> On Thu, Aug 9, 2012 at 9:46 AM, Jim Schutt <jaschut@sandia.gov> wrote:
>> I'm embarrassed to admit I haven't been keeping up with this,
>> but I seem to recall that early versions didn't handle a
>> journal on a partition.  Did I get that wrong, or maybe that
>> capability exists now?  In the past I've found it to have a
>> small performance benefit, and would hate to lose it.
>=20
> It's still not quite ready for prime time. Journal placement was cut
> out to allow us to focus on the distributed aspects of it first; those
> are now working pretty well. Putting much effort on the alternative is
> probably not a good bet.
>=20
> This ticket needs to get fixed (and defined better, first!) to have
> more flexibility with journals:
> http://tracker.newdream.net/issues/2398

So you mean chef?! Will there be an alternative to simply setup a
cluster from console?

We (SUSE) are already working on an own chef ceph cookbook. But from
what I've seen till now it's really hard and more laborious to initially
setup a cluster with chef than with mkcephfs.

Danny


--------------enig6006CA25125F32CF82A6A904
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iJwEAQECAAYFAlAj7VsACgkQ9DHLX79LmTI0owP/VDX7K+/d8kF/GQlMT9bHzADT
ponqOPF4rEH7He51VaI7nuW5v6aJg5qG8OgPcwHXgrIifdeDJZCTOtyqpipsUtbM
7lrq6RDkLZPsYi7sPakq1AFehEHmwkwrh1U50RaiGUunlUviU9H597Bmo34lR/iM
Hk4kU4XEvswgGDlRRFM=
=zFkG
-----END PGP SIGNATURE-----

--------------enig6006CA25125F32CF82A6A904--
