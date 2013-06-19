From: Loic Dachary <loic@dachary.org>
Subject: Re: Erasure code library summary
Date: Wed, 19 Jun 2013 10:33:39 +0200
Message-ID: <51C16CE3.9020004@dachary.org>
References: <51C05123.8000002@dachary.org> <kpr0dn$3cr$1@ger.gmane.org> <kpr0ld$3cr$2@ger.gmane.org> <51C156FA.2000509@dachary.org> <kprnn8$l72$1@ger.gmane.org>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig30688A7848A84C2374CD59DF"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:42780 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756605Ab3FSIdm (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jun 2013 04:33:42 -0400
In-Reply-To: <kprnn8$l72$1@ger.gmane.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elsayed <eternaleye@gmail.com>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig30688A7848A84C2374CD59DF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Alex,

If I understand correctly, part of what you propose is to make use of fou=
ntain codes to optimize replicas transmissions. It could even be used to =
speed up replication by allowing existing copies to contribute to the com=
pletion of the others. Although this is very appealing, it may be outside=
 of the scope of my current work. Unless you tell me that both topics are=
 intimately linked and should be handled simultaneously for some reason :=
-)

The erasure coded placement group could work as follows:

* Placement group is using K+M OSDs

* An object is sent by a client to the primary OSD
* The primary OSD code the object in K+M chunks=20
* The primary OSD writes the chunks to the OSDs in order
* The primary OSD acknowledge the write

* An object is read by a client from the primary OSD
* The primary OSD reads the K chunks from the K OSDs
* The primary OSD concatenates the K chunks and returns the result

I'd be interested to know if you see a problem with this approach. I coul=
d elaborate on how it would behave when scrubbing, or when the OSDMap cha=
nges ( either because new OSDs becomes available or because an OSD fails =
).

Cheers

On 06/19/2013 09:47 AM, Alex Elsayed wrote:
> Loic Dachary wrote:
>=20
>>
>>
>> On 06/19/2013 03:14 AM, Alex Elsayed wrote:
>>> Alex Elsayed wrote:
>>>
>>>> Loic Dachary wrote:
>>>>
>>>>> Hi Ceph,
>>>>>
>>>> <snip>
>>>>> Reed-Solomon coding family is the only one that can keep the chunck=
s
>>>>> unencoded and therefore concatenable.
>>>> <snip>
>>>>
>>>> In my understanding, this is not strictly true - any 'systematic' co=
de
>>>> will have the unencoded chunks remain available in this manner, and =
any
>>>> non- systematic linear code can be transformed into a systematic cod=
e
>>>> with the same minimum distance. Fountain codes are often explicitly
>>>> constructed to maintain this property, as in the case of RaptorQ [RF=
C
>>>> 6330].
>>>>
>>>> https://en.wikipedia.org/wiki/Systematic_code
>>>
>>> ...that said, Reed-Solomon is to the best of my knowledge the only sp=
ace-
>>> optimal such code.
>>
>> What does "space-optimal" mean ? Does it mean that Reed-Solomon will u=
se
>> less disk space than fountain codes to code the same number of parity
>> chunks ?
>=20
> Optimal (for an erasure code) means that if you have K symbols of real =
data,=20
> then *any* K symbols of the output of the erasure code will let you rec=
over=20
> it.
>=20
> Current fountain codes (RaptorQ is best-of-breed right now as far as I =
know)=20
> require K + epsilon, and while epsilon is zero for the vast majority of=
=20
> cases, some K-sized subsets of the total list of encoded symbols have a=
 non-
> zero epsilon, thus requiring more parity data to get exactly the same l=
evel=20
> of assurance.
>=20
> Optimal erasure codes are also known as "Maximum Distance Separable" co=
des.
>=20
>>> An interesting option, however, might be to use a
>>> fountain code over the network when distributing either replicas *or*=

>>> parity chunks, so that losses can be recovered with <1 full chunk
>>> retransmission.
>>
>> I would be gratefull if you could expand on this idea. I don't get it =
:-)
>=20
> First, a couple caveats - one, doing this over TCP would yield no real =

> benefit. In fact, any reliable transport makes this mostly pointless - =
the=20
> idea is to avoid retransmitting not only chunks, but packets as well.
>=20
> Let's assume 4MB chunks. Encode the chunk as a single source block (Rap=
tor=20
> terminology, see the RFC), with a symbol size chosen to fit 1 (one) sym=
bol=20
> comfortably into a single packet of whatever unreliable, unordered tran=
sport=20
> you're using. DCCP is basically perfect for this.
>=20
> Send the symbols taking advantage of RaptorQ being a systematic code, a=
nd=20
> thus sending the unmodified chunk first. If it gets through okay, the=20
> receiver closes the connection and you're done.
>=20
> If one or more packets failed to get through, those are erasures - so t=
he=20
> receiver leaves the connection open. The sender can be really simplisti=
c -=20
> 'keep encoding and sending symbols as long as the connection is open.' =
Once=20
> the receiver has enough symbols to recover, it closes the connection.
>=20
> In cases of no loss, overhead is zero. In cases of some loss, the numbe=
r of=20
> additional packets is equal to the number of lost packets plus a (very =

> small) potential overhead. The real benefit here is this:
>=20
> There is no longer any need to wait a syn/ack cycle to realize a packet=
 was=20
> lost.
>=20
> This is the use case fountain codes are optimized for - coding for=20
> transmission. Creating a new symbol is an O(1) operation for RaptorQ, w=
hile=20
> for Reed-Solomon it's O(N) with the size of the source block.
>=20
> Another neat property with Raptor codes is that you can have multiple, =

> unsynchronized senders - so for replicas, once one replica has succeede=
d it=20
> could join in to accelerate it *linearly* without needing to track who =
had=20
> which symbols in the chunk.
>=20
> Multicast, too.
>=20
>> Cheers
>>
>=20
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig30688A7848A84C2374CD59DF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlHBbOMACgkQ8dLMyEl6F21v4gCfSSozYSxJKVXt6K6GX99a2t4w
9GQAnAolLtSNrgOvvJt+FKK4WUuB2L44
=rgIG
-----END PGP SIGNATURE-----

--------------enig30688A7848A84C2374CD59DF--
