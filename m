From: Loic Dachary <loic@dachary.org>
Subject: Re: OSD abstract class
Date: Sun, 05 May 2013 01:27:45 +0200
Message-ID: <51859971.2050106@dachary.org>
References: <5178E6AE.6060609@dachary.org> <CAPYLRzirdWRaAEDP7UrrgV-AGcj3KoEoHOtC+A7DFYJD7BQbCA@mail.gmail.com> <517975D6.1020904@dachary.org> <CAPYLRzg__S87=WTByxrKDnxRmx+PqtxibYLQGUC51hJ4dSsMow@mail.gmail.com> <51799024.8030101@dachary.org> <CA+4uBUbLf9SsVM1Y5Pd=asA7VgiKGEaKn8w_2JfwiKwGZijvPg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig5A9D99BC15764FA7E0DF0414"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:52152 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751288Ab3EDX1t (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 4 May 2013 19:27:49 -0400
In-Reply-To: <CA+4uBUbLf9SsVM1Y5Pd=asA7VgiKGEaKn8w_2JfwiKwGZijvPg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Samuel Just <sam.just@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig5A9D99BC15764FA7E0DF0414
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 04/26/2013 03:05 AM, Samuel Just wrote:
> A good place to start would be to get some unit test coverage of the
> PG::PriorSet logic.  It's already factored out to a degree.
> osd_types.h::pg_interval_t::check_new_interval would also be a good
> place for testing.
>=20
> For something rather more ambitious, the
> merge_log/rewind_dievergent_log and related methods could use better
> test coverage, but that would require some significant refactoring.

Hi Sam,

A short note to let you know that I appreciate the advice. I'll need to u=
nderstand a little more about PG before I can act on it ;-)

Cheers

> -Sam
>=20
> On Thu, Apr 25, 2013 at 1:20 PM, Loic Dachary <loic@dachary.org> wrote:=

>>
>>
>> On 04/25/2013 09:47 PM, Gregory Farnum wrote:
>>> On Thu, Apr 25, 2013 at 11:28 AM, Loic Dachary <loic@dachary.org> wro=
te:
>>>>
>>>>
>>>> On 04/25/2013 06:45 PM, Gregory Farnum wrote:
>>>>> On Thu, Apr 25, 2013 at 1:17 AM, Loic Dachary <loic@dachary.org> wr=
ote:
>>>>>> Hi,
>>>>>>
>>>>>> In the context of the implementation of
>>>>>>
>>>>>> http://wiki.ceph.com/01Planning/02Blueprints/Dumpling/Erasure_enco=
ding_as_a_storage_backend
>>>>>>
>>>>>> I'm preparing tests to assert that the modifications that will be =
made to the existing PG and ReplicatedPG will not introduce regressions. =
Unless I'm mistaken, there are no unit tests or functional tests for PG o=
r ReplicatedPG at the moment. I thought that it might be useful to add an=
 abstract OSD class from which OSD is derived, to allow a test to derive =
from it to implement synthetic behavior.
>>>>>>
>>>>>>
>>>>>> I gave it a try and it passes make check successfully. It is a lit=
tle hairy because I commented out the code instead of removing it to help=
 with rebasing.
>>>>>>
>>>>>> https://github.com/dachary/ceph/commit/a9eb690a3537c3f844b47e76cde=
048b084e314eb
>>>>>>
>>>>>> I'll now try to use it to implement some tests for ReplicatedPG.
>>>>>>
>>>>>> I would very much appreciate if someone has an advice on the best =
way to proceed. Even if it's to say : "you're crazy, don't go there ! you=
're wasting your time, there is a much simpler way !" ;-)
>>>>>
>>>>> What's your plot here? The OSD is fairly large to be doing unit tes=
ts
>>>>> on (although it's not insensible) =97 but if we want to form a new =
PG it
>>>>> might be best to start out by making abstract PG implementations.
>>>>>
>>>>
>>>> My reasoning was that to for a new PG it was enough to rely on
>>>>
>>>> https://github.com/ceph/ceph/blob/master/src/osd/PG.h
>>>>
>>>> and create a new ErasureEncodingPG.{cc,h} after
>>>>
>>>> https://github.com/ceph/ceph/blob/master/src/osd/ReplicatedPG.cc
>>>>
>>>> Since ReplicatedPG is the only class derived from PG, I assumed ther=
e will be a need to move code from ReplicatedPG to PG and vice versa to m=
ake sure PG can actually be the base class of two different implementatio=
ns. Are you suggesting that PG should be abstracted ? Is there a reason w=
hy it would not be a good base class for a new ErasureEncodedPG ?
>>>
>>> Oh, it *should* be the base class, but the distinction between PG and=

>>> ReplicatedPG right now is...vanishing. I had a quick chat about this
>>> with Sam a couple days ago and we agreed the first task here is going=

>>> to be properly slicing them up somehow (the current state of affairs
>>> is not a good model, even, from what he's told me).
>>
>> Understood :-) I'm quite sure this is out of my league.
>>
>>> I'm not saying the OSD is a bad plan, just that I'm not sure what kin=
d
>>> of useful tests we could produce by abstracting it =97 whereas the un=
it
>>> tests we can write against a PG seem a lot simpler and more obvious. =
I
>>> could well be missing something, though.
>>
>> I'll focus on writing PG tests. It will help me understand the details=
 of PG / ReplicatedPG and eventually help with the necessary refactoring.=

>>
>> Thanks again for the guidance :-)
>>
>>> -Greg
>>> Software Engineer #42 @ http://inktank.com | http://ceph.com
>>
>> --
>> Lo=EFc Dachary, Artisan Logiciel Libre
>>

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig5A9D99BC15764FA7E0DF0414
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlGFmXIACgkQ8dLMyEl6F22sqgCgw4htTXPYXSlkVXV88fco6JB+
09YAnjNB891tUStZl6JC8gImG9XRIhTK
=mrlN
-----END PGP SIGNATURE-----

--------------enig5A9D99BC15764FA7E0DF0414--
