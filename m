From: =?ISO-8859-2?Q?S=B3awomir_Skowron?= <szibis@gmail.com>
Subject: Re: Missing required features 2000
Date: Tue, 21 Feb 2012 14:45:18 +0100
Message-ID: <CAMwB3Tg8Xh2cgaNrK8t40woJmYaJh38BUQZrZ7vkLboKdyMO8A@mail.gmail.com>
References: <CAMwB3Tjs8yiL1y7QgtRdbdCo2kmun-E4MRe6vGiG2ZvB2EUF4Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-we0-f174.google.com ([74.125.82.174]:56479 "EHLO
	mail-we0-f174.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752647Ab2BUNpT convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 21 Feb 2012 08:45:19 -0500
Received: by werb13 with SMTP id b13so3805225wer.19
        for <ceph-devel@vger.kernel.org>; Tue, 21 Feb 2012 05:45:18 -0800 (PST)
In-Reply-To: <CAMwB3Tjs8yiL1y7QgtRdbdCo2kmun-E4MRe6vGiG2ZvB2EUF4Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

Ok Sorry for trouble, this is old version of ceph on one machine. All
packages has been updated to 0.42, except a ceph package :(

2012/2/21 S=C5=82awomir Skowron <szibis@gmail.com>:
> What is that mean v0.42 in mon log:
>
> 2012-02-21 14:31:56.188513 7f4c59cee700 -- 10.177.64.4:6789/0 >>
> 10.177.64.6:6815/11843 pipe(0x133f280 sd=3D36 pgs=3D0 cs=3D0 l=3D1).p=
eer
> missing required features 2000
> 2012-02-21 14:31:56.215195 7f4c59cee700 -- 10.177.64.4:6789/0 >> :/0
> pipe(0x133f780 sd=3D36 pgs=3D0 cs=3D0 l=3D0).accept sd=3D36
> 2012-02-21 14:31:56.215376 7f4c59cee700 -- 10.177.64.4:6789/0 >>
> 10.177.64.6:6809/11390 pipe(0x133f780 sd=3D36 pgs=3D0 cs=3D0 l=3D1).p=
eer
> missing required features 2000
> 2012-02-21 14:31:56.254106 7f4c59cee700 -- 10.177.64.4:6789/0 >> :/0
> pipe(0x1672a00 sd=3D36 pgs=3D0 cs=3D0 l=3D0).accept sd=3D36
> 2012-02-21 14:31:56.254280 7f4c59cee700 -- 10.177.64.4:6789/0 >>
> 10.177.64.6:6866/8497 pipe(0x1672a00 sd=3D36 pgs=3D0 cs=3D0 l=3D1).pe=
er
> missing required features 2000
> 2012-02-21 14:31:56.254888 7f4c59cee700 -- 10.177.64.4:6789/0 >> :/0
> pipe(0x11e5000 sd=3D36 pgs=3D0 cs=3D0 l=3D0).accept sd=3D36
> 2012-02-21 14:31:56.255063 7f4c59cee700 -- 10.177.64.4:6789/0 >>
> 10.177.64.6:6866/8497 pipe(0x11e5000 sd=3D36 pgs=3D0 cs=3D0 l=3D1).pe=
er
> missing required features 2000
> 2012-02-21 14:31:56.278601 7f4c59cee700 -- 10.177.64.4:6789/0 >> :/0
> pipe(0x11e5280 sd=3D36 pgs=3D0 cs=3D0 l=3D0).accept sd=3D36
> 2012-02-21 14:31:56.278775 7f4c59cee700 -- 10.177.64.4:6789/0 >>
> 10.177.64.6:6803/10948 pipe(0x11e5280 sd=3D36 pgs=3D0 cs=3D0 l=3D1).p=
eer
> missing required features 2000
> 2012-02-21 14:31:56.289903 7f4c59cee700 -- 10.177.64.4:6789/0 >> :/0
> pipe(0x11e5780 sd=3D36 pgs=3D0 cs=3D0 l=3D0).accept sd=3D36
> 2012-02-21 14:31:56.290199 7f4c59cee700 -- 10.177.64.4:6789/0 >>
> 10.177.64.6:6830/7347 pipe(0x11e5780 sd=3D36 pgs=3D0 cs=3D0 l=3D1).pe=
er
> missing required features 2000
> 2012-02-21 14:31:56.290768 7f4c59cee700 -- 10.177.64.4:6789/0 >> :/0
> pipe(0xe95c80 sd=3D36 pgs=3D0 cs=3D0 l=3D0).accept sd=3D36
> 2012-02-21 14:31:56.290944 7f4c59cee700 -- 10.177.64.4:6789/0 >>
> 10.177.64.6:6830/7347 pipe(0xe95c80 sd=3D36 pgs=3D0 cs=3D0 l=3D1).pee=
r missing
> required features 200
>
> After adding a new osd's into cluster.
>
> --
> -----
> Pozdrawiam
>
> S=C5=82awek "sZiBis" Skowron



--=20
-----
Pozdrawiam

S=C5=82awek "sZiBis" Skowron
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
