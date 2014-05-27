From: Thorsten Behrens <tbehrens@suse.com>
Subject: Re: A plea for more tooling usage
Date: Wed, 28 May 2014 00:19:35 +0200
Message-ID: <20140527221935.GA15288@thinkpad.thebehrens.net>
References: <20140506134826.GA17004@trvx.org>
 <alpine.DEB.2.00.1405060816160.28165@cobra.newdream.net>
 <20140515233431.GS13333@thinkpad.thebehrens.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="KAk/33nSS6LK84p9"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.emea.novell.com ([130.57.118.101]:36517 "EHLO
	mail.emea.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753323AbaE0WWm (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Tue, 27 May 2014 18:22:42 -0400
Content-Disposition: inline
In-Reply-To: <20140515233431.GS13333@thinkpad.thebehrens.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Danny Al-Gaaf <danny.al-gaaf@bisect.de>
Cc: ceph-devel@vger.kernel.org


--KAk/33nSS6LK84p9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I wrote:
> Sage Weil wrote:
> > If anybody is interested in helping with that effort, pull requests
> > are very welcome!  :)
> >=20
[snip]

> As hinted at in the patch, something like boost::program_options would
> be nice, but that's a chunk of work & I'd rather hear feedback first
> this way or the other. For the boost option, not sure if verbose error
> reporting (the if (oss) parts) would translate over easily, I presume
> that is deemed important?
>=20
Hi guys,

any further opinion on that? If no one feels strongly, I think I'll
just go ahead & hack something up with program_options, and see if
that looks more pleasant. :)

Cheers,

-- Thorsten

--KAk/33nSS6LK84p9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQJ8BAEBCgBmBQJThQ93XxSAAAAAAC4AKGlzc3Vlci1mcHJAbm90YXRpb25zLm9w
ZW5wZ3AuZmlmdGhob3JzZW1hbi5uZXRDREI0NTE4NDRDMTFEMjY1NDlFM0FCNzgx
QzE2REZEQjMwRjRGNERGAAoJEBwW39sw9PTf9fQQAIxqKxv4SzJDbOvwrlZbABXZ
Yj2vMYp3bHSvasBcUMcMSutUm00ADl0NreytyV9QceTGK1bdsn21MFYskaUX0jQD
z3i0c3FpkQFWRrAWu1mLJVHPVoSOQZt1lDl5Ji6/pBrcrIjy+4R1d4pSwHkHDyw7
ySyDn7LRTjwH1/2wT9YMox7G1ddhC84tNegx0+hY6Gt+2i949TATesZQPSnzmMja
Kl9DKovUPs4/EuRdiZAOrir7m3A3iBYyq965v6MbTgU93dk9v7Id3Q65ek/vazxk
hCwSx9ndR9sB9XfBAGT/6MQFBIVaOXLMbNEdYCJ2kAEz2v8Xd9Ws4i4XJtFAFEAY
H53RC3tSqH1QQsFFb3bMFQSHdlLwMiAoqHEFr5RssE0o4KtmRJVpup10xGhnZPBe
T5CCz4IWLroj05ZDqjProq2DgDbyJ7q9XYLPlL+JPh6YqdrS8D/WPGkdXhUFitPH
AnMNH8RtiFl6+pwZaelcyKrg9A2tSNYCCWF20cY96/g0eOrN3aR3tsIIJMl9+xvy
R1J2+i2u6TllEKIc8WUG4twoEzrl5Noj9oE9F09H9HPX0Di/k5PjXGej5e5PbMSE
hSi282tMoN/s7JucqBzex/81Z4aAKP/lgPk/qYt1kdfXXhv+eJSBWslufWe6wFev
u+BSbzHlbxoy4zpej175
=BBEy
-----END PGP SIGNATURE-----

--KAk/33nSS6LK84p9--
