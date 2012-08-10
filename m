From: Danny Kukawka <danny.kukawka@bisect.de>
Subject: Re: [PATCH] make mkcephfs and init-ceph osd filesystem handling more
 flexible
Date: Fri, 10 Aug 2012 18:03:21 +0200
Message-ID: <502530C9.7030008@bisect.de>
References: <1344526971-17035-1-git-send-email-danny.kukawka@bisect.de> <alpine.DEB.2.00.1208100851260.8611@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigA0B33F818705B53F4C5EA556"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:57238 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1751945Ab2HJQDi (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Fri, 10 Aug 2012 12:03:38 -0400
In-Reply-To: <alpine.DEB.2.00.1208100851260.8611@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigA0B33F818705B53F4C5EA556
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Am 10.08.2012 17:54, schrieb Sage Weil:
> On Thu, 9 Aug 2012, Danny Kukawka wrote:
>> Remove btrfs specific keys and replace them by more generic
>> keys to be able to replace btrfs with e.g. xfs or ext4 easily.
>>
>> Add new key to define the osd fs type: 'fstype', which can get
>> defined in the [osd] section for all OSDs.
>>
>> Replace:
>> - 'btrfs devs' -> 'devs'
>> - 'btrfs path' -> 'fs path'
>> - 'btrfs options' -> 'fs options'
>> - mkcephfs: replace --mkbtrfs with --mkfs
>> - init-ceph: replace --btrfs with --fsmount, --nobtrfs
>> with --nofsmount, --btrfsumount with --fsumount
>>
>> Update documentation, manpage and example config files.
>=20
> Maybe this should keep the old options as well, so that --mkbtrfs is an=
=20
> alias for --mkfs --btrfs...

I can add this to the patch, no problem!

> Tommi, is this kind of invocation compatible with your notion of what=20
> mkcephfs 2.0 should be?  If we can jump to the target interface and=20
> rewrite the implementation in terms of the new tools that would capture=
=20
> the best of both worlds.

If you can point me to some documentation how the target interface
works, I could take a look at adapting mkcephfs to the new tools as soon
as the new interface/workflow is ready.

Danny


--------------enigA0B33F818705B53F4C5EA556
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iJwEAQECAAYFAlAlMNIACgkQ9DHLX79LmTIldQP8DEOfgwSGdLJ058zlCqZ44jt+
MrYjaYiArpoCvEOrzKw4MgxUj7YmMejBc2oYUEVhe21uxQ9mHBaIW+hxRaPGk0P6
M/nvyt70sQImnOxZ377KUq0S5J515U+RinvjJuz2ewTSu0CVKx/Ivk42hckT5TPD
uuN/YdFyDTsIFeb2AxY=
=hk/c
-----END PGP SIGNATURE-----

--------------enigA0B33F818705B53F4C5EA556--
