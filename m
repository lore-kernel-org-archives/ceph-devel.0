From: Karol Mroz <kmroz@suse.de>
Subject: Re: 12.2.2 status
Date: Mon, 30 Oct 2017 13:38:44 -0700
Message-ID: <1495E835-20EE-4D3E-823E-A8D1260AEDD3@suse.de>
References: <87fua6c4xy.fsf@suse.com>
 <CADRKj5RuqjfQQoK+ri+WLqh07O9snWvsKSfr+83GmmRtBYiBHw@mail.gmail.com>
 <FCD206E6-9E88-478C-9230-D0FAD0F8BA4F@suse.de>
 <393a5637-16da-2c2f-36ab-334fddc01db1@redhat.com>
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Content-Type: multipart/signed;
 boundary="Apple-Mail=_265BD1C8-3D0E-4A9A-B004-55113589F48E";
 protocol="application/pgp-signature"; micalg=pgp-sha512
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.suse.de ([195.135.220.15]:45239 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752735AbdJ3Uip (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 30 Oct 2017 16:38:45 -0400
In-Reply-To: <393a5637-16da-2c2f-36ab-334fddc01db1@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Casey Bodley <cbodley@redhat.com>
Cc: Yehuda Sadeh-Weinraub <yehuda@redhat.com>, Abhishek Lekshmanan <abhishek@suse.com>, ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@newdream.net>, Matt Benjamin <mbenjamin@redhat.com>, "Dillaman, Jason" <dillaman@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, "Durgin, Josh" <jdurgin@redhat.com>


--Apple-Mail=_265BD1C8-3D0E-4A9A-B004-55113589F48E
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=utf-8

Hey Casey,

Please see inline=E2=80=A6

> On Oct 27, 2017, at 6:57 AM, Casey Bodley <cbodley@redhat.com> wrote:
>=20
>=20
>=20
> On 10/26/2017 06:48 PM, Karol Mroz wrote:
>> +CC Casey
>>=20
>> Hi Yehuda and Casey,
>>=20
>>=20
>>> On Oct 26, 2017, at 9:50 AM, Yehuda Sadeh-Weinraub =
<yehuda@redhat.com> wrote:
>> [=E2=80=A6]
>>> I'd be happy to see these fixed:
>>> http://tracker.ceph.com/issues/21819
>> Opened backport ticket http://tracker.ceph.com/issues/21937
>> https://github.com/ceph/ceph/pull/18539
>>=20
>>=20
>>> http://tracker.ceph.com/issues/21735
>> Opened backport ticket http://tracker.ceph.com/issues/21938
>> Final commit of https://github.com/ceph/ceph/pull/18198 appears =
dependent on at least: cbb84cb13db and 53526d5050a in master.  Please =
advise.
>=20
> resolved this conflict in https://github.com/ceph/ceph/pull/18591

Awesome, thanks!

>=20
>>> however, these are not in master yet, need validation.
>>>=20
>>> This one is ready I think:
>>> http://tracker.ceph.com/issues/21500
>> Opened: http://tracker.ceph.com/issues/21939
>> https://github.com/ceph/ceph/pull/18569
>>   - Still need https://github.com/ceph/s3-tests/pull/189 backported =
to ceph-luminous branch of s3tests
>=20
> do you want me to cherry-pick that s3test before the backport merges? =
it's likely to cause failures for teuthology runs that don't include =
https://github.com/ceph/ceph/pull/18569

Taken care of here: https://github.com/ceph/s3-tests/pull/193  If you =
could please take a look.

Regards,
Karol Mroz
kmroz@suse.de




--Apple-Mail=_265BD1C8-3D0E-4A9A-B004-55113589F48E
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename=signature.asc
Content-Type: application/pgp-signature;
	name=signature.asc
Content-Description: Message signed with OpenPGP

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCgAdFiEE8+xsF/Gq4ohtXtiEKnbxtOGDNq0FAln3jdQACgkQKnbxtOGD
Nq3ITwf8DGlE6/NtJEfU/oeSodfgjjL3IfQgG8Mw5tD2S0jaWpD8KXPBX1iGhZSo
lUph+CS+Lg4bzdxKaVzqLL6y4PR/jCkCy/k6p7cKLZQBfbmh0+6XocxUvqbJ7Cem
MaGvYEV8gJd/7Pt18ZiSQlUNe5yRKakRux9+XEjmZElhcxeEaUdMSHQ2ueUgcHzq
/E5rF79dawI5MRXX6Hw5H6j552ad6CPOA+QYxq9K2iwjvx9L2AvI3Oyr+N6PmnOh
1/gRL7pOYgCu09bGXg5IghqRRH+hMte7Z43QFDZ7yqJfQzITu2v7t1/JdDh5kO6i
y3STW/jci4eU5yUxuNU1mE2whPvI/Q==
=FOUV
-----END PGP SIGNATURE-----

--Apple-Mail=_265BD1C8-3D0E-4A9A-B004-55113589F48E--
