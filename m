From: Danny Kukawka <danny.kukawka@bisect.de>
Subject: cherry-pick 7adc6c08f14 for stable branch
Date: Tue, 14 Aug 2012 10:45:07 +0200
Message-ID: <502A1013.6040302@bisect.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="------------enigFB7F3AEC7EBB61E2AA3540F1"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from wp188.webpack.hosteurope.de ([80.237.132.195]:47074 "EHLO
	wp188.webpack.hosteurope.de" rhost-flags-OK-OK-OK-OK)
	by vger.kernel.org with ESMTP id S1754725Ab2HNIpP (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>);
	Tue, 14 Aug 2012 04:45:15 -0400
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 2440 and 3156)
--------------enigFB7F3AEC7EBB61E2AA3540F1
Content-Type: text/plain; charset=ISO-8859-15
Content-Transfer-Encoding: quoted-printable

Hi,

could you please cherry-pick:
---------------
commit 7adc6c08f1474806c83ef6c89e8752d6cfd35bfd
Author: Sage Weil <sage@inktank.com>
Date:   Mon Jul 9 17:24:19 2012 -0700

    mon: simplify logmonitor check_subs; less noise

     * simple helper to translate name to id
     * verify sub type is valid in caller
     * assert sub type is valid in method
     * simplify iterator usage

    Among other things, this gets rid of this noise in the logs:

    2012-07-10 20:51:42.617152 7facb23f1700  1 mon.a@1(peon).log v310
check_sub sub monmap not log type

    Signed-off-by: Sage Weil <sage@inktank.com>
---------------

from master to the stable branch?

Thanks!

Danny


--------------enigFB7F3AEC7EBB61E2AA3540F1
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.19 (GNU/Linux)

iJwEAQECAAYFAlAqEBgACgkQ9DHLX79LmTJu+gP9FW/3Unntp2u7rKrPVgmTDwl2
Ctm2FFWwYgLgK6bNJBsF/Xk/yrJlwqeAcVWy7RAhglsFJuKi9Qz0MQvPMfEStULW
KKGFyjWxQvfY/7YrhB9JfMrvWVR04NM2Wa8cUDJ/uCSmXvVJbhE18EgNQ27sMood
it01bGu382Rk84/Vr8E=
=8Ton
-----END PGP SIGNATURE-----

--------------enigFB7F3AEC7EBB61E2AA3540F1--
