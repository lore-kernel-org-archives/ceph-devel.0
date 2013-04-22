From: Loic Dachary <loic@dachary.org>
Subject: Re: erasure coding (sorry)
Date: Mon, 22 Apr 2013 20:09:47 +0200
Message-ID: <51757CEB.4090701@dachary.org>
References: <20130418162842.0c61d1e2@dieter-t420s> <alpine.DEB.2.00.1304181345300.10005@cobra.newdream.net> <517060B2.80706@inktank.com> <51706120.2060702@inktank.com> <20130418173113.74a53769@dieter-t420s> <8232544E-56F5-40BF-899D-2A2D4735FD54@asgaard.org> <5174F08F.2070001@dachary.org> <0AEB5F22-B38F-4702-95A1-B18938FE7F7C@asgaard.org> <alpine.DEB.2.00.1304220805100.14056@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA861632CB19D7DCDDBAA7F7F"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:51483 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754298Ab3DVSJv (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 22 Apr 2013 14:09:51 -0400
In-Reply-To: <alpine.DEB.2.00.1304220805100.14056@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA861632CB19D7DCDDBAA7F7F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Sage,

On 04/22/2013 05:09 PM, Sage Weil wrote:
> On Mon, 22 Apr 2013, Christopher LILJENSTOLPE wrote:
>> Supposedly, on 2013-Apr-22, at 01.10 PDT(-0700), someone claiming to b=
e Loic Dachary scribed:
>>
>>> Hi Christopher,
>>>
>>> You wrote "A modified client/library could be used to store objects t=
hat should be sharded, vs "standard" ceph treatment.  In this model, each=
 shard would be written to a seperate PG, and each PG would we stored on =
exactly one OSD.  " but there is no way for a client to enforce the fact =
that two objects are stored in separate PG.
>>
>> Poorly worded.  The idea is that each shard becomes a seperate object,=
 and the encoder/sharder would use CRUSH to identify the OSDs to hold the=
 shards.  However, the OSDs would treat the shard as an n=3D1 replication=
 and just store locally. =20
