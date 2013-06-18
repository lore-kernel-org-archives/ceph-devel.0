From: Loic Dachary <loic@dachary.org>
Subject: Re: Comments on Ceph distributed parity implementation
Date: Tue, 18 Jun 2013 17:46:56 +0200
Message-ID: <51C080F0.70907@dachary.org>
References: <20130614201327.70240@gmx.com> <51BB9FC3.8040102@dachary.org> <622F4407872BA447A16110F65453358C01A4D3D29CB3@FMSAMAIL.fmsa.local> <C395B77B849187439280E1CF5FE1F2FA8990491B@G9W0337.americas.hpqcorp.net> <CAJOObidVdjtiwk+xk5rwZi4=DBZ9GvTQnAkteCC0OhB_vyg6pg@mail.gmail.com> <CAJOObicNGkweZbVSR-V8NA9YXaZucUpNm0y8Ph3X7EkE=pRG5g@mail.gmail.com> <CAJOObieUVDQwXVeM68ybuXBmPkZsb57b-gwyVwNVC6VQaat4Zw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig7EEEA27F49C434E234091554"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:53848 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755589Ab3FRPq7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Jun 2013 11:46:59 -0400
In-Reply-To: <CAJOObieUVDQwXVeM68ybuXBmPkZsb57b-gwyVwNVC6VQaat4Zw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Harvey Skinner <hpmpec2a@gmail.com>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig7EEEA27F49C434E234091554
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

Hi Harvey,

On 06/18/2013 04:31 PM, Harvey Skinner wrote:
> all,
>=20
>=20
> nice discussion on implementing  erasure-encoding as an option in Ceph =
for
> object store.   THis will be a great feature option.   I would recommen=
d
> that a good default be implemented  as being discussed here, but also t=
hat
> an API or plug-in be architected at the same time so the deployment cou=
ld
> also use some other form of parity/erasure-encoding if required/desired=
=2E
> Governments and other vendors will push/convince (or have hardcoded in =
an
> RFP) that some other algorithm be used and allowing an API/plug-in
> capability will allow Ceph to still be applicable. There are some
> proprietary object store solutions today which allow other
> erasure-encode/parity plug-ins which you will want to be competitive wi=
th.
>=20

For most coding libraries it looks like an abstract API such as:

// extra =3D=3D GF(2^8) for instance, i.e. parameters dependant on the ki=
nd of encoding function
context =3D initialize(int k, int m, void* extra)
// code block into k+m chunks
code(context, char* block, char** chunks)
// decode k+m chunks into block and if chunk[i] is erased[i], repair it
decode(context, char** chunks, char* block, int* erased)

is all we need. However, if hierarchical codes are to be considered, the =
code() function will need information about the location of the object ( =
the crushmap maybe ?) and probably output additional information to be us=
ed when coding other objects, not just chunks.=20

What do you think ?=20
                          =20
> I would see initial deployments of erasure-encoded object store be used=
 for
> static data objects; block device usage would come later if proved to b=
e as
> performant as replicated objects.   Replication as done now in Ceph may=

> still be a better block storage solution choice for DR strategies,
> configuring replicas to be at different DR site(s).

I suspect you're correct : using erasure coding in a pool used by rgw is =
likely to be the first actual use case.

>=20
> just my view of course =85
>=20
> Harvey
>=20
>=20
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org
>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Paul Von-Stamwi=
tz
>> Sent: Friday, June 14, 2013 6:12 PM
>> To: Loic Dachary; Martin Flyvbjerg
>> Cc: ceph-devel@vger.kernel.org
>> Subject: RE: Comments on Ceph distributed parity implementation
>>
>> Hi Loic and Martin,
>>
>> This is a great discussion and I agree that the performance ramificati=
ons
>> of erasure coding need to be thought out very carefully. Since chunks =
are
>> not only encoded, but distributed across the cluster, we need to pay
>> attention to the network overhead as well as the arithmetic involved i=
n the
>> encoding/decoding.
>>
>> If I understand the proposal correctly, objects begin their life's jou=
rney
>> replicated as normal. As it grows cold, it gets transformed to an enco=
de PG
>> in another pool. Subsequent reads will be redirected (ehh). Subsequent=

