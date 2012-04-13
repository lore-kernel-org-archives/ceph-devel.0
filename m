From: Danny Kukawka <danny.kukawka@bisect.de>
Subject: Re: Kernel crashes with RBD
Date: Fri, 13 Apr 2012 20:18:49 +0200
Message-ID: <4F886E09.7040801@bisect.de>
References: <4F860619.5040802@bisect.de> <4F88670A.7080709@dreamhost.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigF5BB69E8F5DFAF5EEDADDDC1"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:41017 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751033Ab2DMSTE (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Fri, 13 Apr 2012 14:19:04 -0400
In-Reply-To: <4F88670A.7080709@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Josh Durgin <josh.durgin@dreamhost.com>, Alex Elder <elder@dreamhost.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigF5BB69E8F5DFAF5EEDADDDC1
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi

Am 13.04.2012 19:48, schrieb Josh Durgin:
> On 04/11/2012 03:30 PM, Danny Kukawka wrote:
[...]
>=20
> This looks similar to http://tracker.newdream.net/issues/2261. What do
> you think Alex?

Not sure about that, since this crashes only the clients and not the
OSDs. We see no crashes in the cluster.

I analyzed it a bit more and found that the last working version was
0.43. Any later released version leads to this crash sooner or later,
but as I already said only on a 10Gbit (FC) network. I didn't see any
crash on the 1Gbit net on the same machines.

What kind of network do you use at dreamhost for testing?

If you need more info, let me known.

Danny


--------------enigF5BB69E8F5DFAF5EEDADDDC1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.18 (GNU/Linux)

iJwEAQECAAYFAk+IbhMACgkQ9DHLX79LmTLh8gQAiDhGMOfwpztK7CWQ9nvPaeck
CJl/PnVuZHKgr1eJpKzDhcExAOXgMdZUXbCBXk5NQhaCZlVSXmVPj8cIBxstAsBz
ByfgKWPKtI0kIR2HZScu2zELn3KC/Ne+Gpqat0ABxXJVcFP6SyffQdbL0lADNCww
t06t2oRPgcX/4w9icg0=
=r2wg
-----END PGP SIGNATURE-----

--------------enigF5BB69E8F5DFAF5EEDADDDC1--
