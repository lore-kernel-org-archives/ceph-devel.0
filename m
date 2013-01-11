From: James Page <james.page@canonical.com>
Subject: Re: v0.48.3 argonaut update released
Date: Fri, 11 Jan 2013 11:36:36 +0000
Message-ID: <50EFF944.3070400@canonical.com>
References: <alpine.DEB.2.00.1301081927450.32282@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:41263 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753169Ab3AKLgj (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 11 Jan 2013 06:36:39 -0500
In-Reply-To: <alpine.DEB.2.00.1301081927450.32282@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: ceph-devel@vger.kernel.org

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Hi Sage

On 09/01/13 03:30, Sage Weil wrote:
> After several months, we have an important update for the argonaut
> v0.48.x series. This release contains a critical fix that can
> prevent data loss or corruption in a power loss or kernel panic
> situation. There are also several fixes for the OSDs and for the
> radosgw. We recommend all v0.48.x users upgrade.
[...]

As argonaut is the version shipped in Ubuntu 12.10 and for the Cloud
Archive for precise I'm going to apply for Micro Release Exception
(see [0]) for ceph so that we can push minor point release updates in
a little easier via the Ubuntu SRU process.

I need to document how the following requirements are fulfilled:

1) upstream supports micro-version updates to stable releases

This should be OK _ but more detail on how bugs are selected for the
point releases would be helpful.

2) upstream has a sufficiently high level of regression testing for
their stable releases

Details of what regression testing of stable release is done by the
ceph project would be great.

3) regression tests are always run on the update before it is released
(e.g. by being enabled in the package's build)

We don't run unit tests during package build; but we do regular smoke
testing of ceph in the Ubuntu Openstack CI lab; I'm going to extend
this so we can do regression testing of Ceph for SRU's going forwards
- - this is how we validate Openstack SRU's so should be acceptable.

Help documenting 1 & 2 would be much appreciated!

Cheers

James


[0] https://wiki.ubuntu.com/StableReleaseUpdates/MicroReleaseExceptions
- -- 
James Page
Technical Lead
Ubuntu Server Team
james.page@canonical.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.12 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBCAAGBQJQ7/lEAAoJEL/srsug59jDmUcP/Ayz4WSaqb3YArKUqLNil11Z
d1o9bVrEajXhhde5fKjAHTHosxl0sQ3nOWyoJU3zLNkK1BoBaXnxz0/7JyKHDPny
cFmSqqHDmiIuAp+Ka0fwWuk2XQ5RxFMHnpS/+9E5SOtciafRwuMruTK/825s0oFP
si053/0cxyKnemw0SuwQ+9ejcK/+6IW80O4C2V2n8NV9ZuBRflnHpX4n2XJIfPkW
D9iUzfCxRBdOrMCuJ2hG8MGBR/CaeQRsLoJb60ztYE+V+awkOgIWGf0jAXk+/YOn
d62+Tw86rqpFEIwjWZbktfbH9+PM1PZF7RteC8aKLzbcqJizLwHOKqlaqZpOnoyt
U2SBgI7OyOYmFB4dtwxo+xM8LQY5RvjAPUyXRcaU2LQ2O0Vkfr07mkVuxRGrEYtA
XGsne6VUnBAf4GNMiSoRYmpKdi+rHBNjvepaO0/1U5a1FEqSv9koAQwRjVikwV0W
SoDXjP3RZ8/EH/fQEdKTsnfZpe1A80w5wfXrzwKW3RX54BG0s5/XdYYBqilOGnZy
F6rt9Z1cWUg22CMPwHG7tfSToAAuV8wqrPB6u21w1zOM+2e4XJqV4ib7NE3fDywZ
yvdKu2RsiIvp2Cv8G/MDy2qsRX2NIhUMAnY2hVGx0t7JZMsown1ioMC/BTNWnM0C
R2wSULYnSVqdYtgJbEZb
=6r9q
-----END PGP SIGNATURE-----
