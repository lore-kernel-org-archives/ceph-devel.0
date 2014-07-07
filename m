From: Loic Dachary <loic@dachary.org>
Subject: Re: Markov models for Ceph
Date: Mon, 07 Jul 2014 19:16:32 +0200
Message-ID: <53BAD5F0.20804@dachary.org>
References: <CACUN8h1j=j-=37TRcnauqGuxMff3Ebs4x5jewY3KefOgDprp8g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="u4tBK0bB6pDURW8id4f6aDOOO5Aa1jaAX"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail2.dachary.org ([91.121.57.175]:39787 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
	with ESMTP id S1750707AbaGGRQk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 7 Jul 2014 13:16:40 -0400
In-Reply-To: <CACUN8h1j=j-=37TRcnauqGuxMff3Ebs4x5jewY3KefOgDprp8g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Koleos Fuscus <koleosfuscus@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--u4tBK0bB6pDURW8id4f6aDOOO5Aa1jaAX
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi koleosfuscus,

=46rom http://www.kaymgee.com/Kevin_Greenan/Software_files/hfrs.tar downl=
oaded from http://www.kaymgee.com/Kevin_Greenan/Software.html

In hfrs/models/weaver_8_8_3.disk.ber.model

[num states]
4
0 1 a failure
1 0 b repair
1 2 c failure
2 1 d repair
2 3 e failure
[assign]
a=3DN*lam_d
b=3Dmu
c=3D(N-1)*lam_d
d=3D2*mu
e=3D(N-2)*lam_d
N=3D8
lam_d=3D(1/461386.)
mu=3D(1/12.)
[END]

is semi-human parsable but hfrs/models/weaver_8_8_3.disk.ber.model

[num states]
5
0 1 a failure
0 4 b failure
1 2 c failure
1 4 d failure
1 0 e repair
2 3 f failure
2 4 g failure
2 1 h repair
3 4 i failure
3 2 j repair
[assign]
a=3D(N-0)*lam_d*(1-0.000000)*(1-(0.000000*(1-(1-p)**(N-1))))
b=3D(N-0)*lam_d*(0.000000)+(N-0)*lam_d*(1-0.000000)*((0.000000*(1-(1-p)**=
(N-1))))
c=3D(N-1)*lam_d*(1-0.000000)*(1-(0.000000*(1-(1-p)**(N-2))))
d=3D(N-1)*lam_d*(0.000000)+(N-1)*lam_d*(1-0.000000)*((0.000000*(1-(1-p)**=
(N-2))))
e=3D1*mu
f=3D(N-2)*lam_d*(1-0.000000)*(1-(0.114286*(1-(1-p)**(N-3))))
g=3D(N-2)*lam_d*(0.000000)+(N-2)*lam_d*(1-0.000000)*((0.114286*(1-(1-p)**=
(N-3))))
h=3D2*mu
i=3D(N-3)*lam_d
j=3D3*mu
N=3D8
lam_d=3D(1/461386.)
mu=3D(1/12.)
p=3D0.0237
[END]

[Disk sector conditional fault tolerance]
[[0.0, 0.0, 0.0, 0.0, 0.0043956043956043956, 0.02197802197802198, 0.07592=
4075924075921], [0.0, 0.0, 0.0, 0.01098901098901099, 0.057942057942057944=
, 0.19780219780219779, 1.0], [0.0, 0.0, 0.034632034632034632, 0.166233766=
23376623, 0.49494949494949497, 1.0, 1.0], [0.0, 0.11428571428571428, 0.44=
126984126984126, 0.98333333333333328, 1.0, 1.0, 1.0]]


Kevin write that "The HFRS uses an extremely efficient mathematical techn=
ique, called importance sampling, which enables the observation of extrem=
ely low-probability events.  I have implemented (and derived in my thesis=
) efficient simulation algorithms under both exponential and Weibull fail=
ure/repairs.  The combination of these techniques, in addition to a custo=
m Markov model solver, makes the HFRS an extremely useful tool for evalua=
ting storage system reliability." meaning you need to understand both htt=
ps://en.wikipedia.org/wiki/Markov_model and https://en.wikipedia.org/wiki=
/Importance_sampling as well as the semantics of the input file which is =
documented in the README.

Nice find koleosfuscus :-)

Cheers

On 07/07/2014 17:19, Koleos Fuscus wrote:
> Hello Loic,
>=20
> You ask previously:
> In other words, is there a place where one could set things like "disk
> fail % of the time" and "network is X Gb/s" and "repairing a disk
> failure requires disk require reading B bytes from M disks" ? As far
> as I understand, such factors cannot be expressed with a single
> formula and this is why a Markov model is useful.
>=20
> I think we need to run simulations to have a more precise estimation
> of the reliability of an erasure coded system. Markov models are not
> as flexible as you may think. Besides, solving equations when the
> number of components that may fail is large makes the problem not
> trivial. Maybe standard simulation is enough. As observed by Greenan
> in his thesis, standard simulations have problems with rare events
> which may not be observed during simulation time. I don't know if we
> should care about rare events for comparing methods..
>=20
> Greenan released the software used for his thesis. It is completely
> developed in Python.
> http://www.kaymgee.com/Kevin_Greenan/Software.html
>=20
> I found Greenan tool while trying to validate the results of ceph-tool
> and the numbers are completely different:
>=20
> For instance:
>=20
> Parameters for ceph tool:
> Disk type consumer, FIT1=3D2167, FIT2=3D2167
> Size: 2000GiB
> RAID-6
> Replace 0h
> Rebuild 6000MiB/s
> Volumes:8
> NRE model: ignore
> Period: 10 years
>=20
> (I used this numbers to compared with model 2DFT.disk.model of Greenan =
tool)
>=20
> Parameters for  Greenan HFRS tool
> python mm_solve.py -m 2DFT.disk.model -M
>=20
> Results
>=20
> CEPH:
>=20
>     storage               durability    PL(site)  PL(copies)
> PL(NRE)     PL(rep)    loss/PiB
>=20
>     ----------            ----------  ----------  ----------
> ----------  ----------  ----------
>=20
>     RAID-6: 6+2             11-nines   0.000e+00   1.318e-12
> 0.000e+00   0.000e+00   9.887e+02
>=20
>=20
> HRFS:
>=20
> Analytic MTTDL:  4.06111903031e+12
> *********************
> Analytic prob. of failure: 2.15660e-08
> *********************
>=20
> Could you check if the parameters for ceph are correct and equivalent
> to HRFS model?Do you think it has sense to include Greenan tool.
> Greenan has a number of models including nonMDS codes. I am not sure
> yet how we can describe the LRC code in this platform but it might be
> possible.
>=20
> koleosfuscus
>=20
> ________________________________________________________________
> "My reply is: the software has no known bugs, therefore it has not
> been updated."
> Wietse Venema
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre


--u4tBK0bB6pDURW8id4f6aDOOO5Aa1jaAX
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)
Comment: Using GnuPG with Thunderbird - http://www.enigmail.net/

iEYEARECAAYFAlO61fAACgkQ8dLMyEl6F23XLQCgs6ZkFP4bvE9fLk85NOZVkhQq
FbYAoKOxudGvQCPccVAFcvMBZKOO+Ye6
=w1OV
-----END PGP SIGNATURE-----

--u4tBK0bB6pDURW8id4f6aDOOO5Aa1jaAX--
