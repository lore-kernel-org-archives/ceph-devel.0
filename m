From: Loic Dachary <loic@dachary.org>
Subject: Re: firefly branch for v0.80.10 ready for QE
Date: Fri, 05 Jun 2015 20:08:21 +0200
Message-ID: <5571E595.9040801@dachary.org>
References: <5568915D.3040005@dachary.org> <557167D0.40201@dachary.org> <1372965780.14838160.1433516098283.JavaMail.zimbra@redhat.com> <5571DBBC.8050908@dachary.org> <1235437871.15043015.1433526463363.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="E2e54ex6B2IrDInnw0XLulUgamuCMbR2C"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:57027 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752594AbbFESIY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 5 Jun 2015 14:08:24 -0400
In-Reply-To: <1235437871.15043015.1433526463363.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yuri Weinstein <yweinste@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, Xinxin Shu <xinxin.shu@intel.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--E2e54ex6B2IrDInnw0XLulUgamuCMbR2C
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

We have Nathan to thank for catching this today ;-)

On 05/06/2015 19:47, Yuri Weinstein wrote:
> Then it still in the queue and I will reschedule to pick up the latest =
code.
>=20
> Thx
> YuriW
>=20
> ----- Original Message -----
> From: "Loic Dachary" <loic@dachary.org>
> To: "Yuri Weinstein" <yweinste@redhat.com>
> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>, "Xinxin Shu" <xinx=
in.shu@intel.com>
> Sent: Friday, June 5, 2015 10:26:20 AM
> Subject: Re: firefly branch for v0.80.10 ready for QE
>=20
>=20
>=20
> On 05/06/2015 16:54, Yuri Weinstein wrote:
>> Loic
>>
>> Thx for the heads up.
>>
>> Would that touch only the "rgw" suite?
>=20
> Yes.
>=20
>>
>> Thx
>> YuriW
>>
>> ----- Original Message -----
>> From: "Loic Dachary" <loic@dachary.org>
>> To: "Yuri Weinstein" <yweinste@redhat.com>
>> Cc: "Ceph Development" <ceph-devel@vger.kernel.org>, "Xinxin Shu" <xin=
xin.shu@intel.com>
>> Sent: Friday, June 5, 2015 2:11:44 AM
>> Subject: Re: firefly branch for v0.80.10 ready for QE
>>
>> Hi Yuri,
>>
>> A month passed since this mail was sent and the firefly branch has a f=
ew additional commits. All but one (https://github.com/ceph/ceph/pull/482=
9 with more information at http://tracker.ceph.com/issues/11890) have bee=
n tested. This exception seems harmless but I thought you should know.=20
>>
>> For the record, the head of the firefly branch now is https://github.c=
om/ceph/ceph/commit/d0f9c5f47024f53b4eccea2e0fde9b7844746362 and http://t=
racker.ceph.com/issues/11090#Release-information has been updated accordi=
ngly.
>>
>> Cheers
>>
>> On 29/05/2015 18:18, Loic Dachary wrote:> Hi Yuri,
>>>
>>> The firefly branch for v0.80.10 as found at https://github.com/ceph/c=
eph/commits/firefly has been approved by Greg, Yehuda, Josh and Sam and i=
s ready for QE. For the record, the head is https://github.com/ceph/ceph/=
commit/071c94385ee71b86c5ed8363d56cf299da1aa7b3 and the details of the te=
sts run are at http://tracker.ceph.com/issues/11090
>>>
>>> Cheers
>>>
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--E2e54ex6B2IrDInnw0XLulUgamuCMbR2C
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVx5ZUACgkQ8dLMyEl6F20PlgCdH1u5H+Ltv9urqnwkm5kdWQa0
Bg4AnjwlPjt4MvGbotGrELgWbzWNrKUR
=6Vd/
-----END PGP SIGNATURE-----

--E2e54ex6B2IrDInnw0XLulUgamuCMbR2C--
