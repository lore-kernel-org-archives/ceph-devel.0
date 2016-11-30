From: Lenz Grimmer <lenz@grimmer.com>
Subject: Re: Introducing DeepSea: A tool for deploying Ceph using Salt
Date: Wed, 30 Nov 2016 12:16:26 +0100
Message-ID: <c2b65f06-25ab-3bf5-8873-275d77b7d39d@grimmer.com>
References: <0c7928bb-947a-23c9-5770-e588dbffb6af@suse.com>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="BIs7ScKU3hAkw9kGjM9leKRuw1VbNlXfJ"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:33649 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S932789AbcK3LQw (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 30 Nov 2016 06:16:52 -0500
In-Reply-To: <0c7928bb-947a-23c9-5770-e588dbffb6af@suse.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--BIs7ScKU3hAkw9kGjM9leKRuw1VbNlXfJ
Content-Type: multipart/mixed; boundary="NR0NpNUAIk7akOFWPPaE6woQ6Pt1x8fEI";
 protected-headers="v1"
From: Lenz Grimmer <lenz@grimmer.com>
To: "ceph-users@lists.ceph.com" <ceph-users@lists.ceph.com>,
 "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Message-ID: <c2b65f06-25ab-3bf5-8873-275d77b7d39d@grimmer.com>
Subject: Re: Introducing DeepSea: A tool for deploying Ceph using Salt
References: <0c7928bb-947a-23c9-5770-e588dbffb6af@suse.com>
In-Reply-To: <0c7928bb-947a-23c9-5770-e588dbffb6af@suse.com>

--NR0NpNUAIk7akOFWPPaE6woQ6Pt1x8fEI
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable

Hi all,

(replying to the root of this thread, as the discussions between
ceph-users and ceph-devel have somewhat diverged):

On 11/03/2016 06:52 AM, Tim Serong wrote:

> I thought I should make a little noise about a project some of us at
> SUSE have been working on, called DeepSea.  It's a collection of Salt
> states, runners and modules for orchestrating deployment of Ceph
> clusters.  To help everyone get a feel for it, I've written a blog post=

> which walks through using DeepSea to set up a small test cluster:
>=20
>   http://ourobengr.com/2016/11/hello-salty-goodness/
>=20
> If you'd like to try it out yourself, the code is on GitHub:
>=20
>   https://github.com/SUSE/DeepSea
>=20
> More detailed documentation can be found at:
>=20
>   https://github.com/SUSE/DeepSea/wiki/intro
>   https://github.com/SUSE/DeepSea/wiki/management
>   https://github.com/SUSE/DeepSea/wiki/policy
>=20
> Usual story: feedback, issues, pull requests are all welcome ;)

FYI, we now also have a dedicated mailing list "deepsea-users":
http://lists.suse.com/mailman/listinfo/deepsea-users

If you have any questions, suggestions for improvements or any other
feedback, please joins us there! We look forward to your contributions.

Thanks,

Lenz


--NR0NpNUAIk7akOFWPPaE6woQ6Pt1x8fEI--

--BIs7ScKU3hAkw9kGjM9leKRuw1VbNlXfJ
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iFgEARECABgFAlg+tQ4RHGxlbnpAZ3JpbW1lci5jb20ACgkQSVDhKrJykfLKHACf
QryhAsVNzPs+h0P0EHiEZNpkY/AAnjRmLt1t9VAfx3WYqlbUmr2aUc9j
=+D42
-----END PGP SIGNATURE-----

--BIs7ScKU3hAkw9kGjM9leKRuw1VbNlXfJ--
