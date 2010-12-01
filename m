From: Jeff Wu <cpwu@tnsoft.com.cn>
Subject: Re: Performence test on ceph v0.23 + EXT4 and Btrfs
Date: Wed, 1 Dec 2010 09:35:44 +0800
Message-ID: <1291167344.1809.60.camel@cephhost>
References: <1291001135.1872.106.camel@cephhost>
	 <AANLkTi=E=pjvixkronpD-ij0CxjFBVauN5bBrsbT8nqW@mail.gmail.com>
	 <1291085741.1809.25.camel@cephhost>
	 <AANLkTikz_quAcoYL8VUoA4i87WczKCh0yM2TsCG6dQEz@mail.gmail.com>
	 <1291097975.1809.54.camel@cephhost>
	 <AANLkTinkgBwzfESaQNs0VkLn+LGbd8wEccy6LNDSFM2Z@mail.gmail.com>
Reply-To: <cpwu@tnsoft.com.cn>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from [210.22.136.227] ([210.22.136.227]:56211 "EHLO
	MAIL.TNSOFT.COM.CN" rhost-flags-FAIL-FAIL-OK-FAIL) by vger.kernel.org
	with ESMTP id S1753425Ab0LABeg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 30 Nov 2010 20:34:36 -0500
In-Reply-To: <AANLkTinkgBwzfESaQNs0VkLn+LGbd8wEccy6LNDSFM2Z@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Andrew Lv <mllv@tnsoft.com.cn>



=E5=9C=A8 2010-12-01=E4=B8=89=E7=9A=84 01:07 +0800=EF=BC=8CGregory Farn=
um=E5=86=99=E9=81=93=EF=BC=9A
> On Mon, Nov 29, 2010 at 10:19 PM, Jeff Wu <cpwu@tnsoft.com.cn> wrote:
> > Is "40-50MB/s" the speed that it run bench at local btrfs disk ?
> > not the speed that run bench from client to osd server ?
> > with this speed ,run bench from client to osd server ,will which  g=
et
> > about 20~25MB/s( 40~50MB /2 )speed ?
> Data on Ceph is replicated across 2 OSDs (by default; this is
> configurable). So while figuring out potential performance involves a
> lot of variables, in a simple case like this where you aren't bounded
> by network bandwidth you'll find that your read/write performance
> simply tracks the slower disk. I'd expect your Ceph tests (at least
> the streaming ones) to run at 40-50MB/s.

Hi Greg,thank you very much for your quickly reply.
>=20
> Given that everything else is okay, I cannot stress enough that
> running without a journal is going to cause significant performance
> degradations. I have a hard time believing that it's responsible for
> 13-second latencies, but it's possible. So how about you set up a
> journal (it can just be a file or new partition on the drives you're
> already using) and report back your results after you do that. :)

I will add journal to ceph.conf to try it .=20



> Adding a journal to the OSDs lets them turn all their random writes
> into streaming ones.
> -Greg

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
