From: Loic Dachary <loic@dachary.org>
Subject: Re: Comments on Ceph distributed parity implementation
Date: Sat, 15 Jun 2013 08:51:07 +0200
Message-ID: <51BC0EDB.9090903@dachary.org>
References: <20130614201327.70240@gmx.com> <51BB9FC3.8040102@dachary.org> <622F4407872BA447A16110F65453358C01A4D3D29CB3@FMSAMAIL.fmsa.local>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig0327213651A2E03A269CC6B6"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:44183 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751521Ab3FOGvK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 15 Jun 2013 02:51:10 -0400
In-Reply-To: <622F4407872BA447A16110F65453358C01A4D3D29CB3@FMSAMAIL.fmsa.local>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Paul Von-Stamwitz <PVonStamwitz@us.fujitsu.com>
Cc: Martin Flyvbjerg <martinflyvbjerg@gmx.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig0327213651A2E03A269CC6B6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 06/15/2013 03:12 AM, Paul Von-Stamwitz wrote:
> Hi Loic and Martin,
>=20
> This is a great discussion and I agree that the performance ramificatio=
ns of erasure coding need to be thought out very carefully. Since chunks =
are not only encoded, but distributed across the cluster, we need to pay =
attention to the network overhead as well as the arithmetic involved in t=
he encoding/decoding.
>=20
> If I understand the proposal correctly, objects begin their life's jour=
ney replicated as normal. As it grows cold, it gets transformed to an enc=
ode PG in another pool. Subsequent reads will be redirected (ehh). Subseq=
uent writes will first decode the original object and re-replicate it (ou=
ch!). Client writes never are encoded on the fly; they are always replica=
ted (nice).

Hi Paul,

The first step is to have an encoded PG : it could be useful on its own. =


> So...
> encode() is run as a low-priority background process probably once a we=
ek during deep scrubs.
> decode() should be rare (if not, the object shouldn't have been encoded=
 in the first place.) If the cluster is healthy no arithmetic is needed, =
just concatenation, but a lot of network activity.
> repair() operations will be the most prevalent and may occur at any tim=
e during normal self-healing/rebalancing operations.
>=20
> Therefore, in my opinion, the algorithm that we choose must be optimize=
d for repairing damaged and missing chunks. The main problem I have with =
Reed-Solomon is that it uses MDS codes which maximize network activity fo=
r recalculations. Pyramid codes have the same write (encode) overhead, bu=
t have better read (repair) overhead.

Which library do you typically use ? I would love to hear about the use c=
ases you worked on.

Cheers

> Loic, I know nothing about Mojette Transforms. From what little I glean=
ed, it might be good for repair (needing only a subset of chunks within a=
 range to recalculate a missing chunk) but I'm worried about the storage =
efficiency. RozoFS claims 1.5x. I'd like to do better than that.
>=20
> All the best,
> Paul
>=20
> On 06/14/2013 3:57 PM, Loic Dachary wrote:
>> Hi Martin,
>>
>> Your explanations are very helpful to better understand the tradeoffs =
of
>> the existing implementations. To be honest I was looking forward to yo=
ur
>> intervention. Not you specifically, of course :-) But someone with a g=
ood
>> theoretical background to be a judge of what's best in the context of =
Ceph.
>> If you say it's the upcoming library to be released in August 2013, I'=
ll
>> take your word for it.
>>
>> The work currently being done within Ceph is to architecture to storag=
e
>> backend ( namely placement groups ) to make room for distributed parit=
y.
>> My initial idea was to isolate the low level library under an API that=

>> takes a region ( 16KB for instance, as in gf_unit.c found in
>> http://web.eecs.utk.edu/~plank/plank/papers/CS-13-
>> 703/gf_complete_0.1.tar ) as input and outputs chunks that can then be=

