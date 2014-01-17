From: Loic Dachary <loic@dachary.org>
Subject: Re: Pyramid Erasure Code plugin (draft)
Date: Fri, 17 Jan 2014 14:56:25 +0100
Message-ID: <52D93689.7010705@dachary.org>
References: <52D8FC5A.5090905@dachary.org> <CAGhffvwLtm1rJ68ORiASxDzfsOuo0y2YQvU3uLMUvxQOAA_d7g@mail.gmail.com>,<52D90D50.8080501@dachary.org> <3472A07E6605974CBC9BC573F1BC02E4AE6B2508@PLOXCHG03.cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="LCTTfiI3dJMqj4BlsjFQVXrQPlJqp36OX"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:46364 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751971AbaAQN4b (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Jan 2014 08:56:31 -0500
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4AE6B2508@PLOXCHG03.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--LCTTfiI3dJMqj4BlsjFQVXrQPlJqp36OX
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 17/01/2014 12:18, Andreas Joachim Peters wrote:
> Is k:4 not wrong? I want to build the local parity using 4 data + 2 RS =
stripes ?!?!?
>=20

I misunderstood and did not consider the case where you would want to do =
this. I'm glad you raise this now :-) Reading http://home.ie.cuhk.edu.hk/=
~mhchen/papers/pyramid.ToS.13.pdf my understanding is that local parity i=
s not calculated for chunks created by the lower level. Am I reading it i=
ncorrectly ?=20

In the context of Ceph I think you're right anyway : local parity needs t=
o apply to chunks generated at the global level.=20

>=20
> { "plugin": "xor",
>       "k": 4,
>       "m": 1,
>       "item": "datacenter",
>       "mapping": "0000--^1111--^2222--^",
>     },
>=20
> ________________________________________
> From: Loic Dachary [loic@dachary.org]
> Sent: 17 January 2014 12:00
> To: Andreas Joachim Peters
> Cc: Ceph Development
> Subject: Re: Pyramid Erasure Code plugin (draft)
>=20
> On 17/01/2014 11:34, Andreas-Joachim Peters wrote:
>> Hi Loic,
>>
>> i think I don't understand if this works really for all cases and prob=
ably sysadmins will be lost without ready to use templates.
>=20
> I agree, providing a sensible default is important. I'll draft somethin=
g.
>=20
>> Can you write down with this syntax a rule like this:
>>
>> =3D> build 12 data chunks (d1...d12)
>> =3D> build 6 RS chunks, distribute  (p1..p6)
>> =3D> arrange them as : lp1=3D(d1,d2,d3,d4,p1,p2) lp2=3D(d5,d6,d7,d8,p3=
,p4) lp3=3D(d9,d10,d11,d12,p5,p6)
>> =3D> map 21 stripes to 3 data center as: D1=3D(d1,d2,d3,d4,p1,p2,lp1) =
D2=3D(d5,d6,d7,d8,p3,p4,lp2) D3=3D(d9,d10,d11,d12,p5,p6,lp3)
>> e.g. chunk(0...21) =3D (d1,d2,d3...lp1,d5,d6,d7...lp2,d9,d10,d11...lp3=
)
>=20
> Here is how it translates : http://tracker.ceph.com/issues/7146#note-2 =
( replacing | with - ... maybe more readable ).
>=20
> Does that make sense ?
>>
>> Thanks, Andreas.
>>
>>
>>
>>
>>
>>
>>
>>
>> On Fri, Jan 17, 2014 at 10:48 AM, Loic Dachary <loic@dachary.org <mail=
to:loic@dachary.org>> wrote:
>>
>>     Hi Andreas,
>>
>>     I spent some time this week trying to figure out something that wo=
uld be reasonably generic, readable from the sysadmin point of view and s=
imple to implement. The input of the plugin is here:
>>
>>     http://tracker.ceph.com/issues/7146#note-1
>>
>>     The json structure describes the pyramid and associates an erasure=
 code method with each layer, including parameters. The mapping describes=
 how chunks relate to the list of OSDs obtained from crush. For instance =
in |^000111^| the | are ignored ( whitespace is confusing because it's no=
t easy to figure out visually how many of them there are ), ^ marks a cod=
ing chunk, any other character is a data chunk. The pyramid encoding func=
tion reads this and encode the first three data chunks with one coding ch=
unk. The re-ordering of the chunks is done by the pyramid code and the un=
derlying erasure code method does not need to know anything about it. The=
re is no copy involved, it re-orders pointers ( bufferptr ).
>>
>>     Here is a draft (not compiling not working but the logic looks rig=
ht to me) implementation:
>>
>>     encode :
>>     https://github.com/dachary/ceph/blob/wip-pyramid/src/osd/ErasureCo=
dePluginPyramid/ErasureCodePyramid.cc#L250
>>
>>     decode :
>>     https://github.com/dachary/ceph/blob/wip-pyramid/src/osd/ErasureCo=
dePluginPyramid/ErasureCodePyramid.cc#L367
>>
>>     The plugins for each layer would be loaded at init time :
>>
>>     https://github.com/dachary/ceph/blob/wip-pyramid/src/osd/ErasureCo=
dePluginPyramid/ErasureCodePyramid.cc#L83
>>
>>     with as much consistency checks as possible, for instance:
>>
>>     https://github.com/dachary/ceph/blob/wip-pyramid/src/osd/ErasureCo=
dePluginPyramid/ErasureCodePyramid.cc#L102
>>
>>     so that runtime can assume constraints are enforced. Please let me=
 know if you see something that does not look right, this is a draft, it =
can be reworked 100% ;-)
>>
>>     Cheers
>>
>>     --
>>     Lo=EFc Dachary, Artisan Logiciel Libre
>>
>>
>=20
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--LCTTfiI3dJMqj4BlsjFQVXrQPlJqp36OX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlLZNokACgkQ8dLMyEl6F22dMACfaaTNxZaJK7nZKD7PdJx2117G
nfYAnRnfdf7Lyrx0mBAvhkPaYhe04V0W
=TagB
-----END PGP SIGNATURE-----

--LCTTfiI3dJMqj4BlsjFQVXrQPlJqp36OX--
