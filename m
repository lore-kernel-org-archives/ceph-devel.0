From: Karol Mroz <kmroz@suse.com>
Subject: Re: master build failure with boost 1.60
Date: Wed, 9 Mar 2016 11:58:11 +0100
Message-ID: <20160309105811.GB21590@pxe-sup5.sup.suse.de>
References: <20160307144944.GA21590@pxe-sup5.sup.suse.de>
 <CAANLjFq3bC+-3LZ4PzyqY5W5pSfHGVQp=BAW986M67P2g8K+dA@mail.gmail.com>
 <86io0wrn1s.fsf@linux-stsn.suse>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="8P1HSweYDcXXzwPJ"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp2.provo.novell.com ([137.65.250.81]:51406 "EHLO
	smtp2.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752934AbcCIK6Q (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Wed, 9 Mar 2016 05:58:16 -0500
Content-Disposition: inline
In-Reply-To: <86io0wrn1s.fsf@linux-stsn.suse>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>
Cc: Robert LeBlanc <robert@leblancnet.us>


--8P1HSweYDcXXzwPJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 09, 2016 at 10:57:35AM +0100, Abhishek L wrote:
>=20
> Robert LeBlanc writes:
>=20
> > -----BEGIN PGP SIGNED MESSAGE-----
> > Hash: SHA256
> >
> > Karol,
> >
> > I think I may have already resolved this with a patch I was already
> > working on. Can you pull in https://github.com/ceph/ceph/pull/7984 and
> > see if it resolves the issue?
>=20
> I tried applying 7984 atop of current master, it was still failing, on
> similar errors with WeightedPriorityQueue, here is a log http://ix.io/pYl
>=20

Hi Robert,

+1 here as well, with the same failure as seen in Abhishek's log above.

--=20
Regards,
Karol

--8P1HSweYDcXXzwPJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW4AHAAAoJECp28bThgzat214IAJO3mx2zAjcM59tT/BuFnsd9
i4OdvHkPWPJmXcmFzzIlJppv5km1B9d16scBDNeEUqkC9Y7jmFRNcZoJcviGqodX
SDYp7ZeElOURhDiUVsatTeoRpX+eJlh+awSCeDj5aiXtfMJJtgxWajoX3CXBUhmC
P2lhvSyDlv5pRrqlbrq9LlvIHh1hUhaQ7t/47VozeLKpaC0XY+MrWylRg4n+JjHN
J1JOsQDqCSBOnL7tSJ+LYm3krQmGzoiYfQSJ7bUqeWeH/7IO7jpzmmeCHzcvCYpQ
wi2sBYB6e3p5yAkX5IWIqUZqoB/kjpk9EuWB+g2skUjcPAyfSfEAVst7CIBuHI4=
=Ti1j
-----END PGP SIGNATURE-----

--8P1HSweYDcXXzwPJ--
