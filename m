From: Leen Besselink <leen@consolejunkie.net>
Subject: Re: Comments on Ceph distributed parity implementation
Date: Sat, 15 Jun 2013 11:40:44 +0200
Message-ID: <20130615094043.GB1067@apia.perrit.net>
References: <20130614201327.70240@gmx.com>
 <51BC1813.6000509@dachary.org>
Reply-To: leen@consolejunkie.net
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mta2.perrit.net ([194.213.15.114]:36767 "EHLO mta2.perrit.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753107Ab3FOJkq (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 15 Jun 2013 05:40:46 -0400
Received: from apia.perrit.net (apia.colo.hnglo.perrit.net [194.0.170.50])
	by mail.perrit.nl (Postfix) with ESMTP id 77B462001CE
	for <ceph-devel@vger.kernel.org>; Sat, 15 Jun 2013 11:40:44 +0200 (CEST)
Content-Disposition: inline
In-Reply-To: <51BC1813.6000509@dachary.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

On Sat, Jun 15, 2013 at 09:30:27AM +0200, Loic Dachary wrote:
> Hi Martin,
>=20
> Just listened to
>=20
> https://2459d6dc103cb5933875-c0245c5c937c5dedcca3f1764ecc9b2f.ssl.cf2=
=2Erackcdn.com/fast13/plank_screaming.mp4
> from
> https://www.usenix.org/conference/fast13/screaming-fast-galois-field-=
arithmetic-using-sse2-extensions
>=20
> and it's very entertaining ;-)
>=20

If video is what you like the Microsoft presentation of the previously =
mentioned PDF is here:

https://www.usenix.org/conference/usenixfederatedconferencesweek/high-p=
erformance-vehicular-connectivity-opportunistic

They also talk about why they made their choices. I guess that it's als=
o in the PDF.

> Cheers
>=20
>=20
> On 06/14/2013 10:13 PM, Martin Flyvbjerg wrote:
> > Dear Community
> > I am a young engineer (not software or math, please bare with me) w=
ith some suggestions regarding erasure codes. I never used Ceph before =
or any other distributed file system.
> >=20
> > I stumped upon the suggestion for adding erasure codes to Ceph, as
> > described in this article
> > http://wiki.Ceph.com/01Planning/02Blueprints/Dumpling/Erasure_encod=
ing_as_a_storage_backend
> >=20
> > first I would like to say great initiative to add erasure codes to =
Ceph.
> > Ceph needs its own implementation and it have to be done right, I c=
annot stress this enough, suggested software mentioned in that article =
would result in very low performance.
> >=20
> > Why?
> > Reed-Solomon is normally something regarded as being very slow comp=
ared to other erasure codes, because the underlying Galois-Field multip=
lication is slow. Please see video at usenix.org forexplanation.
> >=20
> > The implementations of Zfec library and other suggested software th=
e others rely on the Vandermonde matrix, a matrix used in in Reed-Solom=
on erasure codes, a faster approach would be to use the Cauchy-Reed-Sol=
omon implementation. Please see [1,2,3]
> > Although there is something even better, by using the Intel SSE2/3 =
SIMD instructions it is possible to do the as fast as any other XOR bas=
ed erasure codes (RaptorQ LT-codes, LDPC etc.).
> >=20
> > The suggested FECpp lib uses the optimisation but with a relative s=
mall Galois-field only 2^8, since Ceph aimes at unlimited scalability i=
ncreasing the size of the Galois-Field would improve performance [4]. O=
f course the configured Ceph Object Size and/or Stripe width have to be=
 taken into account.
> > Please see
> > https://www.usenix.org/conference/fast13/screaming-fast-galois-fiel=
d-arithmetic-using-sse2-extensions
> >=20
> >=20
> > The solution
> > Using the GF-Complete open source library [4] to implement Reed-Sol=
omon in Ceph in order to allow Ceph to scale to infinity.
> > James S. Plank the author of GF-complete have developed a library i=
mplementing various Reed-Solomon codes called Jerasure. http://web.eecs=
=2Eutk.edu/~plank/plank/www/software.html
> > Jerasure 2.0 using the GF-complete artimetric based in Intel SSE SI=
MD instructions, is current in development expected release august 2013=
=2E Will be released under the new BSD license. Jerasure 2.0 also suppo=
rts arbitrary Galois-field sizes 8,16,32,64 or 128 bit.
> >=20
> > The limit of this implementation would be the processors L2/L3 cach=
e not the underlying arithmetic.=20
> >=20
> > Best Regards
> > Martin Flyvbjerg
> >=20
> > [1] http://web.eecs.utk.edu/~plank/plank/papers/CS-05-569.pdf
> > [2] http://web.eecs.utk.edu/~plank/plank/papers/CS-08-625.pdf
> > [3] http://web.eecs.utk.edu/~plank/plank/papers/FAST-2009.pdf
> > [4] http://web.eecs.utk.edu/~plank/plank/papers/FAST-2013-GF.pdf
> > --
> > To unsubscribe from this list: send the line "unsubscribe ceph-deve=
l" in
> > the body of a message to majordomo@vger.kernel.org
> > More majordomo info at  http://vger.kernel.org/majordomo-info.html
>=20
> --=20
> Lo=EFc Dachary, Artisan Logiciel Libre
> All that is necessary for the triumph of evil is that good people do =
nothing.
>=20


--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
