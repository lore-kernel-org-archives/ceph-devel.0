From: Lenz Grimmer <lenz@grimmer.com>
Subject: Re: REST APIs
Date: Sat, 16 Sep 2017 17:29:48 +0200
Message-ID: <aa19dcdb-f7c8-66f2-c1f1-99e943ff68e3@grimmer.com>
References: <CALe9h7e02DdmcXPfJFP56c6KCpZ-DoRdS9nvNg1SHQFKuwr9qg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="6ViDSmEGxREVLJfheED5G6gq6hhJPr6qB"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.mailbox.org ([80.241.60.212]:53808 "EHLO mx1.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751273AbdIPP3w (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Sat, 16 Sep 2017 11:29:52 -0400
Received: from smtp1.mailbox.org (smtp1.mailbox.org [80.241.60.240])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.mailbox.org (Postfix) with ESMTPS id C7606428CC
        for <ceph-devel@vger.kernel.org>; Sat, 16 Sep 2017 17:29:50 +0200 (CEST)
Received: from smtp1.mailbox.org ([80.241.60.240])
        by spamfilter03.heinlein-hosting.de (spamfilter03.heinlein-hosting.de [80.241.56.117]) (amavisd-new, port 10030)
        with ESMTP id KNPkvcs3AM6A for <ceph-devel@vger.kernel.org>;
        Sat, 16 Sep 2017 17:29:49 +0200 (CEST)
In-Reply-To: <CALe9h7e02DdmcXPfJFP56c6KCpZ-DoRdS9nvNg1SHQFKuwr9qg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ceph Development <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--6ViDSmEGxREVLJfheED5G6gq6hhJPr6qB
Content-Type: multipart/mixed; boundary="nVpGmn5A01TP679xe23lG2pQAgAcM1qTg";
 protected-headers="v1"
From: Lenz Grimmer <lenz@grimmer.com>
To: Ceph Development <ceph-devel@vger.kernel.org>
Message-ID: <aa19dcdb-f7c8-66f2-c1f1-99e943ff68e3@grimmer.com>
Subject: Re: REST APIs
References: <CALe9h7e02DdmcXPfJFP56c6KCpZ-DoRdS9nvNg1SHQFKuwr9qg@mail.gmail.com>
In-Reply-To: <CALe9h7e02DdmcXPfJFP56c6KCpZ-DoRdS9nvNg1SHQFKuwr9qg@mail.gmail.com>

--nVpGmn5A01TP679xe23lG2pQAgAcM1qTg
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi John,

On 09/13/2017 03:43 PM, John Spray wrote:

> This message is prompted by: https://github.com/ceph/ceph/pull/17530
>=20
> Questions:
>  - Is anyone using either ceph-rest-api or the restful module?
>  - Is anyone planning on doing any work on either?
>  - Is the CLI pass through of the restful module a sufficient
> replacement for ceph-rest-api for anyone that was using it?

Thanks for the heads up.

FWIW, openATTIC does not make use of ceph-rest-api and we don't have
plans on using it.

However, AFAIK Inkscope [1] relies on it to perform its duty - I have
pinged the author (Alain Dechorgnat) in the pull request to get his opini=
on.

Lenz

[1] http://inkscope.blogspot.de/



--nVpGmn5A01TP679xe23lG2pQAgAcM1qTg--

--6ViDSmEGxREVLJfheED5G6gq6hhJPr6qB
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

iG8EARECAC8WIQRwnM6QdoQNrjll2jdJUOEqsnKR8gUCWb1DbBEcbGVuekBncmlt
bWVyLmNvbQAKCRBJUOEqsnKR8hGNAJ0cGfpBTF5MNfCAWI9r/uDgvbz5vgCfT97n
9J10+9B4bcodMztX9fIEapg=
=6oBe
-----END PGP SIGNATURE-----

--6ViDSmEGxREVLJfheED5G6gq6hhJPr6qB--
