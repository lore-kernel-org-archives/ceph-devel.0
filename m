From: Loic Dachary <loic@dachary.org>
Subject: Re: teuthology and code coverage revisited
Date: Wed, 06 Mar 2013 00:05:24 +0100
Message-ID: <51367A34.1080207@dachary.org>
References: <513530E6.4000705@dachary.org> <51362BCC.6030307@inktank.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigD729C00E4130104C131039B8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:48405 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752694Ab3CEXF2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 5 Mar 2013 18:05:28 -0500
In-Reply-To: <51362BCC.6030307@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigD729C00E4130104C131039B8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 03/05/2013 06:30 PM, Josh Durgin wrote:
> On 03/04/2013 03:40 PM, Loic Dachary wrote:
>> CommandFailedError: Command failed on 10.20.0.7 with status 1: 'rmdir =
-- /tmp/cephtest/ubuntu@teuthology-2013-03-04_21-03-19'
>> DEBUG:teuthology.run_tasks:Exception was not quenched, exiting: Except=
ion: failed to fetch package version from http://gitbuilder.ceph.com/ceph=
-deb-quantal-x86_64-gcov/ref/master/version
>> INFO:teuthology.run:Summary data:
>=20
> There's only one gitbuilder that is configured --enable-coverage, and
> that one is for precise, hence the error fetching a gcov package for
> quantal. You can see them all at: http://ceph.com/gitbuilder.cgi

Hi Josh,

Thanks for clarifying this. I'll re-build the targets with precise.

Cheers

>=20
> Josh
> --=20
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--------------enigD729C00E4130104C131039B8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlE2ejQACgkQ8dLMyEl6F21tDwCfZCe4UCFGxzg1qg/mVSCtZLRY
RlEAoI78Czwa2lyB5KSDTiIke1QwtbZZ
=n8XR
-----END PGP SIGNATURE-----

--------------enigD729C00E4130104C131039B8--
