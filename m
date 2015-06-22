From: Loic Dachary <loic@dachary.org>
Subject: Re: firefly v0.80.10 QE validation completed
Date: Mon, 22 Jun 2015 04:48:19 -0400
Message-ID: <5587CBD3.5020804@dachary.org>
References: <887573759.22073065.1434386240075.JavaMail.zimbra@redhat.com>	 <628525610.25137687.1434591207216.JavaMail.zimbra@redhat.com> <1434958820.2806.3.camel@daevel.fr>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="VuftoRN7P9UIEv7iKKvSI4vmPTc3I5462"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:38000 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753446AbbFVIsY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Jun 2015 04:48:24 -0400
In-Reply-To: <1434958820.2806.3.camel@daevel.fr>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Olivier Bonvalet <ceph.list@daevel.fr>, Yuri Weinstein <yweinste@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>
Cc: Loic Dachary <ldachary@redhat.com>, Xinxin Shu <xinxin.shu@intel.com>, Alfredo Deza <adeza@redhat.com>, Sage Weil <sweil@redhat.com>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VuftoRN7P9UIEv7iKKvSI4vmPTc3I5462
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable


Hi Olivier,

On 22/06/2015 03:40, Olivier Bonvalet wrote:
> Hi,
>=20
> I saw the proposed upgrade to 0.80.10 this morning, but can't find the
> announce about this (neither by email or on the website).
>=20
> Is the 0.80.10 ready to be used ?
>=20

The QE validation is the last step before it is published. But it's not p=
ublished yet. You can track progress at http://tracker.ceph.com/issues/11=
090

Cheers

> thanks,
> Olivier
>=20
> Le mercredi 17 juin 2015 =C3=A0 21:33 -0400, Yuri Weinstein a =C3=A9cri=
t :
>> firefly v0.80.10 is ready for publishing (Sage, Alfredo, Loic, Xinxin =

>> FYI)
>>
>> All results details were summarized in=20
>> http://tracker.ceph.com/issues/11090
>>
>> Note:
>>
>> - upgrade/dumpling-firefly-x (to hammer)(distros) - runs out of=20
>> memory on vps and unreliable
>> - #11957 fixed (thanks Ilya, Zack!) and tested
>>
>> Thx
>> YuriW
>>
>> ----- Original Message -----
>> From: "Yuri Weinstein" <yweinste@redhat.com>
>> To: "Ceph Development" <ceph-devel@vger.kernel.org>
>> Cc: "Loic Dachary" <ldachary@redhat.com>, "Xinxin Shu" <
>> xinxin.shu@intel.com>
>> Sent: Monday, June 15, 2015 9:37:20 AM
>> Subject: firefly v0.80.10 QE validation status 6/15/2015
>>
>> QE validation is almost completed (there are a couple of jobs that=20
>> are still running)
>>
>> All statis details were summarized in=20
>> http://tracker.ceph.com/issues/11090
>>
>> Highlights (by suite/issue):
>>
>> rados #11914 needs Sam's approval
>> kcephfs n/a needs Greg's approval
>> samba #6613 needs Greg's approval
>>
>> Nice to have fixes (no blockers):
>> upgrade/firefly(distros) #11957	(env noise)
>>
>>
>> Thx
>> YuriW
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =

>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =

>> in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--VuftoRN7P9UIEv7iKKvSI4vmPTc3I5462
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlWHy9MACgkQ8dLMyEl6F20XOwCffhy8VSKrSu0sdsbxwTCWJote
d+IAoI2G4vJ9T3nnbfw06novJ5lH/Gk6
=aQXc
-----END PGP SIGNATURE-----

--VuftoRN7P9UIEv7iKKvSI4vmPTc3I5462--
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
