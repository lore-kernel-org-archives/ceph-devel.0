From: Loic Dachary <loic@dachary.org>
Subject: Re: erasure code and coefficients
Date: Mon, 30 Jun 2014 12:34:18 +0200
Message-ID: <53B13D2A.8030901@dachary.org>
References: <53AFDC99.9010009@dachary.org>	<CACUN8h3rxRmBkMD7dWJgp3yiJ6Qm9TvJptGSfsUgL-bAyoQi8Q@mail.gmail.com>	<53B05E85.9020405@dachary.org> <CACUN8h2PnC=x4_6EesCAgG5meQB=e0QMqrc6AHTNa0tJzOyaTA@mail.gmail.com>,<53B1289D.8030901@dachary.org> <3472A07E6605974CBC9BC573F1BC02E4AE746F2A@CERNXCHG44.cern.ch>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="diPwFMRlqFF9nmcp5DOqeal7T9NlEHSsN"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:60551 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1755287AbaF3Ke0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jun 2014 06:34:26 -0400
In-Reply-To: <3472A07E6605974CBC9BC573F1BC02E4AE746F2A@CERNXCHG44.cern.ch>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Joachim Peters <Andreas.Joachim.Peters@cern.ch>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--diPwFMRlqFF9nmcp5DOqeal7T9NlEHSsN
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Andreas,

TL;DR: which part of the code chooses the coefficients to maximize the fa=
ult tolerance of the code as suggested in the Xorbas paper ?

If I understand correctly, the locality is computed (i.e. how many local =
parity chunks are created) with:

https://github.com/madiator/HadoopUSC/blob/developUSC/src/contrib/raid/sr=
c/java/org/apache/hadoop/raid/SimpleRegeneratingCode.java#L84

This is different from specifying it explicitly (https://github.com/dacha=
ry/ceph/commit/91b9cc2be5851f7668d593bb69b2f4f089ea585a#diff-5518964bc98a=
094a784ce2d17a5b0cc1R11)

Then a RS encoding matrix is calculated=20

https://github.com/madiator/HadoopUSC/blob/developUSC/src/contrib/raid/sr=
c/java/org/apache/hadoop/raid/SimpleRegeneratingCode.java#L100

and will be used when encoding an object

https://github.com/madiator/HadoopUSC/blob/developUSC/src/contrib/raid/sr=
c/java/org/apache/hadoop/raid/SimpleRegeneratingCode.java#L143

then each local parity chunk is calculated using a simpler function (XOR)=


https://github.com/madiator/HadoopUSC/blob/developUSC/src/contrib/raid/sr=
c/java/org/apache/hadoop/raid/SimpleRegeneratingCode.java#L154

When decoding, the equivalent of the Ceph minimum_to_decode method is use=
d to figure out which chunks are needed to recover the lost chunks

https://github.com/madiator/HadoopUSC/blob/developUSC/src/contrib/raid/sr=
c/java/org/apache/hadoop/raid/SimpleRegeneratingCode.java#L319

During recovery, if only one chunk is missing, it is recovered with the s=
impler function (XOR)

https://github.com/madiator/HadoopUSC/blob/developUSC/src/contrib/raid/sr=
c/java/org/apache/hadoop/raid/SimpleRegeneratingCode.java#L207
https://github.com/madiator/HadoopUSC/blob/developUSC/src/contrib/raid/sr=
c/java/org/apache/hadoop/raid/SimpleRegeneratingCode.java#L224
(both of which are combined recursively)

and if there is is a "conflict" (i.e. if local parity is not enough to re=
cover), then the RS decoding function is used

https://github.com/madiator/HadoopUSC/blob/developUSC/src/contrib/raid/sr=
c/java/org/apache/hadoop/raid/SimpleRegeneratingCode.java#L266

I don't understand at all how local parity is related to RS parity, in th=
e sense of "choosing the coefficients c(i) to maximize the fault toleranc=
e of the code" as mentioned in the Xorbas paper : I must be missing somet=
hing :-) I do understand how the code works though, which is troubling. I=
t also is reassuring because the logic is very similar to what is propose=
d in https://github.com/ceph/ceph/pull/1921

Cheers

On 30/06/2014 11:26, Andreas Joachim Peters wrote:
> Hi Loic,=20
>=20
> i think the best is to read along the sources. It is very readable!
>=20
> https://github.com/madiator/HadoopUSC/blob/developUSC/src/contrib/raid/=
src/java/org/apache/hadoop/raid/SimpleRegeneratingCode.java
>=20
> If there is a high interest in this, you  could port the code from Java=
 to C++ and use the GF-complete or Intel GF-multiplication implementation=
 for the used GF multiplications.
