From: Loic Dachary <loic@dachary.org>
Subject: Re: firefly branch for v0.80.10 ready for QE
Date: Fri, 05 Jun 2015 19:26:20 +0200
Message-ID: <5571DBBC.8050908@dachary.org>
References: <5568915D.3040005@dachary.org> <557167D0.40201@dachary.org> <1372965780.14838160.1433516098283.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="bgD4T67BqFqwih1Qos1pX3r78ptVEwvuS"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:56996 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1754791AbbFER0X (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Jun 2015 13:26:23 -0400
In-Reply-To: <1372965780.14838160.1433516098283.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Xinxin Shu <xinxin.shu@intel.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bgD4T67BqFqwih1Qos1pX3r78ptVEwvuS
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 05/06/2015 16:54, Yuri Weinstein wrote:
> Loic
>=20
> Thx for the heads up.
>=20
> Would that touch only the "rgw" suite?

Yes.

>=20
> Thx
> YuriW
>=20
> ----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Yuri Weinstein" <yweinste@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>, "Xinxin Shu" <xinx=
in.shu@intel.com>
> Sent: Friday, June 5, 2015 2:11:44 AM
> Subject: Re: firefly branch for v0.80.10 ready for QE
>=20
> Hi Yuri,
>=20
> A month passed since this mail was sent and the firefly branch has a fe=
w additional commits. All but one (https://github.com/ceph/ceph/pull/4829=
 with more information at http://tracker.ceph.com/issues/11890) have been=
 tested. This exception seems harmless but I thought you should know.=20
>=20
> For the record, the head of the firefly branch now is https://github.co=
m/ceph/ceph/commit/d0f9c5f47024f53b4eccea2e0fde9b7844746362 and http://tr=
acker.ceph.com/issues/11090#Release-information has been updated accordin=
gly.
>=20
> Cheers
>=20
> On 29/05/2015 18:18, Loic Dachary wrote:> Hi Yuri,
>>
>> The firefly branch for v0.80.10 as found at https://github.com/ceph/ce=
ph/commits/firefly has been approved by Greg, Yehuda, Josh and Sam and is=
 ready for QE. For the record, the head is https://github.com/ceph/ceph/c=
ommit/071c94385ee71b86c5ed8363d56cf299da1aa7b3 and the details of the tes=
ts run are at http://tracker.ceph.com/issues/11090
>>
>> Cheers
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--bgD4T67BqFqwih1Qos1pX3r78ptVEwvuS
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVx27wACgkQ8dLMyEl6F20pqwCgrINklrhWqo77XJY2DZsnIFg3
uMEAoLxIvkte9IQkKv0yWFpYuAVi3pzj
=iCPM
-----END PGP SIGNATURE-----

--bgD4T67BqFqwih1Qos1pX3r78ptVEwvuS--
