From: Loic Dachary <loic@dachary.org>
Subject: Re: ISA erasure code plugin and cache
Date: Mon, 04 Aug 2014 23:26:56 +0200
Message-ID: <53DFFAA0.1030306@dachary.org>
References: <53DF750B.6080107@dachary.org> <3472A07E6605974CBC9BC573F1BC02E4AE75711F@CERNXCHG43.cern.ch> <53DF7E7A.5040509@dachary.org> <6AA21C22F0A5DA478922644AD2EC308C8A60B8@SHSMSX101.ccr.corp.intel.com>, <53DF8304.5040100@dachary.org> <3472A07E6605974CBC9BC573F1BC02E4AE7581DE@CERNXCHG43.cern.ch>,<alpine.DEB.2.00.1408040719440.18917@cobra.newdream.net> <3472A07E6605974CBC9BC573F1BC02E4AE75828F@CERNXCHG43.cern.ch>,<53DFBD34.7020901@dachary.org> <3472A07E6605974CBC9BC573F1BC02E4AE75832D@CERNXCHG43.cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="VMTVqvmC88HioreII4Xg54uQrEgHJTUns"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:53779 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751119AbaHDV1D (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Aug 2014 17:27:03 -0400
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4AE75832D@CERNXCHG43.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VMTVqvmC88HioreII4Xg54uQrEgHJTUns
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

On 04/08/2014 22:07, Andreas Joachim Peters wrote:
> Hi Loic,=20
> brilliant!
>=20
> That's also a good compromise to share encoding tables and avoid lockin=
g for encoding.

I'm glad you like it ;-)

> If there is no upstream change envisaged, I will prepare a pull request=
 according to your proposal. The decoding cache can be shared for each te=
chnique, k+m are intrinsic in the key's used for lookup e.g. we would hav=
e two LRU caches if both techniques are used and one encoding table for e=
ach (k+m) value in use.
> The current setting let's one LRU cache grow to a maximum of 15 MB, how=
ever I would consider such an event as 'extremly' rare ... it is mainly t=
riggered artificially using the benchmark tool.

I'll work on adapting the isa plugin to use the common ErasureCode class =
but that should have little impact on what you'll do. Feel free to ignore=
 this and proceed with the implementation. I'll rebase if necessary once =
you're done.

Cheers

> Cheers Andreas.
>=20
> ________________________________________
> From: Loic Dachary [loic@dachary.org]
> Sent: 04 August 2014 19:04
> To: Andreas Joachim Peters
> Cc: Ceph Development
> Subject: Re: ISA erasure code plugin and cache
>=20
> Hi Andreas,
>=20
> What about getting a singleton containing the LRU cache in
>=20
>     https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/Erasu=
reCodePluginIsa.cc#L48
>=20
> and making it a parameter to the constructor
>=20
>     https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/Erasu=
reCodePluginIsa.cc#L56
>=20
> or the init method
>=20
>     https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/Erasu=
reCodePluginIsa.cc#L70
>=20
> I assume LRU cache can only be shared if the parameters are the same be=
cause it would not make sense to share the cache of an instance using the=
 Cauchy technique with the cache of an instance using the Vandermonde tec=
hnique.
>=20
> If the singleton is created in the plugin entry point:
>=20
>    https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/Erasur=
eCodePluginIsa.cc#L77
>=20
> there is no need to protect it against race conditions because the call=
 to the entry point already is guarded:
>=20
>    https://github.com/ceph/ceph/blob/master/src/erasure-code/ErasureCod=
ePlugin.cc#L74
>=20
> Cheers
>=20
> On 04/08/2014 17:22, Andreas Joachim Peters wrote:
>> Could one not attach the EC instance to the "pg_pool_t" structure whic=
h is given by reference to PGBackend *PGBackend::build_pg_backend? Just a=
 naive question ... i don't know the upstream code ...
>>
>> That would follow the spirit of 'saving/sharing resources' and would f=
ollow the logic that the CODEC configuration is by pool and not by PG ?!?=
!?
>>
>> Cheers Andreas.
>>
>>
>>
>> ________________________________________
>> From: ceph-devel-owner@vger.kernel.org [ceph-devel-owner@vger.kernel.o=
rg] on behalf of Sage Weil [sweil@redhat.com]
>> Sent: 04 August 2014 16:22
>> To: Andreas Joachim Peters
>> Cc: Loic Dachary; Ma, Jianpeng; Ceph Development
>> Subject: RE: ISA erasure code plugin and cache
>>
>> On Mon, 4 Aug 2014, Andreas Joachim Peters wrote:
>>> Yes,
>>> you are both right, it would have only the current failure situation =
in
>>> each cache and it stores the encoding table in each plug-in instance.=

>>> Probably the sharing of cache and encoding table would add more
>>> (unwanted) thread synchronization points.
>>>
>>> If this is the final design, I might remove also the lock? Neverthele=
ss,
>>> it has no measurable performance impact ...
>>
>> Perhaps, but I think the memory impact is significant, especially sinc=
e
>> people will want to use erasure coding for "cold" storage pools are
>> underpowered hardware.  I think we should adjust the strategy so that
>> there is a single instance per pool, or (perhaps better) the cache is
>> global to the plugin (and shared across pools that may share the same
>> EC profile).
>>
>> sage
>>
>>
>>> Cheers Andreas.
>>>
>>>
>>> ________________________________________
>>> From: Loic Dachary [loic@dachary.org]
>>> Sent: 04 August 2014 14:56
>>> To: Ma, Jianpeng; Andreas Joachim Peters
>>> Cc: Ceph Development
>>> Subject: Re: ISA erasure code plugin and cache
>>>
>>> On 04/08/2014 14:50, Ma, Jianpeng wrote:
>>>>> -----Original Message-----
>>>>> From: ceph-devel-owner@vger.kernel.org
>>>>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Loic Dachary=

>>>>> Sent: Monday, August 4, 2014 8:37 PM
>>>>> To: Andreas Joachim Peters
>>>>> Cc: Ma, Jianpeng; Ceph Development
>>>>> Subject: Re: ISA erasure code plugin and cache
>>>>>
>>>>>
>>>>>
>>>>> On 04/08/2014 14:15, Andreas Joachim Peters wrote:> Hi Loic,
>>>>>>
>>>>>> the background relevant to your comments have (unfortunately) neve=
r been
>>>>> answered on the mailing list.
>>>>>>
>>>>>> The cache is written in a way, that it is useful for a fixed (k,m)=
 combination
>>>>> and thread-safe.
>>>>>>
>>>>>> So, if there is one instance of the plugin per pool, it is the rig=
ht
>>>>> implementation. If there is (as you write) one instance for each PG=
 in any pool,
>>>>> it is sort of 'stupid' because the same encoding table is stored fo=
r each PG
>>>>> seperatly.
>>>>>
>>>>> I would not called it stupid ;-) Just not as efficient as if the ca=
che was by all PGs.
>>>>> Without cache the decode table has to be calculated for each object=
 in the
