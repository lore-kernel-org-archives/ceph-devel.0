From: Loic Dachary <loic@dachary.org>
Subject: Re: Comments on Ceph distributed parity implementation
Date: Sat, 15 Jun 2013 00:57:07 +0200
Message-ID: <51BB9FC3.8040102@dachary.org>
References: <20130614201327.70240@gmx.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEC48EF01276969971219C059"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.dmail.dachary.org ([86.65.39.20]:46390 "EHLO
	smtp.dmail.dachary.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751599Ab3FNW5L (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Jun 2013 18:57:11 -0400
In-Reply-To: <20130614201327.70240@gmx.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Martin Flyvbjerg <martinflyvbjerg@gmx.com>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEC48EF01276969971219C059
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Hi Martin,

Your explanations are very helpful to better understand the tradeoffs of =
the existing implementations. To be honest I was looking forward to your =
intervention. Not you specifically, of course :-) But someone with a good=
 theoretical background to be a judge of what's best in the context of Ce=
ph. If you say it's the upcoming library to be released in August 2013, I=
'll take your word for it.=20

The work currently being done within Ceph is to architecture to storage b=
ackend ( namely placement groups ) to make room for distributed parity. M=
y initial idea was to isolate the low level library under an API that tak=
es a region ( 16KB for instance, as in gf_unit.c found in http://web.eecs=
=2Eutk.edu/~plank/plank/papers/CS-13-703/gf_complete_0.1.tar ) as input a=
nd outputs chunks that can then be written on different hosts. For instan=
ce

	encode(char* region, char** chuncks) =3D> encode the region into N chunc=
ks
	decode(char** chunks, char* region) =3D> decode the N chuncks into a reg=
ion
        repair(char** chunks, int damaged) =3D> repair the damaged chunck=


Do you think it is a sensible approach ? And if you do, will I find examp=
les of such higher level functions in http://web.eecs.utk.edu/~plank/plan=
k/papers/CS-13-703/gf_complete_0.1.tar ? Or elsewhere ?

I'm a little confused about the relation between GF complete ( as found a=
t http://web.eecs.utk.edu/~plank/plank/papers/CS-13-703/gf_complete_0.1.t=
ar ) which is very recent ( 2013 ) and Jerasure ( as found at http://web.=
eecs.utk.edu/~plank/plank/papers/CS-08-627/Jerasure-1.2.tar )  which is c=
omparatively older ( 2008 ). Do you know how Jerasure 2.0 relates to GF c=
omplete ?=20

For completeness, here is a thread with pointers to Mojette Transform tha=
t's being used as part of Rozofs.

http://www.mail-archive.com/ceph-devel@vger.kernel.org/msg14666.html

I'm not able to compare it with the other libraries because it seems to t=
ake a completely different approach. Do you have an opinion about it ?

As Patrick mentioned, I'll be at http://www.oscon.com/oscon2013 next mont=
h but I'd love to understand more about this as soon as possible :-)

Cheers

P.S. Updated http://wiki.ceph.com/01Planning/02Blueprints/Dumpling/Erasur=
e_encoding_as_a_storage_backend#Erasure_Encoded_Storage with a link to ht=
tp://web.eecs.utk.edu/~plank/plank/www/software.html for the record

On 06/14/2013 10:13 PM, Martin Flyvbjerg wrote:
> Dear Community
> I am a young engineer (not software or math, please bare with me) with =
some suggestions regarding erasure codes. I never used Ceph before or any=
 other distributed file system.
>=20
> I stumped upon the suggestion for adding erasure codes to Ceph, as
> described in this article
> http://wiki.Ceph.com/01Planning/02Blueprints/Dumpling/Erasure_encoding_=
as_a_storage_backend
>=20
> first I would like to say great initiative to add erasure codes to Ceph=
=2E
> Ceph needs its own implementation and it have to be done right, I canno=
t stress this enough, suggested software mentioned in that article would =
result in very low performance.
>=20
> Why?
> Reed-Solomon is normally something regarded as being very slow compared=
 to other erasure codes, because the underlying Galois-Field multiplicati=
on is slow. Please see video at usenix.org forexplanation.
>=20
> The implementations of Zfec library and other suggested software the ot=
hers rely on the Vandermonde matrix, a matrix used in in Reed-Solomon era=
sure codes, a faster approach would be to use the Cauchy-Reed-Solomon imp=
lementation. Please see [1,2,3]
> Although there is something even better, by using the Intel SSE2/3 SIMD=
 instructions it is possible to do the as fast as any other XOR based era=
sure codes (RaptorQ LT-codes, LDPC etc.).
>=20
> The suggested FECpp lib uses the optimisation but with a relative small=
 Galois-field only 2^8, since Ceph aimes at unlimited scalability increas=
ing the size of the Galois-Field would improve performance [4]. Of course=
 the configured Ceph Object Size and/or Stripe width have to be taken int=
o account.
> Please see
> https://www.usenix.org/conference/fast13/screaming-fast-galois-field-ar=
ithmetic-using-sse2-extensions
>=20
>=20
> The solution
> Using the GF-Complete open source library [4] to implement Reed-Solomon=
 in Ceph in order to allow Ceph to scale to infinity.
> James S. Plank the author of GF-complete have developed a library imple=
menting various Reed-Solomon codes called Jerasure. http://web.eecs.utk.e=
du/~plank/plank/www/software.html
> Jerasure 2.0 using the GF-complete artimetric based in Intel SSE SIMD i=
nstructions, is current in development expected release august 2013. Will=
 be released under the new BSD license. Jerasure 2.0 also supports arbitr=
ary Galois-field sizes 8,16,32,64 or 128 bit.
>=20
> The limit of this implementation would be the processors L2/L3 cache no=
t the underlying arithmetic.=20
>=20
> Best Regards
> Martin Flyvbjerg
>=20
> [1] http://web.eecs.utk.edu/~plank/plank/papers/CS-05-569.pdf
> [2] http://web.eecs.utk.edu/~plank/plank/papers/CS-08-625.pdf
> [3] http://web.eecs.utk.edu/~plank/plank/papers/FAST-2009.pdf
> [4] http://web.eecs.utk.edu/~plank/plank/papers/FAST-2013-GF.pdf
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

--=20
Lo=C3=AFc Dachary, Artisan Logiciel Libre
All that is necessary for the triumph of evil is that good people do noth=
ing.



--------------enigEC48EF01276969971219C059
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iEYEARECAAYFAlG7n8MACgkQ8dLMyEl6F23k+wCeNws7LW0bJ2gk9/uzI0+5Ivja
aQ0AoJnhAWWFWtL9RMBuvXJ8wIeWIVfB
=rZCc
-----END PGP SIGNATURE-----

--------------enigEC48EF01276969971219C059--
