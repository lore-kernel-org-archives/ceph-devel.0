From: Robert LeBlanc <robert@leblancnet.us>
Subject: Re: [ceph-users] Ceph giant installation fails on rhel 7.0
Date: Thu, 11 Jun 2015 08:32:24 -0600
Message-ID: <CAANLjFrLqAgyRbEGuVcF1AacyjRt5vBmq4i0HiG7_i8ySpDWdQ@mail.gmail.com>
References: <39F9E8A5546B9448A82E55FBEBE3EC4526584F21@SACMBXIP03.sdcorp.global.sandisk.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f52.google.com ([74.125.82.52]:35862 "EHLO
	mail-wg0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752432AbbFKOcZ convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Jun 2015 10:32:25 -0400
Received: by wgbgq6 with SMTP id gq6so6348987wgb.3
        for <ceph-devel@vger.kernel.org>; Thu, 11 Jun 2015 07:32:24 -0700 (PDT)
In-Reply-To: <39F9E8A5546B9448A82E55FBEBE3EC4526584F21@SACMBXIP03.sdcorp.global.sandisk.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Shambhu Rajak <Shambhu.Rajak@sandisk.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, "ceph-users@ceph.com" <ceph-users@ceph.com>

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Have you configured and enabled the epel repo?
- ----------------
Robert LeBlanc
GPG Fingerprint 79A2 9CA4 6CC4 45DD A904  C70E E654 3BB2 FA62 B9F1


On Thu, Jun 11, 2015 at 6:26 AM, Shambhu Rajak  wrote:
> I am trying to install ceph gaint on rhel 7.0, while installing
> ceph-common-0.87.2-0.el7.x86_64.rpm I am getting following dependency
>
>
>
> packages]$ sudo yum install ceph-common-0.87.2-0.el7.x86_64.rpm
>
> Loaded plugins: amazon-id, priorities, rhui-lb
>
> Examining ceph-common-0.87.2-0.el7.x86_64.rpm:
> 1:ceph-common-0.87.2-0.el7.x86_64
>
> Marking ceph-common-0.87.2-0.el7.x86_64.rpm to be installed
>
> Resolving Dependencies
>
> --> Running transaction check
>
> ---> Package ceph-common.x86_64 1:0.87.2-0.el7 will be installed
>
> --> Processing Dependency: libtcmalloc.so.4()(64bit) for package:
> 1:ceph-common-0.87.2-0.el7.x86_64
>
> --> Finished Dependency Resolution
>
> Error: Package: 1:ceph-common-0.87.2-0.el7.x86_64
> (/ceph-common-0.87.2-0.el7.x86_64)
>
>            Requires: libtcmalloc.so.4()(64bit)
>
> You could try using --skip-broken to work around the problem
>
> You could try running: rpm -Va --nofiles =E2=80=93nodigest
>
>
>
>
>
> So I am trying install gperftools-libs to resolve the dependencies, b=
ut I am
> unable to get the package using yum install
>
>
>
> Can any one help me getting the complete list of dependencies to inst=
all
> ceph giant on rhel 7.0.
>
>
>
> Thanks,
>
> Shambhu
>
>
>
>
> ________________________________
>
> PLEASE NOTE: The information contained in this electronic mail messag=
e is
> intended only for the use of the designated recipient(s) named above.=
 If the
> reader of this message is not the intended recipient, you are hereby
> notified that you have received this message in error and that any re=
view,
> dissemination, distribution, or copying of this message is strictly
> prohibited. If you have received this communication in error, please =
notify
> the sender by telephone or e-mail (as shown above) immediately and de=
stroy
> any and all copies of this message in your possession (whether hard c=
opies
> or electronically stored copies).
>
>
> _______________________________________________
> ceph-users mailing list
> ceph-users@lists.ceph.com
> http://lists.ceph.com/listinfo.cgi/ceph-users-ceph.com
>

-----BEGIN PGP SIGNATURE-----
Version: Mailvelope v0.13.1
Comment: https://www.mailvelope.com

wsFcBAEBCAAQBQJVeZv0CRDmVDuy+mK58QAAODEQALfE8XG5TTOSJGBl20O8
Ol47KjhHzAYtSTod3jFDJRqzpKDv61YKX4XAqOT3NrGiWP33hzWZiBQoYjlZ
LqsjmZyvOZfQVkS2v78C0oBmIqyFhND7Xp/U57CBGhhqMk/LS9P36eaYdywZ
MkYSqy+Jwk9Cg++VA4spbG+i6eu+Gp3vPJnJbzJ/3pLBK8K1wKz97qPuyztk
LSRIDejrdUPx355m2pAkzYVdVMaw41+FFiz4QJPCTfZx/Ya6oCboyBLFcNA0
vka2U3NmWHQDiT0MCOylTvDk4cqjX9bHFrqa0juNw0vxBwICoVa4JieLNlyE
CLPHUrqq3kfKHO18zapvc204uJuec/Ufm9bPW8cnXMg3m4izzUOQ5ZKDk5aL
K2WfTB0fozy099AsPnDOy4DYFkv2zIRTZngD4Gs0aIAQd7XIHv1SohEDve50
D6trpQW8BAzuQVaGh7pY9X1rWnRLeAdaXIW+X5aZlrhCZQDP4tTPvyL0VuGi
ncp1H5dnuZlfHXCSrMZUQoETgXAjhHl+ww+6RCccYzg2wEcT0TV7fXFKUkLU
jJlPMFOW0dqbt4NkxulBQrXKDPB/VsQFYegCcNPSyvOPsYs5iysy5u21tBz9
jfZjUA8qxaAGpQb2EnCGhsK3mWLV5ud3RqCQvBz7xiVeAXdQZEfcdKtlDjFi
Cpmr
=3DYtyr
-----END PGP SIGNATURE-----
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
