From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: RGW S3 Website hosting, non-clean code for early review
Date: Fri, 31 Jul 2015 08:21:03 +0000
Message-ID: <robbat2-20150731T080643-628065411Z@orbis-terrarum.net>
References: <20150623093325.GH10754@orbis-terrarum.net>
 <1739382408.18844114.1435091419238.JavaMail.zimbra@redhat.com>
 <robbat2-20150623T230410-006258787Z@orbis-terrarum.net>
 <854662566.18884035.1435100864177.JavaMail.zimbra@redhat.com>
 <1563403567.1093721.1438280774967.JavaMail.zimbra@redhat.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="bajzpZikUji1w+G9"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:46340 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751582AbbGaIVF (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 31 Jul 2015 04:21:05 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id 85C0D3409FE
	for <ceph-devel@vger.kernel.org>; Fri, 31 Jul 2015 08:21:03 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <1563403567.1093721.1438280774967.JavaMail.zimbra@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh-Weinraub <yehuda@redhat.com>
Cc: "Robin H. Johnson" <robbat2@gentoo.org>, ceph-devel@vger.kernel.org, Jonathan LaCour <jonathan.lacour@dreamhost.com>


--bajzpZikUji1w+G9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

I'm busy travelling and wrapping other things up, but will resume major
work on this in August, probably week 2/3, depending on other
interrupts/priorities.

It's almost complete, the only missing features are:
- error page fetcher gets confused on conditional requests (I think a
  different approach is needed, esp re range & if-modified requests,
  they still seem to leak into the custom req_info on the second request)
- cascaded errors on conditional requests need more handling (eg
  404 bounces to the error page that doesn't exist as well)
Some further work that isn't blocking is also:
- review handling of x-amz-website-redirect-location header when it
  conflicts with RoutingRules
- Check what input validations Amazon does, because already they don't
  match the docs=20
  - eg docs say any http code for redirect, but it really only allows
	301-305, 307, 308
  - Exact validation on the URI/paths is also not immediately clear, I
	had some unexpected results with URL-escaped inputs.
- Review cases in which AMZ sets the errors in the header as well as the
  page, didn't seem consistent, esp in the double-error cases.
- more cleanup/refactor of test cases

--=20
Robin Hugh Johnson
Gentoo Linux: Developer, Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85

--bajzpZikUji1w+G9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iKYEARECAGYFAlW7L+5fFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3Bl
bnBncC5maWZ0aGhvcnNlbWFuLm5ldDc1OTQwNEJFQkQ0MUY3MTIzODIzODZFRjNF
OTIyQzIyMzIzM0MyMkMACgkQPpIsIjIzwiwYWwCg3Xr9+jpauiVdWb0HaxwaBryk
9wMAn20j3zG8mNA2knLOLMzxd5vhD3lg
=FHFv
-----END PGP SIGNATURE-----

--bajzpZikUji1w+G9--
