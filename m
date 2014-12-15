From: Loic Dachary <loic@dachary.org>
Subject: Re: Improving latency and ordering of the backfilling workload
Date: Mon, 15 Dec 2014 19:13:14 +0100
Message-ID: <548F24BA.8080401@dachary.org>
References: <548EEF2C.1010703@dachary.org> <alpine.DEB.2.00.1412150841220.5263@cobra.newdream.net> <548F15E5.2030304@dachary.org> <alpine.DEB.2.00.1412150913400.5263@cobra.newdream.net> <548F1EDF.5020401@dachary.org> <alpine.DEB.2.00.1412150959150.22847@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="g7H0qnB16tMoGs2jgqCXjIW4PasoA602U"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:53372 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751178AbaLOSNR (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Dec 2014 13:13:17 -0500
In-Reply-To: <alpine.DEB.2.00.1412150959150.22847@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--g7H0qnB16tMoGs2jgqCXjIW4PasoA602U
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 15/12/2014 19:03, Sage Weil wrote:
> On Mon, 15 Dec 2014, Loic Dachary wrote:
>> On 15/12/2014 18:20, Sage Weil wrote:
>>> On Mon, 15 Dec 2014, Loic Dachary wrote:
>>>> Hi Sage,
>>>>
>>>> On 15/12/2014 17:44, Sage Weil wrote:
>>>>> On Mon, 15 Dec 2014, Loic Dachary wrote:
>>>>>> Hi Sam,
>>>>>>
>>>>>> Here is what could be done (in the context of http://tracker.ceph.=
com/issues/9566
>>>>>> ), please let me know if that makes sense:
>>>>>>
>>>>>> * ordering:
>>>>>>
>>>>>>   * when dequeuing a pending local reservation, chose one that con=
tains=20
>>>>>> a PG that belongs to the busiest OSD (i.e. the OSD for which there=
 are=20
>>>>>> more PGs waiting for a local reservation than any other)
>>>>>
>>>>> I'm worried the reservation count won't be an accurate enough proxy=
 for=20
>>>>> the amount of work the remote OSD has to do. =20
>>>>
>>>> Are you thinking about taking into account the number and size of=20
>>>> objects in a given PGs ? The length of the local reservation queue=20
>>>> accurately reflects the number of PGs that need work (because the le=
ngth=20
>>>> of the reservation queue is not bounded). But it does not reflect th=
e=20
>>>> content of the PGs at all, indeed.
>>>
>>> Including that information could help, yeah, but the main thing is th=
at=20
>>> any estimate of "the busiest OSD" based on local information is going=
 to=20
>>> be weak if it's only based on info reservation requests. =20
>>
>> What other information would be relevant in addition to the number of =

>> PGs that need to backfill and their size (objects & bytes) ?
>=20
> Maybe the background client workload?  If an OSD is more heavily loaded=
=20
> than others than it should probably start it's recovery sooner as its r=
ate=20
> of progress will be a bit lower.
>=20
>>> Unless that=20
>>> information is refreshed periodically by the requesting OSD (I think =
we=20
>>> also discussed that a bit last week).
>>
>> I tried to take that into account by proposing to calculate the priori=
ty=20
>> when the reservation is dequeued from the waiting list instead of when=
=20
>> it is added to the waiting list. When the local reservation is dequeue=
d,=20
>> it gets one of the osd_max_backfill slots in the AsyncReserver and wil=
l=20
>> then get work to do : the delay between calculating the priority and=20
>> actual backfilling is minimum. The delay actually is the latency betwe=
en=20
>> when the remote reservation is sent and when it comes back successfull=
y.=20
>> By adding the priority to the remote reservation request, we make the =

>> peer OSD aware of the local priority and compare it with the priority =
of=20
>> the other OSDs asking for a remote reservation. The peer OSD will be=20
>> grant us a remote reservation quickly if we are the OSD declaring to=20
>> have most work to do.
>>
>> I sense you have something else in mind in terms of algorithm and/or=20
>> data sources. Hopefully this explanation will allow you to see what I'=
m=20
>> missing and guide me ;-)
>=20
> Oh, I see.  That sounds very reasonable.  I suspect even with this=20
> approach though it will help to periodically refresh that reservation, =

> though, as the remote OSD may have lots of people contending for recove=
ry. =20
> Whoever is not first in line will be there for a while and their priori=
ty=20
> will likely be less than accurate by the time the next item is dequeued=
=20
> there?

The priority is attached to each reservation and is relative to one PG re=
servation request. The remote reservation priority will be reconsidered e=
ach time a new PG asks for a remote reservation (because it will use the =
priority queues of the AsyncReserver). If we want to revise the priority =
during the backfilling of a given PG that already has a local+remote slot=
 allocated to it, it means we should periodically consider cancelling an =
on going backfill operation to give a chance to an other, maybe busier, O=
SD.=20

Am I following ?

>=20
> Sorry if my drive-by suggestions aren't helping; I'm only half followin=
g=20
> this discussion!

It's helping a lot !

> sage
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--g7H0qnB16tMoGs2jgqCXjIW4PasoA602U
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlSPJLoACgkQ8dLMyEl6F20ERgCghc2GtzkCEjLrUCGarNpDMvhD
Wg4Ani9sLG19GurFUkoVropfh0FGqLIy
=PyC9
-----END PGP SIGNATURE-----

--g7H0qnB16tMoGs2jgqCXjIW4PasoA602U--
