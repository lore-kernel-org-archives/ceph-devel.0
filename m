From: Owen Synge <osynge@suse.com>
Subject: Re: autodetecting init system.
Date: Tue, 12 May 2015 09:56:17 +0200
Message-ID: <5551B221.9070704@suse.com>
References: <5550D903.8000802@suse.com> <555122EF.4090105@dachary.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:43632 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752752AbbELH5W (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Tue, 12 May 2015 03:57:22 -0400
In-Reply-To: <555122EF.4090105@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Loic Dachary <loic@dachary.org>, ceph-devel@vger.kernel.org

On 05/11/2015 11:45 PM, Loic Dachary wrote:
> Hi Owen,
>=20
> It would help to provide one or two use cases where (C) solves a prob=
lem=20
> that (B) (that is the current ceph-detect-init approach) does not
> solve.

> I sense there is something better in (C) but I can't think of a use c=
ase=20
> just now
> (maybe because I've been thinking about erasure code all day :-).

Hi Loic,

Please note that I believe we are correct to explicitly allow the user
to specify the init system and override any auto detection.

Hence I believe it is correct for autodetection to be able to fail.

Use case (1)
~~~~~~~~~~~~

When a new release of an operating system comes out with a different
init system (B) as a static database will not immediately account for
this solution.

=46or example

SUSE SLE 11 -> sysV
SUSE SLE 12 -> systemd
RHEL 5 -> sysV
RHEL 6 -> upstart
RHEL 7 -> systemd

When for example SLE12 came out ceph upstream code assumed ceph ran on
the sysV init system until appropriate patches where taken.

Since we can only test on "free as in beer" operating systems at this
moment covering these OS's with the database and appropriate tests is
problematic.

Use case (2)
~~~~~~~~~~~~

The use cases are on the latest debian, ubuntu platforms.

On both these platforms you can install alternative init systems.

on debian stable I can apt-get install the following init systems:

systemd
upstart
sysvinit

Hence assuming all debian stable systems are systemd (the default) is a
false assumption as (B) does not support users changing the init system
before installing ceph on debian and ubuntu as having a database of ini=
t
systems cannot support all platforms.

Use case (3)
~~~~~~~~~~~~

By supporting (B) and (C) and emitting a warning on operating systems
not in the database, populating the database will be quicker, and
correcting values in the database will be easier to verify.

In some ways, the code tests its self, at run time.

Summary:
~~~~~~~~
I think its a value decision, is the extra complexity of doing (B) and
(C) worth the corner case of supporting the people who chose to use non
default init system worth the code complexity. If we are supporting mor=
e
than one init detection mechanism, it may well be worth supporting all
of (A) (B) and (c).

Best regards

Owen



> Cheers
>=20
> On 11/05/2015 18:29, Owen Synge wrote:
>> Dear all,
>>
>> Many init systems are used in linux now. Some ceph code needs to kno=
w
>> the init system. (I must admit I have not looked into Solaris, MacOS=
 and
>> BSD and probably should have)
>>
>> It would be nice to have one function that detects the init system
>>
>> Since the init system can be specified in ceph and ceph-deploy
>> explicitly it seems to be its reasonable to fail clearly to detect i=
nit
>> system.
>>
>> I see 4 ways I can see to detect init system.
>>
>> (A) Check pid 1.
>> (B) Use a database of OS to init mapping / compile time.
>> (C) look for init manipulation tools and infure the init system from=
 tools.
>>
>> Comments:
>> ~~~~~~~~
>>
>> (A1) systmd can be detected easily with.
>>
>>  grep -qs systemd /proc/1/comm
>>
>> (A2) With init scripts such as its hard to know what the init system=
=2E
>>
>> (B1) For operating systems like RHEL, SLE, CENTOS, Fedora and scient=
ific
>> linux this works well.
>>
>> (B2) FOr operating systems like newer debian and ubuntu releases mor=
e
>> than one init system can be installed and used on the OS, so making =
a
>> database / doing it at compile time are not practical on all OS's
>>
>> (C1) This is fairly reliable.
>>
>> (C2) sysV tools have compatibility scripts / programs on other platf=
orms
>> so if you use a points system for each init system helper script you=
 can
>> infure systemd over sysV if sytemctrl exists for example.
>>
>> So to summarise this:
>> ~~~~~~~~~~~~~~~~~~~~
>>
>> (1) No one system is perfect in all cases.
>> (2) Combined these systesm can provide reliable init system detectio=
n.
>>
>> My proposed approach.
>> ~~~~~~~~~~~~~~~~~~~~
>>
>> (I) Use all three approaches where each approach can provide and ans=
wer,
>> or fail to provide an answer.
>>
>> (II) Should any approaches disagree -> fail to detect init system.
>>
>> (III) Should all approaches agree -> then return init system.
>>
>> (III) Should no approaches provide an init system -> fail to return =
init
>> system.
>>
>> Comments
>> ~~~~~~~~
>>
>> This multi layered and comparing way of doing init systems may seem
>> complete overkill, or maybe its useful.
>>
>> What do you guys think?
>>
>> Best regards
>>
>> Owen
>>
>>
>>
>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel=
" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>=20

--=20
SUSE LINUX GmbH, GF: Jeff Hawn, Jennifer Guild, Felix Imend=C3=B6rffer,=
 HRB
21284 (AG
N=C3=BCrnberg)

Maxfeldstra=C3=9Fe 5

90409 N=C3=BCrnberg

Germany
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
