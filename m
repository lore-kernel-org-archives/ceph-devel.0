From: Owen Synge <osynge@suse.com>
Subject: Re: autodetecting init system.
Date: Tue, 12 May 2015 12:27:37 +0200
Message-ID: <5551D599.8040603@suse.com>
References: <5550D903.8000802@suse.com> <555122EF.4090105@dachary.org> <5551B221.9070704@suse.com> <5551CBBC.2040303@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:59887 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214AbbELK2x (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Tue, 12 May 2015 06:28:53 -0400
In-Reply-To: <5551CBBC.2040303@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, ceph-devel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On 05/12/2015 11:45 AM, Loic Dachary wrote:
>=20
>=20
> On 12/05/2015 09:56, Owen Synge wrote:
>> On 05/11/2015 11:45 PM, Loic Dachary wrote:
>>> Hi Owen,
>>>
>>> It would help to provide one or two use cases where (C) solves a pr=
oblem=20
>>> that (B) (that is the current ceph-detect-init approach) does not
>>> solve.
>>
>>> I sense there is something better in (C) but I can't think of a use=
 case=20
>>> just now
>>> (maybe because I've been thinking about erasure code all day :-).
>>
>> Hi Loic,
>>
>> Please note that I believe we are correct to explicitly allow the us=
er
>> to specify the init system and override any auto detection.
>>
>> Hence I believe it is correct for autodetection to be able to fail.
>>
>> Use case (1)
>> ~~~~~~~~~~~~
>>
>> When a new release of an operating system comes out with a different
>> init system (B) as a static database will not immediately account fo=
r
>> this solution.
>>
>> For example
>>
>> SUSE SLE 11 -> sysV
>> SUSE SLE 12 -> systemd
>> RHEL 5 -> sysV
>> RHEL 6 -> upstart
>> RHEL 7 -> systemd
>>
>> When for example SLE12 came out ceph upstream code assumed ceph ran =
on
>> the sysV init system until appropriate patches where taken.
>=20
> So Ceph failed to run on SLE12 because it was relying on sysV ?

When we first released on SLE12 yes, I haven't yet checked the latest
master.

Also if someone was "unusual" and used gentoo, mint, or other OS not in
a database known OS, they might get "unusual" results.

This is a use case example the use case is maybe beter stated:

Handling of Operating systems which are not in the database of known
operating systems.

Best regards

Owen



>>
>> Since we can only test on "free as in beer" operating systems at thi=
s
>> moment covering these OS's with the database and appropriate tests i=
s
>> problematic.
>>
>> Use case (2)
>> ~~~~~~~~~~~~
>>
>> The use cases are on the latest debian, ubuntu platforms.
>>
>> On both these platforms you can install alternative init systems.
>>
>> on debian stable I can apt-get install the following init systems:
>>
>> systemd
>> upstart
>> sysvinit
>>
>> Hence assuming all debian stable systems are systemd (the default) i=
s a
>> false assumption as (B) does not support users changing the init sys=
tem
>> before installing ceph on debian and ubuntu as having a database of =
init
>> systems cannot support all platforms.
>>
>> Use case (3)
>> ~~~~~~~~~~~~
>>
>> By supporting (B) and (C) and emitting a warning on operating system=
s
>> not in the database, populating the database will be quicker, and
>> correcting values in the database will be easier to verify.
>>
>> In some ways, the code tests its self, at run time.
>>
>> Summary:
>> ~~~~~~~~
>> I think its a value decision, is the extra complexity of doing (B) a=
nd
>> (C) worth the corner case of supporting the people who chose to use =
non
>> default init system worth the code complexity. If we are supporting =
more
>> than one init detection mechanism, it may well be worth supporting a=
ll
>> of (A) (B) and (c).
>>
>> Best regards
>>
>> Owen
>>
>>
>>
>>> Cheers
>>>
>>> On 11/05/2015 18:29, Owen Synge wrote:
>>>> Dear all,
>>>>
>>>> Many init systems are used in linux now. Some ceph code needs to k=
now
>>>> the init system. (I must admit I have not looked into Solaris, Mac=
OS and
>>>> BSD and probably should have)
>>>>
>>>> It would be nice to have one function that detects the init system
>>>>
>>>> Since the init system can be specified in ceph and ceph-deploy
>>>> explicitly it seems to be its reasonable to fail clearly to detect=
 init
>>>> system.
>>>>
>>>> I see 4 ways I can see to detect init system.
>>>>
>>>> (A) Check pid 1.
>>>> (B) Use a database of OS to init mapping / compile time.
>>>> (C) look for init manipulation tools and infure the init system fr=
om tools.
>>>>
>>>> Comments:
>>>> ~~~~~~~~
>>>>
>>>> (A1) systmd can be detected easily with.
>>>>
>>>>  grep -qs systemd /proc/1/comm
>>>>
>>>> (A2) With init scripts such as its hard to know what the init syst=
em.
>>>>
>>>> (B1) For operating systems like RHEL, SLE, CENTOS, Fedora and scie=
ntific
>>>> linux this works well.
>>>>
>>>> (B2) FOr operating systems like newer debian and ubuntu releases m=
ore
>>>> than one init system can be installed and used on the OS, so makin=
g a
>>>> database / doing it at compile time are not practical on all OS's
>>>>
>>>> (C1) This is fairly reliable.
>>>>
>>>> (C2) sysV tools have compatibility scripts / programs on other pla=
tforms
>>>> so if you use a points system for each init system helper script y=
ou can
>>>> infure systemd over sysV if sytemctrl exists for example.
>>>>
>>>> So to summarise this:
>>>> ~~~~~~~~~~~~~~~~~~~~
>>>>
>>>> (1) No one system is perfect in all cases.
>>>> (2) Combined these systesm can provide reliable init system detect=
ion.
>>>>
>>>> My proposed approach.
>>>> ~~~~~~~~~~~~~~~~~~~~
>>>>
>>>> (I) Use all three approaches where each approach can provide and a=
nswer,
>>>> or fail to provide an answer.
>>>>
>>>> (II) Should any approaches disagree -> fail to detect init system.
>>>>
>>>> (III) Should all approaches agree -> then return init system.
>>>>
>>>> (III) Should no approaches provide an init system -> fail to retur=
n init
>>>> system.
>>>>
>>>> Comments
>>>> ~~~~~~~~
>>>>
>>>> This multi layered and comparing way of doing init systems may see=
m
>>>> complete overkill, or maybe its useful.
>>>>
>>>> What do you guys think?
>>>>
>>>> Best regards
>>>>
>>>> Owen
>>>>
>>>>
>>>>
>>>>
>>>>
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe ceph-dev=
el" in
>>>> the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>
>>>
>>
>=20

- --=20
SUSE LINUX GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imend=C3=B6rffer,=
 HRB
21284 (AG
N=C3=BCrnberg)

Maxfeldstra=C3=9Fe 5

90409 N=C3=BCrnberg

Germany
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBAgAGBQJVUdWZAAoJECe/2BuiZiboAjwIAJGTYQZ20VLwExjFJHMeYtbO
MfeIPTYOc5DislnkjLWT2eUjgejqBR6Hg5pBcl+/Xw6i7CrTnpSk82dO//JvWjwo
bE2LHA/os0ssSivkzg2u1eslEYTEy1fspQzDiZv4k5L/6b+M9AAxkzxInYs8HUhi
KcOw2BB92SToOQPSLdRtRcYdpCILTKWALy3LzbySIJdZXAv0BD4EYiNJax7CWH+A
tfMmV1CTGduOCsAOmgTfFOcaL8DsDom4TSnp1Vqn2mNVEaChH4CmOpKsWW6ThXQ8
bjRhoTMZ20ZBbewfnfgulKMM1+tilnw4B4rA92F8ElfGgdrH49WvCLP8LjKD9EU=3D
=3DinsW
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
