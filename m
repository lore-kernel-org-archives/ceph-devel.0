From: Loic Dachary <loic@dachary.org>
Subject: Re: Improving latency and ordering of the backfilling workload
Date: Mon, 15 Dec 2014 18:09:57 +0100
Message-ID: <548F15E5.2030304@dachary.org>
References: <548EEF2C.1010703@dachary.org> <alpine.DEB.2.00.1412150841220.5263@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="A0mfwqSWsU0VJ0DbXvH7fCCsTw45NnC79"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:53327 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750763AbaLORKA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Dec 2014 12:10:00 -0500
In-Reply-To: <alpine.DEB.2.00.1412150841220.5263@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@newdream.net>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--A0mfwqSWsU0VJ0DbXvH7fCCsTw45NnC79
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Sage,

On 15/12/2014 17:44, Sage Weil wrote:
> On Mon, 15 Dec 2014, Loic Dachary wrote:
>> Hi Sam,
>>
>> Here is what could be done (in the context of http://tracker.ceph.com/=
issues/9566
>> ), please let me know if that makes sense:
>>
>> * ordering:
>>
>>   * when dequeuing a pending local reservation, chose one that contain=
s=20
>> a PG that belongs to the busiest OSD (i.e. the OSD for which there are=
=20
>> more PGs waiting for a local reservation than any other)
>=20
> I'm worried the reservation count won't be an accurate enough proxy for=
=20
> the amount of work the remote OSD has to do. =20

Are you thinking about taking into account the number and size of objects=
 in a given PGs ? The length of the local reservation queue accurately re=
flects the number of PGs that need work (because the length of the reserv=
ation queue is not bounded). But it does not reflect the content of the P=
Gs at all, indeed.

It would be very easy to=20
> piggyback some load information on the heartbeat messages which we shou=
ld=20
> already be exchanging with anyone we would backfill with.
>=20
> If we go down that path, there are a bunch of patches in the wip-read-h=
ole=20
> series that lay useful groundwork.  Getting that branch into shape=20
> is the next big item after I finish the current batch of pull=20
> requests.

Would you mind telling me which of https://github.com/ceph/ceph/commits/w=
ip-read-hole commits are relevant ? I assume https://github.com/ceph/ceph=
/commit/ee72f699e236371a5b8651cd900013a2bd2227fb is to some extent.=20

Cheers

>>   * when sending a remote reservation request, set the priority to=20
>> reflect the total number of pending PG (absolute workload) and the=20
>> number local pending PG for the destination OSD (workload queued local=
ly=20
>> for the remote OSD)
>>   * on the receiving side, the priority of the remote reservation=20
>> request makes sure the busiest OSD gets a remote reservation before th=
e=20
>> others
>>
>> * reducing latency:
>>  =20
>>   * if there are N pending remote reservations, reject a remote=20
>> reservation request instead of queuing it so that the local reservatio=
n=20
>> can be used instead of waiting.
>>
>> Cheers
>>
>> --=20
>> Lo?c Dachary, Artisan Logiciel Libre
>>
>>
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--A0mfwqSWsU0VJ0DbXvH7fCCsTw45NnC79
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iEYEARECAAYFAlSPFeUACgkQ8dLMyEl6F23yTwCfcv0dFoGBIurfvgwR8L92nC83
c3YAoJNjAFtHEdp+/Q1dnZaqRiciXtsH
=oR6r
-----END PGP SIGNATURE-----

--A0mfwqSWsU0VJ0DbXvH7fCCsTw45NnC79--
