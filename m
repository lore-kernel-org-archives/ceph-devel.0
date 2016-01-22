From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: About ceph_clock_now()
Date: Fri, 22 Jan 2016 12:35:22 -0500
Message-ID: <20160122173521.GA29065@ultraspiritum.redhat.com>
References: <177186823.10053087.1452614184109.JavaMail.zimbra@redhat.com>
 <892700092.10054838.1452614393452.JavaMail.zimbra@redhat.com>
 <20160112173248.GA8218@ultraspiritum.redhat.com>
 <964746730.10566211.1452681675142.JavaMail.zimbra@redhat.com>
 <alpine.DEB.2.11.1601130846500.26381@cpach.fuggernut.com>
 <1365711662.13730117.1453220271917.JavaMail.zimbra@redhat.com>
 <20160119162902.GA21358@ultraspiritum.redhat.com>
 <1522288191.15295456.1453404176015.JavaMail.zimbra@redhat.com>
 <1575597139.15885899.1453478438366.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="/04w6evG8XlLl3ft"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:55070 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751908AbcAVRfX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 22 Jan 2016 12:35:23 -0500
Received: from int-mx09.intmail.prod.int.phx2.redhat.com (int-mx09.intmail.prod.int.phx2.redhat.com [10.5.11.22])
	by mx1.redhat.com (Postfix) with ESMTPS id 5584732D3C5
	for <ceph-devel@vger.kernel.org>; Fri, 22 Jan 2016 17:35:23 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1575597139.15885899.1453478438366.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Erwan Velu <evelu@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, The Sacred Order of the Squid Cybernetic <ceph-devel@vger.kernel.org>


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 22/01/2016, Erwan Velu wrote:
> Hey,
>=20
> I've been able to continue this work and updated by branch accordingly.
> I understand the benefit of using the ceph_time work but I feel that it m=
akes the change pretty verbose for a not a so big change (CLOCK_REALTIME vs=
 CLOCK_MONO).
>
> This imply a change of all utime_t and makes the computations a little bi=
t more complex to read.

There are a few changes one can use to make it less verbose. If you're not =
in a
header file (or inside a function), you might like to do:

using ceph::coarse_mono_clock;

(Don't do that in headers outside of functions, though.)

Then you can just do things like

auto now =3D mono_clock_coarse::now();

Which should be a bit less verbose.

Or even:

using cm_clock =3D ceph::coarse_mono_clock;

auto now =3D cm_clock::now();

> Does it worth the time spent on it ? If yes, I don't have any issue conti=
nuing this way.
> I'm pretty new to the project and would like to make the best PR as possi=
ble.
> So your insights on the under-work patch would be very helpful.

I think so. We definitely wnat to use monotonic clocks where appropriate. A=
nd we
can get a performance benefit from using coarse clocks where appropriate, t=
oo.
And we want to switch to the ceph_time stuff anyway just because it rules o=
ut a
whole class of bugs and integrates with standard and third-party libraries.

--=20
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9

--/04w6evG8XlLl3ft
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQF8BAEBCgBmBQJWomhUXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXREMUY1QjNFRjgyQTI1NjIxNkVERDQxQUNF
OEIyRUY4QzA3NUU1RTIzAAoJEOiy74wHXl4jIk0H/1yVCBgTDIH+goqLV5aR5CJX
PFV8wL+8H8J61caNgfqlOVMm+HVg77pxZeDxGDTr2U5QzbPA74bBJhfFDbkuXCVx
99t73LQYmYM3sTcVCBc2lsUe3LqdzA12+OI+rpsAJJ5OZjGwDWA0zWhjfLkDTBxP
9EsBk38VYlxAuu5bLM88XXMQCCBxCcbjtjY7kL4enDBSlomsLPGaKNr9W2XtDOoA
TNKnr/d859OIfubcG6OqVEMI+2k7K7j2TgtGSEPAbozqi9PF4j/DnSABSl7KRKYq
IiCJHYkmY/slaNfrmDG9UR4NYXm+eS98pOHm16p+ubSf5q7IAPJZXnj9iHLiJXY=
=Hv0F
-----END PGP SIGNATURE-----

--/04w6evG8XlLl3ft--
