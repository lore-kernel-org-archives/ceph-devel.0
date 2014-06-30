From: Loic Dachary <loic@dachary.org>
Subject: Re: FW: erasure code and coefficients
Date: Mon, 30 Jun 2014 15:32:41 +0200
Message-ID: <53B166F9.5050206@dachary.org>
References: <53AFDC99.9010009@dachary.org>	<CACUN8h3rxRmBkMD7dWJgp3yiJ6Qm9TvJptGSfsUgL-bAyoQi8Q@mail.gmail.com>	<53B05E85.9020405@dachary.org>	<CACUN8h2PnC=x4_6EesCAgG5meQB=e0QMqrc6AHTNa0tJzOyaTA@mail.gmail.com>	<53B1289D.8030901@dachary.org>	<3472A07E6605974CBC9BC573F1BC02E4AE746F2A@CERNXCHG44.cern.ch>	<53B13D2A.8030901@dachary.org> <CAGhffvxTXLfziX9YLifvufYtuBnFPoooKNL5nGaHU0QyZWt6yg@mail.gmail.com>,<53B158FC.8050303@dachary.org> <3472A07E6605974CBC9BC573F1BC02E4AE746FD9@CERNXCHG44.cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="JA0SRQf56LDO4rO9Pv6hfXIk0sE9tBRfF"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:60773 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750771AbaF3Ncs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jun 2014 09:32:48 -0400
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4AE746FD9@CERNXCHG44.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--JA0SRQf56LDO4rO9Pv6hfXIk0sE9tBRfF
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi,

On 30/06/2014 14:59, Andreas Joachim Peters wrote:
> Hi Loic,=20
>=20
> I was reading through the code and I have got the impression that they =
have formulated something simple with a lot of mathematical formulas in t=
his paper. Indeed all ci =3D 1 ... which makes it simple ...

It makes things simpler to understand from my perspective, cool :-)

> The code seems to work  like this  e..g 10 + 2 + 4 :
>=20
> Data =3D (1,2,3,4,5,6,7,8,9,10)
>=20
> (RS1,RS2,RS3,RS4) =3D RS(1,2,3,4,5,5,6,7,8,9,10)
>=20
> P1 =3D 1 ^ 2 ^ 3 ^ 4 ^ 5
> P2 =3D 6 ^ 7 ^ 8 ^ 9 ^ 10
> P3 =3D P1 ^ P2 =3D RS1 ^ RS2 ^ RS3 ^ RS4 ( no need to store that, since=
 we store P1 and P2)
>=20

Using my own words, if local parity P1 and P2 is calculated using only th=
e data chunks, it follows that P1 ^ P2 can also be used as an implied par=
ity chunk for the RS parity chunks. But would that be true if P1 and P2 w=
as calculated using a random subset of the data + coding chunks ? I.e if =
P1 =3D RS1 ^ 2 ^ 3 ^ 4 ^ 5 , can P1 ^ P2 =3D P3 be used to recover any of=
 1, RS2, RS3, RS4 ? In other words, does it make a difference that P3 is =
an implied parity for the parity chunks or can it be an implied parity fo=
r any data/coding chunks involved in RS ?

Cheers

> You can reconstruct a missing RS chunk with local parity like: RS1 =3D =
P1 ^ P2 ^ RS2 ^ RS3 ^ RS4
>=20
> At least this is what I got out of the code ...  look at getSRCGroupNei=
ghbors
>=20
> What I don't know is, if P1 ^ P2 ^ P3 =3D 0 work with every encoding ma=
trix or only for that particular one used.
>=20
> Cheers Andreas.
>=20
>=20
>=20
>>
>> On Mon, Jun 30, 2014 at 12:34 PM, Loic Dachary <loic@dachary.org <mail=
to:loic@dachary.org>> wrote:
>>
>>     Hi Andreas,
>>
>>     TL;DR: which part of the code chooses the coefficients to maximize=
 the fault tolerance of the code as suggested in the Xorbas paper ?
