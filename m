From: Loic Dachary <loic@dachary.org>
Subject: Re: qemu jemalloc support soon in master (applied in paolo upstream
 branch)
Date: Tue, 08 Sep 2015 13:12:45 +0200
Message-ID: <55EEC2AD.2000404@dachary.org>
References: <1583693791.33394679.1441709895629.JavaMail.zimbra@oxygem.tv>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="dDv7WDNJ7JFQfDh9UPRRheO6AIsUOgfD3"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:51584 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753254AbbIHLMr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 8 Sep 2015 07:12:47 -0400
In-Reply-To: <1583693791.33394679.1441709895629.JavaMail.zimbra@oxygem.tv>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alexandre DERUMIER <aderumier@odiso.com>, ceph-devel <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--dDv7WDNJ7JFQfDh9UPRRheO6AIsUOgfD3
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Cool !

On 08/09/2015 12:58, Alexandre DERUMIER wrote:
> Hi,
>=20
> Paolo Bonzini from qemu team has finally applied my qemu jemalloc patch=
=20
> in his for-upstream branch
>=20
> https://github.com/bonzini/qemu/releases/tag/for-upstream
> https://github.com/bonzini/qemu/tree/for-upstream
>=20
> So,It'll be in qemu master soon and ready for qemu 2.5
>=20
>=20
> I have write some small benchmark results with librbd in the commit its=
elf
> https://github.com/bonzini/qemu/commit/efc1e9f08020cd460eb2204e3092b39e=
408e1fa9
>=20
>=20
> you simply need to compile qemu with --enable-jemalloc, to enable jemma=
loc support.
>=20
> Regards,
>=20
> Alexandre
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--dDv7WDNJ7JFQfDh9UPRRheO6AIsUOgfD3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlXuwq0ACgkQ8dLMyEl6F227cgCfapw00aM+13FV6+HOi5qx+zAb
cCAAnA7COaybtjtbiT4NGgqgoxjUluXT
=sjTo
-----END PGP SIGNATURE-----

--dDv7WDNJ7JFQfDh9UPRRheO6AIsUOgfD3--
