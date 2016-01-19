From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: About ceph_clock_now()
Date: Tue, 19 Jan 2016 11:29:03 -0500
Message-ID: <20160119162902.GA21358@ultraspiritum.redhat.com>
References: <177186823.10053087.1452614184109.JavaMail.zimbra@redhat.com>
 <892700092.10054838.1452614393452.JavaMail.zimbra@redhat.com>
 <20160112173248.GA8218@ultraspiritum.redhat.com>
 <964746730.10566211.1452681675142.JavaMail.zimbra@redhat.com>
 <alpine.DEB.2.11.1601130846500.26381@cpach.fuggernut.com>
 <1365711662.13730117.1453220271917.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="opJtzjQTFsWo+cga"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:46426 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755753AbcASQ3F (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 19 Jan 2016 11:29:05 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 7DDFB3D1D8A
	for <ceph-devel@vger.kernel.org>; Tue, 19 Jan 2016 16:29:04 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1365711662.13730117.1453220271917.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Erwan Velu <evelu@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>


--opJtzjQTFsWo+cga
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 19/01/2016, Erwan Velu wrote:
> Before propagating the change to more code base and offer a PR with that,=
 what do you think of this style ?
>=20
> Is it aligned with the best-pratices of the project ?
>=20
> https://gist.github.com/ErwanAliasr1/f74f7f046e9300ac2c30

One minor thing, you shouldn't use anything in time_detail directly. It SHO=
ULD
be ceph::coarse_mono_clock::now() ('detail' or leading underscores signal a
'private' namespace.)

Other than that, this looks very good.

--=20
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9

--opJtzjQTFsWo+cga
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQF8BAEBCgBmBQJWnmRJXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXREMUY1QjNFRjgyQTI1NjIxNkVERDQxQUNF
OEIyRUY4QzA3NUU1RTIzAAoJEOiy74wHXl4jiW8H/RxE9NLc0CRkyyehhUjU+6la
xFTpW8Ooq2OarZ2hYp8IChK6e/CgI1t79W0r1W20KNKhsbqC+dt9vKM8ZqGxcAo4
/Jkv1X03vpixG+5HRYast4cp15IK5q+Zs0r1KJRxhIF0HKPOOMaQMtpE5j8eaI8N
iKwtolPabSDCsbvLrRbhKkAmwVI3x7RzepzkC3d9QbwYRQ29ZCF2m4X5/Korjdh0
JOS2Mp7+qh5+6hl5r8Hi3kdzrZ1Gm1Xlio9IoVb9PPMPtrHolaGVqW9UV0TBZRYN
oxqrNSFr2UD1SJHj4ndWwNYebWMI9RfanGo4PzcIGWd59Mbk51Avxu1v95cOaek=
=TUBk
-----END PGP SIGNATURE-----

--opJtzjQTFsWo+cga--
