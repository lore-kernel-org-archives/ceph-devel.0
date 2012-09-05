From: James Page <james.page@ubuntu.com>
Subject: Re: Initial rest-bench execution failure
Date: Wed, 05 Sep 2012 16:41:34 +0100
Message-ID: <504772AE.2070403@ubuntu.com>
References: <50473D4F.4010903@ubuntu.com> <CAC-hyiEicrcTCK9qtRAKkkM4Pc6A7dgHh777VFCTz7Wn3jfs1w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:38724 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753085Ab2IEPlh (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Sep 2012 11:41:37 -0400
In-Reply-To: <CAC-hyiEicrcTCK9qtRAKkkM4Pc6A7dgHh777VFCTz7Wn3jfs1w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@inktank.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 05/09/12 15:38, Yehuda Sadeh wrote:
>>> Any ideas?  It looks like it might be a bug in libs3 as this is
>>> where the ConnectionRefused return code status is set.
>>> 
> Sounds like a short timeout on the bucket creation operation, might
> be a libs3 configurable. The first time it takes a bit longer (2
> seconds in this example) as it needs to create some initial pools
> for rgw to operate.

Sounds probably - I'll have a poke and see if I can increase that
timeout then.

- -- 
James Page
Ubuntu Core Developer
Debian Maintainer
james.page@ubuntu.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://www.enigmail.net/

iQIcBAEBCAAGBQJQR3KuAAoJEL/srsug59jDct8QAJDSvEIBO1+LkSQJe3Xzj2Ao
PUjnh6azFoNYLKPpmbiZLRIBuudCjFh4r5IG3K6/3vTcNHKG8rSiz6NCLThGctPD
Hwsno45VatOWfdYzrAAyb7zZZ5IbgFqUe5rySaX45fB8hXlsQ3kPxpbW0HYXd40E
gY8hhrJbhnYjsHcItoQ8R95IVxyXsfb2vxeEfTJLF8iP+/PTIbm92XHngG3WBiga
hyHHDP/VVOwG0VSyV/vZDsdph6vDm0RHEA5hczJp3AF60QrmpWsB1pp9OihBo255
xVC/AUS9USnQIfDEhjertZ8GtT50ng452jYPKc+tCYL5tyT588wX4eAzhWPoy2py
cZpCuKg2cs/r9NbOWWRrOJZK3QGeyqqCwJrPqT18I3OSniQ01ZSsI5uPpDJqU8fC
UMXrzVtdBc9Cqt88VpHJgcFnKx6Vf95OHOARMWRZwq+5Tr4nobsXPTqTxI06JoCL
aPiQq3hzd39HHgNqyTYO4mUdHMSKd/ozT8jsck9H421WNaKrL1ZVospLIEYDqGNU
bPhX/bQA1tqujnvnDq/a4DRQPA52zYfeNGayI3F7NHKwyRy2NV1FNs80yGi2oLq5
4EXW/tuYSK06lhai/ApMND4sQCaLmkLO8ClWCcxuw6oFCj95OMO+JOn9WpUjoiaA
9WT1zF2lIEiSsBKDeKPb
=icp5
-----END PGP SIGNATURE-----
