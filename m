From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: Undefined Ref for simple prog
Date: Thu, 3 Dec 2015 18:08:14 -0500
Message-ID: <20151203230814.GC17144@ultraspiritum.redhat.com>
References: <CAANLjFrbaa=wC=9tk9_w_ROxDF-yityFNRf=zBkrb6b0gA0gmg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="JWEK1jqKZ6MHAcjA"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:44224 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751873AbbLCXIQ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 3 Dec 2015 18:08:16 -0500
Content-Disposition: inline
In-Reply-To: <CAANLjFrbaa=wC=9tk9_w_ROxDF-yityFNRf=zBkrb6b0gA0gmg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Robert LeBlanc <robert@leblancnet.us>
Cc: ceph-devel <ceph-devel@vger.kernel.org>


--JWEK1jqKZ6MHAcjA
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03/12/2015, Robert LeBlanc wrote:
> I'm trying to do some testing of Ceph components specifically around
> the OP queues. I'm trying to use the class in a simple program where I
> will do my testing, but I can't resolve one problem. I've had to
> include  types.h as forward defining the Formatter class (already
> included/forward defined in the base class). This is based on my PR
> https://github.com/ceph/ceph/pull/6781 .

Ceph's assert is infelicitous. The libcommon static library
has the definitions in src/common/assert.cc. It depends on other
things, though, so the easiest thing to do, if you're using autotools, is j=
ust
to add a target to one of the Makefile.am scripts (probably in src/test)
that uses CEPH_GLOBAL as its library. If you just copy and modify one
of the targets for the binary tests, your program will get built as part of=
 the
unittests target.

(You'll have to build src/gmock and src/gmock/gtest manually to call make
unittests on its own.)

If you're using cmake, it's simpler. Just copy one of the
add_executable/target_link_libraries pairs in src/test/CMakeLists.txt and m=
odify
as appropriate. Your executable will be built as part of the default CMake
target.

--=20
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9

--JWEK1jqKZ6MHAcjA
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQF8BAEBCgBmBQJWYMtaXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXREMUY1QjNFRjgyQTI1NjIxNkVERDQxQUNF
OEIyRUY4QzA3NUU1RTIzAAoJEOiy74wHXl4jWCYIAKb525KFeUBHI5PGqR9TFPJS
cW//qV0nupKmZmH36ZLDKzp/KXRag64lwxXtt2F0/DoNlNz3LCL6sgD3Q/qeqGCA
OuTwFPnAy/AW2matlgqGY/jWGupxNj0v09Q/gDgm+AqgbJ/HcQDKG1ur8OaCJ3NN
gW+8JVq2mWoj/6oxzD3q7bO7sNfIjLxOAmCShqGh/LAkAdOX88cXj7pjy8cgRDKB
Ha3iL9kGt7IM+mj5zoyYC0WIshbwv67HUP1MTi8tJz53bQeLs2ZYDD+aWrEcdANZ
PHZVDp0+8uwccDga0FQ0h7hCw+W8+mSvW9RBbnzqM7zuuHduFVsMstSULOHBABg=
=OIS6
-----END PGP SIGNATURE-----

--JWEK1jqKZ6MHAcjA--
