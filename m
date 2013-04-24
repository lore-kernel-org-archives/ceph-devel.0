From: "Christopher LILJENSTOLPE" <cdl@asgaard.org>
Subject: Re: erasure coding (sorry)
Date: Tue, 23 Apr 2013 21:35:26 -0700
Message-ID: <42B6DB32-5E25-4223-AFBA-88C71F9805C9@asgaard.org>
References: <20130418162842.0c61d1e2@dieter-t420s>
 <alpine.DEB.2.00.1304181345300.10005@cobra.newdream.net>
 <517060B2.80706@inktank.com> <51706120.2060702@inktank.com>
 <20130418173113.74a53769@dieter-t420s>
 <8232544E-56F5-40BF-899D-2A2D4735FD54@asgaard.org>
 <5174F08F.2070001@dachary.org>
 <0AEB5F22-B38F-4702-95A1-B18938FE7F7C@asgaard.org>
 <alpine.DEB.2.00.1304220805100.14056@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed;
 boundary="=_MailMate_2AB7FD57-EB20-4736-8A3D-A4B0CBCA1B80_=";
 micalg=pgp-sha1; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp4.emailarray.com ([65.39.216.22]:64052 "EHLO
	smtp4.emailarray.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750890Ab3DXEf4 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Apr 2013 00:35:56 -0400
In-Reply-To: <alpine.DEB.2.00.1304220805100.14056@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Loic Dachary <loic@dachary.org>, ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 3156 and 4880).

--=_MailMate_2AB7FD57-EB20-4736-8A3D-A4B0CBCA1B80_=
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Supposedly, on 2013-Apr-22, at 08.09 PDT(-0700), someone claiming to be S=
age Weil scribed:

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
 and just store locally.
>>
>> Actually, looking at this this morning, this is actually harder than t=
he prefered alternative (i.e. grafting a encode/decode into the (e)OSD.  =
It was meant to cover the alternative approaches.  I didn't like this one=
, but it now appears to be more difficult, and non-deterministic of the p=
lacement.
>>
>> One question on CRUSH (it's been too long since I read the paper), if =
x is the same for two objects, and, using an n=3D3 returns R=3D{OSD18,OSD=
45,OSD97}, if an object is handed to OSD45 that matches x, but has an n=3D=
1, would OSD45 store it, or would it forward it to OSD18 to store?  If it=
 would this idea is DOA.  Also, if x is held invariant, but n changes, do=
es the same R set get returned (truncated to n members)?
>
> It would go to osd18, the first item in the sequence that CRUSH generat=
es.

That's what I thought - then it is a non-starter

>
> As Loic observes, not having control of placement from above the librad=
os
> level makes this more or less a non-started.  The only thing that might=

> work at that layer is to set up ~5 or more pools, each with a distinct =
set
> of OSDs, and put each shard/fragment in a different pool.  I don't thin=
k
> that is a particularly good approach.

Pretty much of a kludge - I would agree

>
> If we are going to do parity encoding (and I think we should!), I think=
 we
> should fully integrate it into the OSD.
>
> The simplest approach:
>
> - we create a new PG type for 'parity' or 'erasure' or whatever (type
> fields already exist)
> - those PGs use the parity ('INDEP') crush mode so that placement is
> intelligent
> - all reads and writes go to the 'primary'
> - the primary does the shard encoding and distributes the write pieces =
to
> the other replicas
> - same for reads

Yup - that's basically what I was trying to outline for the single-tier m=
odel.  I called them eOSD's.
>
> There will be a pile of patches to move code around between PG and
> ReplicatedPG, which will be annoying, but hopefully not too painful.  T=
he
> class structure and data types were set up with this in mind long ago.
>
> Several key challenges:
>
> - come up with a scheme for internal naming to keep shards distinct
> - safely rewriting a stripe when there is a partial overwrite.  probabl=
y
> want to write new stripes to distinct new objects (cloning old data as
> needed) and clean up the old ones once enough copies are present.
> - recovery logic

Been giving this some thought - I'll try and get them into the blueprint.=
  Is the blueprint, as it is, reasonable to include in the design summit,=
 knowing that it will continue to evolve?
>
> sage
>
Christopher

>
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
>>> --
>>> Lo?c Dachary, Artisan Logiciel Libre
>>
>>
>> --
>> ???
>> Check my PGP key here: https://www.asgaard.org/~cdl/cdl.asc
>> Current vCard here: https://www.asgaard.org/~cdl/cdl.vcf
>> Check my calendar availability: https://tungle.me/cdl


--
=E6=9D=8E=E6=9F=AF=E7=9D=BF
Check my PGP key here: https://www.asgaard.org/~cdl/cdl.asc
Current vCard here: https://www.asgaard.org/~cdl/cdl.vcf
Check my calendar availability: https://tungle.me/cdl
--=_MailMate_2AB7FD57-EB20-4736-8A3D-A4B0CBCA1B80_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----
Comment: GPGTools - http://gpgtools.org

iQEcBAEBAgAGBQJRd2EOAAoJEGmx2Mt/+Iw/NS8H/R4+3j3oFTYSzEc9llbS7/5T
xuwuK5+C10fUbNsYlVX+UiZIIs4yt1CGpigxiZdROH2HxTUBFI1XBq8uk1xoFvPO
KUt4NOgchxTL7qLSl5Y8G0ZAS+gPrER+HBkrdx9gdkebBJ21QifWfPyxpu5aub24
RR5H5wAUxcrOC5I7lElujsdTynBjIb1fRHB3hnJOom8AY8mRJ/4Nm/BBPMyuijVQ
iO+MUfokCbClETvgZ8LakR+Q167AY4sREsAsbLdSh1BjwS6AR23NWIiIdpIjGd9F
e+7XwmRzus6WIZI8cFQNJyeZor5Lp8RVC7fiuEQSlSPxaF9lYlFYvcyXoe1ruco=
=sd6j
-----END PGP SIGNATURE-----

--=_MailMate_2AB7FD57-EB20-4736-8A3D-A4B0CBCA1B80_=--
