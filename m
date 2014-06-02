From: Loic Dachary <loic@dachary.org>
Subject: Re: Pyramid erasure code description revisited
Date: Mon, 02 Jun 2014 20:49:57 +0200
Message-ID: <538CC755.7000708@dachary.org>
References: <538A0CF8.8030501@dachary.org> <3472A07E6605974CBC9BC573F1BC02E4AE72E354@CERNXCHG44.cern.ch> <538C78C7.2090308@dachary.org> <1401733713.18379.YahooMailNeo@web165006.mail.bf1.yahoo.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="7LnH6jrDLVIEp2upJAjpALdeX0skTsMQ3"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([91.121.254.229]:58723 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750723AbaFBSuB (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 2 Jun 2014 14:50:01 -0400
In-Reply-To: <1401733713.18379.YahooMailNeo@web165006.mail.bf1.yahoo.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Koleos Fuskus <koleosfuscus@yahoo.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--7LnH6jrDLVIEp2upJAjpALdeX0skTsMQ3
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi koleosfuscus,

A simpler proposal was made a few days ago. As you rightfully point out, =
the previous one was a bit complicated to understand ;-)

http://thread.gmane.org/gmane.comp.file-systems.ceph.devel/19753

Cheers

On 02/06/2014 20:28, Koleos Fuskus wrote:
> Hi Loic,
> I am trying to understand your proposal on http://pad.ceph.com/p/cdsgia=
nt-pyramid-erasure-code
> Is the mapping specification a new feature on CRUSH to support Pyramid =
Codes?=20
> I don't follow from line 72, when you are talking about "crush multidat=
acenter mapping".=20
> Adding a failure domain typically adds a new level in the pyramid using=
 xor?
>=20
> "** if one chunk is missing, will return that all chunks from the local=
 cluster are needed"
> If one chunk is missing, it recovers it using xor instead of jerasure?
> "** if two chunks are missing in the same local cluster, it will defer =
to the global level"
> In this case it has the pyramid code doesn't help, does it?
> ** if two chunks are missing, each of them in a different local cluster=
, it will return that it needs all chunks from both local cluster but wil=
l not defer to the upper level
>=20
> Best,
> koleos
>=20
>=20
>=20
> On Monday, June 2, 2014 3:14 PM, Loic Dachary <loic@dachary.org> wrote:=

> Hi Andreas,
>=20
> On 02/06/2014 14:20, Andreas Joachim Peters wrote:> Hi Loic,=20
>>
>> I think this gives all the flexibility to define any possible combinat=
ion for encoding ...
>>
>> When one constructs the steps one has just to be aware that the 'most =
local' encoding should happen in the end, right?
>=20
> Yes.=20
>=20
>>
>> It would be usefule to have a tool which outputs then for each data aN=
D parity chunk the achieved 'redundancy' and the overall volume and maxim=
al reconstruction 'overhead'.
>=20
> Right. I'm kind of hoping koleosfuscus (cc'ed) will be able to fit that=
 into the reliability model, but we've not discussed that yet. In any cas=
e you are right, a small command line tool would be helpful. Something th=
at would explain: if you loose one of the chunks you need four to recover=
=2E If you lose two you need all of them. That's more humanly readable an=
d understandable than the full description ;-)
>=20
> Cheers
>=20
>>
>> Cheers Andreas.
>>
>> ________________________________________
>> From: Loic Dachary [loic@dachary.org]
>> Sent: 31 May 2014 19:10
>> To: Andreas Joachim Peters
>> Cc: Ceph Development
>> Subject: Pyramid erasure code description revisited
>>
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
>> --
>> Lo=EFc Dachary, Artisan Logiciel Libre
>>
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" =
in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>=20

--=20
Lo=EFc Dachary, Artisan Logiciel Libre


--7LnH6jrDLVIEp2upJAjpALdeX0skTsMQ3
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOMx1YACgkQ8dLMyEl6F21WAgCfSFRzZzprsX6u4ZH23UM0OFKK
CnAAn1aXjDHLat5Bob/hpGyntI8KHUq7
=hyJx
-----END PGP SIGNATURE-----

--7LnH6jrDLVIEp2upJAjpALdeX0skTsMQ3--
