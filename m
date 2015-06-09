From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: rgw static-website hosting design WIP: how S3-like should we be with
 endpoint types?
Date: Tue, 9 Jun 2015 03:52:21 +0000
Message-ID: <20150609035221.GA2868@orbis-terrarum.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="sHrvAb52M6C8blB9"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:42938 "EHLO smtp.gentoo.org"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S932706AbbFIDwX (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 8 Jun 2015 23:52:23 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtp.gentoo.org (Postfix) with ESMTPS id 079CB3409D0
	for <ceph-devel@vger.kernel.org>; Tue,  9 Jun 2015 03:52:22 +0000 (UTC)
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>
Cc: jonathan.lacour@dreamhost.com


--sHrvAb52M6C8blB9
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

I'm working on implementing S3 Static Website hosting on top of RGW,
based on the initial work that Yehuda did (wip-static-website branch).

I have a scratchpad here:
https://github.com/robbat2/temp-ceph-rgw-static-website-wiki/wiki
WIP Codebase here:
https://github.com/robbat2/ceph/tree/wip-static-website-robbat2-master

As part of writing up a full design for it, I'm wondering if we should
try to be "as close to S3 as possible", or try to improve the experience
for the administrator rather.

In S3, they explicitly add some DNS endpoints that are used for
accessing the bucket in website mode. Via those special endpoints, there
are MANY constraints applied [1], and you pretty much can't use them for
anything else.

At this point in early implementation, it seems possible that rather
than requiring organizations to have a separate DNS subdomain/wildcard
scope for websites, that we can make the decision based on headers:
If(bucket has website metadata set) {
  if(request has auth headers) {
    use normal REST mode
  } else {
    use website mode
  }=20
}

I've got it mostly working to make this behavior, but I'm wondering
about fallout/breakage, and unintended consequences. The codebase is
pretty ready for plugging the alternative logic with hostnames in as
well.

The most notable one so far, is that under Amazon's S3, the website
endpoint will server up only fixed pages for directories (no listing);
and the regular REST endpoint will serve listings if the
bucket/directory has a public ACL.

Another side-effect, and I think that's an improvement, is that if you
use a browser to just access a bucket this way, you'll automatically get
HTML error pages, instead of the XML blobs (as an admin of a RGW install
previously, the non-technical users telling me the rendered HTML from
their errors would have been a huge help instead of them being scared of
the XML).

[1] The list of S3 website endpoint constraints is here:
http://docs.aws.amazon.com/AmazonS3/latest/dev/WebsiteEndpoints.html

--=20
Robin Hugh Johnson
Gentoo Linux: Developer, Infrastructure Lead
E-Mail     : robbat2@gentoo.org
GnuPG FP   : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85

--sHrvAb52M6C8blB9
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iKYEARECAGYFAlV2YvRfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3Bl
bnBncC5maWZ0aGhvcnNlbWFuLm5ldDc1OTQwNEJFQkQ0MUY3MTIzODIzODZFRjNF
OTIyQzIyMzIzM0MyMkMACgkQPpIsIjIzwizWiwCfc/5r500e6eNgxw+bAdOa2aLK
6wwAoOQDuBsowty0f8VxY3MFmbmCAxJF
=JCOr
-----END PGP SIGNATURE-----

--sHrvAb52M6C8blB9--
