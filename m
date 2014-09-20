From: Dmitry Smirnov <onlyjob@member.fsf.org>
Subject: Re: issue 8747 / 9011
Date: Fri, 19 Sep 2014 20:08:08 -0700 (PDT)
Message-ID: <2949490.exWB3TExxB@debstor>
References: <alpine.DEB.2.00.1409191642270.19460@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; boundary="nextPart1807213.P5UxQiSYbe"; micalg="pgp-sha256"; protocol="application/pgp-signature"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pd0-f171.google.com ([209.85.192.171]:33948 "EHLO
	mail-pd0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753409AbaITDIK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Sep 2014 23:08:10 -0400
Received: by mail-pd0-f171.google.com with SMTP id y13so1054901pdi.2
        for <ceph-devel@vger.kernel.org>; Fri, 19 Sep 2014 20:08:10 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1409191642270.19460@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel@vger.kernel.org


--nextPart1807213.P5UxQiSYbe
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="us-ascii"

Hi Sage,

On Fri, 19 Sep 2014 16:43:31 Sage Weil wrote:
> Are you still seeing this crash?
>=20
>  osd/ReplicatedPG.cc: 5297: FAILED assert(soid < scrubber.start || so=
id >=3D
> scrubber.end)

Thanks for following-up on this, Sage.
Yes, I've seen this crash just recently on 0.80.5. It usually happens d=
uring=20
long recovery like when OSD is replaced. I've seen this happening after=
 hours=20
of backfilling/remapping although it may take a long time to manifest.

=2D-=20
Cheers,
 Dmitry Smirnov
 GPG key : 4096R/53968D1B

=2D--

However beautiful the strategy, you should occasionally look at the
results.
        -- Winston Churchill

--nextPart1807213.P5UxQiSYbe
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part.
Content-Transfer-Encoding: 7Bit

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iQIcBAABCAAGBQJUHOOhAAoJEFK2u9lTlo0bcIcQAJtZmZ01SpRkOK6Iwh5DRPvk
VYdGw6spkACVcYjnieVJsY6TIVoJUkWeenXHzNYXyoJpAkKcxrRqERFoxq31Cna9
8giV6E8XMkM3FmSKsRT8gCmtQV9qQLZz7ICF3g8/6vdRr3OvoQgoYcLmC4nqR5Sz
cDBgj2x9Ws+snP2RJIOL9CKbQXBIGhBeOlVzIfbaePoPyzt9fkfeTvfMtHIPkp+P
FanVc+bzdtufB48vYXg5i7V8TuSF0B+k2gSutmS7zFlxweAJoMmmBIVT9kPpZzCE
pJ9SnUEytw9Ymk4F3/mLNKyDpuolrczEpRAnp1tVVoYQ6GCDmLCWK1G328DTK7N0
HU1+9nUqjKNyir/qSFIn13KO8e4c+VBJQWZsVH7AmYC5CdGNAYzziIRmvpM0mBjP
huN0RY6QOtzlYEni3poBMIitxa0ToParBVnQBQIbcblbc6GkJbACgRBAdY+syFQe
lWCrkbEs18riC0x8q8FsILITqZR7g8HDh3QaqY7VDTDADJB7+JCiKD19kRdEcSI0
FSeSLbnMhW4U8KSItd0guJ7AbLIPJj5XOBOnhD0j04+6H8h+iCfOt02+Di0cv2eX
HpPTa2nnkW+p31s3rVkU1ORqUf7GP7OW7q7o4zwNtct0ohlRL4vRCY7xvWMbaoBO
cWTdgapwfPH2ZTijdnKs
=c6u9
-----END PGP SIGNATURE-----

--nextPart1807213.P5UxQiSYbe--

