From: Dimitri Maziuk <dmaziuk@bmrb.wisc.edu>
Subject: Re: handling fs errors
Date: Tue, 22 Jan 2013 12:29:13 -0600
Message-ID: <50FEDA79.2090203@bmrb.wisc.edu>
References: <alpine.DEB.2.00.1301212200031.29915@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig26E5B191A4AE69892B7F8AD8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cowfish.bmrb.wisc.edu ([144.92.167.220]:38984 "EHLO
	mail.bmrb.wisc.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752198Ab3AVS3O (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 22 Jan 2013 13:29:14 -0500
Received: from stingray.bmrb.wisc.edu (stingray.bmrb.wisc.edu [144.92.167.179])
	by mail.bmrb.wisc.edu (Postfix) with ESMTP id B11992C010D
	for <ceph-devel@vger.kernel.org>; Tue, 22 Jan 2013 12:29:13 -0600 (CST)
In-Reply-To: <alpine.DEB.2.00.1301212200031.29915@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig26E5B191A4AE69892B7F8AD8
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 01/22/2013 12:05 AM, Sage Weil wrote:
> We observed an interesting situation over the weekend.  The XFS volume =

> ceph-osd locked up (hung in xfs_ilock) for somewhere between 2 and 4=20
> minutes.
=2E..

FWIW I see this often enough on cheap sata drives: they've a failure
mode that makes sata driver timeout, reset the link, resend the command,
rinse, lather, repeat. (You usually get "slow to respond, please be
patient" and/or "resetting link" in syslog & console.) It's at the low
enough level to freeze the whole system for minutes.

--=20
Dimitri Maziuk
Programmer/sysadmin
BioMagResBank, UW-Madison -- http://www.bmrb.wisc.edu


--------------enig26E5B191A4AE69892B7F8AD8
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.14 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org/

iD8DBQFQ/tp5xzG8ttqkbbgRAmJgAKDI80cZe/rleUIOPCurF0suJen33wCgkxZY
X1B58j77HM1YfNtGcrSRJPI=
=9qi2
-----END PGP SIGNATURE-----

--------------enig26E5B191A4AE69892B7F8AD8--
