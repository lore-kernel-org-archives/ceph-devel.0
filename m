From: Loic Dachary <loic@dachary.org>
Subject: Re: Erasure code library summary
Date: Sun, 23 Jun 2013 09:01:56 +0200
Message-ID: <51C69D64.7080901@dachary.org>
References: <51C05123.8000002@dachary.org> <51C196F8.4080501@inktank.com> <51C19FB1.7000700@dachary.org> <51C1A513.8040604@inktank.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigAB3BBB27B448476B4331D3BE"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:33622 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750811Ab3FWHCE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 23 Jun 2013 03:02:04 -0400
In-Reply-To: <51C1A513.8040604@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigAB3BBB27B448476B4331D3BE
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 06/19/2013 02:33 PM, Mark Nelson wrote:
> On 06/19/2013 07:10 AM, Loic Dachary wrote:
>>
>>
>> On 06/19/2013 01:33 PM, Mark Nelson wrote:
>>> On 06/18/2013 07:22 AM, Loic Dachary wrote:
>>>> Hi Ceph,
>>>>
>>>> TL;DR: use jerasure 1.2 with Reed-Solomon to code/decode/repair an o=
bject, and upgrade to 2.0 when available.
>>>>
>>>> Disclaimer: I'm no expert ;-) The terms are explained in wikipedia[1=
].
>>>>
>>>> Using Reed-Solomon object O is encoded by dividing it into consecuti=
ve chuncks O1, O2, ... ON and computing parity blocks P1, P2, ... PK.  Re=
ading the original content of object O is a simple concatenation of O1, O=
2, ... ON. If O2 or P2 are lost, they can be repaired/reconstructed using=
 O1 ... ON and P1 ... PK. If the use case is mostly reading objects and r=
epairs are at least 1000 times less likely than normal operations, being =
able to read the object from non-coded chuncks is attractive.
>>>>
>>>> Reed-Solomon is significantly more expensive to encode ( 100MB/s ord=
er of magnitude on a single 2.5Ghz core ) than fountain codes with the cu=
rrent jerasure implementation[2]. However, gf-complete[3] that will be us=
ed in the upcoming version of jerasure significantly improves performance=
s ( 2 to 10 times faster ) and the difference becomes negligible.
>>>
>>> One thing that we might consider is that ARM is very quickly becoming=
 an option for Ceph.  It may be very important to have our erasure coding=
 scheme be viable on that platform and CPU is going to be the primary bot=
tleneck.  It may be worth a quick look at NEON to see if there are any th=
ings we should be thinking about now.
>>
>> Hi Mark,
>>
>> In another thread James Plank wrote that CPU usage is not going to be =
a problem as long as we're not trying to slice an object into more than 2=
^16 chunks ( the actual sentence is "I agree that the CPU burden of the G=
F arithmetic will not be a bottleneck in your system, regardless of which=
 implementation you use, as long as you stay at or below GF(2^16)." http:=
//article.gmane.org/gmane.comp.file-systems.ceph.devel/15650 ). It looks =
like we're aiming for something in the order of 10 data chunks + 5 parity=
 chunks, i.e. much lower than 2^16. My hunch is that using more than 100 =
OSDs to code a single object would be problematic for reasons that are un=
related to the maths involved in coding it anyway.
>>
>> That being said I can look for/write benchmark code based on jerasure =
to run on ARM and get a rough idea of the CPU footprint, if you think it'=
s worth it.
>=20
> I don't want to add even more to your plate because you already have qu=
ite a bit here!  I just want to mention it because on ARM, CRC32c and gen=
eral Ceph processing is already using a significant amount of the CPU res=
ources.  I suspect that even highly optimized erasure coding implementati=
ons will be fighting for CPU on ARM (That may change though with some of =
the next generation ARM cores coming out next year).

Hi Mark,

I'll keep that in mind and ask around for ARM vs Intel benchmarks related=
 to erasure coding.

Cheers

>=20
>>
>> Cheers
>>>
>>>>
>>>> Reed-Solomon coding family is the only one that can keep the chuncks=
 unencoded and therefore concatenable.
>>>>
>>>> The jerasure library is packaged and being worked on by the author a=
t the moment. All other Free Software implementations are either not pack=
aged or not maintained.
>>>>
>>>> The license[4] of jerasure is compatible with the license of Ceph.
>>>>
>>>> Performances depend on the parameters to the Reed-Solomon functions =
but they will also be influenced by the buffer sizes used when calling th=
e encoding functions: smaller buffers will mean more calls and more overh=
ead.
>>>>
>>>> Open questions:
>>>>
>>>> * Does Mojette Transform [5] have compelling qualities compared to o=
ther code families ?
>>>> * Do hierarchical codes [6] have compelling qualities ? Implementing=
 them would require a different API. To be effective they need to take in=
to account the context in which an object is stored where the other code =
only require the object itself.
>>>> * I have not experiemented with the jerasure API yet
>>>>
>>>> Feedback and criticisms are welcome :-)
>>>>
>>>> [1] http://en.wikipedia.org/wiki/Erasure_code
>>>> [2] jerasure 1.2 http://web.eecs.utk.edu/~plank/plank/papers/CS-08-6=
27.html
>>>> [3] gf-complete http://web.eecs.utk.edu/~plank/plank/papers/CS-13-70=
3.html
>>>> [4] jerasure license https://github.com/tsuraan/Jerasure/blob/master=
/License.txt
>>>> [5] Mojette Transform http://en.wikipedia.org/wiki/Mojette_Transform=

>>>> [6] hierarchical codes http://www.e-biersack.eu/BPublished/nc_spring=
er.pdf
>>>>
>>>>
>>>
>>
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.



--------------enigAB3BBB27B448476B4331D3BE
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlHGnWQACgkQ8dLMyEl6F20iywCfUnfE+qlimHPsVtKk/Zz8wucL
nAwAnjOGLuV9vRF65NToMIrYwUa191I6
=dgjj
-----END PGP SIGNATURE-----

--------------enigAB3BBB27B448476B4331D3BE--