>>>>> placement group and there are a lot of objects. The table may be du=
plicated
>>>>> hundreds of time so it has an impact on the memory footprint, but i=
t should not
>>>>> have a visible impact on the decode performances. An optimisation o=
f your
>>>>> implementation to save memory would be nice, but it is not critical=
=2E
>>>>>
>>>> AFAIK, for a recovery pg, all the objects of pg have the same lost c=
hunks. So only the first object miss the cache.
>>>> But the later won't.  It only need a entry to cache.
>>>> Or am I missing something?
>>>
>>> It also is my understanding and that's what makes the cache so useful=
=2E Now, in the long run the cache stays and grows. Since it is a few meg=
a bytes per PG, it will eventually has a non negligible impact on a long =
running OSD. But again, it's nothing critical to performances.
>>>
>>> Cheers
>>>
>>>>
>>>> Jianpeng Ma
>>>>
>>>>> How large are the decode tables ?
>>>>>
>>>>>> So if the final statement is to create one plugin instance per PG,=
 I will change
>>>>> it accordingly and shared encoding & decoding tables for a fixed (k=
,m), if not it
>>>>> can stay.
>>>>>>
>>>>>> Just need to know that ... this boils down to the fact, that encod=
ing &
>>>>> decoding should not be considered 'stateless'.
>>>>>>
>>>>>> Cheers Andreas.
>>>>>>
>>>>>>
>>>>>> ________________________________________
>>>>>> From: Loic Dachary [loic@dachary.org]
>>>>>> Sent: 04 August 2014 13:56
>>>>>> To: Andreas Joachim Peters
>>>>>> Cc: Ma, Jianpeng; Ceph Development
>>>>>> Subject: ISA erasure code plugin and cache
>>>>>>
>>>>>> Hi,
>>>>>>
>>>>>> Here is how I understand the current code:
>>>>>>
>>>>>> When an OSD is missing, recovery is required and the primary OSD w=
ill collect
>>>>> the available chunks to do so. It will then call the decode method =
via
>>>>> ECUtil::decode which is a small wrapper around the corresponding
>>>>> ErasureCodeInterface::decode method.
>>>>>>
>>>>>>    https://github.com/ceph/ceph/blob/master/src/osd/ECBackend.cc#L=
361
>>>>>>
>>>>>> The ISA plugin will then use the isa_decode method to perform the =
work
>>>>>>
>>>>>>
>>>>> https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/Erasu=
reCode
>>>>> Isa.cc#L212
>>>>>>
>>>>>> and will be repeatedly called until all objects in the PGs that we=
re relying on
>>>>> the missing OSD are recovered. To avoid computing the decoding tabl=
e for each
>>>>> object, it is stored in a LRU cache
>>>>>>
>>>>>>
>>>>> https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/Erasu=
reCode
>>>>> Isa.cc#L480
>>>>>>
>>>>>> and copied in the stack if already there:
>>>>>>
>>>>>>
>>>>> https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/Erasu=
reCode
>>>>> Isa.cc#L433
>>>>>>
>>>>>> Each PG has a separate instance of ErasureCodeIsa, obtained when i=
t is
>>>>> created:
>>>>>>
>>>>>>    https://github.com/ceph/ceph/blob/master/src/osd/PGBackend.cc#L=
292
>>>>>>
>>>>>> It means that data members of each ErasureCodeIsa are copied as ma=
ny
>>>>> times as there are PGs. If an OSD handles participates in 200 PG th=
at belong to
>>>>> an erasure coded pool configured to use ErasureCodeIsa, the data me=
mbers
>>>>> will be duplicated 200 times.
>>>>>>
>>>>>> It is good practice to make it so that the encode/decode methods o=
f
>>>>> ErasureCodeIsa are thread safe. In the jerasure plugin these method=
s have no
>>>>> side effect on the object. In the isa plugin the LRU cache storing =
the decode
>>>>> tables is modified by the decode method and guarded by a mutex:
>>>>>>
>>>>>>    get
>>>>> https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/Erasu=
reCode
>>>>> Isa.cc#L281
>>>>>>    put
>>>>> https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/Erasu=
reCode
>>>>> Isa.cc#L310
>>>>>>
>>>>>> Please correct me if I'm mistaken ;-) I've not reviewed the code y=
et and try to
>>>>> find problems, I just wanted to make sure I get the intention befor=
e doing so.
>>>>>>
>>>>>> Cheers
>>>>>> --
>>>>>> Lo?c Dachary, Artisan Logiciel Libre
>>>>>>
>>>>>
>>>>> --
>>>>> Lo?c Dachary, Artisan Logiciel Libre
>>>>
>>>
>>> --
>>> Lo?c Dachary, Artisan Logiciel Libre
>>>
>>> --
>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
>>> the body of a message to majordomo@vger.kernel.org
>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>
>>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html--
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>=20
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--VMTVqvmC88HioreII4Xg54uQrEgHJTUns
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlPf+qAACgkQ8dLMyEl6F239ugCgilvaPkmqWfqhRjHb5rnKqCGF
Jn0An2NOVkpC8V/Jra+lJq/WH2qUe5Ij
=uiHj
-----END PGP SIGNATURE-----

--VMTVqvmC88HioreII4Xg54uQrEgHJTUns--
