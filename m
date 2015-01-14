From: Loic Dachary <loic@dachary.org>
Subject: Re: Some gitbuilders not working
Date: Wed, 14 Jan 2015 18:22:07 +0100
Message-ID: <54B6A5BF.2050102@dachary.org>
References: <54AF7B4C.6010305@inktank.com> <54AFAE7D.5070402@dachary.org> <54AFDA69.2080002@redhat.com> <alpine.DEB.2.00.1501090710500.10525@cobra.newdream.net> <54B69FAB.3020504@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="Acd1vhD1NLfdIj07uFKATMH9t8X5Ng5cn"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:39832 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1752495AbbANRWK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 14 Jan 2015 12:22:10 -0500
In-Reply-To: <54B69FAB.3020504@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--Acd1vhD1NLfdIj07uFKATMH9t8X5Ng5cn
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi,

On 14/01/2015 17:56, Ken Dreyer wrote:
> On 01/09/2015 08:16 AM, Sage Weil wrote:
>> On Fri, 9 Jan 2015, Ken Dreyer wrote:
>>> On 01/09/2015 03:33 AM, Loic Dachary wrote:
>>>> On 09/01/2015 07:55, David Zafman wrote:
>>>>>
>>>>> We are seeing gitbuilder failures.  This is what I saw on one.
>>>>>
>>>>> error: Failed build dependencies:
>>>>> xmlstarlet is needed by ceph-1:0.90-821.g680fe3c.el7.x86_64
>>>>
>>>> This is because https://github.com/ceph/ceph/pull/3036 was recently =
merged.
>>>> However, https://github.com/ceph/autobuild-ceph/pull/19 added xmlsta=
rlet
>>>> about a month ago. Maybe some gitbuilder machines were not updated
>>>> accordingly. If I'm not mistaken this is a manual process but I'm no=
t sure
>>>> exactly how to do it myself.
>>>
>>> I'm not entirely sure of the SOP to apply fabfile changes across our
>>> infrastructure, either. Is there a simple "push this fabfile change
>>> everywhere" command for gitbuilder?
>>
>> Not really, but it is high time we established one.
>>
>> At the top of the fabfile all of the targets are defined, so that if y=
ou=20
>> run bin/fab w/o arguments it should run on *all* of them. Unfortunatel=
y=20
>> IIRC it's a bit disruptive as it restarts the autobuild service which =
will=20
>> interrupt and restart the current build.
>>
>> But, that list isn't well-maintained, so it doesn't map to the current=
 set=20
>> of gitbuilders.  That's probably pretty easy to fix.  Even if we=20
>> do, though, I think fab isn't super great about skipping targets that =
are=20
>> down?  Not sure.
>>
>> In any case, the way I've run it in practice is on specific targets ta=
ht=20
>> need updating, like so
>>
>>  bin/fab gitbuilder_auto:host=3Duser@foo
>>
>> (or something like that, I forget the exact syntax).  Often on a=20
>> host that isn't in the master list.
>>
>> More frequently the procedure has been:
>>
>>  - add a dependency to the fabfile for future builders
>>  - manually install the package on the existing ones to avoid the abov=
e=20
>> pain
>>
>> which mostly works but doesn't regularly verify that the fabfile is=20
>> sufficient and correct.
>> =20
>>> In the long term we'll want to get to a point where we're building
>>> Ceph's RPM packages using mock [1] instead of rpmbuild so that mock c=
an
>>> resolve these sort of things automatically without having to deal wit=
h
>>> installing new BuildRequires by hand.
>>
>> That sounds great, although I wonder if it is slow?  We used to do=20
>> all of our debian builds with pbuilder which does a similar thing,=20
>> but it is way slow because it reinstalls deps on every run.  We moved =

>> to doing native dpkg builds because time is of the essence for test=20
>> builds and use pbuilder only for releases...
>=20
> It sounds like we should research exactly how much time mock and
> pbuilder would add. Mock implements caching at a lot of levels, though
> it's true that it won't be as fast as just running plain rpmbuild. We
> should get some hard numbers so we know how painful the speed hit would=
 be.
>=20
> I'm weighing the time that mock would slow down the builds against the
> time and energy that it takes to
>  - Duplicate the BuildRequires in autobuild-ceph.git
>  - Review the change for correctness and merge the autobuild-ceph.git
>    pull request
>  - Deploy the autobuild-ceph.git changes out to the appropriate
>    gitbuilders

It could be changed to use https://github.com/ceph/ceph/blob/master/insta=
ll-deps.sh instead.

> And then there's the "people stuff", like comprehending that all of the=

> above is even necessary, or communicating about this on mailing lists
> like this thread, etc.
>=20
> The fact that pbuilders are introduced very late (only during releases)=

> means that we encounter errors during a release day when Alfredo or I
> have tried to get a release out the door. The pbuilder stuff isn't
> touched until we try to do a release, and in the mean time, it breaks
> because it's not getting continually tested. We're paying the "slow"
> penalty in other areas down the road.
>=20
> I'm not looking to purposefully slow down other people's work, so I'll
> continue to mull over how we can balance speed with correctness.

IMHO the overhead of mock is so small that it can be ignored. pbuilder is=
 much more expensive (because of the tarbal / tree removal) and there is =
no way to reduce that overhead, IIRC.

There also is a need to run make check on each platform instead of a smal=
l subset (ubuntu 12.04 + 14.04 on amd64 + i386 only). That can only be co=
nveniently done within a container (the pbuilder / mock chroot isolation =
is not good enough).=20

We could combine the two: move the current packaging process to use conta=
iners instead of mock / pbuilder. It has the advantage of being a single =
method cross distributions and allowing more comprehensive checks (make c=
heck) during packaging.

My 2cts ;-)

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--Acd1vhD1NLfdIj07uFKATMH9t8X5Ng5cn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlS2pb8ACgkQ8dLMyEl6F20+MQCfXf2kNCvRnjzzmvoPG0YBiXmO
3JwAmwekyQQ3TlsKwQG2hHGZ6gtkAP2u
=DpZP
-----END PGP SIGNATURE-----

--Acd1vhD1NLfdIj07uFKATMH9t8X5Ng5cn--
