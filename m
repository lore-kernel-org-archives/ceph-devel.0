From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: inconsistent rados semantics between automake/cmake builds
Date: Thu, 21 Jan 2016 12:03:05 -0500
Message-ID: <20160121170305.GA32590@ultraspiritum.redhat.com>
References: <CAB2gnbUxzE7z6ec39=cPg2sqNOtMc6cS8_GN9ybxxdvB7zXW+g@mail.gmail.com>
 <CADRKj5RFKdLWWAaWg1EtTtJB+g3FigoEm3=xJ2+FCostq7fp4A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="SLDf9lqlvOQaIe6s"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:41030 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1759882AbcAURDH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 21 Jan 2016 12:03:07 -0500
Content-Disposition: inline
In-Reply-To: <CADRKj5RFKdLWWAaWg1EtTtJB+g3FigoEm3=xJ2+FCostq7fp4A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: Noah Watkins <noahwatkins@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, Casey Bodley <cbodley@redhat.com>, Orit Wasserman <owasserm@redhat.com>


--SLDf9lqlvOQaIe6s
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 21/01/2016, Yehuda Sadeh-Weinraub wrote:
[snip]
> This sounds somewhat like an issue Casey and Orit had seen, one that I
> wasn't able to replicate (both of them are using cmake, I'm using
> automake). I think they tracked it to Adam's c++11 time change.
[snip]

I was thinking about this the other night. There doesn't seem to be any pro=
blem
with the actual /read/ that I can find. (There'd be failures in stat all ov=
er
the place.)

But I recalled that Objecter allows you to specify the mtime for operations=
 and
thought perhaps that might be where the problem is. If we know what operati=
on is
creating/last touching these objects, can someone who's able to reproduce t=
he
problem run a cycle or two of it through valgrind? It might be feeding in a
not-properly-initialized time value, and if this shows up under one build s=
ystem
but not another that feels like it could be a touch more likely.

--=20
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9

--SLDf9lqlvOQaIe6s
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQF8BAEBCgBmBQJWoQ9DXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXREMUY1QjNFRjgyQTI1NjIxNkVERDQxQUNF
OEIyRUY4QzA3NUU1RTIzAAoJEOiy74wHXl4jNZcH/2Zy0ySplQKpNcTRWoG0CJqU
/d/UFyy5QEhtCtsUPu/lDa3jtTW2E5hiROUBFB/rYkNbB5AT3DXkzsQRB2zXK+3k
2KT67uDUY9slxzGrqC9jSZqzUe7L0wctn1XgysRjHlqVrpJ2AGEexElmyxEHNOgL
GpS1G6JkTOSZ3kmtejVpQf+yQ/frHmniEzUDNUF8XhV9mfOXsKUqFbRo8BDxrr8q
C/kjQSe0kYpv4DfJLV31QieIs+0eKoRVe33Dc69wcZC8raS2H2wru7HlDueo7GK5
XO9QAUIpqHWKoT9+mLApZ1db5xn1+PFrhmEeMXNCCjNKPg1M62FnlZcfWOVQZ2c=
=ldgn
-----END PGP SIGNATURE-----

--SLDf9lqlvOQaIe6s--
