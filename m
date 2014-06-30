From: Loic Dachary <loic@dachary.org>
Subject: Re: erasure code and coefficients
Date: Mon, 30 Jun 2014 11:06:37 +0200
Message-ID: <53B1289D.8030901@dachary.org>
References: <53AFDC99.9010009@dachary.org>	<CACUN8h3rxRmBkMD7dWJgp3yiJ6Qm9TvJptGSfsUgL-bAyoQi8Q@mail.gmail.com>	<53B05E85.9020405@dachary.org> <CACUN8h2PnC=x4_6EesCAgG5meQB=e0QMqrc6AHTNa0tJzOyaTA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="VcIfJh3lep2Ccolaua9OiVkEhcgTAqSAL"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:60456 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753017AbaF3JGr (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jun 2014 05:06:47 -0400
In-Reply-To: <CACUN8h2PnC=x4_6EesCAgG5meQB=e0QMqrc6AHTNa0tJzOyaTA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Koleos Fuscus <koleosfuscus@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--VcIfJh3lep2Ccolaua9OiVkEhcgTAqSAL
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi koleosfuscus,

It clarifies it enough to raise a question : where can I read code (or an=
 algorithm if not code) that chose the coefficients desirable to implemen=
t what is suggested in the Xorbas paper ?

Cheers

On 30/06/2014 10:18, Koleos Fuscus wrote:
> Hi Loic,
>=20
> I am happy to contribute with some clarifications. In fact,
> erasure/reliability concepts are not blocking my progress with the
> reliability model at ceph. It is the ceph model itself that has some
> parts not clear to me, and nobody had time yet to review the state
> model diagram that I published on the wiki. :(
>  Anyway, regarding coefficients here is a bit of background.
> Coefficients are the numbers that multiply your variables inside an
> equation. In a toy example, to solve the equation ax^2+bx+c=3D0 you nee=
d
> to find the coefficients a,b,c that make the equation valid.
> In the context of Reed Solomon, the definition of coefficients is a
> bit more confusing. In the original design, the message x is
> interpreted as coefficients of a polynomial p. But in subsequents
> interpretations the message x is seen as the values of the polynomial
> p evaluated at the first k points a1..ak. Such interpretation is
> apparently a bit less efficient but desirable because you can
> construct a systematic code.
> In the context of xorbas, you are constructing a code on top of Reed
> Solomon. The codewords are seen as values, and the idea is to get
> coefficients c1..c10 that also satisfy s1+s2+s3=3D0 (take this as a
> missing introduction to my previous message)
>=20
> Cheers,
>=20
> koleosfuscus
>=20
> ________________________________________________________________
> "My reply is: the software has no known bugs, therefore it has not
> been updated."
> Wietse Venema
>=20
>=20
> On Sun, Jun 29, 2014 at 8:44 PM, Loic Dachary <loic@dachary.org> wrote:=

>> Hi koleofuscus,
>>
>> Thanks for the explanation : it is very conforting to know that you un=
derstand this :-) At the risk of being thick, I must say that the very no=
tion of "coefficient" eludes me. What are they ?
>>
>> Cheers
>>
>> On 29/06/2014 20:38, Koleos Fuscus wrote:
>>> Hello Loic,
>>> Dimakis (one of the authors of xorbas) is talking about coefficients
>>> because they want to find a way to reduce the storage overhead used
>>> with LRC. In the simple case used in Fig. 2, a RS (k=3D10, m=3D4) has=

>>> 14/10 storage overhead but when using LRC, the overhead increases to
>>> 17/10 because you also need to store s1, s2 and s3. Basically, the
>>> idea is to find specific coefficients c1..c10 that permit to obtain s=
3
>>> through s1 and s2. In other words, get some s1 and s2 that when xored=

>>> together give s3. If you find such coefficients, you don't need to
>>> store s3 and the storage overhead of LRC is 1.6x instead of 1.7x.
>>>
>>> Dimakis said that for the Reed Solomon implementation used in HDFS
>>> RAID they can simple set all coefficients with value '1' and use xor.=

>>>
>>> This cannot be the case of the Reed Solomon implemented by you (I
>>> understood is the jerasure library by Plank) but that I am not sure. =
I
>>> guess we need the help of a mathematician or at least check and
>>> compare both implementations.
>>>
>>> Finally, apparently for xorbas they only implemented the configuratio=
n
>>> RS(10,4) and not other combinations. Unfortunately, the wiki page of
>>> the project is empty http://wiki.apache.org/hadoop/ErasureCode and th=
e
>>> main page says 'erasure coding under development'.
>>>
>>> I recommend you to watch the xorbas presentation video
>>> http://smahesh.com/HadoopUSC/ (a very clear explanation of xorbas) an=
d
>>> use the Dimakis wiki page to check the large collection of paper they=

>>> have: http://storagewiki.ece.utexas.edu/
>>>
>>> Best,
>>>
>>> koleosfuscus
>>>
>>> ________________________________________________________________
>>> "My reply is: the software has no known bugs, therefore it has not
>>> been updated."
>>> Wietse Venema
>>>
>>>
>>> On Sun, Jun 29, 2014 at 11:30 AM, Loic Dachary <loic@dachary.org> wro=
te:
>>>> Hi Andreas,
>>>>
>>>> In http://anrg.usc.edu/~maheswaran/Xorbas.pdf I get the idea of comp=
uting local coding chunks the way it is implemented in https://github.com=
/ceph/ceph/pull/1921 (i.e. delegating encoding / decoding to other plugin=
s). However, there are theoretical aspects of the paper that I do not und=
erstand and I'm hoping you can shed some light on it. In particular, I do=
n't know what "coefficients" are about. For instance in the context of Fi=
gure 2 caption : "The main theoretical challenge is to choose the coeffi =
cients c(i) to maximize the fault tolerance of the code."
>>>>
>>>> Would you recommend a paper to read to better understand this ? Also=
 I'd like to understand what "coefficients" mean in the context of jerasu=
re or if they do not apply.
>>>>
>>>> Thanks for you help :-)
>>>>
>>>> --
>>>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>>>
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--VcIfJh3lep2Ccolaua9OiVkEhcgTAqSAL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOxKJ0ACgkQ8dLMyEl6F20mHwCfVx0QNAJ+lThKf3vFQq4NMOVi
D3cAoIDVnnAbF/eB65rJFUV7um6siNvf
=uWOI
-----END PGP SIGNATURE-----

--VcIfJh3lep2Ccolaua9OiVkEhcgTAqSAL--