>>
>>     If I understand correctly, the locality is computed (i.e. how many=
 local parity chunks are created) with:
>>
>>     https://github.com/madiator/HadoopUSC/blob/developUSC/src/contrib/=
raid/src/java/org/apache/hadoop/raid/SimpleRegeneratingCode.java#L84
>>
>>     This is different from specifying it explicitly (https://github.co=
m/dachary/ceph/commit/91b9cc2be5851f7668d593bb69b2f4f089ea585a#diff-55189=
64bc98a094a784ce2d17a5b0cc1R11)
>>
>>     Then a RS encoding matrix is calculated
>>
>>     https://github.com/madiator/HadoopUSC/blob/developUSC/src/contrib/=
raid/src/java/org/apache/hadoop/raid/SimpleRegeneratingCode.java#L100
>>
>>     and will be used when encoding an object
>>
>>     https://github.com/madiator/HadoopUSC/blob/developUSC/src/contrib/=
raid/src/java/org/apache/hadoop/raid/SimpleRegeneratingCode.java#L143
>>
>>     then each local parity chunk is calculated using a simpler functio=
n (XOR)
>>
>>     https://github.com/madiator/HadoopUSC/blob/developUSC/src/contrib/=
raid/src/java/org/apache/hadoop/raid/SimpleRegeneratingCode.java#L154
>>
>>     When decoding, the equivalent of the Ceph minimum_to_decode method=
 is used to figure out which chunks are needed to recover the lost chunks=

>>
>>     https://github.com/madiator/HadoopUSC/blob/developUSC/src/contrib/=
raid/src/java/org/apache/hadoop/raid/SimpleRegeneratingCode.java#L319
>>
>>     During recovery, if only one chunk is missing, it is recovered wit=
h the simpler function (XOR)
>>
>>     https://github.com/madiator/HadoopUSC/blob/developUSC/src/contrib/=
raid/src/java/org/apache/hadoop/raid/SimpleRegeneratingCode.java#L207
>>     https://github.com/madiator/HadoopUSC/blob/developUSC/src/contrib/=
raid/src/java/org/apache/hadoop/raid/SimpleRegeneratingCode.java#L224
>>     (both of which are combined recursively)
>>
>>     and if there is is a "conflict" (i.e. if local parity is not enoug=
h to recover), then the RS decoding function is used
>>
>>     https://github.com/madiator/HadoopUSC/blob/developUSC/src/contrib/=
raid/src/java/org/apache/hadoop/raid/SimpleRegeneratingCode.java#L266
>>
>>     I don't understand at all how local parity is related to RS parity=
, in the sense of "choosing the coefficients c(i) to maximize the fault t=
olerance of the code" as mentioned in the Xorbas paper : I must be missin=
g something :-) I do understand how the code works though, which is troub=
ling. It also is reassuring because the logic is very similar to what is =
proposed in https://github.com/ceph/ceph/pull/1921
>>
>>     Cheers
>>
>>     On 30/06/2014 11:26, Andreas Joachim Peters wrote:
>>     > Hi Loic,
>>     >
>>     > i think the best is to read along the sources. It is very readab=
le!
>>     >
>>     > https://github.com/madiator/HadoopUSC/blob/developUSC/src/contri=
b/raid/src/java/org/apache/hadoop/raid/SimpleRegeneratingCode.java
>>     >
>>     > If there is a high interest in this, you  could port the code fr=
om Java to C++ and use the GF-complete or Intel GF-multiplication impleme=
ntation for the used GF multiplications.
>>     >
>>     > Cheers Andreas.
>>     >
>>     >
>>     > ________________________________________
>>     > From: ceph-devel-owner@vger.kernel.org <mailto:ceph-devel-owner@=
vger.kernel.org> [ceph-devel-owner@vger.kernel.org <mailto:ceph-devel-own=
er@vger.kernel.org>] on behalf of Loic Dachary [loic@dachary.org <mailto:=
loic@dachary.org>]
>>     > Sent: 30 June 2014 11:06
>>     > To: Koleos Fuscus
>>     > Cc: Ceph Development
>>     > Subject: Re: erasure code and coefficients
>>     >
>>     > Hi koleosfuscus,
>>     >
>>     > It clarifies it enough to raise a question : where can I read co=
de (or an algorithm if not code) that chose the coefficients desirable to=
 implement what is suggested in the Xorbas paper ?
