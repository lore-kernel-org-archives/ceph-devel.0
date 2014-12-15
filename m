From: Loic Dachary <loic@dachary.org>
Subject: Re: Improving latency and ordering of the backfilling workload
Date: Mon, 15 Dec 2014 18:48:15 +0100
Message-ID: <548F1EDF.5020401@dachary.org>
References: <548EEF2C.1010703@dachary.org> <alpine.DEB.2.00.1412150841220.5263@cobra.newdream.net> <548F15E5.2030304@dachary.org> <alpine.DEB.2.00.1412150913400.5263@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="AWPFguC2o5MjLflWoWdRpR4Tn6mhU5FKn"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:53355 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750772AbaLORsS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Dec 2014 12:48:18 -0500
In-Reply-To: <alpine.DEB.2.00.1412150913400.5263@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--AWPFguC2o5MjLflWoWdRpR4Tn6mhU5FKn
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 15/12/2014 18:20, Sage Weil wrote:
> On Mon, 15 Dec 2014, Loic Dachary wrote:
>> Hi Sage,
>>
>> On 15/12/2014 17:44, Sage Weil wrote:
>>> On Mon, 15 Dec 2014, Loic Dachary wrote:
>>>> Hi Sam,
>>>>
>>>> Here is what could be done (in the context of http://tracker.ceph.co=
m/issues/9566
>>>> ), please let me know if that makes sense:
>>>>
>>>> * ordering:
>>>>
>>>>   * when dequeuing a pending local reservation, chose one that conta=
ins=20
>>>> a PG that belongs to the busiest OSD (i.e. the OSD for which there a=
re=20
>>>> more PGs waiting for a local reservation than any other)
>>>
>>> I'm worried the reservation count won't be an accurate enough proxy f=
or=20
>>> the amount of work the remote OSD has to do. =20
>>
>> Are you thinking about taking into account the number and size of=20
>> objects in a given PGs ? The length of the local reservation queue=20
>> accurately reflects the number of PGs that need work (because the leng=
th=20
>> of the reservation queue is not bounded). But it does not reflect the =

>> content of the PGs at all, indeed.
>=20
> Including that information could help, yeah, but the main thing is that=
=20
> any estimate of "the busiest OSD" based on local information is going t=
o=20
> be weak if it's only based on info reservation requests. =20

What other information would be relevant in addition to the number of PGs=
 that need to backfill and their size (objects & bytes) ?

> Unless that=20
> information is refreshed periodically by the requesting OSD (I think we=
=20
> also discussed that a bit last week).

I tried to take that into account by proposing to calculate the priority =
when the reservation is dequeued from the waiting list instead of when it=
 is added to the waiting list. When the local reservation is dequeued, it=
 gets one of the osd_max_backfill slots in the AsyncReserver and will the=
n get work to do : the delay between calculating the priority and actual =
backfilling is minimum. The delay actually is the latency between when th=
e remote reservation is sent and when it comes back successfully. By addi=
ng the priority to the remote reservation request, we make the peer OSD a=
ware of the local priority and compare it with the priority of the other =
OSDs asking for a remote reservation. The peer OSD will be grant us a rem=
ote reservation quickly if we are the OSD declaring to have most work to =
do.

I sense you have something else in mind in terms of algorithm and/or data=
 sources. Hopefully this explanation will allow you to see what I'm missi=
ng and guide me ;-)

>=20
>> It would be very easy to=20
>>> piggyback some load information on the heartbeat messages which we sh=
ould=20
>>> already be exchanging with anyone we would backfill with.
>>>
>>> If we go down that path, there are a bunch of patches in the wip-read=
-hole=20
>>> series that lay useful groundwork.  Getting that branch into shape=20
>>> is the next big item after I finish the current batch of pull=20
>>> requests.
>>
>> Would you mind telling me which of=20
>> https://github.com/ceph/ceph/commits/wip-read-hole commits are relevan=
t=20
>> ? I assume=20
>> https://github.com/ceph/ceph/commit/ee72f699e236371a5b8651cd900013a2bd=
2227fb=20
>> is to some extent.
>=20
> Yeah that's the one.  There's a later patch that give each PG a handy=20
> reference to that struct for the acting set (for quick access), though =
in=20
> this case not all backfill peers will be in acting.
>=20
> Note that there is also a osd_peer_stat_t struct in MOSDPing that is=20
> currently unused cruft.  We could replace/supplement that with whatever=
=20
> information we thing would be helpful.
>=20
> If we go down that path at least.. I think ahve reservers refresh their=
=20
> reservation periodically with updated priorities would also work.
>=20
> sage
>=20
>=20
>>
>> Cheers
>>
>>>>   * when sending a remote reservation request, set the priority to=20
>>>> reflect the total number of pending PG (absolute workload) and the=20
>>>> number local pending PG for the destination OSD (workload queued loc=
ally=20
>>>> for the remote OSD)
>>>>   * on the receiving side, the priority of the remote reservation=20
>>>> request makes sure the busiest OSD gets a remote reservation before =
the=20
>>>> others
>>>>
>>>> * reducing latency:
>>>>  =20
>>>>   * if there are N pending remote reservations, reject a remote=20
>>>> reservation request instead of queuing it so that the local reservat=
ion=20
>>>> can be used instead of waiting.
>>>>
>>>> Cheers
>>>>
>>>> --=20
>>>> Lo?c Dachary, Artisan Logiciel Libre
>>>>
>>>>
>>>
>>
>> --=20
>> Lo?c Dachary, Artisan Logiciel Libre
>>
>>

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--AWPFguC2o5MjLflWoWdRpR4Tn6mhU5FKn
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlSPHt8ACgkQ8dLMyEl6F23HxwCfWFFCXqcGgZ98mpU5NWYDiWJH
FigAnj4FNr7SlteXxBj4JDDvsahkZ9Bt
=SjNy
-----END PGP SIGNATURE-----

--AWPFguC2o5MjLflWoWdRpR4Tn6mhU5FKn--
