From: James Page <james.page@ubuntu.com>
Subject: Re: Debian packaging question
Date: Thu, 13 Dec 2012 09:09:50 +0000
Message-ID: <50C99B5E.9010006@ubuntu.com>
References: <B29C14E0-EFB2-4F4C-A1CA-481CB3F7AC39@inktank.com> <50C6C5E5.6010107@widodh.nl> <0D99561D-3A0B-4766-9770-8A90E37B7A24@inktank.com> <50C705A9.1030603@ubuntu.com> <7A33695B-249B-4638-94BF-BC3BD283216B@inktank.com> <50C864A8.1010707@ubuntu.com> <alpine.DEB.2.00.1212120742140.8754@cobra.newdream.net> <50C90293.4060407@ubuntu.com> <95BEC6FE-ECFA-4106-BF1F-C4BD43819602@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from youngberry.canonical.com ([91.189.89.112]:42566 "EHLO
	youngberry.canonical.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752927Ab2LMJJy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 13 Dec 2012 04:09:54 -0500
In-Reply-To: <95BEC6FE-ECFA-4106-BF1F-C4BD43819602@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gary Lowell <gary.lowell@inktank.com>
Cc: Sage Weil <sage@inktank.com>, Wido den Hollander <wido@widodh.nl>, ceph-devel <ceph-devel@vger.kernel.org>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

On 12/12/12 23:38, Gary Lowell wrote:
> I took your new rules file out for a spin.  It built ok, but we
> still got the libcephfs-java_0.55.1-1precise_all.deb built despite
> the --binary-arch flag.  The command used for the build is:
> 
> sudo pbuilder build --binary-arch --debug --distribution precise
> --basetgz /srv/debian-base/precise.tgz --buildresult
> /tmp/release/0.55.1/ --debbuildopts '-j8 -b'
> /tmp/release/0.55.1/ceph_0.55.1-1precise.dsc
> 
> And the log shows the -B option on dpkg-buildpackage:
> 
> I: Building the package I: Running cd tmp/buildd/*/ && env
> PATH="/usr/lib/ccache:/usr/sbin:/usr/bin:/sbin:/bin"
> dpkg-buildpackage -us -uc   -B -j8 -b -rfakeroot


I think that the "--debbuildopts '-j8 -b'" might be trouncing the
- --binary-arch flag - I'll get pbuilder setup and give it a test - I
normally use sbuild (for which the packaging changes did have the
desired effect).



- -- 
James Page
Ubuntu Core Developer
Debian Maintainer
james.page@ubuntu.com
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)
Comment: Using GnuPG with undefined - http://www.enigmail.net/

iQIcBAEBCAAGBQJQyZteAAoJEL/srsug59jDJWkP/1zjLIrtuyju2ButhcouDcv3
zxST5h+vizA9CWhl8WGeckoi1aTUA1Xs1oYYnfBMJyWaSyZFinhI8L32kHw/7eau
fvzMHBFJaEl3CFCYBZK/D7SyRLIsVLEayQhpIJOyOofSDSw466br5A5v3o2M+MFZ
+bdVBZmfF/2xRZpNnM8n+Orm35V70ejifwhPF6LXjzjxL9L40ft3KTi9XLxuZ6De
lQorbGGQ/pFWaerNK2a3TPvLynsstLofeWYfwSywh0uDK22StABu+T29rxS9fr4d
y6GaND185Lakrux/bWbnPntQPTzYY/6w93PM+zzHwpwsAWokhsRSrn1aN4IH9qy1
e48wHRnuZl7263bG10FklIVqI6Mfk4WrtEiuZNM7O74bFSS2Xd5I418BQKoIwzaq
Kcg3AHaIC2eGUKtjUi/uljDIYowWXAI6JOFClNIgj69lS0cE3SdwXfwhnRTHX5vc
h5ku8gaYiejpnoNFXfJYC5W458TU0aXNaqecWCdX+gNOfYuntCDQSWCT4NDSaA92
VQJXyvn7UOz5qFY5jQ9J0lpCUlaIWa5TVpsT5RJmZLhDV8aR0t4EnaS7q4HI6uZ6
JZNY9j/EIwMAG5Oqf3dThi5tyxxgwQ6Qvvk9UIMdv9mWkw/jtKHZSWK0cyskbjK9
lM0og+k9EJHQtOa7yNj8
=dOQW
-----END PGP SIGNATURE-----
