From: "Robin H. Johnson" <robbat2@gentoo.org>
Subject: Re: new boost
Date: Fri, 26 Aug 2016 19:31:09 +0000
Message-ID: <20160826193109.GA24024@orbis-terrarum.net>
References: <alpine.DEB.2.11.1608261829420.24244@piezo.us.to>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="TeJTyD9hb8KJN2Jy"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from smtp.gentoo.org ([140.211.166.183]:49516 "EHLO smtp.gentoo.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751014AbcHZTbv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 26 Aug 2016 15:31:51 -0400
Received: from grubbs.orbis-terrarum.net (localhost [127.0.0.1])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by smtp.gentoo.org (Postfix) with ESMTPS id D63F5340834
        for <ceph-devel@vger.kernel.org>; Fri, 26 Aug 2016 19:31:08 +0000 (UTC)
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.11.1608261829420.24244@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org


--TeJTyD9hb8KJN2Jy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Aug 26, 2016 at 06:42:47PM +0000, Sage Weil wrote:
> Now that we've transitioned to cmake, I'd like to resurrect the discussio=
n=20
> about moving to a new version of boost.  I'm dying to use small_vector an=
d=20
> flat_map.
>
> IIRC, we have a few options:
As a distribution packager for a very long time, I'm firmly in the #4 camp,=
 but
worry about the bugs present in system Boost...

As an example of those bugs, and a useful data point on how other major
projects are handling similar issues with Boost, there was an email that
crossed my inbox this morning, as I used to lead Gentoo's MySQL team. MySQL=
 5.7
uses the Boost geometry code.  MySQL builds were failing the testsuite with
newer boost releases, which lead to bugs and this email we got from the Ora=
cle
MySQL packaging people.

Relevant excerpts below:
>>MySQL 5.7 has a strict requirement on Boost 1.59.0. ...
>>...
>>Currently, MySQL includes fixes for bugs that haven't been fixed in Boost
>>1.61.0 (we expect them to be included in Boost 1.63.0, but by then we may
>>have fixes that won't land in a Boost release until 1.64.0). If you change
>>the CMake files to use Boost 1.61.0, MySQL will compile, but the test
>>suite will fail because of missing bugfixes. Even if all bugfixes are
>>included and MySQL builds successfully with a new Boost, there's no
>>guarantee that the order of floating point operations in newer Boost
>>versions are the same, so results of operations may differ slightly, and
>>the testsuite may fail.
>>...
>>Therefore, we strongly recommend always building MySQL with the specified
>>version of Boost. We're taking care of backporting all the necesary
>>bugfixes. Debian, Ubuntu, Fedora and Red Hat are all following our advice,
>>and on request from them, we have made a special tarball that includes
>>MySQL and the Boost header files. It's available for download from the
>>MySQL download site [2].
>>...
>>Debian, Ubuntu, Fedora and Red Hat are going to be using the mysql-boost
>>tarball going forward, so I recommend that Gentoo does the same. Another
>>option is to build from two tarballs: MySQL and Boost 1.59.0.

--=20
Robin Hugh Johnson
Gentoo Linux: Dev, Infra Lead, Foundation Trustee & Treasurer
E-Mail   : robbat2@gentoo.org
GnuPG FP : 11ACBA4F 4778E3F6 E4EDF38E B27B944E 34884E85
GnuPG FP : 7D0B3CEB E9B85B1F 825BCECF EE05E6F6 A48F6136

--TeJTyD9hb8KJN2Jy
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.1
Comment: Robbat2 @ Orbis-Terrarum Networks - The text below is a digital signature. If it doesn't make any sense to you, ignore it.

iKYEARECAGYFAlfAmPxfFIAAAAAALgAoaXNzdWVyLWZwckBub3RhdGlvbnMub3Bl
bnBncC5maWZ0aGhvcnNlbWFuLm5ldDc1OTQwNEJFQkQ0MUY3MTIzODIzODZFRjNF
OTIyQzIyMzIzM0MyMkMACgkQPpIsIjIzwiwZ2QCg49Ub3coeOX/rHYRXRR4b2olL
d50AoKRUOIpKNuL8JqVEihqTC0/NdRvV
=2Qz9
-----END PGP SIGNATURE-----

--TeJTyD9hb8KJN2Jy--
