From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: RGW bucket tagging
Date: Mon, 29 Jan 2018 07:41:11 +0000
Message-ID: <robbat2-20180129T073902-650234676Z@orbis-terrarum.net>
References: <CAA1GxO07U6t_WQhHFur9BPjaaWhZoA1nGazffSB_1Nfjptetog@mail.gmail.com>
 <CAKOnar=rwS6SKDDbAk6udCi8bJUD5pnM1g4ZSkH-VD4Edjo-rg@mail.gmail.com>
 <CAA1GxO2CbG=UR_4SKb4pV-j78ZG-nzjwaD+veqgx-RyQBryOSg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="1fZJyN7nFm/tosmV"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:38034 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751042AbeA2HlN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 29 Jan 2018 02:41:13 -0500
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA (128/128 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id 0CF78335C86
        for <ceph-devel@vger.kernel.org>; Mon, 29 Jan 2018 07:41:13 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <CAA1GxO2CbG=UR_4SKb4pV-j78ZG-nzjwaD+veqgx-RyQBryOSg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Andreas Calminder <andreas.calminder@klarna.com>
Cc: Matt Benjamin <mbenjami@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Abhishek Lekshmanan <abhishek@suse.com>


--1fZJyN7nFm/tosmV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 29, 2018 at 08:25:44AM +0100, Andreas Calminder wrote:
> Thanks for your reply Matt, I did some more poking around; you're
> right, there's no support for bucket tagging. Does anyone know if this
> feature will be implemented somewhere in the foreseeable future?
I'd find it useful, but I have nowhere near enough time to implement it.
Bucket Inventory would also be really nice to have, but moving far from
RGW's core goal I feel.

--=20
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136

--1fZJyN7nFm/tosmV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iQKTBAEBCgB9FiEEveu2pS8Vb98xaNkRGTlfI8WIJsQFAlpu0BZfFIAAAAAALgAo
aXNzdWVyLWZwckBub3RhdGlvbnMub3BlbnBncC5maWZ0aGhvcnNlbWFuLm5ldEJE
RUJCNkE1MkYxNTZGREYzMTY4RDkxMTE5Mzk1RjIzQzU4ODI2QzQACgkQGTlfI8WI
JsRqKg/+Ma8aLtJEaZOWPFPOU5F0eiaD9IT2YttR3esccS4elMR7QBlpEG/T4TxA
I3DTf/T46ogc3I0H0CoJa6Fj+2fvGnEBlFzSDrdd+zacMnsguPYKNAAqIInuUA8M
OIfTtvAux0jmDSqGzce8dtuF14gK5POE9406NxS4VYW+JqgmgdrO6cylIDB3nQQQ
z5obJfdS+dW0b870Y/9j82K6lutmpqnPYVg6irMQAy+3p/ZVrPJbhJ3XqT/FBSxg
/irC4xPzLOMCBv3FDsvO84yWFfq46u7z8TRUPMQQsh6pNUbQswmj7Urqb+K7zqQD
imyLhmr5RgLmoCH7xJ65H2//MrH5R4bUT/QuXnXjJ23Hh6esQCU+kqScinhQoKGa
fwzm1RYyZVOftjfGg53v5GsRzCm0LSKcYGPw8Z4Kyb5ZgVcZFiys3o2C/ldPCf7Z
aFGDJi9QWwrBkSj/0duRTw8c6T7MZhxFRqVoU4OKId6c5yUXn52f2frhErWC6mw9
SbQ5gVUrqxOWyHWTZh9dCcZSuN0JBfTPuU8njrZJP9UAtw5vnm1MW9ePAacZDZj3
4XR+Lkge0LII/+kNob4sYnpx6kv0anTtcDbilAojcDjemoNqP9CUS+EHwVYkhLX9
9LOErHfn1nsQ5NvSlsd/5fLC7YPSLFfRDLcl2xCusfGCqjdUNaw=
=Fu0H
-----END PGP SIGNATURE-----

--1fZJyN7nFm/tosmV--