>>     >
>>     > Cheers
>>     >
>>     > On 30/06/2014 10:18, Koleos Fuscus wrote:
>>     >> Hi Loic,
>>     >>
>>     >> I am happy to contribute with some clarifications. In fact,
>>     >> erasure/reliability concepts are not blocking my progress with =
the
>>     >> reliability model at ceph. It is the ceph model itself that has=
 some
>>     >> parts not clear to me, and nobody had time yet to review the st=
ate
>>     >> model diagram that I published on the wiki. :(
>>     >>  Anyway, regarding coefficients here is a bit of background.
>>     >> Coefficients are the numbers that multiply your variables insid=
e an
>>     >> equation. In a toy example, to solve the equation ax^2+bx+c=3D0=
 you need
>>     >> to find the coefficients a,b,c that make the equation valid.
>>     >> In the context of Reed Solomon, the definition of coefficients =
is a
>>     >> bit more confusing. In the original design, the message x is
>>     >> interpreted as coefficients of a polynomial p. But in subsequen=
ts
>>     >> interpretations the message x is seen as the values of the poly=
nomial
>>     >> p evaluated at the first k points a1..ak. Such interpretation i=
s
>>     >> apparently a bit less efficient but desirable because you can
>>     >> construct a systematic code.
>>     >> In the context of xorbas, you are constructing a code on top of=
 Reed
>>     >> Solomon. The codewords are seen as values, and the idea is to g=
et
>>     >> coefficients c1..c10 that also satisfy s1+s2+s3=3D0 (take this =
as a
>>     >> missing introduction to my previous message)
>>     >>
>>     >> Cheers,
>>     >>
>>     >> koleosfuscus
>>     >>
>>     >> _______________________________________________________________=
_
>>     >> "My reply is: the software has no known bugs, therefore it has =
not
>>     >> been updated."
>>     >> Wietse Venema
>>     >>
>>     >>
>>     >> On Sun, Jun 29, 2014 at 8:44 PM, Loic Dachary <loic@dachary.org=
 <mailto:loic@dachary.org>> wrote:
>>     >>> Hi koleofuscus,
>>     >>>
>>     >>> Thanks for the explanation : it is very conforting to know tha=
t you understand this :-) At the risk of being thick, I must say that the=
 very notion of "coefficient" eludes me. What are they ?
>>     >>>
>>     >>> Cheers
>>     >>>
>>     >>> On 29/06/2014 20:38, Koleos Fuscus wrote:
>>     >>>> Hello Loic,
>>     >>>> Dimakis (one of the authors of xorbas) is talking about coeff=
icients
>>     >>>> because they want to find a way to reduce the storage overhea=
d used
>>     >>>> with LRC. In the simple case used in Fig. 2, a RS (k=3D10, m=3D=
4) has
>>     >>>> 14/10 storage overhead but when using LRC, the overhead incre=
ases to
>>     >>>> 17/10 because you also need to store s1, s2 and s3. Basically=
, the
>>     >>>> idea is to find specific coefficients c1..c10 that permit to =
obtain s3
>>     >>>> through s1 and s2. In other words, get some s1 and s2 that wh=
en xored
>>     >>>> together give s3. If you find such coefficients, you don't ne=
ed to
>>     >>>> store s3 and the storage overhead of LRC is 1.6x instead of 1=
=2E7x.
>>     >>>>
>>     >>>> Dimakis said that for the Reed Solomon implementation used in=
 HDFS
