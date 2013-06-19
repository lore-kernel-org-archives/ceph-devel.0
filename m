From: Loic Dachary <loic@dachary.org>
Subject: Re: Erasure code library summary
Date: Wed, 19 Jun 2013 14:10:25 +0200
Message-ID: <51C19FB1.7000700@dachary.org>
References: <51C05123.8000002@dachary.org> <51C196F8.4080501@inktank.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig79270C3D29413C4F3BD4C4EF"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:53992 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S934297Ab3FSMK2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 19 Jun 2013 08:10:28 -0400
In-Reply-To: <51C196F8.4080501@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig79270C3D29413C4F3BD4C4EF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 06/19/2013 01:33 PM, Mark Nelson wrote:
> On 06/18/2013 07:22 AM, Loic Dachary wrote:
>> Hi Ceph,
>>
>> TL;DR: use jerasure 1.2 with Reed-Solomon to code/decode/repair an obj=
ect, and upgrade to 2.0 when available.
>>
>> Disclaimer: I'm no expert ;-) The terms are explained in wikipedia[1].=

>>
>> Using Reed-Solomon object O is encoded by dividing it into consecutive=
 chuncks O1, O2, ... ON and computing parity blocks P1, P2, ... PK.  Read=
ing the original content of object O is a simple concatenation of O1, O2,=
 ... ON. If O2 or P2 are lost, they can be repaired/reconstructed using O=
1 ... ON and P1 ... PK. If the use case is mostly reading objects and rep=
airs are at least 1000 times less likely than normal operations, being ab=
le to read the object from non-coded chuncks is attractive.
>>
>> Reed-Solomon is significantly more expensive to encode ( 100MB/s order=
 of magnitude on a single 2.5Ghz core ) than fountain codes with the curr=
ent jerasure implementation[2]. However, gf-complete[3] that will be used=
 in the upcoming version of jerasure significantly improves performances =
( 2 to 10 times faster ) and the difference becomes negligible.
>=20
> One thing that we might consider is that ARM is very quickly becoming a=
n option for Ceph.  It may be very important to have our erasure coding s=
cheme be viable on that platform and CPU is going to be the primary bottl=
eneck.  It may be worth a quick look at NEON to see if there are any thin=
gs we should be thinking about now.

Hi Mark,

In another thread James Plank wrote that CPU usage is not going to be a p=
roblem as long as we're not trying to slice an object into more than 2^16=
 chunks ( the actual sentence is "I agree that the CPU burden of the GF a=
rithmetic will not be a bottleneck in your system, regardless of which im=
plementation you use, as long as you stay at or below GF(2^16)." http://a=
rticle.gmane.org/gmane.comp.file-systems.ceph.devel/15650 ). It looks lik=
e we're aiming for something in the order of 10 data chunks + 5 parity ch=
unks, i.e. much lower than 2^16. My hunch is that using more than 100 OSD=
s to code a single object would be problematic for reasons that are unrel=
ated to the maths involved in coding it anyway.

That being said I can look for/write benchmark code based on jerasure to =
run on ARM and get a rough idea of the CPU footprint, if you think it's w=
orth it.=20

Cheers
>=20
>>
>> Reed-Solomon coding family is the only one that can keep the chuncks u=
nencoded and therefore concatenable.
>>
>> The jerasure library is packaged and being worked on by the author at =
the moment. All other Free Software implementations are either not packag=
ed or not maintained.
>>
>> The license[4] of jerasure is compatible with the license of Ceph.
>>
>> Performances depend on the parameters to the Reed-Solomon functions bu=
t they will also be influenced by the buffer sizes used when calling the =
encoding functions: smaller buffers will mean more calls and more overhea=
d.
>>
>> Open questions:
>>
>> * Does Mojette Transform [5] have compelling qualities compared to oth=
er code families ?
>> * Do hierarchical codes [6] have compelling qualities ? Implementing t=
hem would require a different API. To be effective they need to take into=
 account the context in which an object is stored where the other code on=
ly require the object itself.
>> * I have not experiemented with the jerasure API yet
>>
>> Feedback and criticisms are welcome :-)
>>
>> [1] http://en.wikipedia.org/wiki/Erasure_code
>> [2] jerasure 1.2 http://web.eecs.utk.edu/~plank/plank/papers/CS-08-627=
=2Ehtml
>> [3] gf-complete http://web.eecs.utk.edu/~plank/plank/papers/CS-13-703.=
html
>> [4] jerasure license https://github.com/tsuraan/Jerasure/blob/master/L=
icense.txt
>> [5] Mojette Transform http://en.wikipedia.org/wiki/Mojette_Transform
>> [6] hierarchical codes http://www.e-biersack.eu/BPublished/nc_springer=
=2Epdf
>>
>>
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.



--------------enig79270C3D29413C4F3BD4C4EF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlHBn7EACgkQ8dLMyEl6F20ehgCggKHzj2/nB+n9IBT870aI8OLh
bhUAn37v9qeSmcvAZKzqpiL8b/BIg1gn
=9Ayc
-----END PGP SIGNATURE-----

--------------enig79270C3D29413C4F3BD4C4EF--
