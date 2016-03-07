From: Abhishek Lekshmanan <abhishek@suse.com>
Subject: Re: master build failure with boost 1.60
Date: Mon, 7 Mar 2016 17:47:44 +0100
Message-ID: <56DDB0B0.2090005@suse.com>
References: <20160307144944.GA21590@pxe-sup5.sup.suse.de>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature";
 boundary="rXNluPJPrCEJpxIlVCKDFjgTRGBQ48kp4"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.nue.novell.com ([195.135.221.5]:47972 "EHLO
	smtp.nue.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752418AbcCGQsA (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:0:0>);
	Mon, 7 Mar 2016 11:48:00 -0500
In-Reply-To: <20160307144944.GA21590@pxe-sup5.sup.suse.de>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--rXNluPJPrCEJpxIlVCKDFjgTRGBQ48kp4
Content-Type: multipart/mixed; boundary="XBmC4wvJD4Bq8J8ESv8wQbmX3u8ajpBLn"
From: Abhishek Lekshmanan <abhishek@suse.com>
To: ceph-devel@vger.kernel.org
Message-ID: <56DDB0B0.2090005@suse.com>
Subject: Re: master build failure with boost 1.60
References: <20160307144944.GA21590@pxe-sup5.sup.suse.de>
In-Reply-To: <20160307144944.GA21590@pxe-sup5.sup.suse.de>

--XBmC4wvJD4Bq8J8ESv8wQbmX3u8ajpBLn
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable



On 03/07/2016 03:49 PM, Karol Mroz wrote:
> Hi folks,
>=20
> We've recently hit a build failure on ceph master for which Abhishek ha=
s opened
> a bug: http://tracker.ceph.com/issues/14998.
>
> Our rolling distribution (openSUSE Tumbleweed) has pushed out boost 1.6=
0
> which looks to be at the heart of the failure. Is boost 1.60 to be supp=
orted in
> Jewel?

Reverting https://github.com/ceph/ceph/pull/7654 makes the build
succeed, of course that is not the solution, but might indicate where we
may need fixing

Regards
Abhishek

> Thanks!
>=20


--XBmC4wvJD4Bq8J8ESv8wQbmX3u8ajpBLn--

--rXNluPJPrCEJpxIlVCKDFjgTRGBQ48kp4
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJW3bC9AAoJEPnwZB8bZe1fpmAH/3BtBTt2xdEL6gjKpWA3s5XT
oVfMtl4fMMhdymsi4hXZYRUSqiwXb2ch1/phR/9Qe8CDjOVvKcJ/E63uZLhc7gIH
0U5iTiZ2fggSvR1/BeXUQSBF8x3qz0D5lX9eTXwhgwSsgLKtPock/djuAVt1/AQP
y7Zc4UZ8LvwPxQe3hFIM54xwM9Fn32G+BWyHIkzpc80h5WoD4RFfxOvB3SDBtoKY
cgzzN9Kwxnvrau0aeIsa1U2HQcawfgH8ygDK0JP7XHf82hWZdcKc0h4qFy7SbA1G
5V685Dn2HzNKf2VquHImWAvs9q7Ta4CJyOrvOdb5JEkTzTUROHMqpK9oC6sBf8o=
=kNFF
-----END PGP SIGNATURE-----

--rXNluPJPrCEJpxIlVCKDFjgTRGBQ48kp4--
