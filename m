From: Loic Dachary <loic@dachary.org>
Subject: Re: erasure code and coefficients
Date: Sun, 29 Jun 2014 20:44:21 +0200
Message-ID: <53B05E85.9020405@dachary.org>
References: <53AFDC99.9010009@dachary.org> <CACUN8h3rxRmBkMD7dWJgp3yiJ6Qm9TvJptGSfsUgL-bAyoQi8Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="GsOo5gjA7hxpKamo4cDop4Dlrfl5erjnL"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:60092 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753312AbaF2So2 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sun, 29 Jun 2014 14:44:28 -0400
In-Reply-To: <CACUN8h3rxRmBkMD7dWJgp3yiJ6Qm9TvJptGSfsUgL-bAyoQi8Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Koleos Fuscus <koleosfuscus@gmail.com>
Cc: Andreas-Joachim Peters <andreas.joachim.peters@cern.ch>, Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--GsOo5gjA7hxpKamo4cDop4Dlrfl5erjnL
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi koleofuscus,

Thanks for the explanation : it is very conforting to know that you under=
stand this :-) At the risk of being thick, I must say that the very notio=
n of "coefficient" eludes me. What are they ?

Cheers

On 29/06/2014 20:38, Koleos Fuscus wrote:
> Hello Loic,
> Dimakis (one of the authors of xorbas) is talking about coefficients
> because they want to find a way to reduce the storage overhead used
> with LRC. In the simple case used in Fig. 2, a RS (k=3D10, m=3D4) has
> 14/10 storage overhead but when using LRC, the overhead increases to
> 17/10 because you also need to store s1, s2 and s3. Basically, the
> idea is to find specific coefficients c1..c10 that permit to obtain s3
> through s1 and s2. In other words, get some s1 and s2 that when xored
> together give s3. If you find such coefficients, you don't need to
> store s3 and the storage overhead of LRC is 1.6x instead of 1.7x.
>=20
> Dimakis said that for the Reed Solomon implementation used in HDFS
> RAID they can simple set all coefficients with value '1' and use xor.
>=20
> This cannot be the case of the Reed Solomon implemented by you (I
> understood is the jerasure library by Plank) but that I am not sure. I
> guess we need the help of a mathematician or at least check and
> compare both implementations.
>=20
> Finally, apparently for xorbas they only implemented the configuration
> RS(10,4) and not other combinations. Unfortunately, the wiki page of
> the project is empty http://wiki.apache.org/hadoop/ErasureCode and the
> main page says 'erasure coding under development'.
>=20
> I recommend you to watch the xorbas presentation video
> http://smahesh.com/HadoopUSC/ (a very clear explanation of xorbas) and
> use the Dimakis wiki page to check the large collection of paper they
> have: http://storagewiki.ece.utexas.edu/
>=20
> Best,
>=20
> koleosfuscus
>=20
> ________________________________________________________________
> "My reply is: the software has no known bugs, therefore it has not
> been updated."
> Wietse Venema
>=20
>=20
> On Sun, Jun 29, 2014 at 11:30 AM, Loic Dachary <loic@dachary.org> wrote=
:
>> Hi Andreas,
>>
>> In http://anrg.usc.edu/~maheswaran/Xorbas.pdf I get the idea of comput=
ing local coding chunks the way it is implemented in https://github.com/c=
eph/ceph/pull/1921 (i.e. delegating encoding / decoding to other plugins)=
=2E However, there are theoretical aspects of the paper that I do not und=
erstand and I'm hoping you can shed some light on it. In particular, I do=
n't know what "coefficients" are about. For instance in the context of Fi=
gure 2 caption : "The main theoretical challenge is to choose the coeffi =
cients c(i) to maximize the fault tolerance of the code."
>>
>> Would you recommend a paper to read to better understand this ? Also I=
'd like to understand what "coefficients" mean in the context of jerasure=
 or if they do not apply.
>>
>> Thanks for you help :-)
>>
>> --
>> Lo=C3=AFc Dachary, Artisan Logiciel Libre
>>

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--GsOo5gjA7hxpKamo4cDop4Dlrfl5erjnL
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlOwXoUACgkQ8dLMyEl6F21n3QCdHNcKqdsq18Yh07/zQJtD2vm8
8cgAniAUWgbS+urnqUrML9Al7i0w2VyE
=hLL9
-----END PGP SIGNATURE-----

--GsOo5gjA7hxpKamo4cDop4Dlrfl5erjnL--
