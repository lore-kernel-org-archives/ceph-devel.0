From: Loic Dachary <loic@dachary.org>
Subject: Re: Comments on Ceph distributed parity implementation
Date: Thu, 20 Jun 2013 20:25:54 +0200
Message-ID: <51C34932.4080304@dachary.org>
References: <20130614201327.70240@gmx.com> <51BB9FC3.8040102@dachary.org> <622F4407872BA447A16110F65453358C01A4D3D29CB3@FMSAMAIL.fmsa.local> <loom.20130616T214215-201@post.gmane.org> <51BE2EB1.2020807@dachary.org> <622F4407872BA447A16110F65453358C01A4D3D29CEE@FMSAMAIL.fmsa.local> <51C00FDB.6030803@polytech.univ-nantes.fr> <3E438C2F-0779-4824-9C05-ABE4B5803E05@cs.utk.edu>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEFD944462991568B58B52A9F"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:41531 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757728Ab3FTSZ7 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 Jun 2013 14:25:59 -0400
In-Reply-To: <3E438C2F-0779-4824-9C05-ABE4B5803E05@cs.utk.edu>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: James Plank <plank@cs.utk.edu>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEFD944462991568B58B52A9F
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable



On 06/18/2013 04:22 PM, James Plank wrote:
> Hi all -- thank you for including me on this thread, although I have li=
ttle substantive to add.  At the moment, my sole focus is finishing a jou=
rnal paper about GF implementations, with a concomitant GF-complete relea=
se to accompany it.  I agree that the CPU burden of the GF arithmetic wil=
l not be a bottleneck in your system, regardless of which implementation =
you use, as long as you stay at or below GF(2^16).  If you want to go hig=
her, GF-complete will help.  When we put out a new release (the code will=
 be ready within two weeks, however, the documentation is lagging), I'll =
let you know.  I think LRC is a nice coding paradigm, although I imagine =
that it has IP issues with Microsoft.  I don't have first-hand experience=
 with network/regenerating codes, and I'll be honest -- there have been s=
o many papers in that realm that I am not up to date on them.
>=20
> Is there a question on which you'd like some help?  It sounds as though=
 you are at two decision points: What code should you use, and at which p=
oint on the space-overhead/fault-tolerance curve would you like to be?

Hi James,=20

Unless someone objects it looks like Ceph going to use jerasure-1.2 with =
reed-solomon. I'm glad to hear that GF arithmetic will not be a bottlenec=
k : we're going to stay below GF(2^8). However minimizing the CPU footpri=
nt is essential and I'm looking forward to use the next version including=
 the SIMD optimizations that you demonstrated in gf-complete.

I wrote down a short description of the read/write path I plan to impleme=
nt in ceph : https://github.com/dachary/ceph/blob/wip-4929/doc/dev/osd_in=
ternals/erasure-code.rst . A quick look at the drawings will hopefully gi=
ve you an idea. Each OSD is a disk connected to the others over the netwo=
rk. Although I chose K+M =3D 5 I suspect the most common use case will be=
 around K+M =3D 7+3 =3D 10=20

I've seen that jerasure-1.2 not only provides classic reed-solomon but al=
so cauchy reed-solomon and liberation / minimal density MDS codes. I assu=
me classic reed-solomon is best suited for the default Ceph use case desc=
ribed above but I'm not sure. What do you think ?

Thanks a lot for your advices :-) It helps me write sensible code.=20

Cheers

>=20
> Best wishes,
>=20
> Jim
> ----------
>=20
> On Jun 18, 2013, at 3:44 AM, Beno=EEt Parrein wrote:
>=20
>> Hi Paul,
>>
>> thank you for your message
>>
>> from my point, LRC focuses on the repairing problem. how to reconstruc=
t destroyed node to maintain the same availability by the distributed sys=
tem?
>> in this context they can even go below 1x rate by introducing local pa=
rity on classical Reed Solomon blocks (but they pay a supplementary overh=
ead). see excellent Alex Dimakis's papers for that. but, still from my po=
int, the same relationship between redundancy and availability occurs (if=
 you consider binomial model for your loses).
>>
>> best
>> bp
>>
>>
>> Le 17/06/2013 18:55, Paul Von-Stamwitz a =E9crit :
>>> Loic,
>>>
>>> As Benoit points out, Mojette uses discrete geometry rather than alge=
bra, so simple XOR is all that is needed.
>>>
>>> Benoit,
>>>
>>> Microsoft's paper states that their [12,2,2] LRC provides better avai=
lability than 3x replication with 1.33x efficiency. 1.5x is certainly a g=
ood number. I'm just pointing out that better efficiency can be had witho=
ut losing availibity.
>>>
>>> All the best,
>>> Paul
>>
>> <benoit_parrein.vcf>
>=20
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Lo=EFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.



--------------enigEFD944462991568B58B52A9F
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlHDSTIACgkQ8dLMyEl6F230TQCff52I2rnc4Yak5QOjVwP51zo2
myUAn3T0/f04Gf0fg8ZDxXFK53WYx2UG
=x0mG
-----END PGP SIGNATURE-----

--------------enigEFD944462991568B58B52A9F--
