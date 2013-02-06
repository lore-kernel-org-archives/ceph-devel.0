From: Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>
Subject: Re: rest mgmt api
Date: Wed, 06 Feb 2013 16:20:19 -0600
Message-ID: <5112D723.3030500@bmrb.wisc.edu>
References: <alpine.DEB.2.00.1302051452200.27331@cobra.newdream.net> <CAC-hyiFPcjXBYr8Wd8YWEk0aBmpM_1smPNktyA5FHVMac8Ji0A@mail.gmail.com> <5112AE17.6080605@inktank.com> <alpine.DEB.2.00.1302061130220.13326@cobra.newdream.net> <5112B43D.6070602@bmrb.wisc.edu> <alpine.DEB.2.00.1302061211550.13326@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig2C89BAB72CF77CE3FF345652"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cowfish.bmrb.wisc.edu ([144.92.167.220]:35625 "EHLO
	mail.bmrb.wisc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1755931Ab3BFWUU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 6 Feb 2013 17:20:20 -0500
Received: from stingray.bmrb.wisc.edu (stingray.bmrb.wisc.edu [144.92.167.179])
	by mail.bmrb.wisc.edu (Postfix) with ESMTP id 2C3932C010F
	for <ceph-devel@vger.kernel.org>; Wed,  6 Feb 2013 16:20:20 -0600 (CST)
In-Reply-To: <alpine.DEB.2.00.1302061211550.13326@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig2C89BAB72CF77CE3FF345652
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 02/06/2013 02:14 PM, Sage Weil wrote:
> On Wed, 6 Feb 2013, Dimitri Maziuk wrote:

>> Any reason you can't have your CLI json-encode the commands (or,
>> conversely, your cgi/wsgi/php/servlet URL handler decode them into
>> vector<string>) before passing them on to the monitor?
>=20
> We can, but they won't necessarily look the same, because it is unlikel=
y=20
> we can make a sane 1:1 translation of the CLI to REST that makes sense,=
=20
> and it would be nice to avoid baking knowledge about the individual=20
> commands into the client side.
>=20
>  ceph osd pool create <poolname> <numpgs>
>    vs
>  /osd/pool/?op=3Dcreate&poolname=3Dfoo&numpgs=3Dbar
>=20
> or whatever.  I know next to nothing about REST API design best practic=
es,=20
> but I'm guessing it doesn't look like a CLI.

(Last I looked "?op=3Dcreate&poolname=3Dfoo" was the Old Busted CGI, The =
New
Shiny Hotness(tm) was supposed to look like "/create/foo" -- and I never
understood how the optional parameters are supposed to work. But that's
beside the point.)

To me you sounded like you the piece that actually does the work
(daemon?) should understand both (and have a built-in httpd on top).
What I meant is it should know just one and let the UI modules do the
translation.

--=20
Dimitri Maziuk
Programmer/sysadmin
BioMagResBank, UW-Madison -- http://www.bmrb.wisc.edu


--------------enig2C89BAB72CF77CE3FF345652
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFREtckxzG8ttqkbbgRAhb+AJ4orvYp5mZyHVA6fcGP+j76iTWuywCeLecV
UMw7syP62p2PPAShwMAI6BM=
=bGp3
-----END PGP SIGNATURE-----

--------------enig2C89BAB72CF77CE3FF345652--
