From: Gregory Farnum <greg@inktank.com>
Subject: Re: Ceph performance on Ubuntu Oneiric vs Ubuntu Precise
Date: Mon, 18 Jun 2012 11:04:01 -0700
Message-ID: <CAPYLRzgM=_1CpXB3Kr+=RFdaC3KPiVHGQyRurmTZJ=Zopsx=QA@mail.gmail.com>
References: <4FDF6BB8.4080401@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ee0-f46.google.com ([74.125.83.46]:54341 "EHLO
	mail-ee0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750792Ab2FRSED convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Jun 2012 14:04:03 -0400
Received: by eeit10 with SMTP id t10so1713724eei.19
        for <ceph-devel@vger.kernel.org>; Mon, 18 Jun 2012 11:04:01 -0700 (PDT)
In-Reply-To: <4FDF6BB8.4080401@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Do I correctly assume that these nodes hosted only the OSDs, and the
monitors were on a separate node?

On Mon, Jun 18, 2012 at 10:56 AM, Mark Nelson <mark.nelson@inktank.com>=
 wrote:
> Hi Guys,
>
> I've been tracking down some performance issues over the past month w=
ith our
> internal test nodes and believe I have narrowed it down to something =
related
> to Ubuntu Oneiric. =A0Tests done on nodes running Ubuntu Precise are
> significantly faster.
>
> One of the major differences between the releases is the support for =
syncfs
> in libc. =A0Theoretically this shouldn't have a big effect on btrfs s=
o I'm not
> totally sure that this is the culprit. =A0Having said that, previous =
tests
> showed good SSD performance on Oneiric leading me to believe the lowe=
r
> latency mitigates the effect. =A0Some of spinning disk seekwatcher re=
sults for
> Oneiric are quite strange with long periods of inactivity on the OSD =
data
> disks.
>
> I wanted to post these results for those of you who have had performa=
nce
> problems in the past. =A0If you are continuing to have issues, you ma=
y want to
> try testing on precise and see if you notice any changes. =A0It is po=
ssible
> that all of this could be specific to our internal testing nodes, so =
I
> wouldn't mind hearing if other people have seen similar behavior.
>
> These tests were done using rados bench with 16 concurrent requests. =
There
> are two nodes that each have a single 7200rpm OSD data disk and journ=
al on a
> second 7200rpm disk. =A0Replication is set at the default level (2). =
=A0Kernel
> is 3.4 in all cases.
>
> Here's a run down (Numbers are MB/s)
>
> 4KB Requests
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BTRFS =A0 EXT4 =A0 =A0=
XFS
> Ceph 0.46/Oneiric: =A0 =A0 =A00.073 =A0 0.694 =A0 0.723
> Ceph 0.46/Precise: =A0 =A0 =A02.15 =A0 =A02.031 =A0 1.546
> Ceph 0.47.2/Oneiric: =A0 =A01.072 =A0 0.836 =A0 0.749
> Ceph 0.47.2/Precise: =A0 =A02.566 =A0 2.579 =A0 1.498
>
> 128KB Requests:
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BTRFS =A0 EXT4 =A0 =A0=
XFS
> Ceph 0.46/Oneiric: =A0 =A0 =A011.874 =A020.066 =A012.641
> Ceph 0.46/Precise: =A0 =A0 =A049.304 =A039.736 =A038.982
> Ceph 0.47.2/Oneiric: =A0 =A013.81 =A0 19.05 =A0 12.739
> Ceph 0.47.2/Precise: =A0 =A047.943 =A049.655 =A036.764
>
>
> 4MB Requests:
>
> =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0 =A0BTRFS =A0 EXT4 =A0 =A0=
XFS
> Ceph 0.46/Oneiric: =A0 =A0 =A0110.202 26.58 =A0 15.445
> Ceph 0.46/Precise: =A0 =A0 =A0135.975 128.759 106.426
> Ceph 0.47.2/Oneiric: =A0 =A091.337 =A046.277 =A023.897
> Ceph 0.47.2/Precise: =A0 =A0136.906 134.955 106.545
>
> I've posted seekwatcher results for all of the tests:
>
> Ceph 0.46/Oneiric: =A0 =A0 =A0http://nhm.ceph.com/movies/sprint/test2
> Ceph 0.46/Precise: =A0 =A0 =A0http://nhm.ceph.com/movies/sprint/test3
> Ceph 0.47.2/Oneiric: =A0 =A0http://nhm.ceph.com/movies/sprint/test4
> Ceph 0.47.2/Precise: =A0 =A0http://nhm.ceph.com/movies/sprint/test5
>
> Mark
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
