From: Lenz Grimmer <lenz@grimmer.com>
Subject: Re: [ceph-users] dropping filestore+btrfs testing for luminous
Date: Fri, 30 Jun 2017 17:46:55 +0200
Message-ID: <c4cf8858-6c29-4ec7-7ffa-479781258569@grimmer.com>
References: <alpine.DEB.2.11.1706300314120.3424@piezo.novalocal>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="sBWLi7ETK4HUaP0K1xqGQ6qMTnwFNFj6M"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx2.mailbox.org ([80.241.60.215]:58109 "EHLO mx2.mailbox.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751649AbdF3PrG (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 30 Jun 2017 11:47:06 -0400
In-Reply-To: <alpine.DEB.2.11.1706300314120.3424@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--sBWLi7ETK4HUaP0K1xqGQ6qMTnwFNFj6M
Content-Type: multipart/mixed; boundary="aQijQVbLuHhqj3VcPDXHDsAXjVrwili2p";
 protected-headers="v1"
From: Lenz Grimmer <lenz@grimmer.com>
To: ceph-devel@vger.kernel.org, ceph-users@ceph.com
Message-ID: <c4cf8858-6c29-4ec7-7ffa-479781258569@grimmer.com>
Subject: Re: [ceph-users] dropping filestore+btrfs testing for luminous
References: <alpine.DEB.2.11.1706300314120.3424@piezo.novalocal>
In-Reply-To: <alpine.DEB.2.11.1706300314120.3424@piezo.novalocal>

--aQijQVbLuHhqj3VcPDXHDsAXjVrwili2p
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable

Hi Sage,

On 06/30/2017 05:21 AM, Sage Weil wrote:

> The easiest thing is to
>=20
> 1/ Stop testing filestore+btrfs for luminous onward.  We've recommended=
=20
> against btrfs for a long time and are moving toward bluestore anyway.

Searching the documentation for "btrfs" does not really give a user any
clue that the use of Btrfs is discouraged.

Where exactly has this been recommended?

The documentation currently states:

http://docs.ceph.com/docs/master/rados/configuration/ceph-conf/?highlight=
=3Dbtrfs#osds

"We recommend using the xfs file system or the btrfs file system when
running mkfs."

http://docs.ceph.com/docs/master/rados/configuration/filesystem-recommend=
ations/?highlight=3Dbtrfs#filesystems

"btrfs is still supported and has a comparatively compelling set of
features, but be mindful of its stability and support status in your
Linux distribution."

http://docs.ceph.com/docs/master/start/os-recommendations/?highlight=3Dbt=
rfs#ceph-dependencies

"If you use the btrfs file system with Ceph, we recommend using a recent
Linux kernel (3.14 or later)."

As an end user, none of these statements would really sound as
recommendations *against* using Btrfs to me.

I'm therefore concerned about just disabling the tests related to
filestore on Btrfs while still including and shipping it. This has
potential to introduce regressions that won't get caught and fixed.

> 2/ Leave btrfs in the mix for jewel, and manually tolerate and filter o=
ut=20
> the occasional ENOSPC errors we see.  (They make the test runs noisy bu=
t=20
> are pretty easy to identify.)
>=20
> If we don't stop testing filestore on btrfs now, I'm not sure when we=20
> would ever be able to stop, and that's pretty clearly not sustainable.
> Does that seem reasonable?  (Pretty please?)

If you want to get rid of filestore on Btrfs, start a proper deprecation
process and inform users that support for it it's going to be removed in
the near future. The documentation must be updated accordingly and it
must be clearly emphasized in the release notes.

Simply disabling the tests while keeping the code in the distribution is
setting up users who happen to be using Btrfs for failure.

Just my 0.02=E2=82=AC,

Lenz


--aQijQVbLuHhqj3VcPDXHDsAXjVrwili2p--

--sBWLi7ETK4HUaP0K1xqGQ6qMTnwFNFj6M
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iFgEARECABgFAllWcnMRHGxlbnpAZ3JpbW1lci5jb20ACgkQSVDhKrJykfLBqgCf
ZCZjaq6oAaJ0G0cu13AYJ15Z2zYAn2B8qHCbVKF8mXbKbLn6McuUDtIO
=7SJE
-----END PGP SIGNATURE-----

--sBWLi7ETK4HUaP0K1xqGQ6qMTnwFNFj6M--
