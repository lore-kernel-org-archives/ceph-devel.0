From: Loic Dachary <loic@dachary.org>
Subject: Re: Separating Peering from PG
Date: Fri, 21 Jun 2013 19:10:46 +0200
Message-ID: <51C48916.7090102@dachary.org>
References: <51C4570F.70206@dachary.org> <CA+4uBUYTieHXeOWQXtqvRg6jX-fS1cedt74H2-v36FZhSwqo0A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig9D453B362D6CB4B95B1C6101"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:45247 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1423404Ab3FURKt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Jun 2013 13:10:49 -0400
In-Reply-To: <CA+4uBUYTieHXeOWQXtqvRg6jX-fS1cedt74H2-v36FZhSwqo0A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig9D453B362D6CB4B95B1C6101
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 06/21/2013 06:38 PM, Samuel Just wrote:
> I'm not sure I understand, by PG::RecoveryStats, do you mean PG::Recove=
ryState?

Yes I do, sorry for the confusion. Fixed the typos for clarity, hopefully=
=2E

* Move PG::RecoveryState in PGRecoveryState.{cc,h}
* Create PGInterface : an abstract base class for PG enumerating all PG m=
ethods used by PGRecoveryState
* Move Peering states / methods out of PGRecoveryState.{cc,h} and into PG=
Peering.{cc,h}
* Write tests for PGPeering.{cc,h}, using a fixture derived from PGInterf=
ace

Cheers

> -Sam
>=20
> On Fri, Jun 21, 2013 at 6:37 AM, Loic Dachary <loic@dachary.org> wrote:=

>> Hi Sage,
>>
>> In order to move the PG peering code out of PG.{cc,h} (which is the ne=
xt step in refactoring PGs as suggested by Sam http://pad.ceph.com/p/Eras=
ure_encoding_as_a_storage_backend ) I think it would be sensible to:
>>
>> * Move PG::RecoveryStats in PGRecoveryStat.{cc,h}
>> * Create PGInterface : an abstract base class for PG enumerating all P=
G methods used by PGRecoveryStats
>> * Move Peering states / methods out of PGRecoveryStat.{cc,h} and into =
PGPeering.{cc,h}
>> * Write tests for PGPeering.{cc,h}, using a fixture derived from PGInt=
erface
>>
>> Because this approach not only moves the peering out of PG.{cc,h} but =
also the rest of the state logic, I would like to know if this seems sens=
ible to you. Also, introducing an abstract base class to help isolate the=
 PG interface and facilitate writing fixtures has not been discussed yet.=

>>
>> Cheers
>>
>> --
>> Lo=EFc Dachary, Artisan Logiciel Libre
>> All that is necessary for the triumph of evil is that good people do n=
othing.
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig9D453B362D6CB4B95B1C6101
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlHEiRYACgkQ8dLMyEl6F21NVQCeOS7cu0xL7zlqMs/dSLqFZa9u
GD8An2lk62o9hURs+ukqyDxjbs69AF7P
=O2Rj
-----END PGP SIGNATURE-----

--------------enig9D453B362D6CB4B95B1C6101--
