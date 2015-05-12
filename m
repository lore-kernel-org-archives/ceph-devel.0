From: Loic Dachary <loic@dachary.org>
Subject: Re: autodetecting init system.
Date: Tue, 12 May 2015 11:45:32 +0200
Message-ID: <5551CBBC.2040303@dachary.org>
References: <5550D903.8000802@suse.com> <555122EF.4090105@dachary.org> <5551B221.9070704@suse.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="IfEd0K7vOFv9hrQJkVreqO95tO9AuXqpW"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:33583 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932307AbbELJpf (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 May 2015 05:45:35 -0400
In-Reply-To: <5551B221.9070704@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Owen Synge <osynge@suse.com>, ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IfEd0K7vOFv9hrQJkVreqO95tO9AuXqpW
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 12/05/2015 09:56, Owen Synge wrote:
> On 05/11/2015 11:45 PM, Loic Dachary wrote:
>> Hi Owen,
>>
>> It would help to provide one or two use cases where (C) solves a probl=
em=20
>> that (B) (that is the current ceph-detect-init approach) does not
>> solve.
>=20
>> I sense there is something better in (C) but I can't think of a use ca=
se=20
>> just now
>> (maybe because I've been thinking about erasure code all day :-).
>=20
> Hi Loic,
>=20
> Please note that I believe we are correct to explicitly allow the user
> to specify the init system and override any auto detection.
>=20
> Hence I believe it is correct for autodetection to be able to fail.
>=20
> Use case (1)
> ~~~~~~~~~~~~
>=20
> When a new release of an operating system comes out with a different
> init system (B) as a static database will not immediately account for
> this solution.
>=20
> For example
>=20
> SUSE SLE 11 -> sysV
> SUSE SLE 12 -> systemd
> RHEL 5 -> sysV
> RHEL 6 -> upstart
> RHEL 7 -> systemd
>=20
> When for example SLE12 came out ceph upstream code assumed ceph ran on
> the sysV init system until appropriate patches where taken.

So Ceph failed to run on SLE12 because it was relying on sysV ?

>=20
> Since we can only test on "free as in beer" operating systems at this
> moment covering these OS's with the database and appropriate tests is
> problematic.
>=20
> Use case (2)
> ~~~~~~~~~~~~
>=20
> The use cases are on the latest debian, ubuntu platforms.
>=20
> On both these platforms you can install alternative init systems.
>=20
> on debian stable I can apt-get install the following init systems:
>=20
> systemd
> upstart
> sysvinit
>=20
> Hence assuming all debian stable systems are systemd (the default) is a=

> false assumption as (B) does not support users changing the init system=

> before installing ceph on debian and ubuntu as having a database of ini=
t
> systems cannot support all platforms.
>=20
> Use case (3)
> ~~~~~~~~~~~~
>=20
> By supporting (B) and (C) and emitting a warning on operating systems
> not in the database, populating the database will be quicker, and
> correcting values in the database will be easier to verify.
>=20
> In some ways, the code tests its self, at run time.
>=20
> Summary:
> ~~~~~~~~
> I think its a value decision, is the extra complexity of doing (B) and
> (C) worth the corner case of supporting the people who chose to use non=

> default init system worth the code complexity. If we are supporting mor=
e
> than one init detection mechanism, it may well be worth supporting all
> of (A) (B) and (c).
>=20
> Best regards
>=20
> Owen
>=20
>=20
>=20
>> Cheers
>>
>> On 11/05/2015 18:29, Owen Synge wrote:
>>> Dear all,
>>>
>>> Many init systems are used in linux now. Some ceph code needs to know=

>>> the init system. (I must admit I have not looked into Solaris, MacOS =
and
>>> BSD and probably should have)
>>>
>>> It would be nice to have one function that detects the init system
>>>
>>> Since the init system can be specified in ceph and ceph-deploy
>>> explicitly it seems to be its reasonable to fail clearly to detect in=
it
>>> system.
>>>
>>> I see 4 ways I can see to detect init system.
>>>
>>> (A) Check pid 1.
>>> (B) Use a database of OS to init mapping / compile time.
>>> (C) look for init manipulation tools and infure the init system from =
tools.
>>>
>>> Comments:
>>> ~~~~~~~~
>>>
>>> (A1) systmd can be detected easily with.
>>>
>>>  grep -qs systemd /proc/1/comm
>>>
>>> (A2) With init scripts such as its hard to know what the init system.=

>>>
>>> (B1) For operating systems like RHEL, SLE, CENTOS, Fedora and scienti=
fic
>>> linux this works well.
>>>
>>> (B2) FOr operating systems like newer debian and ubuntu releases more=

>>> than one init system can be installed and used on the OS, so making a=

>>> database / doing it at compile time are not practical on all OS's
>>>
>>> (C1) This is fairly reliable.
>>>
>>> (C2) sysV tools have compatibility scripts / programs on other platfo=
rms
>>> so if you use a points system for each init system helper script you =
can
>>> infure systemd over sysV if sytemctrl exists for example.
>>>
>>> So to summarise this:
>>> ~~~~~~~~~~~~~~~~~~~~
>>>
>>> (1) No one system is perfect in all cases.
>>> (2) Combined these systesm can provide reliable init system detection=
=2E
>>>
>>> My proposed approach.
>>> ~~~~~~~~~~~~~~~~~~~~
>>>
>>> (I) Use all three approaches where each approach can provide and answ=
er,
>>> or fail to provide an answer.
>>>
>>> (II) Should any approaches disagree -> fail to detect init system.
>>>
>>> (III) Should all approaches agree -> then return init system.
>>>
>>> (III) Should no approaches provide an init system -> fail to return i=
nit
>>> system.
>>>
>>> Comments
>>> ~~~~~~~~
>>>
>>> This multi layered and comparing way of doing init systems may seem
>>> complete overkill, or maybe its useful.
>>>
>>> What do you guys think?
>>>
>>> Best regards
>>>
>>> Owen
>>>
>>>
>>>
>>>
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--IfEd0K7vOFv9hrQJkVreqO95tO9AuXqpW
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVRy7wACgkQ8dLMyEl6F22vSwCfbZbRy6yPMxP0EXvaCbSPpjn/
TL4An39c2bo5LDrnDVoAVf9VVvAUUPV2
=VfpW
-----END PGP SIGNATURE-----

--IfEd0K7vOFv9hrQJkVreqO95tO9AuXqpW--
