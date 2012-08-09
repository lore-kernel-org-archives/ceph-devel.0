From: Matthew Richardson <m.richardson@ed.ac.uk>
Subject: Re: Ceph RBD performance - random writes
Date: Thu, 09 Aug 2012 15:48:50 +0100
Message-ID: <5023CDD2.6040307@ed.ac.uk>
References: <5021F6D1.7000004@catalyst.net.nz>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enig804B3C354ABDCFB3B2491CB0"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from nougat.ucs.ed.ac.uk ([129.215.13.205]:38523 "EHLO
	nougat.ucs.ed.ac.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293Ab2HIPYL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Aug 2012 11:24:11 -0400
Received: from lmtp1.ucs.ed.ac.uk (lmtp1.ucs.ed.ac.uk [129.215.149.64])
	by nougat.ucs.ed.ac.uk (8.13.8/8.13.4) with ESMTP id q79EmoXT024903
	for <ceph-devel@vger.kernel.org>; Thu, 9 Aug 2012 15:48:52 +0100 (BST)
Received: from [129.215.183.3] (pcw3047.see.ed.ac.uk [129.215.183.3])
	(authenticated user=mrichar1 mech=PLAIN bits=0)
	by lmtp1.ucs.ed.ac.uk (8.13.8/8.13.7) with ESMTP id q79Emo8B028301
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NOT)
	for <ceph-devel@vger.kernel.org>; Thu, 9 Aug 2012 15:48:50 +0100 (BST)
In-Reply-To: <5021F6D1.7000004@catalyst.net.nz>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig804B3C354ABDCFB3B2491CB0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 08/08/12 06:19, Mark Kirkwood wrote:
> I've been looking at using Ceph RBD as a block store for database use.
> As part of this I'm looking a how (particularly random) IO of smallish
> (4K, 8K) block sizes performs.

It may or may not be related, but have a look at the message thread here:=


http://www.mail-archive.com/ceph-devel@vger.kernel.org/msg07678.html

It looks like there might be a specific bug relating to random writes.

Matthew

--=20
The University of Edinburgh is a charitable body, registered in
Scotland, with registration number SC005336.


--------------enig804B3C354ABDCFB3B2491CB0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iEYEARECAAYFAlAjzdIACgkQRWpi1WYCQdKpkwCfXlskKRT0wqZw1ClBoC5m2wZ2
wm0AoJm6/pCsJ89OKNVm2MLDWVTdyUOL
=h8Z4
-----END PGP SIGNATURE-----

--------------enig804B3C354ABDCFB3B2491CB0--
