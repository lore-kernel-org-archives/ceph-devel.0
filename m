From: Eric Blake <eblake@redhat.com>
Subject: Re: [libvirt] [PATCH v2] add network disk support
Date: Thu, 09 Dec 2010 14:31:22 -0700
Message-ID: <4D014AAA.2070502@redhat.com>
References: <20101202131928.GV2502@redhat.com>	<1291620249-19645-1-git-send-email-morita.kazutaka@lab.ntt.co.jp>	<20101209110925.GA5313@redhat.com> <4D012A6D.3080602@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="------------enig417B3CE155CFEEBECF5E96D6"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:31257 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1756915Ab0LIVbg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Thu, 9 Dec 2010 16:31:36 -0500
In-Reply-To: <4D012A6D.3080602@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
Cc: "Daniel P. Berrange" <berrange@redhat.com>, libvir-list@redhat.com, ceph-devel@vger.kernel.org, sheepdog@lists.wpkg.org, MORITA Kazutaka <morita.kazutaka@lab.ntt.co.jp>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enig417B3CE155CFEEBECF5E96D6
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

On 12/09/2010 12:13 PM, Eric Blake wrote:
> On 12/09/2010 04:09 AM, Daniel P. Berrange wrote:
>> On Mon, Dec 06, 2010 at 04:24:09PM +0900, MORITA Kazutaka wrote:
>>> This patch adds network disk support to libvirt/QEMU.  The currently
>>> supported protocols are nbd, rbd, and sheepdog.  The XML syntax is li=
ke
>>> this:
>>>
>=20
>> ACK
>=20
> NACK.  After applying this patch, I get 'make check' failures:
>=20
> TEST: vmx2xmltest
>       /bin/sh: line 5: 15285 Segmentation fault      (core dumped)

Weird.  After 'make clean', I was no longer able to reproduce the
failure; I then did a complete fresh checkout to verify on a pristine
tree.  I must have had some bad cruft lying around in my tree, and
wonder what it was about your patch to expose that cruft?

At any rate, given that your patch does not fail after all, I will go
ahead and push it.  However, we still need a follow-up patch:

> Hmm; missing a corresponding update to docs/formatdomain.html.in to
> document the new XML.

--=20
Eric Blake   eblake@redhat.com    +1-801-349-2682
Libvirt virtualization library http://libvirt.org


--------------enig417B3CE155CFEEBECF5E96D6
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Public key at http://people.redhat.com/eblake/eblake.gpg
Comment: Using GnuPG with Fedora - http://enigmail.mozdev.org/

iQEcBAEBCAAGBQJNAUqqAAoJEKeha0olJ0NqU9UH/RUXrJr+BTNMfgEpCJ7pEO18
Lk46kI4ndRhVaE+PIjASSYNKwFgOFh07bMZeXPI6PKq1YfFxAEvQcp1i3aeiJCaj
cC3Cu/0lXx+QbeXwQo1jD4i+CwyumRK4GUUKwEQaYQJLPFYgIHu2m/ApaDgkKx9l
Oyv52ZMz/jMotKXu0q/72aRzlXk/YpF0HjK4X7FyGA7CUjuUMB+idtqqA1QPPP7s
nNsT3R2VA42V/KxA4b8RzXSPIvhXyAvrwPZre8QcKOujOWFSrfLSyvGPNJcm/etX
avLRivoTpIU0LOyBExLoMTZRmEIVRH2p/BQPbYNLFAF3k7vs0aDqdzBSITJe2Qo=
=0tIM
-----END PGP SIGNATURE-----

--------------enig417B3CE155CFEEBECF5E96D6--
