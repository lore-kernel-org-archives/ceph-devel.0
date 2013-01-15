From: Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>
Subject: Re: Grid data placement
Date: Tue, 15 Jan 2013 13:00:23 -0600
Message-ID: <50F5A747.2060404@bmrb.wisc.edu>
References: <50F59431.3000401@bmrb.wisc.edu> <CAPYLRzhZdP6ehio9MgOZ7VnPSnMa05NUPmaRG3D_+tmWhe+oYA@mail.gmail.com> <50F5A116.4090607@bmrb.wisc.edu> <CAPYLRzgP8iKxD69+D_S7TtWUsre=y5JF51yWJDoMFHSUufJNQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2F27C24066E15C2210597D58"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cowfish.bmrb.wisc.edu ([144.92.167.220]:45396 "EHLO
	mail.bmrb.wisc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757782Ab3AOTAY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 Jan 2013 14:00:24 -0500
Received: from stingray.bmrb.wisc.edu (stingray.bmrb.wisc.edu [144.92.167.179])
	by mail.bmrb.wisc.edu (Postfix) with ESMTP id A05AB2C00EF
	for <ceph-devel@vger.kernel.org>; Tue, 15 Jan 2013 13:00:23 -0600 (CST)
In-Reply-To: <CAPYLRzgP8iKxD69+D_S7TtWUsre=y5JF51yWJDoMFHSUufJNQg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2F27C24066E15C2210597D58
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/15/2013 12:36 PM, Gregory Farnum wrote:
> On Tue, Jan 15, 2013 at 10:33 AM, Dimitri Maziuk <dmaziuk@bmrb.wisc.edu=
> wrote:

>> At the start of the batch #cores-in-the-cluster processes try to mmap
>> the same 2GB and start reading it from SEEK_SET at the same time. I
>> won't know until I try but I suspect it won't like that.
>=20
> Well, it'll be #servers-in-cluster serving up 4MB chunks out of cache.
> It's possible you could overwhelm their networking but my bet is
> they'll just get spread out slightly on the first block and then not
> contend in the future.

In the future the application spreads out the reads as well: running
instances go through the data at different speed, and when one's
finished, the next one starts on the same core & it mmap's the first
chunk again.

> Just as long as you're thinking of it as a test system that would make
> us very happy. :)

Well, IRL this is throw-away data generated at the start of a batch, and
we're good if one batch a month runs to completion. So if it doesn't
crash all the time every time, that actually should be good enough for
me. However, not all of the nodes have spare disk slots, so I couldn't
do a full-scale deployment anyway, not without rebuilding half the nodes.=


--=20
Dimitri Maziuk
Programmer/sysadmin
BioMagResBank, UW-Madison -- http://www.bmrb.wisc.edu


--------------enig2F27C24066E15C2210597D58
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFQ9adHxzG8ttqkbbgRAlMYAJ9FanjGa3skqD3PTnAAE/j4RobaGwCeK8hs
J6jmshLsKRr/z0+u6l/5nus=
=wVPC
-----END PGP SIGNATURE-----

--------------enig2F27C24066E15C2210597D58--