>>     >>>> RAID they can simple set all coefficients with value '1' and =
use xor.
>>     >>>>
>>     >>>> This cannot be the case of the Reed Solomon implemented by yo=
u (I
>>     >>>> understood is the jerasure library by Plank) but that I am no=
t sure. I
>>     >>>> guess we need the help of a mathematician or at least check a=
nd
>>     >>>> compare both implementations.
>>     >>>>
>>     >>>> Finally, apparently for xorbas they only implemented the conf=
iguration
>>     >>>> RS(10,4) and not other combinations. Unfortunately, the wiki =
page of
>>     >>>> the project is empty http://wiki.apache.org/hadoop/ErasureCod=
e and the
>>     >>>> main page says 'erasure coding under development'.
>>     >>>>
>>     >>>> I recommend you to watch the xorbas presentation video
>>     >>>> http://smahesh.com/HadoopUSC/ (a very clear explanation of xo=
rbas) and
>>     >>>> use the Dimakis wiki page to check the large collection of pa=
per they
>>     >>>> have: http://storagewiki.ece.utexas.edu/
>>     >>>>
>>     >>>> Best,
>>     >>>>
>>     >>>> koleosfuscus
>>     >>>>
>>     >>>> _____________________________________________________________=
___
>>     >>>> "My reply is: the software has no known bugs, therefore it ha=
s not
>>     >>>> been updated."
>>     >>>> Wietse Venema
>>     >>>>
>>     >>>>
>>     >>>> On Sun, Jun 29, 2014 at 11:30 AM, Loic Dachary <loic@dachary.=
org <mailto:loic@dachary.org>> wrote:
>>     >>>>> Hi Andreas,
>>     >>>>>
>>     >>>>> In http://anrg.usc.edu/~maheswaran/Xorbas.pdf I get the idea=
 of computing local coding chunks the way it is implemented in https://gi=
thub.com/ceph/ceph/pull/1921 (i.e. delegating encoding / decoding to othe=
r plugins). However, there are theoretical aspects of the paper that I do=
 not understand and I'm hoping you can shed some light on it. In particul=
ar, I don't know what "coefficients" are about. For instance in the conte=
xt of Figure 2 caption : "The main theoretical challenge is to choose the=
 coeffi cients c(i) to maximize the fault tolerance of the code."
>>     >>>>>
>>     >>>>> Would you recommend a paper to read to better understand thi=
s ? Also I'd like to understand what "coefficients" mean in the context o=
f jerasure or if they do not apply.
>>     >>>>>
>>     >>>>> Thanks for you help :-)
>>     >>>>>
>>     >>>>> --
>>     >>>>> Lo=EFc Dachary, Artisan Logiciel Libre
>>     >>>>>
>>     >>>
>>     >>> --
>>     >>> Lo=EFc Dachary, Artisan Logiciel Libre
>>     >>>
>>     >
>>     > --
>>     > Lo=EFc Dachary, Artisan Logiciel Libre
>>     >
>>     > --
>>     > To unsubscribe from this list: send the line "unsubscribe ceph-d=
evel" in
>>     > the body of a message to majordomo@vger.kernel.org <mailto:major=
domo@vger.kernel.org>
>>     > More majordomo info at  http://vger.kernel.org/majordomo-info.ht=
ml
>>     >
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


--JA0SRQf56LDO4rO9Pv6hfXIk0sE9tBRfF
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOxZvkACgkQ8dLMyEl6F21/FACgvAQp0kC1seKvRPsZ1gptc0P0
8Y4AoKRExcEikLGuoMzJszbrPP+J+7h5
=lnGT
-----END PGP SIGNATURE-----

--JA0SRQf56LDO4rO9Pv6hfXIk0sE9tBRfF--
