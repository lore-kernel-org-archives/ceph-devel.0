From: Loic Dachary <loic@dachary.org>
Subject: Re: Separating Peering from PG
Date: Mon, 24 Jun 2013 17:03:48 +0200
Message-ID: <51C85FD4.7030801@dachary.org>
References: <51C4570F.70206@dachary.org> <CA+4uBUYTieHXeOWQXtqvRg6jX-fS1cedt74H2-v36FZhSwqo0A@mail.gmail.com> <51C48916.7090102@dachary.org> <51C49287.2020907@dachary.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig28A848F1A795726B55D6CBC9"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:45545 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752003Ab3FXPDv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 24 Jun 2013 11:03:51 -0400
Received: from [10.8.0.22] (unknown [10.8.0.22])
	by smtp.dmail.dachary.org (Postfix) with ESMTPS id 4E04926396
	for <ceph-devel@vger.kernel.org>; Mon, 24 Jun 2013 17:03:50 +0200 (CEST)
In-Reply-To: <51C49287.2020907@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig28A848F1A795726B55D6CBC9
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

The refactor suggested below is implemented and compiles ( does not link =
yet ).=20

https://github.com/dachary/ceph/commit/03b18a5f4b985781316e9aa9f1e73d3300=
b95a91
from the branch
https://github.com/dachary/ceph/tree/wip-5433

I hope it will help clarify my intentions. I created a task to track this=
 work : http://tracker.ceph.com/issues/5433

Cheers

On 06/21/2013 07:51 PM, Loic Dachary wrote:
> Hi Sam,
>=20
> This draft commit may clarify what I mean
>=20
> https://github.com/dachary/ceph/commit/5c6678385eed4f8769d0f5ee38ad629e=
32b902a6
>=20
> Cheers
>=20
> On 06/21/2013 07:10 PM, Loic Dachary wrote:
>>
>>
>> On 06/21/2013 06:38 PM, Samuel Just wrote:
>>> I'm not sure I understand, by PG::RecoveryStats, do you mean PG::Reco=
veryState?
>>
>> Yes I do, sorry for the confusion. Fixed the typos for clarity, hopefu=
lly.
>>
>> * Move PG::RecoveryState in PGRecoveryState.{cc,h}
>> * Create PGInterface : an abstract base class for PG enumerating all P=
G methods used by PGRecoveryState
>> * Move Peering states / methods out of PGRecoveryState.{cc,h} and into=
 PGPeering.{cc,h}
>> * Write tests for PGPeering.{cc,h}, using a fixture derived from PGInt=
erface
>>
>> Cheers
>>
>>> -Sam
>>>
>>> On Fri, Jun 21, 2013 at 6:37 AM, Loic Dachary <loic@dachary.org> wrot=
e:
>>>> Hi Sage,
>>>>
>>>> In order to move the PG peering code out of PG.{cc,h} (which is the =
next step in refactoring PGs as suggested by Sam http://pad.ceph.com/p/Er=
asure_encoding_as_a_storage_backend ) I think it would be sensible to:
>>>>
>>>> * Move PG::RecoveryStats in PGRecoveryStat.{cc,h}
>>>> * Create PGInterface : an abstract base class for PG enumerating all=
 PG methods used by PGRecoveryStats
>>>> * Move Peering states / methods out of PGRecoveryStat.{cc,h} and int=
o PGPeering.{cc,h}
>>>> * Write tests for PGPeering.{cc,h}, using a fixture derived from PGI=
nterface
>>>>
>>>> Because this approach not only moves the peering out of PG.{cc,h} bu=
t also the rest of the state logic, I would like to know if this seems se=
nsible to you. Also, introducing an abstract base class to help isolate t=
he PG interface and facilitate writing fixtures has not been discussed ye=
t.
>>>>
>>>> Cheers
>>>>
>>>> --
>>>> Lo=EFc Dachary, Artisan Logiciel Libre
>>>> All that is necessary for the triumph of evil is that good people do=
 nothing.
>>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig28A848F1A795726B55D6CBC9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlHIX9UACgkQ8dLMyEl6F21amwCdHNqCK5AqbcmKQQK47riF7S4K
bQYAnjAKBPJQdv7wqJVDCvOyrZb1qFJX
=NPeD
-----END PGP SIGNATURE-----

--------------enig28A848F1A795726B55D6CBC9--
