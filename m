From: Tomasz Kuzemko <tomasz.kuzemko@corp.ovh.com>
Subject: Re: Single slow OSD can cause unfound object
Date: Fri, 14 Oct 2016 10:58:32 +0200
Message-ID: <4556c45e-1e23-3709-ad99-3feb580525a5@corp.ovh.com>
References: <ed8ed02e-4fb7-25ad-3a5f-d462f70409e2@sadziu.pl>
 <alpine.DEB.2.11.1610111340430.31080@piezo.us.to>
 <8b92ccce-1e31-7a0d-06d0-9126c3d02ffd@sadziu.pl>
 <alpine.DEB.2.11.1610111935530.18626@piezo.us.to>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature";
        boundary="NR5mTalHLAdsoFXS3FtXrD4gQTbdIblus"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from 8.mo301.mail-out.ovh.net ([137.74.110.71]:59466 "EHLO
        8.mo301.mail-out.ovh.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1753254AbcJNJIY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Oct 2016 05:08:24 -0400
Received: from EX3.OVH.local (gw1.corp.ovh.com [51.255.55.226])
        by mo301.mail-out.ovh.net (Postfix) with ESMTPS id 140401A37
        for <ceph-devel@vger.kernel.org>; Fri, 14 Oct 2016 10:58:38 +0200 (CEST)
In-Reply-To: <alpine.DEB.2.11.1610111935530.18626@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

--NR5mTalHLAdsoFXS3FtXrD4gQTbdIblus
Content-Type: multipart/mixed; boundary="WKdM6P8dd5mdw4Srk6XuF2EJRJFUIdKIT";
 protected-headers="v1"
From: Tomasz Kuzemko <tomasz.kuzemko@corp.ovh.com>
To: ceph-devel@vger.kernel.org
Message-ID: <4556c45e-1e23-3709-ad99-3feb580525a5@corp.ovh.com>
Subject: Re: Single slow OSD can cause unfound object
References: <ed8ed02e-4fb7-25ad-3a5f-d462f70409e2@sadziu.pl>
 <alpine.DEB.2.11.1610111340430.31080@piezo.us.to>
 <8b92ccce-1e31-7a0d-06d0-9126c3d02ffd@sadziu.pl>
 <alpine.DEB.2.11.1610111935530.18626@piezo.us.to>
In-Reply-To: <alpine.DEB.2.11.1610111935530.18626@piezo.us.to>

--WKdM6P8dd5mdw4Srk6XuF2EJRJFUIdKIT
Content-Type: text/plain; charset=iso-8859-2
Content-Transfer-Encoding: quoted-printable

Hi,

I work with Pawe=B3 on this subject.

Do I understand correctly that not marking osd.1 as out but instead
making it down first (ie. by killing process) would prevent this
situation from happening?

On 13.10.2016 18:53, Sage Weil wrote:
> On Tue, 11 Oct 2016, Pawe=B3 Sadowski wrote:
>> Hi Sage,
>>
>> W dniu 11.10.2016 o 15:45, Sage Weil pisze:
>>
>>> Hi Pawel,
>>>
>>> On Tue, 11 Oct 2016, Pawe=B3 Sadowski wrote:
>>>> Hi,
>>>>
>>>> I managed to trigger unfound objects on a pool with size 3 and min_s=
ize
>>>> 2 just by removing 'slow' OSD (out and then stop) which is quite
>>>> frightening. Shouldn't Ceph stop IO if there is only one copy in thi=
s
>>>> case (even during recovery/peering/etc)? I'm able to reproduce this =
on
>>>> Hammer (0.94.5, 0.94.9) and Jewel (10.2.3). So far I wasn't able to
>>>> trigger this behavior by just stopping such OSD (still testing).
>>> This is definitely concerning.  I have a couple questions...
>>>
>>> 1. Looking at the log, I see that at one point all of the OSDs mark
>>> themselves down, here:
>>>
>>> 2016-10-11 08:46:23.473335 mon.0 10.99.128.50:6789/0 3275 : cluster [=
INF]
>>> osd.1 marked itself down
>>>
>>> Do you know why they do that?
>>
>> It's probably due to load triggered by rebalance after marking OSD out=
=2E
>> In other tests OSDs stayed up during this period. It didn't happen
>> in my last test (logs posted via ceph-post-file).
>>
>>> 2. Are you throttling the CPU on just a single OSD, or on a whole hos=
t?  I
>>> also see that the monitors are calling elections.  (This shouldn't ha=
ve
>>> anything to do with the problem, but I'm not sure I understand the te=
st
>>> setup.)
>>
>> I'm throttling CPU for single OSD process (in our production we had di=
sk
>> that was slowing down OSD). Monitors share device with one of the OSD.=