>> writes will first decode the original object and re-replicate it (ouch=
!).
>> Client writes never are encoded on the fly; they are always replicated=

>> (nice).
>>
>> So...
>> encode() is run as a low-priority background process probably once a w=
eek
>> during deep scrubs.
>> decode() should be rare (if not, the object shouldn't have been encode=
d in
>> the first place.) If the cluster is healthy no arithmetic is needed, j=
ust
>> concatenation, but a lot of network activity.
>> repair() operations will be the most prevalent and may occur at any ti=
me
>> during normal self-healing/rebalancing operations.
>>
>> Therefore, in my opinion, the algorithm that we choose must be optimiz=
ed
>> for repairing damaged and missing chunks. The main problem I have with=

>> Reed-Solomon is that it uses MDS codes which maximize network activity=
 for
>> recalculations. Pyramid codes have the same write (encode) overhead, b=
ut
>> have better read (repair) overhead.
>>
>> Loic, I know nothing about Mojette Transforms. From what little I glea=
ned,
>> it might be good for repair (needing only a subset of chunks within a =
range
>> to recalculate a missing chunk) but I'm worried about the storage
>> efficiency. RozoFS claims 1.5x. I'd like to do better than that.
>>
>> All the best,
>> Paul
>>
>> On 06/14/2013 3:57 PM, Loic Dachary wrote:
>>> Hi Martin,
>>>
>>> Your explanations are very helpful to better understand the tradeoffs=

>>> of the existing implementations. To be honest I was looking forward t=
o
>>> your intervention. Not you specifically, of course :-) But someone
>>> with a good theoretical background to be a judge of what's best in th=
e
>>> context of Ceph.
>>> If you say it's the upcoming library to be released in August 2013,
>>> I'll take your word for it.
>>>
>>> The work currently being done within Ceph is to architecture to
>>> storage backend ( namely placement groups ) to make room for distribu=
ted
>>> parity.
>>> My initial idea was to isolate the low level library under an API tha=
t
>>> takes a region ( 16KB for instance, as in gf_unit.c found in
>>> http://web.eecs.utk.edu/~plank/plank/papers/CS-13-
>>> 703/gf_complete_0.1.tar ) as input and outputs chunks that can then b=
e
>>> written on different hosts. For instance
>>>
>>>       encode(char* region, char** chuncks) =3D> encode the region int=
o N
>>> chuncks
>>>       decode(char** chunks, char* region) =3D> decode the N chuncks i=
nto a
>>> region
>>>         repair(char** chunks, int damaged) =3D> repair the damaged
>>> chunck
>>>
>>> Do you think it is a sensible approach ? And if you do, will I find
>>> examples of such higher level functions in
>>> http://web.eecs.utk.edu/~plank/plank/papers/CS-13-
>>> 703/gf_complete_0.1.tar ? Or elsewhere ?
>>>
>>> I'm a little confused about the relation between GF complete ( as
>>> found at
>>> http://web.eecs.utk.edu/~plank/plank/papers/CS-13-
>>> 703/gf_complete_0.1.tar ) which is very recent ( 2013 ) and Jerasure =
(
>>> as found at
>>> http://web.eecs.utk.edu/~plank/plank/papers/CS-08-627/Jerasure-
>>> 1.2.tar )  which is comparatively older ( 2008 ). Do you know how
>>> Jerasure
>>> 2.0 relates to GF complete ?
>>>
>>> For completeness, here is a thread with pointers to Mojette Transform=

>>> that's being used as part of Rozofs.
>>>
>>> http://www.mail-archive.com/ceph-devel@vger.kernel.org/msg14666.html
>>>
>>> I'm not able to compare it with the other libraries because it seems
>>> to take a completely different approach. Do you have an opinion about=
 it
>>> ?
>>>
>>> As Patrick mentioned, I'll be at http://www.oscon.com/oscon2013 next
>>> month but I'd love to understand more about this as soon as possible
>>> :-)
>>>
>>> Cheers
>>>
>>> P.S. Updated
>>> http://wiki.ceph.com/01Planning/02Blueprints/Dumpling/Erasure_encodin=
g
>>> _as_ a_storage_backend#Erasure_Encoded_Storage with a link to
>>> http://web.eecs.utk.edu/~plank/plank/www/software.html for the record=

