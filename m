From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: RGW RFC: Multiple-Data-Pool Support for a Bucket
Date: Tue, 26 Dec 2017 19:00:23 +0000
Message-ID: <robbat2-20171226T185704-299365896Z@orbis-terrarum.net>
References: <CAFZHTOYnOQgVsmsGXPL8dBwA-_Gc5q3fZ5V1CjfzRtQbs=tvgg@mail.gmail.com>
Reply-To: ceph-devel@vger.kernel.org
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bg08WKrSYDhXBjb5"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:60504 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751266AbdLZTA0 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 26 Dec 2017 14:00:26 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id DD212341640
        for <ceph-devel@vger.kernel.org>; Tue, 26 Dec 2017 19:00:25 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAFZHTOYnOQgVsmsGXPL8dBwA-_Gc5q3fZ5V1CjfzRtQbs=tvgg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>


--bg08WKrSYDhXBjb5
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Dec 26, 2017 at 09:48:26AM +0800, Jeegn Chen wrote:
> In the daily use of Ceph RGW cluster, we find some pain points when
> using current one-bucket-one-data-pool implementation.
> I guess one-bucket-multiple-data-pools may help (See the appended
> detailed proposal).
> What do you think?
Overall I like

Queries/concerns:
- How would this interact w/ the bucket policy lifecycle code?
- How would this interact w/ existing placement policy in bucket
  creation?
- At the rgw-admin layer, what tooling should exist to migrate objects
  between pools for a given bucket?

--=20
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Asst. Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136

--bg08WKrSYDhXBjb5
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iQKTBAEBCgB9FiEEveu2pS8Vb98xaNkRGTlfI8WIJsQFAlpCnEZfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJE
RUJCNkE1MkYxNTZGREYzMTY4RDkxMTE5Mzk1RjIzQzU4ODI2QzQACgkQGTlfI8WI
JsSNOQ/+JlaISjiFZJwgPkHbQNiRlgUxfLfxjzdmBWkRaO5NsrySn0zFhPohfew9
ZXTUpF/nhdQJw0yh1W6lSfZnUuG//ipZrzA8fAKA31M9YClzOnEAvnM7B37St6As
ZkS2Tsuro2kFn7A+2XHMvn9Simp5Dtbol8deCopYupxMMtHSvLyRpLHldUs6Yj67
6/xFIN0/QUgVhokClZvS7zkOMKnBAoS9rFA94A2tRn5zT4JLzYv+fl4XOaAeNLoK
eGdjMdTL9rhpvKxTz80F5Okr0b4eOBoJVrYgI+M27UX/i6Si0GQ4U1jqdvpoUgmX
Sw7z/r1hqnFrcdw09ePoeGIKnykVaoxgjHIEx+if9Ov7SO0e7GdnzsTJoohqQfXe
YqCaCYMYtCJ85GLZVsrhI1/Ci75vkngKjuOB007s6zTblc5sKMbbHIDjS89jm52G
sMd6dKBSmYAZeRrLgEvmXuJoIGOhtYCobhGl8+QQqxfxGSYaAoVXgcRCMky2bwqS
BqfaWJ6mk1hm7wOZ6QPeG8HM1MG48ECA58BB5U5PTP2wAsu2lUOjDUD6NT4eceoz
AQD85oe9lVXhdQyj6zVNHI0x1YKgnyqcynSBZuE1q3r5Jazu+xOam21C9GZcXlHS
Noj8H95U7oa+JbiUEp2fQRixa8QIQB9iYj8nFtlbCkPm1K9jYRA=
=skMy
-----END PGP SIGNATURE-----

--bg08WKrSYDhXBjb5--
