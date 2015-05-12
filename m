From: Loic Dachary <loic@dachary.org>
Subject: Re: autodetecting init system.
Date: Tue, 12 May 2015 14:34:29 +0200
Message-ID: <5551F355.1090401@dachary.org>
References: <5550D903.8000802@suse.com> <555122EF.4090105@dachary.org> <5551B221.9070704@suse.com> <5551CBBC.2040303@dachary.org> <5551D599.8040603@suse.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="IeEAipwlDhOD2XHLPHVdK41ACk06IscBU"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:33682 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S932449AbbELMec (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 May 2015 08:34:32 -0400
In-Reply-To: <5551D599.8040603@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Owen Synge <osynge@suse.com>, ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--IeEAipwlDhOD2XHLPHVdK41ACk06IscBU
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable



On 12/05/2015 12:27, Owen Synge wrote:
> On 05/12/2015 11:45 AM, Loic Dachary wrote:
>=20
>=20
>> On 12/05/2015 09:56, Owen Synge wrote:
>>> On 05/11/2015 11:45 PM, Loic Dachary wrote:
>>>> Hi Owen,
>>>>
>>>> It would help to provide one or two use cases where (C) solves a pro=
blem=20
>>>> that (B) (that is the current ceph-detect-init approach) does not
>>>> solve.
>>>
>>>> I sense there is something better in (C) but I can't think of a use =
case=20
>>>> just now
>>>> (maybe because I've been thinking about erasure code all day :-).
>>>
>>> Hi Loic,
>>>
>>> Please note that I believe we are correct to explicitly allow the use=
r
>>> to specify the init system and override any auto detection.
>>>
>>> Hence I believe it is correct for autodetection to be able to fail.
>>>
>>> Use case (1)
>>> ~~~~~~~~~~~~
>>>
>>> When a new release of an operating system comes out with a different
>>> init system (B) as a static database will not immediately account for=

>>> this solution.
>>>
>>> For example
>>>
>>> SUSE SLE 11 -> sysV
>>> SUSE SLE 12 -> systemd
>>> RHEL 5 -> sysV
>>> RHEL 6 -> upstart
>>> RHEL 7 -> systemd
>>>
>>> When for example SLE12 came out ceph upstream code assumed ceph ran o=
n
>>> the sysV init system until appropriate patches where taken.
>=20
>> So Ceph failed to run on SLE12 because it was relying on sysV ?

That makes me curious about why it failed. There probably are similar pro=
blems with debian. Is there a tracker issue somewhere reporting this prob=
lem ?

> When we first released on SLE12 yes, I haven't yet checked the latest
> master.
>=20
> Also if someone was "unusual" and used gentoo, mint, or other OS not in=

> a database known OS, they might get "unusual" results.
>=20
> This is a use case example the use case is maybe beter stated:
>=20
> Handling of Operating systems which are not in the database of known
> operating systems.
>=20
> Best regards
>=20
> Owen
>=20
>=20
>=20
>>>
>>> Since we can only test on "free as in beer" operating systems at this=

>>> moment covering these OS's with the database and appropriate tests is=

>>> problematic.
>>>
>>> Use case (2)
>>> ~~~~~~~~~~~~
>>>
>>> The use cases are on the latest debian, ubuntu platforms.
>>>
>>> On both these platforms you can install alternative init systems.
>>>
>>> on debian stable I can apt-get install the following init systems:
>>>
>>> systemd
>>> upstart
>>> sysvinit
>>>
>>> Hence assuming all debian stable systems are systemd (the default) is=
 a
>>> false assumption as (B) does not support users changing the init syst=
em
>>> before installing ceph on debian and ubuntu as having a database of i=
nit
>>> systems cannot support all platforms.
>>>
>>> Use case (3)
>>> ~~~~~~~~~~~~
>>>
>>> By supporting (B) and (C) and emitting a warning on operating systems=

>>> not in the database, populating the database will be quicker, and
>>> correcting values in the database will be easier to verify.
>>>
>>> In some ways, the code tests its self, at run time.
>>>
>>> Summary:
>>> ~~~~~~~~
>>> I think its a value decision, is the extra complexity of doing (B) an=
d
>>> (C) worth the corner case of supporting the people who chose to use n=
on
>>> default init system worth the code complexity. If we are supporting m=
ore
>>> than one init detection mechanism, it may well be worth supporting al=
l
>>> of (A) (B) and (c).
>>>
>>> Best regards
>>>
>>> Owen
>>>
>>>
>>>
>>>> Cheers
>>>>
>>>> On 11/05/2015 18:29, Owen Synge wrote:
>>>>> Dear all,
>>>>>
>>>>> Many init systems are used in linux now. Some ceph code needs to kn=
ow
>>>>> the init system. (I must admit I have not looked into Solaris, MacO=
S and
>>>>> BSD and probably should have)
>>>>>
>>>>> It would be nice to have one function that detects the init system
>>>>>
>>>>> Since the init system can be specified in ceph and ceph-deploy
>>>>> explicitly it seems to be its reasonable to fail clearly to detect =
init
>>>>> system.
>>>>>
>>>>> I see 4 ways I can see to detect init system.
>>>>>
>>>>> (A) Check pid 1.
>>>>> (B) Use a database of OS to init mapping / compile time.
>>>>> (C) look for init manipulation tools and infure the init system fro=
m tools.
>>>>>
>>>>> Comments:
>>>>> ~~~~~~~~
>>>>>
>>>>> (A1) systmd can be detected easily with.
>>>>>
>>>>>  grep -qs systemd /proc/1/comm
>>>>>
>>>>> (A2) With init scripts such as its hard to know what the init syste=
m.
>>>>>
>>>>> (B1) For operating systems like RHEL, SLE, CENTOS, Fedora and scien=
tific
>>>>> linux this works well.
>>>>>
>>>>> (B2) FOr operating systems like newer debian and ubuntu releases mo=
re
>>>>> than one init system can be installed and used on the OS, so making=
 a
>>>>> database / doing it at compile time are not practical on all OS's
>>>>>
>>>>> (C1) This is fairly reliable.
>>>>>
>>>>> (C2) sysV tools have compatibility scripts / programs on other plat=
forms
>>>>> so if you use a points system for each init system helper script yo=
u can
>>>>> infure systemd over sysV if sytemctrl exists for example.
>>>>>
>>>>> So to summarise this:
>>>>> ~~~~~~~~~~~~~~~~~~~~
>>>>>
>>>>> (1) No one system is perfect in all cases.
>>>>> (2) Combined these systesm can provide reliable init system detecti=
on.
>>>>>
>>>>> My proposed approach.
>>>>> ~~~~~~~~~~~~~~~~~~~~
>>>>>
>>>>> (I) Use all three approaches where each approach can provide and an=
swer,
>>>>> or fail to provide an answer.
>>>>>
>>>>> (II) Should any approaches disagree -> fail to detect init system.
>>>>>
>>>>> (III) Should all approaches agree -> then return init system.
>>>>>
>>>>> (III) Should no approaches provide an init system -> fail to return=
 init
>>>>> system.
>>>>>
>>>>> Comments
>>>>> ~~~~~~~~
>>>>>
>>>>> This multi layered and comparing way of doing init systems may seem=

>>>>> complete overkill, or maybe its useful.
>>>>>
>>>>> What do you guys think?
>>>>>
>>>>> Best regards
>>>>>
>>>>> Owen
>>>>>
>>>>>
>>>>>
>>>>>
>>>>>
>>>>> --
>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
>>>>> the body of a message to majordomo@vger.kernel.org
>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>
>>>>
>>>
>=20
>=20
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--IeEAipwlDhOD2XHLPHVdK41ACk06IscBU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlVR81YACgkQ8dLMyEl6F20RLQCfZ57Ko7z9meNdQaCd56AyE3hZ
PjUAoJ5ZagljgRkSoh/9ZtR6rnhZlMEH
=sMs6
-----END PGP SIGNATURE-----

--IeEAipwlDhOD2XHLPHVdK41ACk06IscBU--