>>>
>>> On 06/14/2013 10:13 PM, Martin Flyvbjerg wrote:
>>>> Dear Community
>>>> I am a young engineer (not software or math, please bare with me)
>>>> with
>>> some suggestions regarding erasure codes. I never used Ceph before or=

>>> any other distributed file system.
>>>>
>>>> I stumped upon the suggestion for adding erasure codes to Ceph, as
>>>> described in this article
>>>>
>>> http://wiki.Ceph.com/01Planning/02Blueprints/Dumpling/Erasure_encodin=
g
>>> _as_
>>> a_storage_backend
>>>>
>>>> first I would like to say great initiative to add erasure codes to
>>>> Ceph.
>>>> Ceph needs its own implementation and it have to be done right, I
>>>> cannot
>>> stress this enough, suggested software mentioned in that article woul=
d
>>> result in very low performance.
>>>>
>>>> Why?
>>>> Reed-Solomon is normally something regarded as being very slow
>>>> compared
>>> to other erasure codes, because the underlying Galois-Field
>>> multiplication is slow. Please see video at usenix.org forexplanation=
=2E
>>>>
>>>> The implementations of Zfec library and other suggested software the=

>>> others rely on the Vandermonde matrix, a matrix used in in
>>> Reed-Solomon erasure codes, a faster approach would be to use the
>>> Cauchy-Reed-Solomon implementation. Please see [1,2,3]
>>>> Although there is something even better, by using the Intel SSE2/3
>>>> SIMD
>>> instructions it is possible to do the as fast as any other XOR based
>>> erasure codes (RaptorQ LT-codes, LDPC etc.).
>>>>
>>>> The suggested FECpp lib uses the optimisation but with a relative
>>>> small
>>> Galois-field only 2^8, since Ceph aimes at unlimited scalability
>>> increasing the size of the Galois-Field would improve performance [4]=
=2E
>>> Of course the configured Ceph Object Size and/or Stripe width have to=

>>> be taken into account.
>>>> Please see
>>>> https://www.usenix.org/conference/fast13/screaming-fast-galois-field=

>>>> -
>>> arithmetic-using-sse2-extensions
>>>>
>>>>
>>>> The solution
>>>> Using the GF-Complete open source library [4] to implement
>>>> Reed-Solomon
>>> in Ceph in order to allow Ceph to scale to infinity.
>>>> James S. Plank the author of GF-complete have developed a library
>>> implementing various Reed-Solomon codes called Jerasure.
>>> http://web.eecs.utk.edu/~plank/plank/www/software.html
>>>> Jerasure 2.0 using the GF-complete artimetric based in Intel SSE
>>>> SIMD
>>> instructions, is current in development expected release august 2013.=

>>> Will be released under the new BSD license. Jerasure 2.0 also support=
s
>>> arbitrary Galois-field sizes 8,16,32,64 or 128 bit.
>>>>
>>>> The limit of this implementation would be the processors L2/L3 cache=

>>>> not
>>> the underlying arithmetic.
>>>>
>>>> Best Regards
>>>> Martin Flyvbjerg
>>>>
>>>> [1] http://web.eecs.utk.edu/~plank/plank/papers/CS-05-569.pdf
>>>> [2] http://web.eecs.utk.edu/~plank/plank/papers/CS-08-625.pdf
>>>> [3] http://web.eecs.utk.edu/~plank/plank/papers/FAST-2009.pdf
>>>> [4] http://web.eecs.utk.edu/~plank/plank/papers/FAST-2013-GF.pdf
>>>> --
>>>> To unsubscribe from this list: send the line "unsubscribe
>>>> ceph-devel" in the body of a message to majordomo@vger.kernel.org
>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>> --
>>> Lo=EFc Dachary, Artisan Logiciel Libre
>>> All that is necessary for the triumph of evil is that good people do
>>> nothing.
>>>
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>> the body of a message to majordomo@vger.kernel.org More majordomo info=
 at
>> http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.


--------------enig7EEEA27F49C434E234091554
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlHAgPAACgkQ8dLMyEl6F22a6ACfXYOs14bf4zRG9RModCyRNPfc
6MUAniA/08iZmi29mSRoDuB4Qgy5XPc+
=4tOi
-----END PGP SIGNATURE-----

--------------enig7EEEA27F49C434E234091554--
