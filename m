From: Danny Kukawka <danny.kukawka@bisect.de>
Subject: Re: [PATCH] make mkcephfs and init-ceph osd filesystem handling more
 flexible
Date: Thu, 09 Aug 2012 18:49:01 +0200
Message-ID: <5023E9FD.2060501@bisect.de>
References: <1344526971-17035-1-git-send-email-danny.kukawka@bisect.de> <CADvuQRGLUpPT=RxYqptGq+9Ku2dNiKLsdY8a=KjjfoquucBc7w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigDEE761EB010467B32D667815"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:51972 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1750855Ab2HIQtJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Aug 2012 12:49:09 -0400
In-Reply-To: <CADvuQRGLUpPT=RxYqptGq+9Ku2dNiKLsdY8a=KjjfoquucBc7w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Tommi Virtanen <tv@inktank.com>

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigDEE761EB010467B32D667815
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

Am 09.08.2012 18:26, schrieb Tommi Virtanen:
> On Thu, Aug 9, 2012 at 8:42 AM, Danny Kukawka <danny.kukawka@bisect.de>=
 wrote:
>> Remove btrfs specific keys and replace them by more generic
>> keys to be able to replace btrfs with e.g. xfs or ext4 easily.
>>
>> Add new key to define the osd fs type: 'fstype', which can get
>> defined in the [osd] section for all OSDs.
>=20
> I'm going to say let's not do this. In fact, I've wanted to remove the
> "btrfs devs" option for a while now, as it keeps leading people down
> the wrong path:
> https://github.com/ceph/ceph/commits/kill-btrfs-devs
>=20
> mkcephfs is not a viable route forward. For example, it is unable to
> expand a pre-existing cluster.
>=20
> The new "OSD hotplugging" style init is much, much nicer. And does
> more than just mkfs & mount.

And where can I find this new "OSD hotplugging" style init? Is there any
documentation?

Danny



--------------enigDEE761EB010467B32D667815
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iJwEAQECAAYFAlAj6f4ACgkQ9DHLX79LmTIpTwQAonitkuSxzcgtGvoQ12VWTJOF
UWgOOMmq5Bup6cv4QnA0x3Gu3CdVRfXcMOM+M7UbBvMiAH4bD9JDK6E1Fn6aqDL6
WyX+f1WESFlIt2Wtkbu0GjjDrQmkZwEEqK7WivmIcqhL2zlJx4FUaedQM9eDJuu5
JvHPfOO9rcpRvMPlf78=
=y5AB
-----END PGP SIGNATURE-----

--------------enigDEE761EB010467B32D667815--