>=20
> Cheers Andreas.
>=20
>=20
> ________________________________________
> From: ceph-devel-owner@vger.kernel.org [ceph-devel-owner@vger.kernel.or=
g] on behalf of Loic Dachary [loic@dachary.org]
> Sent: 30 June 2014 11:06
> To: Koleos Fuscus
> Cc: Ceph Development
> Subject: Re: erasure code and coefficients
>=20
> Hi koleosfuscus,
>=20
> It clarifies it enough to raise a question : where can I read code (or =
an algorithm if not code) that chose the coefficients desirable to implem=
ent what is suggested in the Xorbas paper ?
>=20
> Cheers
>=20
> On 30/06/2014 10:18, Koleos Fuscus wrote:
>> Hi Loic,
>>
>> I am happy to contribute with some clarifications. In fact,
>> erasure/reliability concepts are not blocking my progress with the
>> reliability model at ceph. It is the ceph model itself that has some
>> parts not clear to me, and nobody had time yet to review the state
>> model diagram that I published on the wiki. :(
>>  Anyway, regarding coefficients here is a bit of background.
>> Coefficients are the numbers that multiply your variables inside an
>> equation. In a toy example, to solve the equation ax^2+bx+c=3D0 you ne=
ed
>> to find the coefficients a,b,c that make the equation valid.
>> In the context of Reed Solomon, the definition of coefficients is a
>> bit more confusing. In the original design, the message x is
>> interpreted as coefficients of a polynomial p. But in subsequents
>> interpretations the message x is seen as the values of the polynomial
>> p evaluated at the first k points a1..ak. Such interpretation is
>> apparently a bit less efficient but desirable because you can
>> construct a systematic code.
>> In the context of xorbas, you are constructing a code on top of Reed
>> Solomon. The codewords are seen as values, and the idea is to get
>> coefficients c1..c10 that also satisfy s1+s2+s3=3D0 (take this as a
>> missing introduction to my previous message)
>>
>> Cheers,
>>
>> koleosfuscus
>>
>> ________________________________________________________________
>> "My reply is: the software has no known bugs, therefore it has not
>> been updated."
>> Wietse Venema
>>
>>
>> On Sun, Jun 29, 2014 at 8:44 PM, Loic Dachary <loic@dachary.org> wrote=
:
>>> Hi koleofuscus,
>>>
>>> Thanks for the explanation : it is very conforting to know that you u=
nderstand this :-) At the risk of being thick, I must say that the very n=
otion of "coefficient" eludes me. What are they ?
>>>
>>> Cheers
>>>
>>> On 29/06/2014 20:38, Koleos Fuscus wrote:
>>>> Hello Loic,
>>>> Dimakis (one of the authors of xorbas) is talking about coefficients=

>>>> because they want to find a way to reduce the storage overhead used
>>>> with LRC. In the simple case used in Fig. 2, a RS (k=3D10, m=3D4) ha=
s
>>>> 14/10 storage overhead but when using LRC, the overhead increases to=

>>>> 17/10 because you also need to store s1, s2 and s3. Basically, the
>>>> idea is to find specific coefficients c1..c10 that permit to obtain =
s3
>>>> through s1 and s2. In other words, get some s1 and s2 that when xore=
d
>>>> together give s3. If you find such coefficients, you don't need to
>>>> store s3 and the storage overhead of LRC is 1.6x instead of 1.7x.
>>>>
>>>> Dimakis said that for the Reed Solomon implementation used in HDFS
>>>> RAID they can simple set all coefficients with value '1' and use xor=
=2E
>>>>
>>>> This cannot be the case of the Reed Solomon implemented by you (I
>>>> understood is the jerasure library by Plank) but that I am not sure.=
 I
>>>> guess we need the help of a mathematician or at least check and
>>>> compare both implementations.
>>>>
>>>> Finally, apparently for xorbas they only implemented the configurati=
on
>>>> RS(10,4) and not other combinations. Unfortunately, the wiki page of=

>>>> the project is empty http://wiki.apache.org/hadoop/ErasureCode and t=
he
>>>> main page says 'erasure coding under development'.
>>>>
>>>> I recommend you to watch the xorbas presentation video
>>>> http://smahesh.com/HadoopUSC/ (a very clear explanation of xorbas) a=
nd
>>>> use the Dimakis wiki page to check the large collection of paper the=
y
>>>> have: http://storagewiki.ece.utexas.edu/
>>>>
>>>> Best,
>>>>
>>>> koleosfuscus
>>>>
>>>> ________________________________________________________________
>>>> "My reply is: the software has no known bugs, therefore it has not
>>>> been updated."
>>>> Wietse Venema
>>>>
>>>>
>>>> On Sun, Jun 29, 2014 at 11:30 AM, Loic Dachary <loic@dachary.org> wr=
ote:
>>>>> Hi Andreas,
>>>>>
>>>>> In http://anrg.usc.edu/~maheswaran/Xorbas.pdf I get the idea of com=
puting local coding chunks the way it is implemented in https://github.co=
m/ceph/ceph/pull/1921 (i.e. delegating encoding / decoding to other plugi=
ns). However, there are theoretical aspects of the paper that I do not un=
derstand and I'm hoping you can shed some light on it. In particular, I d=
on't know what "coefficients" are about. For instance in the context of F=
igure 2 caption : "The main theoretical challenge is to choose the coeffi=
 cients c(i) to maximize the fault tolerance of the code."
>>>>>
>>>>> Would you recommend a paper to read to better understand this ? Als=
o I'd like to understand what "coefficients" mean in the context of jeras=
ure or if they do not apply.
>>>>>
>>>>> Thanks for you help :-)
>>>>>
>>>>> --
>>>>> Lo=EFc Dachary, Artisan Logiciel Libre
>>>>>
>>>
>>> --
>>> Lo=EFc Dachary, Artisan Logiciel Libre
>>>
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


--diPwFMRlqFF9nmcp5DOqeal7T9NlEHSsN
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOxPSoACgkQ8dLMyEl6F22dEwCePwz/9YyX8r8m2/HGJUFWt/Q2
XecAn2ikO3txBkaRZ5ZMNXZOto6PQdn0
=D3i8
-----END PGP SIGNATURE-----

--diPwFMRlqFF9nmcp5DOqeal7T9NlEHSsN--