>>
>> Actually, looking at this this morning, this is actually harder than t=
he prefered alternative (i.e. grafting a encode/decode into the (e)OSD.  =
It was meant to cover the alternative approaches.  I didn't like this one=
, but it now appears to be more difficult, and non-deterministic of the p=
lacement. =20
>>
>> One question on CRUSH (it's been too long since I read the paper), if =
x is the same for two objects, and, using an n=3D3 returns R=3D{OSD18,OSD=
45,OSD97}, if an object is handed to OSD45 that matches x, but has an n=3D=
1, would OSD45 store it, or would it forward it to OSD18 to store?  If it=
 would this idea is DOA.  Also, if x is held invariant, but n changes, do=
es the same R set get returned (truncated to n members)?
>=20
> It would go to osd18, the first item in the sequence that CRUSH generat=
es.
>           =20
> As Loic observes, not having control of placement from above the librad=
os
> level makes this more or less a non-started.  The only thing that might=
  =20
> work at that layer is to set up ~5 or more pools, each with a distinct =
set
> of OSDs, and put each shard/fragment in a different pool.  I don't thin=
k =20
> that is a particularly good approach.
>=20
> If we are going to do parity encoding (and I think we should!), I think=
 we
> should fully integrate it into the OSD.
>           =20
> The simplest approach:
>           =20
>  - we create a new PG type for 'parity' or 'erasure' or whatever (type =
  =20
>    fields already exist)
>  - those PGs use the parity ('INDEP') crush mode so that placement is
>    intelligent

I assume you do not mean CEPH_FEATURE_INDEP_PG_MAP as used in

https://github.com/ceph/ceph/blob/master/src/osd/OSD.cc#L5237

but CRUSH_RULE_CHOOSE_INDEP as used in

https://github.com/ceph/ceph/blob/master/src/crush/mapper.c#L331

when firstn =3D=3D 0 because it was set in

https://github.com/ceph/ceph/blob/master/src/crush/mapper.c#L523

I see that it would be simpler to write

   step choose indep 0 type row

and then rely on intelligent placement. Is there a reason why it would no=
t be possible to use firstn instead of indep ?

>  - all reads and writes go to the 'primary'              =20
>  - the primary does the shard encoding and distributes the write pieces=
 to
>    the other replicas

Although I understand how that would work when a PG receives a CEPH_OSD_O=
P_WRITEFULL

https://github.com/ceph/ceph/blob/master/src/osd/ReplicatedPG.cc#L2504

It may be inconvenient and expensive to recompute the parity encoded vers=
ion if an object is written with a series of CEPH_OSD_OP_WRITE. The simpl=
est way would be to decode the existing object, modify it according to wh=
at CEPH_OSD_OP_WRITE requires, encode it.

>  - same for reads
>           =20
> There will be a pile of patches to move code around between PG and=20
> ReplicatedPG, which will be annoying, but hopefully not too painful.  T=
he=20
> class structure and data types were set up with this in mind long ago.
>=20
> Several key challenges:
>=20
>  - come up with a scheme for internal naming to keep shards distinct
>  - safely rewriting a stripe when there is a partial overwrite.  probab=
ly=20
>    want to write new stripes to distinct new objects (cloning old data =
as=20
>    needed) and clean up the old ones once enough copies are present.

Do you mean RBD stripes ?=20

>  - recovery logic

If recovery is done from the scheduled scrubber in the ErasureCodedPG , I=
'm not sure if OSD.cc must be modified or is truly independent of the PG =
type=20

https://github.com/ceph/ceph/blob/master/src/osd/OSD.cc#L3818

I'll keep looking, thanks a lot for the hints :-)

Cheers

> sage
>=20
>=20
>>
>> 	Thx
>> 	Christopher
>>
>>
>>
>>>
>>> Am I missing something ?
>>>
>>> On 04/22/2013 09:23 AM, Christopher LILJENSTOLPE wrote:
>>>> Supposedly, on 2013-Apr-18, at 14.31 PDT(-0700), someone claiming to=
 be Plaetinck, Dieter scribed:
>>>>
>>>>> On Thu, 18 Apr 2013 16:09:52 -0500
>>>>> Mark Nelson <mark.nelson@inktank.com> wrote:
>>>>
>>>>>>
>>>>>
>>>>> @Bryan: I did come across cleversafe.  all the articles around it s=
eemed promising,
>>>>> but unfortunately it seems everything related to the cleversafe ope=
n source project
>>>>> somehow vanished from the internet.  (e.g. http://www.cleversafe.or=
g/) quite weird...
>>>>>
>>>>> @Sage: interesting. I thought it would be more relatively simple if=
 one assumes
>>>>> the restriction of immutable files.  I'm not familiar with those ce=
ph specifics you're mentioning.
>>>>> When building an erasure codes-based system, maybe there's ways to =
reuse existing ceph
>>>>> code and/or allow some integration with replication based objects, =
without aiming for full integration or
>>>>> full support of the rados api, based on some tradeoffs.
>>>>>
>>>>> @Josh, that sounds like an interesting approach.  Too bad that page=
 doesn't contain any information yet :)
>>>>
>>>> Greetings - it does now - see what you all think?
>>>>
>>>> 	Christopher
>>>>
>>>>>
>>>>> Dieter
>>>>
>>>>
>>>> --
>>>> ???
>>>> Check my PGP key here: https://www.asgaard.org/~cdl/cdl.asc
>>>> Current vCard here: https://www.asgaard.org/~cdl/cdl.vcf
>>>> Check my calendar availability: https://tungle.me/cdl
>>>
>>> --=20
>>> Lo?c Dachary, Artisan Logiciel Libre
>>
>>
>> --
>> ???
>> Check my PGP key here: https://www.asgaard.org/~cdl/cdl.asc
>> Current vCard here: https://www.asgaard.org/~cdl/cdl.vcf
>> Check my calendar availability: https://tungle.me/cdl
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--------------enigA861632CB19D7DCDDBAA7F7F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlF1fOwACgkQ8dLMyEl6F23s/ACguhSQzJ7BlqRcdSyGa5sZy5qs
UigAmgKPgYzON9JcsudwhhutQ/BRGeIl
=jBhk
-----END PGP SIGNATURE-----

--------------enigA861632CB19D7DCDDBAA7F7F--
