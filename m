From: Tilman Beitter <beitter@b1-systems.de>
Subject: Re: Initial Setup - Chef hangs at "in New OSD"
Date: Thu, 27 Sep 2012 09:35:06 +0200
Message-ID: <506401AA.40403@b1-systems.de>
References: <S1755227Ab2IXIkt/20120924084049Z+524@vger.kernel.org> <506032AF.9040909@b1-systems.de> <CAPYLRzhu+7BqBCc5WpkWpNDx0wv=FsT_BVp+-RGsB6ntpJV52Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig77586D932035D5DA5A37C6D2"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.b1-systems.de ([217.11.58.35]:37085 "EHLO mx1.b1-systems.de"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755646Ab2I0HfM (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 27 Sep 2012 03:35:12 -0400
Received: from [10.1.10.10] (p57B035FC.dip.t-dialin.net [87.176.53.252])
	by mx1.b1-systems.de (Postfix) with ESMTPSA id A55A64092
	for <ceph-devel@vger.kernel.org>; Thu, 27 Sep 2012 09:35:10 +0200 (CEST)
In-Reply-To: <CAPYLRzhu+7BqBCc5WpkWpNDx0wv=FsT_BVp+-RGsB6ntpJV52Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig77586D932035D5DA5A37C6D2
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 09/24/2012 06:52 PM, Gregory Farnum wrote:
> Hmmm...this is probably an issue with SUSECloud setup rather than Ceph
> itself (and we don't know how SUSECloud works). But it looks like it's
> hanging while running "ceph osd tree", which means it's likely a
> problem somewhere in connecting or getting an answer from the
> monitors.
> 1) See if you have all your monitors running.
> 2) See if you can run "ceph -s -k <path/to/admin/keyring>" on one of
> your monitors and get a response.
> 3) See if you can run "ceph -s <path/to/ndoe/keyring>" on the host
> that is stuck.
> 4) See what's output from "ceph osd tree" on the monitor node.

thanks for the tips. I will check this with my next test setup.

greets
Til


--------------enig77586D932035D5DA5A37C6D2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iEYEARECAAYFAlBkAa4ACgkQ1twG6+QYyOXGzgCg14PjTy+J8luyTL9CnDdv6txA
fioAn27CSYZWUc17RW1ahn1wKfGIrbPs
=1zTM
-----END PGP SIGNATURE-----

--------------enig77586D932035D5DA5A37C6D2--
