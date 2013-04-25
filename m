From: Loic Dachary <loic@dachary.org>
Subject: Re: OSD abstract class
Date: Thu, 25 Apr 2013 22:20:52 +0200
Message-ID: <51799024.8030101@dachary.org>
References: <5178E6AE.6060609@dachary.org> <CAPYLRzirdWRaAEDP7UrrgV-AGcj3KoEoHOtC+A7DFYJD7BQbCA@mail.gmail.com> <517975D6.1020904@dachary.org> <CAPYLRzg__S87=WTByxrKDnxRmx+PqtxibYLQGUC51hJ4dSsMow@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2B2D0FCD8BC406659E7A9716"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:58121 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757397Ab3DYUU4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Apr 2013 16:20:56 -0400
In-Reply-To: <CAPYLRzg__S87=WTByxrKDnxRmx+PqtxibYLQGUC51hJ4dSsMow@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2B2D0FCD8BC406659E7A9716
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 04/25/2013 09:47 PM, Gregory Farnum wrote:
> On Thu, Apr 25, 2013 at 11:28 AM, Loic Dachary <loic@dachary.org> wrote=
:
>>
>>
>> On 04/25/2013 06:45 PM, Gregory Farnum wrote:
>>> On Thu, Apr 25, 2013 at 1:17 AM, Loic Dachary <loic@dachary.org> wrot=
e:
>>>> Hi,
>>>>
>>>> In the context of the implementation of
>>>>
>>>> http://wiki.ceph.com/01Planning/02Blueprints/Dumpling/Erasure_encodi=
ng_as_a_storage_backend
>>>>
>>>> I'm preparing tests to assert that the modifications that will be ma=
de to the existing PG and ReplicatedPG will not introduce regressions. Un=
less I'm mistaken, there are no unit tests or functional tests for PG or =
ReplicatedPG at the moment. I thought that it might be useful to add an a=
bstract OSD class from which OSD is derived, to allow a test to derive fr=
om it to implement synthetic behavior.
>>>>
>>>>
>>>> I gave it a try and it passes make check successfully. It is a littl=
e hairy because I commented out the code instead of removing it to help w=
ith rebasing.
>>>>
>>>> https://github.com/dachary/ceph/commit/a9eb690a3537c3f844b47e76cde04=
8b084e314eb
>>>>
>>>> I'll now try to use it to implement some tests for ReplicatedPG.
>>>>
>>>> I would very much appreciate if someone has an advice on the best wa=
y to proceed. Even if it's to say : "you're crazy, don't go there ! you'r=
e wasting your time, there is a much simpler way !" ;-)
>>>
>>> What's your plot here? The OSD is fairly large to be doing unit tests=

>>> on (although it's not insensible) =97 but if we want to form a new PG=
 it
>>> might be best to start out by making abstract PG implementations.
>>>
>>
>> My reasoning was that to for a new PG it was enough to rely on
>>
>> https://github.com/ceph/ceph/blob/master/src/osd/PG.h
>>
>> and create a new ErasureEncodingPG.{cc,h} after
>>
>> https://github.com/ceph/ceph/blob/master/src/osd/ReplicatedPG.cc
>>
>> Since ReplicatedPG is the only class derived from PG, I assumed there =
will be a need to move code from ReplicatedPG to PG and vice versa to mak=
e sure PG can actually be the base class of two different implementations=
=2E Are you suggesting that PG should be abstracted ? Is there a reason w=
hy it would not be a good base class for a new ErasureEncodedPG ?
>=20
> Oh, it *should* be the base class, but the distinction between PG and
> ReplicatedPG right now is...vanishing. I had a quick chat about this
> with Sam a couple days ago and we agreed the first task here is going
> to be properly slicing them up somehow (the current state of affairs
> is not a good model, even, from what he's told me).

Understood :-) I'm quite sure this is out of my league.

> I'm not saying the OSD is a bad plan, just that I'm not sure what kind
> of useful tests we could produce by abstracting it =97 whereas the unit=

> tests we can write against a PG seem a lot simpler and more obvious. I
> could well be missing something, though.

I'll focus on writing PG tests. It will help me understand the details of=
 PG / ReplicatedPG and eventually help with the necessary refactoring.

Thanks again for the guidance :-)

> -Greg
> Software Engineer #42 @ http://inktank.com | http://ceph.com

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--------------enig2B2D0FCD8BC406659E7A9716
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlF5kCUACgkQ8dLMyEl6F23o1gCeMseEj/xfLugx/bPoAMeowwDF
m30AnRwOhANQ16fuyNXeydP3jRpQO9uU
=+ogw
-----END PGP SIGNATURE-----

--------------enig2B2D0FCD8BC406659E7A9716--
