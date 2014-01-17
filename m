From: Loic Dachary <loic@dachary.org>
Subject: Re: Pyramid Erasure Code plugin (draft)
Date: Fri, 17 Jan 2014 15:19:49 +0100
Message-ID: <52D93C05.5010905@dachary.org>
References: <52D8FC5A.5090905@dachary.org> <CAGhffvwLtm1rJ68ORiASxDzfsOuo0y2YQvU3uLMUvxQOAA_d7g@mail.gmail.com>,<52D90D50.8080501@dachary.org> <3472A07E6605974CBC9BC573F1BC02E4AE6B2508@PLOXCHG03.cern.ch>,<52D93689.7010705@dachary.org> <3472A07E6605974CBC9BC573F1BC02E4AE6B2587@PLOXCHG03.cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="6lmuUn8f7iS38A7a9UsSn8RSHfCsleXcK"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:46390 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751958AbaAQOTx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Jan 2014 09:19:53 -0500
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4AE6B2587@PLOXCHG03.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6lmuUn8f7iS38A7a9UsSn8RSHfCsleXcK
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable


http://tracker.ceph.com/issues/7146#note-2 is updated to include the glob=
al parity chunks into the computation of the local parity chunks.

On 17/01/2014 15:10, Andreas Joachim Peters wrote:> Hi Loic,=20
> this is what I mentioned in the other thread ....
> depending on the global parameters, it is more efficient to include the=
 global stripes into the local parity computation because also a disk wit=
h global parity breaks with the same probability like the disk with data =
stripes and you can repair them with the local parity if you include them=
 in the computation.

Understood.

> If I understand your scheme in the given example K:4 means, that local =
parity is computed over d4 ata stripes only while K:6 means, it is comput=
ed over 4 data + 2 global parity stripes, so this should work ?!?!?

Now the local parity is computed on 6 data chunks instead of 4 data chunk=
s.

How does that look ?

>=20
> Cheers Andreas.
>=20
>=20
> ________________________________________
> From: Loic Dachary [loic@dachary.org]
> Sent: 17 January 2014 14:56
> To: Andreas Joachim Peters
> Cc: Ceph Development
> Subject: Re: Pyramid Erasure Code plugin (draft)
>=20
> On 17/01/2014 12:18, Andreas Joachim Peters wrote:
>> Is k:4 not wrong? I want to build the local parity using 4 data + 2 RS=
 stripes ?!?!?
>>
>=20
> I misunderstood and did not consider the case where you would want to d=
o this. I'm glad you raise this now :-) Reading http://home.ie.cuhk.edu.h=
k/~mhchen/papers/pyramid.ToS.13.pdf my understanding is that local parity=
 is not calculated for chunks created by the lower level. Am I reading it=
 incorrectly ?
>=20
> In the context of Ceph I think you're right anyway : local parity needs=
 to apply to chunks generated at the global level.
>=20
>>
>> { "plugin": "xor",
>>       "k": 4,
>>       "m": 1,
>>       "item": "datacenter",
>>       "mapping": "0000--^1111--^2222--^",
>>     },
>>
>> ________________________________________
>> From: Loic Dachary [loic@dachary.org]
>> Sent: 17 January 2014 12:00
>> To: Andreas Joachim Peters
>> Cc: Ceph Development
>> Subject: Re: Pyramid Erasure Code plugin (draft)
>>
>> On 17/01/2014 11:34, Andreas-Joachim Peters wrote:
>>> Hi Loic,
>>>
>>> i think I don't understand if this works really for all cases and pro=
bably sysadmins will be lost without ready to use templates.
>>
>> I agree, providing a sensible default is important. I'll draft somethi=
ng.
>>
>>> Can you write down with this syntax a rule like this:
>>>
>>> =3D> build 12 data chunks (d1...d12)
>>> =3D> build 6 RS chunks, distribute  (p1..p6)
>>> =3D> arrange them as : lp1=3D(d1,d2,d3,d4,p1,p2) lp2=3D(d5,d6,d7,d8,p=
3,p4) lp3=3D(d9,d10,d11,d12,p5,p6)
>>> =3D> map 21 stripes to 3 data center as: D1=3D(d1,d2,d3,d4,p1,p2,lp1)=
 D2=3D(d5,d6,d7,d8,p3,p4,lp2) D3=3D(d9,d10,d11,d12,p5,p6,lp3)
>>> e.g. chunk(0...21) =3D (d1,d2,d3...lp1,d5,d6,d7...lp2,d9,d10,d11...lp=
3)
>>
>> Here is how it translates : http://tracker.ceph.com/issues/7146#note-2=
 ( replacing | with - ... maybe more readable ).
>>
>> Does that make sense ?
>>>
>>> Thanks, Andreas.
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>>
>>> On Fri, Jan 17, 2014 at 10:48 AM, Loic Dachary <loic@dachary.org <mai=
lto:loic@dachary.org>> wrote:
>>>
>>>     Hi Andreas,
>>>
>>>     I spent some time this week trying to figure out something that w=
ould be reasonably generic, readable from the sysadmin point of view and =
simple to implement. The input of the plugin is here:
>>>
>>>     http://tracker.ceph.com/issues/7146#note-1
>>>
>>>     The json structure describes the pyramid and associates an erasur=
e code method with each layer, including parameters. The mapping describe=
s how chunks relate to the list of OSDs obtained from crush. For instance=
 in |^000111^| the | are ignored ( whitespace is confusing because it's n=
ot easy to figure out visually how many of them there are ), ^ marks a co=
ding chunk, any other character is a data chunk. The pyramid encoding fun=
ction reads this and encode the first three data chunks with one coding c=
hunk. The re-ordering of the chunks is done by the pyramid code and the u=
nderlying erasure code method does not need to know anything about it. Th=
ere is no copy involved, it re-orders pointers ( bufferptr ).
>>>
>>>     Here is a draft (not compiling not working but the logic looks ri=
ght to me) implementation:
>>>
>>>     encode :
>>>     https://github.com/dachary/ceph/blob/wip-pyramid/src/osd/ErasureC=
odePluginPyramid/ErasureCodePyramid.cc#L250
>>>
>>>     decode :
>>>     https://github.com/dachary/ceph/blob/wip-pyramid/src/osd/ErasureC=
odePluginPyramid/ErasureCodePyramid.cc#L367
>>>
>>>     The plugins for each layer would be loaded at init time :
>>>
>>>     https://github.com/dachary/ceph/blob/wip-pyramid/src/osd/ErasureC=
odePluginPyramid/ErasureCodePyramid.cc#L83
>>>
>>>     with as much consistency checks as possible, for instance:
>>>
>>>     https://github.com/dachary/ceph/blob/wip-pyramid/src/osd/ErasureC=
odePluginPyramid/ErasureCodePyramid.cc#L102
>>>
>>>     so that runtime can assume constraints are enforced. Please let m=
e know if you see something that does not look right, this is a draft, it=
 can be reworked 100% ;-)
>>>
>>>     Cheers
>>>
>>>     --
>>>     Lo=EFc Dachary, Artisan Logiciel Libre
>>>
>>>
>>
>> --
>> Lo=EFc Dachary, Artisan Logiciel Libre
>>
>=20
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--6lmuUn8f7iS38A7a9UsSn8RSHfCsleXcK
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLZPAUACgkQ8dLMyEl6F209mACgo2EpOn725/R7nQHAoWsR3rRH
mOwAni9A5sxMksTDcJuovXQv+T1nvKnj
=QclM
-----END PGP SIGNATURE-----

--6lmuUn8f7iS38A7a9UsSn8RSHfCsleXcK--
