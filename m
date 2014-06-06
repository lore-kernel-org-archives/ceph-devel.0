From: Loic Dachary <loic@dachary.org>
Subject: Re: Locally repairable code description revisited (was Pyramid ...)
Date: Fri, 06 Jun 2014 16:30:01 +0200
Message-ID: <5391D069.30701@dachary.org>
References: <538A0CF8.8030501@dachary.org>,<53907935.9010009@dachary.org> <3472A07E6605974CBC9BC573F1BC02E4AE730544@CERNXCHG44.cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="bODkBrUelRAfSUacbxhQd3cEGd2KwJSat"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:36277 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751740AbaFFOaK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 6 Jun 2014 10:30:10 -0400
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4AE730544@CERNXCHG44.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--bODkBrUelRAfSUacbxhQd3cEGd2KwJSat
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

On 06/06/2014 13:46, Andreas Joachim Peters wrote:> Hi Loic,
> the basic implementation looks very clean.
>=20
> I have few comments/ideas:
>=20
> - the reconstruction strategy using the three levels is certainly effic=
ient enough for standard cases but does not guarantee always the minimum =
decoding (in cases where one layer is not enough to reconstruct) since yo=
ur third algorithm is just brute-force to reconstruct everything through =
all layers until we have what we need ...

The third strategy is indeed brute force. Do you think it is worth changi=
ng to be minimal ? It would be nice to quantify the percent of cases it a=
ddresses. Do you know how to do that ? It looks like a very small percent=
age but there is no proof it is small ;-)

> - the whole LRC configuration actually does not describe the placement =
- it still looks disconnected from the placement strategy/crush rules ...=
 wouldn't it make sense to have the crush rule implicit in the descriptio=
n or a function to derive it automatically based on the LRC configuration=
? Maybe you have this already done in another way and I didn't see it ...=


Good catch.=20

What about this:

      "  [ \"_aAAA_aAA_\", \"set choose datacenter 2\"," =20
      "    \"_aXXX_aXX_\" ],"
      "  [ \"b_BBB_____\", \"set choose host 5\","
      "    \"baXXX_____\" ],"
      "  [ \"_____cCCC_\", \"\","
      "    \"baXXXcaXX_\" ],"
      "  [ \"_____DDDDd\", \"\","
      "    \"baXXXcaXXd\" ],"

Which translates into

take root
set choose datacenter 2
set choose host 5

In other words, the ruleset is created by concatenating the strings from =
the description, without any kind of smart computation. It is up to the p=
erson who creates the description to add the ruleset near a description t=
hat makes sense. There is going to be minimal checking to make sure the r=
uleset can actually be used to get the required number of chunks.

It probably is very difficult and very confusing to automate the generati=
on of the ruleset. If it is implicit rather than explicit as above, the o=
perator will have to somehow understand and learn how it is computed to m=
ake sure it does what is desired. With an explicit set of crush rules loo=
sely coupled to chunk mapping, the operator can read the crush documentat=
ion instead of guessing.

> -  should the plug-in have the ability to select reconstruction on prox=
imity or this should be up-to the higher layer to provide chunks in a way=
 that reconstruction would select the 'closest' layer? The relevance of t=
he question you will understand better in the next point ....
>=20
> - I remember we had this 3 data centre example with (8,4) where you can=
 reconstruct every object if 2 data centres are up. Another appealing exa=
mple avoiding remote access when reading an object is that you have 2 dat=
a centres having a replication of e.g. (4,2) encoded objects. Can you des=
cribe in your LRC configuration language to store the same chunk twice li=
ke    __ABCCBA__ ?

Unless I'm mistaken that would require the caller of the plugin to suppor=
t duplicate data chunks and provide a kind of proximity check. Since this=
 is not currently supported by the OSD logic, it is difficult to figure o=
ut how an erasure code plugin could provide support for this use case.

Cheers

>=20
> Cheers Andreas.
>=20
>=20
> ________________________________________
> From: Loic Dachary [loic@dachary.org]
> Sent: 05 June 2014 16:05
> To: Andreas Joachim Peters
> Cc: Ceph Development
> Subject: Re: Locally repairable code description revisited (was Pyramid=
 ...)
>=20
> Hi Andreas,
>=20
> Here is a preliminary implementation https://github.com/ceph/ceph/pull/=
1921 . It does not have tests yet, nor does it run but but it compiles an=
d I think it makes sense. It is indeed simpler than the previous implemen=
tation.
>=20
> It would be great if you could quickly browse
>=20
>    https://github.com/dachary/ceph/commit/5661c72864eca04c5dac9494a3f7e=
7a13515fca6
>=20
> and let me know if you have any concerns.
>=20
> Cheers
>=20
> On 31/05/2014 19:10, Loic Dachary wrote:
>> Hi Andreas,
>>
>> After a few weeks and a fresh eye, I revisited the way pyramid erasure=
 code could be described by the system administrator. Here is a proposal =
that is hopefully more intuitive than the one from the last CDS ( http://=
pad.ceph.com/p/cdsgiant-pyramid-erasure-code ).
>>
>> These are the steps to create all coding chunks. The upper case letter=
s are data chunks and the lower case letters are coding chunks.
>>
>> "__ABC__DE_" data chunks placement
>>
>> Step 1
>> "__ABC__DE_"
>> "_yVWX_zYZ_" K=3D5, M=3D2
>> "_aABC_bDE_"
>>
>> Step 2
>> "_aABC_bDE_"
>> "z_XYZ_____" K=3D3, M=3D1
>> "caABC_bDE_"
>>
>> Step 3
>> "caABC_bDE_"
>> "_____zXYZ_" K=3D3, M=3D1
>> "caABCdbDE_"
>>
>> Step 4
>> "caABCdbDE_"
>> "_____WXYZz" K=3D4, M=3D1
>> "caABCdbDEe"
>>
>> The interpretation of Step 3 is as follows:
>>
>> Given the output of the previous step ( "caABC_bDE_" ), the bDE chunks=
 are considered to be data chunks at this stage and they are marked with =
XYZ. A K=3D3, M=3D1 coding chunk is calculated and placed in the chunk ma=
rked with z ( "_____zXYZ_" ). The output of this coding step is the previ=
ous step plus the coding chunk that was just calculated, named d ( "caABC=
dbDE_" ).
>>
>> This gives the flexibility of deciding wether or not a coding chunk fr=
om a previous step is used as data to compute the coding chunk of the nex=
t step. It also allows for unbalanced steps such as step 4.
>>
>> For decoding, the steps are walked from the bottom up. If E is missing=
, it can be reconstructed from dbD.e in step 4 and the other steps are sk=
ipped because it was the only missing chunk. If AB are missing, all steps=
 that have not be used to encode it are ignored, up to step 2 that will f=
ail to recover them because M=3D1 and yeild to step 1 that will use a..Cb=
DE successfully because M=3D2.
>>
>> Giving up the recursion and favor iteration seems to simplify how it c=
an be explained. And I suspect the implementation is also simpler. What d=
o you think ?
>>
>> Cheers
>>
>=20
> --
> Lo=EFc Dachary, Artisan Logiciel Libre
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--bODkBrUelRAfSUacbxhQd3cEGd2KwJSat
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOR0GwACgkQ8dLMyEl6F20L8ACgvOwB55ynwZK+cOFw2kijy8Dk
isIAoKxawPXsJrCcxNzsGajLnWoPqkDa
=XKdF
-----END PGP SIGNATURE-----

--bODkBrUelRAfSUacbxhQd3cEGd2KwJSat--