>> Sometimes election happens after marking OSD out, sometimes not. Proba=
bly
>> caused by load on the underlaying device (didn't happen in last test).=

>>
>>>> Second thing: throttling mechanism is blocking recovery operations/w=
hole
>>>> OSD[4] when there is a lot of client requests for missing objects. I=

>>>> think it shouldn't be like that.
>>> Yeah, there is a similar problem with a PG is inactive and requests p=
ile
>>> up, eventually preventing ops even on active PGs... and 'ceph tell $p=
gid
>>> query' admin commands.  It's non-trivial to fix, though: we need a wa=
y to
>>> inform the client that a PG or individual object is blocked so that t=
hey
>>> stop sending requests... and then also a way to inform them that the =
PG is
>>> unblocked so they can start again.
>>
>> OK. Is it wise to increase this throttling limit and if yes how much?
>> Anyway, in the end it'll probably just delay moment until OSD is block=
ed.
>=20
> Yeah, I wouldn't increase it (at least not by much)... it'll just delay=
=20
> the inevitable.
>=20
>>>> 1: logs from Jewel
>>>> https://gist.github.com/anonymous/c8618adca8984132c82f16c351222883
>>> Do you mind reproducing this sequence with debug ms =3D 1, debug osd =
=3D 20,
>>> and capture all of the OSD logs as well as the cluster ceph.log?  You=
 can
>>> send us the tarball with the ceph-post-file utility.
>>
>> Sure. Gzipped logs are about ~2.7G, ceph-post-file id:
>> 7e16f69e-c410-49c2-b11c-e727854ce7b3
>=20
> Thanks!  I took a look at this and I see what is going on. =20
> It's... subtle.
>=20
> Initially the PG is, say, OSDs [1,2,3].  We are writing a sequence of=20
> updates to existing objects.  Eventually we mark osd.1 out.  At that po=
int=20
> we have
>=20
> osd.1: object A version '23 in flight to disk and replicas
> osd.2,3: object A version '22 (hasn't gotten replicated write yet)
>=20
> If osds 2 and 3 learn about the new osdmap (osd.1 is out) before osd.1,=
=20
> they will toss the replicate write away when they get it (they've alrea=
dy=20
> moved on and are part of the way through peering in the new [2,3]=20
> interval.  And during peering they learn from osd.1 that it has a newer=
=20
> version of the object, '23.  They assume this is the best one and inclu=
de=20
> the '23 write as part of the official history.
>=20
> All is well as long as osd.1 stays alive long enough for them to also=20
> fetch version '23 of the object.  If osd.1 is then killed before that=20
> happens, though, we are in the situation where osds [2,3] know there wa=
s a=20
> newer write but there is no longer a copy available.
>=20
> Since the '23 didn't actually complete (all replicas didn't commit it=20
> so the client didn't get an ack) it is equally valid for us to throw it=
=20
> out and say that '22 is the "official" version.  But if we do that we=20
> could fall into a similar situation where, say, osd.1 and osd.3 had=20
> '23 and osd.2 had '22, we chose '22, osd.1 and 3 throw away their=20
> 'divergent' '23, but then osd.2 fails before we copy '22 around.
>=20
> Somewhere in there is a better strategy that recognizes that either=20
> version is okay and either picks the official version that is least lik=
ely=20
> to lead to one of these failure cases *or* adds some complicated logic =
to=20
> record that either is okay and adjust the official record=20
> as-needed if one of those failure situations comes up.
>=20
> For now, the way to address this is to do the mark-unfound-revert thing=
,=20
> which takes you from a situation where the history says '22 was modifie=
d=20
> to get '23 but you don't have a '23 copy (only '22's).  This is a manua=
l=20
> admin intervention, but it's generally safe and is designed to handle=20
> exactly this case.
>=20
> Perhaps the simplest improvement would be to automatically recognized=20
> that the '23 version was never acked to the client and automatic revert=
=20
> to '22 is safe...
>=20
> Sam's on vacation, but I suspect he'll have some additional thoughts on=
=20
> this when he gets back next week!
>=20
> sage
>=20
>=20
>=20
>>
>>> Thanks!
>>> sage
>>>
>>>> 2: steps to reproduce
>>>>   - put some load on the cluster (run FIO with high iodepth)
>>>>   - slow down single OSD (in my case reduce CPU time using cgroups:
>>>> cpu.cfs_quota_us 15000)
>>>>   - sleep 120
>>>>   - ceph osd out 6
>>>>   - sleep 15
>>>>   - stop ceph-osd id=3D6
>>>>   - unfound objects appear
>>>>
>>>> This is not 100% reproducible but in my test lab (9 OSDs) I'm able t=
o
>>>> trigger this very easily.
>>>>
>>>> 3:
>>>> mon-01:~ # ceph osd pool get rbd size
>>>> size: 3
>>>> mon-01:~ # ceph osd pool get rbd min_size
>>>> min_size: 2
>>>> mon-01:~ # ceph --version
>>>> ceph version 10.2.3 (ecc23778eb545d8dd55e2e4735b53cc93f92e65b)
>>>>
>>>> 4:
>>>> perf dump | grep -A 2 'throttle-osd_client_messages'
>>>>      "throttle-osd_client_messages": {
>>>>          "val": 100,
>>>>          "max": 100,
>>>>
>>>> ops_in_flight:
>>>> https://gist.github.com/anonymous/643607fa3f959c91ba7a9794e5d99dea
>>
>> Thanks!
>>
>>
>> --=20
>> PS
>>

--=20
Tomasz Kuzemko
tomasz.kuzemko@corp.ovh.com


--WKdM6P8dd5mdw4Srk6XuF2EJRJFUIdKIT--

--NR5mTalHLAdsoFXS3FtXrD4gQTbdIblus
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQEcBAEBAgAGBQJYAJ49AAoJEH0wj3uDfd0nMf0H/23iKOhCn3Ho9jHRnYl+Ba5I
VHqk3xlzL5u/JVaV7LQ+TFStPY9le9Nf33FaVCNZBSC9xkjprU13oSCRTAsJmKNa
fVHZl7o3EqfnwVcVM+6mE7yLWSh9YP3NZeu6jtwt8h3M60/jPTp/z9MRuwFsBglY
W7cU7NDbdSBgTEZ1CEW1iLm745xcmXjJNqhIMTB6fWIXTWqvgNw0AQoSUtgrPq8N
4y7r0a5a0s2SlgWUJST9JDieRP5DuHNReIdwMA2cDBSFW/pLwNpWdap/CKsmrPop
e4x+2OVR/O6nPPM6DfZfaOujXIyhdsQQA44+qL/NbFxmvWhzzuyrobRcP/wv6y0=
=OVIk
-----END PGP SIGNATURE-----

--NR5mTalHLAdsoFXS3FtXrD4gQTbdIblus--
