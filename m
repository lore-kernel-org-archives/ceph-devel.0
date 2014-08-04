From: Loic Dachary <loic@dachary.org>
Subject: Re: ISA erasure code plugin and cache
Date: Mon, 04 Aug 2014 14:56:36 +0200
Message-ID: <53DF8304.5040100@dachary.org>
References: <53DF750B.6080107@dachary.org> <3472A07E6605974CBC9BC573F1BC02E4AE75711F@CERNXCHG43.cern.ch> <53DF7E7A.5040509@dachary.org> <6AA21C22F0A5DA478922644AD2EC308C8A60B8@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="9PLDNICqopHtPXvQkQxuJH5U0IpKDHUAG"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:53468 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1751117AbaHDM4n (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 4 Aug 2014 08:56:43 -0400
In-Reply-To: <6AA21C22F0A5DA478922644AD2EC308C8A60B8@SHSMSX101.ccr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Ma, Jianpeng" <jianpeng.ma@intel.com>, Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--9PLDNICqopHtPXvQkQxuJH5U0IpKDHUAG
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 04/08/2014 14:50, Ma, Jianpeng wrote:
>> -----Original Message-----
>> From: ceph-devel-owner@vger.kernel.org
>> [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Loic Dachary
>> Sent: Monday, August 4, 2014 8:37 PM
>> To: Andreas Joachim Peters
>> Cc: Ma, Jianpeng; Ceph Development
>> Subject: Re: ISA erasure code plugin and cache
>>
>>
>>
>> On 04/08/2014 14:15, Andreas Joachim Peters wrote:> Hi Loic,
>>>
>>> the background relevant to your comments have (unfortunately) never b=
een
>> answered on the mailing list.
>>>
>>> The cache is written in a way, that it is useful for a fixed (k,m) co=
mbination
>> and thread-safe.
>>>
>>> So, if there is one instance of the plugin per pool, it is the right
>> implementation. If there is (as you write) one instance for each PG in=
 any pool,
>> it is sort of 'stupid' because the same encoding table is stored for e=
ach PG
>> seperatly.
>>
>> I would not called it stupid ;-) Just not as efficient as if the cache=
 was by all PGs.
>> Without cache the decode table has to be calculated for each object in=
 the
>> placement group and there are a lot of objects. The table may be dupli=
cated
>> hundreds of time so it has an impact on the memory footprint, but it s=
hould not
>> have a visible impact on the decode performances. An optimisation of y=
our
>> implementation to save memory would be nice, but it is not critical.
>>
> AFAIK, for a recovery pg, all the objects of pg have the same lost chun=
ks. So only the first object miss the cache.
> But the later won't.  It only need a entry to cache.
> Or am I missing something?

It also is my understanding and that's what makes the cache so useful. No=
w, in the long run the cache stays and grows. Since it is a few mega byte=
s per PG, it will eventually has a non negligible impact on a long runnin=
g OSD. But again, it's nothing critical to performances.

Cheers

>=20
> Jianpeng Ma
>=20
>> How large are the decode tables ?
>>
>>> So if the final statement is to create one plugin instance per PG, I =
will change
>> it accordingly and shared encoding & decoding tables for a fixed (k,m)=
, if not it
>> can stay.
>>>
>>> Just need to know that ... this boils down to the fact, that encoding=
 &
>> decoding should not be considered 'stateless'.
>>>
>>> Cheers Andreas.
>>>
>>>
>>> ________________________________________
>>> From: Loic Dachary [loic@dachary.org]
>>> Sent: 04 August 2014 13:56
>>> To: Andreas Joachim Peters
>>> Cc: Ma, Jianpeng; Ceph Development
>>> Subject: ISA erasure code plugin and cache
>>>
>>> Hi,
>>>
>>> Here is how I understand the current code:
>>>
>>> When an OSD is missing, recovery is required and the primary OSD will=
 collect
>> the available chunks to do so. It will then call the decode method via=

>> ECUtil::decode which is a small wrapper around the corresponding
>> ErasureCodeInterface::decode method.
>>>
>>>    https://github.com/ceph/ceph/blob/master/src/osd/ECBackend.cc#L361=

>>>
>>> The ISA plugin will then use the isa_decode method to perform the wor=
k
>>>
>>>
>> https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/ErasureC=
ode
>> Isa.cc#L212
>>>
>>> and will be repeatedly called until all objects in the PGs that were =
relying on
>> the missing OSD are recovered. To avoid computing the decoding table f=
or each
>> object, it is stored in a LRU cache
>>>
>>>
>> https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/ErasureC=
ode
>> Isa.cc#L480
>>>
>>> and copied in the stack if already there:
>>>
>>>
>> https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/ErasureC=
ode
>> Isa.cc#L433
>>>
>>> Each PG has a separate instance of ErasureCodeIsa, obtained when it i=
s
>> created:
>>>
>>>    https://github.com/ceph/ceph/blob/master/src/osd/PGBackend.cc#L292=

>>>
>>> It means that data members of each ErasureCodeIsa are copied as many
>> times as there are PGs. If an OSD handles participates in 200 PG that =
belong to
>> an erasure coded pool configured to use ErasureCodeIsa, the data membe=
rs
>> will be duplicated 200 times.
>>>
>>> It is good practice to make it so that the encode/decode methods of
>> ErasureCodeIsa are thread safe. In the jerasure plugin these methods h=
ave no
>> side effect on the object. In the isa plugin the LRU cache storing the=
 decode
>> tables is modified by the decode method and guarded by a mutex:
>>>
>>>    get
>> https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/ErasureC=
ode
>> Isa.cc#L281
>>>    put
>> https://github.com/ceph/ceph/blob/master/src/erasure-code/isa/ErasureC=
ode
>> Isa.cc#L310
>>>
>>> Please correct me if I'm mistaken ;-) I've not reviewed the code yet =
and try to
>> find problems, I just wanted to make sure I get the intention before d=
oing so.
>>>
>>> Cheers
>>> --
>>> Lo=EFc Dachary, Artisan Logiciel Libre
>>>
>>
>> --
>> Lo=EFc Dachary, Artisan Logiciel Libre
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--9PLDNICqopHtPXvQkQxuJH5U0IpKDHUAG
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlPfgwQACgkQ8dLMyEl6F23mFwCffF06+iBL1NLzl3+y8by1Mkih
PswAn16RDbkGP8fRHygGAfGsX8QMkFzc
=R97D
-----END PGP SIGNATURE-----

--9PLDNICqopHtPXvQkQxuJH5U0IpKDHUAG--
