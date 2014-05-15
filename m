From: Thorsten Behrens <tbehrens@suse.com>
Subject: Re: A plea for more tooling usage
Date: Fri, 16 May 2014 01:34:31 +0200
Message-ID: <20140515233431.GS13333@thinkpad.thebehrens.net>
References: <20140506134826.GA17004@trvx.org>
 <alpine.DEB.2.00.1405060816160.28165@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="RtGa12sjXv8gVUZO"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:48432 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750916AbaEOX74 (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Thu, 15 May 2014 19:59:56 -0400
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.00.1405060816160.28165@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Daniel Hofmann <daniel@trvx.org>, ceph-devel@vger.kernel.org


--RtGa12sjXv8gVUZO
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Sage Weil wrote:
> If anybody is interested in helping with that effort, pull requests
> are very welcome!  :)
>=20
Here goes: https://github.com/ceph/ceph/pull/1814

I'm not sure though I like what I did, this macro magic is slightly
over-verbose, and even clang error messages are not overly helpful,
should one get something wrong around there.

As hinted at in the patch, something like boost::program_options would
be nice, but that's a chunk of work & I'd rather hear feedback first
this way or the other. For the boost option, not sure if verbose error
reporting (the if (oss) parts) would translate over easily, I presume
that is deemed important?

Another pending fix in my fork, is consolidating the spelling of long
args in the code (majority uses dash as word separator, minority
underscore). That conflicts badly with the ceph_argparse_flag() change
of course, thus unsubmitted & curious about your feedback for the
while. Again, retaining acceptance of both spellings is probably
mandatory? ;)

Cheers,

--=20

Thorsten Behrens

SUSE LINUX Products GmbH, Maxfeldstr. 5, 90409 N=FCrnberg; GF: Jeff
Hawn, Jennifer Guild, Felix Imend=F6rffer, HRB 16746 (AG N=FCrnberg)

--RtGa12sjXv8gVUZO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQJ8BAEBCgBmBQJTdU8HXxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRDREI0NTE4NDRDMTFEMjY1NDlFM0FCNzgx
QzE2REZEQjMwRjRGNERGAAoJEBwW39sw9PTfE6AP/RbjmyMw3Ctk3I6wTsP9Z4b2
bqP3i32c/KDqfhcqxocB0yV9GAQXuV92fcpk9T7k0A1pOkMZpoqWZoAohAQfY71I
DBKjyvoXM9NzzpJ77/0PnJTrjjKi8xa01IIcSg2KfuXqUTdFPwjWyp+EDyH1WgrK
Cz5bjK5Kcm5f/ciX1CRpZ1Nn99y/V3YqjY9X6GTIzjxvgYAlgBv74wyCXyeYHcYJ
+hfDfL4dKFGAygrsqKT9D/4ixOJsaOvrGlhetF6aK8ocY0mlR3Xw6O2AewSpG0dP
Amu9H5A0TTY8ZyUrXXDSsykoIxWX8n4biliRTKrcqqgNrPCwm8JMJd6d+hwJMG/p
TQEAWlnvDWGoGM7BuwGmlfuTK0Juq1PL/fBMXmcGzfhLcjIN7JN561HYmpRhNV0U
13uQMqfYSZ6i+Wq4GuR0ym7NATbZtmho2HNWycNIHBcKEgkqunu1JMtt5vcE5cBt
+vG+CRkfTnkMdibnBMyGrFtgwBBr4qAHEB2nDxG4Yg0cVsQbFQACIVno2VBerO1N
gxuP/OnjXa7zAU8F7vdl8hzGbUDkaTlrIWjlTDQGYcExKRiduM+BGvfgtsnnwUuk
DXQf2eZDtYeiCc7P2y3zsaYNu5ykKCg6DonD76a61X7JMmy7vJVeRInlfslnTNdn
C6vzLRzp7WWnL9ozcqSG
=Ggey
-----END PGP SIGNATURE-----

--RtGa12sjXv8gVUZO--
