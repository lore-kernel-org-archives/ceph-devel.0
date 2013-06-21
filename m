From: Loic Dachary <loic@dachary.org>
Subject: Re: Separating Peering from PG
Date: Fri, 21 Jun 2013 19:51:03 +0200
Message-ID: <51C49287.2020907@dachary.org>
References: <51C4570F.70206@dachary.org> <CA+4uBUYTieHXeOWQXtqvRg6jX-fS1cedt74H2-v36FZhSwqo0A@mail.gmail.com> <51C48916.7090102@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA9126EAC8D1C42FC6A2F6FE1"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:33353 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423307Ab3FURvH (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Jun 2013 13:51:07 -0400
In-Reply-To: <51C48916.7090102@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA9126EAC8D1C42FC6A2F6FE1
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sam,

This draft commit may clarify what I mean

https://github.com/dachary/ceph/commit/5c6678385eed4f8769d0f5ee38ad629e32=
b902a6

Cheers

On 06/21/2013 07:10 PM, Loic Dachary wrote:
>=20
>=20
> On 06/21/2013 06:38 PM, Samuel Just wrote:
>> I'm not sure I understand, by PG::RecoveryStats, do you mean PG::Recov=
eryState?
>=20
> Yes I do, sorry for the confusion. Fixed the typos for clarity, hopeful=
ly.
>=20
> * Move PG::RecoveryState in PGRecoveryState.{cc,h}
> * Create PGInterface : an abstract base class for PG enumerating all PG=
 methods used by PGRecoveryState
> * Move Peering states / methods out of PGRecoveryState.{cc,h} and into =
PGPeering.{cc,h}
> * Write tests for PGPeering.{cc,h}, using a fixture derived from PGInte=
rface
>=20
> Cheers
>=20
>> -Sam
>>
>> On Fri, Jun 21, 2013 at 6:37 AM, Loic Dachary <loic@dachary.org> wrote=
:
>>> Hi Sage,
>>>
>>> In order to move the PG peering code out of PG.{cc,h} (which is the n=
ext step in refactoring PGs as suggested by Sam http://pad.ceph.com/p/Era=
sure_encoding_as_a_storage_backend ) I think it would be sensible to:
>>>
>>> * Move PG::RecoveryStats in PGRecoveryStat.{cc,h}
>>> * Create PGInterface : an abstract base class for PG enumerating all =
PG methods used by PGRecoveryStats
>>> * Move Peering states / methods out of PGRecoveryStat.{cc,h} and into=
 PGPeering.{cc,h}
>>> * Write tests for PGPeering.{cc,h}, using a fixture derived from PGIn=
terface
>>>
>>> Because this approach not only moves the peering out of PG.{cc,h} but=
 also the rest of the state logic, I would like to know if this seems sen=
sible to you. Also, introducing an abstract base class to help isolate th=
e PG interface and facilitate writing fixtures has not been discussed yet=
=2E
>>>
>>> Cheers
>>>
>>> --
>>> Lo=EFc Dachary, Artisan Logiciel Libre
>>> All that is necessary for the triumph of evil is that good people do =
nothing.
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enigA9126EAC8D1C42FC6A2F6FE1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlHEkocACgkQ8dLMyEl6F22kiACffPH0PrIdQUrDn5uhaceL5Zao
WE0AnjEc7k1AklGCkuFZKenNzJX0X/BF
=XlSy
-----END PGP SIGNATURE-----

--------------enigA9126EAC8D1C42FC6A2F6FE1--
