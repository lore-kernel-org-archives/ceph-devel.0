From: Loic Dachary <loic@dachary.org>
Subject: Re: pg_missing_t::is_missing semantics
Date: Mon, 27 May 2013 21:11:15 +0200
Message-ID: <51A3AFD3.3010205@dachary.org>
References: <51A37BD9.6080109@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig15AF086E94A6D6D9EFED7C52"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:59328 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754170Ab3E0TLS (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 27 May 2013 15:11:18 -0400
Received: from [10.8.0.22] (unknown [10.8.0.22])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id 5D11B26395
	for <ceph-devel@vger.kernel.org>; Mon, 27 May 2013 21:11:16 +0200 (CEST)
In-Reply-To: <51A37BD9.6080109@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig15AF086E94A6D6D9EFED7C52
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 05/27/2013 05:29 PM, Loic Dachary wrote:
> Hi,
>=20
> When testing if a specific version of an object is missing with pg_miss=
ing_t::is_missing
> https://github.com/ceph/ceph/blob/master/src/osd/osd_types.cc#L2153
> if the version needed is greater than the version given in argument, fa=
lse is returned.
>=20
> Each object in pg_missing_t *have* a version and *need* another and *ha=
ve* is lower than *need*.=20
> https://github.com/ceph/ceph/blob/master/src/osd/osd_types.h#L1470
>=20
> Here is what gets me confused:
>=20
>   if (item.need > v)
>     return false;
>   return true;
>=20
> A version lower than *need* is considered to not be missing ( by is_mis=
sing )=20
> where a version greater than *need* is considered to be missing.=20
>=20
> This prototype of is_missing is used at
>=20
> https://github.com/ceph/ceph/blob/master/src/osd/ReplicatedPG.cc#L5910
>=20
>   if (missing.is_missing(oid, v)) {
>     dout(10) << "got missing " << oid << " v " << v << dendl;
>     missing.got(oid, v);
>     if (is_primary())
>       missing_loc.erase(oid);
>=20
> If the version is greater than the one needed ( i.e. it is more recent =
) then it is not considered missing and therefore not removed from missin=
g ( which is what pg_missing_t::got does ).=20
>=20
> Does it mean that when an object version is in missing, it will always =
be removed because the PG will receive an object that is either of the sa=
me version or lower ? And never receive an object of a version greater th=
an the one in missing ?
>=20

https://github.com/ceph/ceph/blob/master/src/osd/ReplicatedPG.cc#L5319

  if (missing.is_missing(recovery_info.soid) &&
      missing.missing[recovery_info.soid].need > recovery_info.version) {=

    assert(is_primary());
    pg_log_entry_t *latest =3D log.objects[recovery_info.soid];
    if (latest->op =3D=3D pg_log_entry_t::LOST_REVERT &&
latest->reverting_to =3D=3D recovery_info.version) {
      dout(10) << " got old revert version " << recovery_info.version
<< " for " << *latest << dendl;
      recovery_info.version =3D latest->version;
      // update the attr to the revert event version
      recovery_info.oi.prior_version =3D recovery_info.oi.version;
      recovery_info.oi.version =3D latest->version;
      bufferlist bl;
      ::encode(recovery_info.oi, bl);
      t->setattr(coll, recovery_info.soid, OI_ATTR, bl);
    }
  }
  recover_got(recovery_info.soid, recovery_info.version);

Before calling recover_got, if the pg_log_entry is a LOST_REVERT operatio=
n for an object which version is lower than *need*, then it is modified t=
o spoof the pg_log_entry as if it was of the same version as the object c=
urrently in the logs.=20

/me still digging :-)

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.



--------------enig15AF086E94A6D6D9EFED7C52
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlGjr9MACgkQ8dLMyEl6F20/SwCeNUstipZOFQ3LsgZAo1zDp7Qk
42cAnRAu678AVfo9Eqrl0Ia1ldj2lwkk
=HY8R
-----END PGP SIGNATURE-----

--------------enig15AF086E94A6D6D9EFED7C52--
