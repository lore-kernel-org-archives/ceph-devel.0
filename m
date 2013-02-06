From: Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>
Subject: Re: rest mgmt api
Date: Wed, 06 Feb 2013 13:51:25 -0600
Message-ID: <5112B43D.6070602@bmrb.wisc.edu>
References: <alpine.DEB.2.00.1302051452200.27331@cobra.newdream.net> <CAC-hyiFPcjXBYr8Wd8YWEk0aBmpM_1smPNktyA5FHVMac8Ji0A@mail.gmail.com> <5112AE17.6080605@inktank.com> <alpine.DEB.2.00.1302061130220.13326@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigEF10B38AB529A1F3710E6CC0"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cowfish.bmrb.wisc.edu ([144.92.167.220]:35164 "EHLO
	mail.bmrb.wisc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758311Ab3BFTv0 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Feb 2013 14:51:26 -0500
In-Reply-To: <alpine.DEB.2.00.1302061130220.13326@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigEF10B38AB529A1F3710E6CC0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/06/2013 01:34 PM, Sage Weil wrote:

> I think the one caveat here is that having a single registry for comman=
ds=20
> in the monitor means that commands can come in two flavors: vector<stri=
ng>=20
> (cli) and URL (presumably in json form).  But a single command=20
> dispatch/registry framework will make that distinction pretty simple...=


Any reason you can't have your CLI json-encode the commands (or,
conversely, your cgi/wsgi/php/servlet URL handler decode them into
vector<string>) before passing them on to the monitor?

--=20
Dimitri Maziuk
Programmer/sysadmin
BioMagResBank, UW-Madison -- http://www.bmrb.wisc.edu


--------------enigEF10B38AB529A1F3710E6CC0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFRErQ9xzG8ttqkbbgRAswSAJ4jXo6Kqx3NHn4SeBxHNipf3zwmmACgrxSm
1fDBtw6e1M9ojRPLIJui9xs=
=g/6d
-----END PGP SIGNATURE-----

--------------enigEF10B38AB529A1F3710E6CC0--
