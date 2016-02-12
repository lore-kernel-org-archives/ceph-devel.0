From: "Adam C. Emerson" <aemerson@redhat.com>
Subject: Re: New Defects reported by Coverity Scan for ceph
Date: Fri, 12 Feb 2016 11:36:03 -0500
Message-ID: <20160212163603.GA15079@ultraspiritum.redhat.com>
References: <56bccb71750ff_105ef2d3209258f@ss1435.mail>
 <CAJ4mKGbhV28AW=tiavCw1STFiP_kgHinFVF21sR-3C-8x_sMPw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="+HP7ph2BbKc20aGI"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:45721 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751453AbcBLQgG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 12 Feb 2016 11:36:06 -0500
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
	by mx1.redhat.com (Postfix) with ESMTPS id 07E9BC0A9CC0
	for <ceph-devel@vger.kernel.org>; Fri, 12 Feb 2016 16:36:06 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAJ4mKGbhV28AW=tiavCw1STFiP_kgHinFVF21sR-3C-8x_sMPw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 11/02/2016, Gregory Farnum wrote:
> So if I'm reading the samples changes here correctly, we seem to have
> a bunch of new warnings around the lock changes? Is this something we
> should be resolving in the lock users, or whitelisting, or fixing
> lower down in the stack?

In this case:

> > 320           return tu;
> > 321         } else if (m =3D=3D nullptr) {
> > 322           return unique_lock_type();
> > 323         }
> > 324         throw std::system_error((int)std::errc::operation_not_permi=
tted,
> > 325                                 std::generic_category());
> >>>>     CID 1352097:  Control flow issues  (UNREACHABLE)
> >>>>     This code cannot be reached: "return ceph::shunique_lock<...".
> > 326         return unique_lock_type();
> > 327       }

This is harmless. It's true that it won't ever be reached, but the function=
 has
a return type and so has to return something. I could rewrite it so we chec=
k for
the error case explicitly and fail then and return something in the non-mar=
ked
case, but as a matter of good design I think it's better in cases like this=
 to
explicitly handle the /good/ cases and fail on everything else.

> >>>>     CID 1352096:    (UNCAUGHT_EXCEPT)
> >>>>     In function "main(int, char **)" an exception of type "boost::ex=
ception_detail::clone_impl<boost::exception_detail::error_info_injector<std=
::ios_base::failure> >" is thrown and never caught.

This is just something in the Boost library. The standard library's
shared_lock will throw an exception under similar circumstances. It's not
really an issue since they only get thrown on things like calling lock
on a unique_ or shared_lock that already owns a lock. Things that you
can rule out fairly easily by how you write a function but the compiler
can't check them for you (unless we rewrite Ceph in Rust.)

I think this one ought to be whitelisted since it's an issue in the library=
 that
will only end up with terminate being called if there's a seriosu bug in the
program. (The kind of thing that really /ought/ to make it crash.)

--=20
Senior Software Engineer           Red Hat Storage, Ann Arbor, MI, US
IRC: Aemerson@{RedHat, OFTC, Freenode}
0x80F7544B90EDBFB9 E707 86BA 0C1B 62CC 152C  7C12 80F7 544B 90ED BFB9

--+HP7ph2BbKc20aGI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQF8BAEBCgBmBQJWvgnuXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXREMUY1QjNFRjgyQTI1NjIxNkVERDQxQUNF
OEIyRUY4QzA3NUU1RTIzAAoJEOiy74wHXl4jl2EIAJzCgrByP6NeDdAbyBXh2FXM
Zq6w0XILGexrxXgsG44bX+D/LAtdVP/KzXtXsoopXSW7aO9r0YXLd0qg4bWCNN1X
w97IOEc0zFOv+XEZWX4HOgLUyQtezutNaUrBpeCDF0UPZn/LgcYy+WKFjA8nBLiQ
bRMPMQIyWumdPNxpTwSHFO/tm6RZV0Vi+m+YEDnIPIo3s//6e3m01GRJ0h5yYkZx
VIUhze4/8Qjfv7bi+NFPC93SJOkmKKvsRudNgArCcdPVuJPKNYNsDU1bV+Io0ivS
u+39ZgxrRqvyT+Md4FxnFJJ4mlk0NcIj+G7uyyiYSZsWoCAzO5Oyv1GIjxam8Jc=
=yBVs
-----END PGP SIGNATURE-----

--+HP7ph2BbKc20aGI--
