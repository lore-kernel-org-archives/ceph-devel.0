From: Loic Dachary <loic@dachary.org>
Subject: Re: pg_missing_t::is_missing semantics
Date: Mon, 27 May 2013 21:35:43 +0200
Message-ID: <51A3B58F.2040208@dachary.org>
References: <51A37BD9.6080109@dachary.org> <51A3AFD3.3010205@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2C94BDC8ABF5264455015671"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:47585 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756682Ab3E0Tft (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 May 2013 15:35:49 -0400
Received: from [10.8.0.22] (unknown [10.8.0.22])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id 4D36926398
	for <ceph-devel@vger.kernel.org>; Mon, 27 May 2013 21:35:45 +0200 (CEST)
In-Reply-To: <51A3AFD3.3010205@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2C94BDC8ABF5264455015671
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 05/27/2013 09:11 PM, Loic Dachary wrote:
>=20
>=20
> On 05/27/2013 05:29 PM, Loic Dachary wrote:
>> Hi,
>>
>> When testing if a specific version of an object is missing with pg_mis=
sing_t::is_missing
>> https://github.com/ceph/ceph/blob/master/src/osd/osd_types.cc#L2153
>> if the version needed is greater than the version given in argument, f=
alse is returned.
>>
>> Each object in pg_missing_t *have* a version and *need* another and *h=
ave* is lower than *need*.=20
>> https://github.com/ceph/ceph/blob/master/src/osd/osd_types.h#L1470
>>
>> Here is what gets me confused:
>>
>>   if (item.need > v)
>>     return false;
>>   return true;
>>
>> A version lower than *need* is considered to not be missing ( by is_mi=
ssing )=20
>> where a version greater than *need* is considered to be missing.=20
>>
>> This prototype of is_missing is used at
>>
>> https://github.com/ceph/ceph/blob/master/src/osd/ReplicatedPG.cc#L5910=

>>
>>   if (missing.is_missing(oid, v)) {
>>     dout(10) << "got missing " << oid << " v " << v << dendl;
>>     missing.got(oid, v);
>>     if (is_primary())
>>       missing_loc.erase(oid);
>>
>> If the version is greater than the one needed ( i.e. it is more recent=
 ) then it is not considered missing and therefore not removed from missi=
ng ( which is what pg_missing_t::got does ).=20
>>
>> Does it mean that when an object version is in missing, it will always=
 be removed because the PG will receive an object that is either of the s=
ame version or lower ? And never receive an object of a version greater t=
han the one in missing ?
>>
>=20
> https://github.com/ceph/ceph/blob/master/src/osd/ReplicatedPG.cc#L5319
>=20
>   if (missing.is_missing(recovery_info.soid) &&
>       missing.missing[recovery_info.soid].need > recovery_info.version)=
 {
>     assert(is_primary());
>     pg_log_entry_t *latest =3D log.objects[recovery_info.soid];
>     if (latest->op =3D=3D pg_log_entry_t::LOST_REVERT &&
> latest->reverting_to =3D=3D recovery_info.version) {
>       dout(10) << " got old revert version " << recovery_info.version
> << " for " << *latest << dendl;
>       recovery_info.version =3D latest->version;
>       // update the attr to the revert event version
>       recovery_info.oi.prior_version =3D recovery_info.oi.version;
>       recovery_info.oi.version =3D latest->version;
>       bufferlist bl;
>       ::encode(recovery_info.oi, bl);
>       t->setattr(coll, recovery_info.soid, OI_ATTR, bl);
>     }
>   }
>   recover_got(recovery_info.soid, recovery_info.version);
>=20
> Before calling recover_got, if the pg_log_entry is a LOST_REVERT operat=
ion for an object which version is lower than *need*, then it is modified=
 to spoof the pg_log_entry as if it was of the same version as the object=
 currently in the logs.=20
>=20
> /me still digging :-)
>=20

is_missing is also called from ReplicatedPG::pull

https://github.com/ceph/ceph/blob/master/src/osd/ReplicatedPG.cc#L5022

If the desired object version is missing from the peer (i.e. soid is know=
n to peer_missing[fromosd] and the *need*ed version is greater than versi=
on v) , the versions it has ( *have* ) is pulled instead:

if (peer_missing[fromosd].is_missing(soid, v)) {
    assert(peer_missing[fromosd].missing[soid].have !=3D v);
    dout(10) << "pulling soid " << soid << " from osd " << fromosd
<< " at version " << peer_missing[fromosd].missing[soid].have
<< " rather than at version " << v << dendl;
    v =3D peer_missing[fromosd].missing[soid].have;

If soid is not known to peer_missing[fromosd] or the *need*ed version is =
lower or equal than version v, it is not missing, meaning the version v w=
ill be pulled.=20

https://github.com/ceph/ceph/blob/master/src/osd/ReplicatedPG.cc#L5101

I'm unsure what will happen if v is pulled although soid is known to peer=
_missing[fromosd]. That is, in the case where the *need*ed version is low=
er or equal than version v. Because the peer does not have the required v=
ersion. Or does it ?=20

/me out for the night

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig2C94BDC8ABF5264455015671
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlGjtY8ACgkQ8dLMyEl6F209pACdGHiFQ0YE36GbuMOTFQm+QKK2
9HMAn3a0axySdIRTaGNU6xZoGrT1zFP1
=WO9F
-----END PGP SIGNATURE-----

--------------enig2C94BDC8ABF5264455015671--