>> written on different hosts. For instance
>>
>> 	encode(char* region, char** chuncks) =3D> encode the region into N
>> chuncks
>> 	decode(char** chunks, char* region) =3D> decode the N chuncks into a
>> region
>>         repair(char** chunks, int damaged) =3D> repair the damaged chu=
nck
>>
>> Do you think it is a sensible approach ? And if you do, will I find
>> examples of such higher level functions in
>> http://web.eecs.utk.edu/~plank/plank/papers/CS-13-
>> 703/gf_complete_0.1.tar ? Or elsewhere ?
>>
>> I'm a little confused about the relation between GF complete ( as foun=
d at
>> http://web.eecs.utk.edu/~plank/plank/papers/CS-13-
>> 703/gf_complete_0.1.tar ) which is very recent ( 2013 ) and Jerasure (=
 as
>> found at http://web.eecs.utk.edu/~plank/plank/papers/CS-08-627/Jerasur=
e-
>> 1.2.tar )  which is comparatively older ( 2008 ). Do you know how Jera=
sure
>> 2.0 relates to GF complete ?
>>
>> For completeness, here is a thread with pointers to Mojette Transform
>> that's being used as part of Rozofs.
>>
>> http://www.mail-archive.com/ceph-devel@vger.kernel.org/msg14666.html
>>
>> I'm not able to compare it with the other libraries because it seems t=
o
>> take a completely different approach. Do you have an opinion about it =
?
>>
>> As Patrick mentioned, I'll be at http://www.oscon.com/oscon2013 next m=
onth
>> but I'd love to understand more about this as soon as possible :-)
>>
>> Cheers
>>
>> P.S. Updated
>> http://wiki.ceph.com/01Planning/02Blueprints/Dumpling/Erasure_encoding=
_as_
>> a_storage_backend#Erasure_Encoded_Storage with a link to
>> http://web.eecs.utk.edu/~plank/plank/www/software.html for the record
>>
>> On 06/14/2013 10:13 PM, Martin Flyvbjerg wrote:
>>> Dear Community
>>> I am a young engineer (not software or math, please bare with me) wit=
h
>> some suggestions regarding erasure codes. I never used Ceph before or =
any
>> other distributed file system.
>>>
>>> I stumped upon the suggestion for adding erasure codes to Ceph, as
>>> described in this article
>>>
>> http://wiki.Ceph.com/01Planning/02Blueprints/Dumpling/Erasure_encoding=
_as_
>> a_storage_backend
>>>
>>> first I would like to say great initiative to add erasure codes to Ce=
ph.
>>> Ceph needs its own implementation and it have to be done right, I can=
not
>> stress this enough, suggested software mentioned in that article would=

>> result in very low performance.
>>>
>>> Why?
>>> Reed-Solomon is normally something regarded as being very slow compar=
ed
>> to other erasure codes, because the underlying Galois-Field multiplica=
tion
>> is slow. Please see video at usenix.org forexplanation.
>>>
>>> The implementations of Zfec library and other suggested software the
>> others rely on the Vandermonde matrix, a matrix used in in Reed-Solomo=
n
>> erasure codes, a faster approach would be to use the Cauchy-Reed-Solom=
on
>> implementation. Please see [1,2,3]
>>> Although there is something even better, by using the Intel SSE2/3 SI=
MD
>> instructions it is possible to do the as fast as any other XOR based
>> erasure codes (RaptorQ LT-codes, LDPC etc.).
>>>
>>> The suggested FECpp lib uses the optimisation but with a relative sma=
ll
>> Galois-field only 2^8, since Ceph aimes at unlimited scalability
>> increasing the size of the Galois-Field would improve performance [4].=
 Of
>> course the configured Ceph Object Size and/or Stripe width have to be
>> taken into account.
>>> Please see
>>> https://www.usenix.org/conference/fast13/screaming-fast-galois-field-=

>> arithmetic-using-sse2-extensions
>>>
>>>
>>> The solution
>>> Using the GF-Complete open source library [4] to implement Reed-Solom=
on
>> in Ceph in order to allow Ceph to scale to infinity.
>>> James S. Plank the author of GF-complete have developed a library
>> implementing various Reed-Solomon codes called Jerasure.
>> http://web.eecs.utk.edu/~plank/plank/www/software.html
>>> Jerasure 2.0 using the GF-complete artimetric based in Intel SSE SIMD=

>> instructions, is current in development expected release august 2013. =
Will
>> be released under the new BSD license. Jerasure 2.0 also supports
>> arbitrary Galois-field sizes 8,16,32,64 or 128 bit.
>>>
>>> The limit of this implementation would be the processors L2/L3 cache =
not
>> the underlying arithmetic.
>>>
>>> Best Regards
>>> Martin Flyvbjerg
>>>
>>> [1] http://web.eecs.utk.edu/~plank/plank/papers/CS-05-569.pdf
>>> [2] http://web.eecs.utk.edu/~plank/plank/papers/CS-08-625.pdf
>>> [3] http://web.eecs.utk.edu/~plank/plank/papers/FAST-2009.pdf
>>> [4] http://web.eecs.utk.edu/~plank/plank/papers/FAST-2013-GF.pdf
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>> --
>> Lo=EFc Dachary, Artisan Logiciel Libre
>> All that is necessary for the triumph of evil is that good people do
>> nothing.
>>
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.



--------------enig0327213651A2E03A269CC6B6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlG8DtsACgkQ8dLMyEl6F21lfQCdHcXeqWWjGmys+nvFCtwqNTWj
j0UAoLbkLWBmVU8YIHO/tmwOpB4J7v2C
=iSMv
-----END PGP SIGNATURE-----

--------------enig0327213651A2E03A269CC6B6--
