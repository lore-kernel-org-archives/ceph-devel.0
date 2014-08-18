From: Loic Dachary <loic@dachary.org>
Subject: Re: Stopping ceph daemons during the upgrade
Date: Mon, 18 Aug 2014 18:24:34 +0200
Message-ID: <53F228C2.4070206@dachary.org>
References: <53F21994.5000202@dachary.org> <A856D71F-CC6F-4A6A-B29B-FD19FB511482@cern.ch> <53F22300.6080702@dachary.org> <alpine.DEB.2.00.1408180907501.28244@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="GolVLS5FoqUmkKR1WTN7IFnFBc5Fp0eHb"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:33388 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750977AbaHRQYg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Aug 2014 12:24:36 -0400
In-Reply-To: <alpine.DEB.2.00.1408180907501.28244@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Dan Van Der Ster <daniel.vanderster@cern.ch>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GolVLS5FoqUmkKR1WTN7IFnFBc5Fp0eHb
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Good idea :-)

On 18/08/2014 18:08, Sage Weil wrote:
> On Mon, 18 Aug 2014, Loic Dachary wrote:
>> Hi Dan,
>>
>> Pre-loading the erasure code plugins will reduce this race condition=20
>> (i.e. the files will have to be modified between the start of the=20
>> ceph-osd process and the bootstrap phase where it loads the plugins fo=
r=20
>> it to happen) and it seems to be preferable to stopping the daemons.=20
>> Thanks for giving an additional incentive to go in this direction !
>=20
> BTW Loic, one other thing would could do is have a number or string in =
the=20
> .so interface that we bump when the interface changes.  Then loading th=
e=20
> plugin could fail with a friendly message instead of crashing.
>=20
> sage
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--GolVLS5FoqUmkKR1WTN7IFnFBc5Fp0eHb
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlPyKMIACgkQ8dLMyEl6F21gcACfXEfe3FWW4JFuDNho7jogG3hc
HlsAoKKHJ4Y2SGYrL0VNyoHHAOtHQUuc
=H/lw
-----END PGP SIGNATURE-----

--GolVLS5FoqUmkKR1WTN7IFnFBc5Fp0eHb--
