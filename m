From: Loic Dachary <loic@dachary.org>
Subject: Re: arm7 gitbuilder ?
Date: Sat, 11 Oct 2014 00:21:13 +0200
Message-ID: <54385BD9.6080904@dachary.org>
References: <5437A6C0.3000005@dachary.org>	<alpine.DEB.2.00.1410100809370.28531@cobra.newdream.net>	<5438134E.7050009@dachary.org>	<alpine.DEB.2.00.1410101014200.28531@cobra.newdream.net>	<CA+Hcz5_gwQdZ15EyJBfzxU05bDp0Pbdcgfqtv_=N5Q9Zm62FdQ@mail.gmail.com>	<5438307C.4060701@dachary.org>	<CA+Hcz58UV8-eEbbV8uJrg5xaS+DCdueZAmRDwdtuVQTzfSPgSw@mail.gmail.com>	<5438558C.7060304@dachary.org> <CA+Hcz5_xuNtgRrk_VPS+Cx76pROyZyTPEOEfs=D11dOTL=rTVA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="qexJRU2OtaExSgIvKFFSu6DC5bv1tWek3"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:42310 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751498AbaJJWVP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Oct 2014 18:21:15 -0400
In-Reply-To: <CA+Hcz5_xuNtgRrk_VPS+Cx76pROyZyTPEOEfs=D11dOTL=rTVA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Noah Watkins <noah.watkins@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--qexJRU2OtaExSgIvKFFSu6DC5bv1tWek3
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable



On 11/10/2014 00:17, Noah Watkins wrote:
> On Fri, Oct 10, 2014 at 2:54 PM, Loic Dachary <loic@dachary.org> wrote:=

>> I would be surprised if it could easily be setup for cross compilation=
=2E Although it would be nice to have an ARMv8 I don't need it right now.=
 Do you ?
>=20
> Potentially. I'll poke around a bit and see. Maybe we can run 32-bit
> builds on ARMv8. I'm not in a huge rush, and can always build from
> source on those boxes, as cross-compiling might be a major headache :)

You are lucky to have access to ARMv8 boxes :-) Would you be willing to r=
un a few tests on my behalf ?

Cheers

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--qexJRU2OtaExSgIvKFFSu6DC5bv1tWek3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlQ4W9kACgkQ8dLMyEl6F20NRwCfbADWNKdbml/Zcf9YJe4SkHzH
4x8AniQQyEf8Lq4cclSAjZhGnGk8WidP
=HdrP
-----END PGP SIGNATURE-----

--qexJRU2OtaExSgIvKFFSu6DC5bv1tWek3--
