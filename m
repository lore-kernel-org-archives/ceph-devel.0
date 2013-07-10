From: Gregory Farnum <greg@inktank.com>
Subject: Re: 4x write amplification?
Date: Wed, 10 Jul 2013 10:43:18 -0700
Message-ID: <CAPYLRzj_8WvEXs55e5DuD3kaiLH17en=HVtgCS1bm0Q84PGcQg@mail.gmail.com>
References: <51DCC225.1050700@ubuntukylin.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f180.google.com ([209.85.212.180]:38075 "EHLO
	mail-wi0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754728Ab3GJRnU (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Jul 2013 13:43:20 -0400
Received: by mail-wi0-f180.google.com with SMTP id c10so6620016wiw.13
        for <ceph-devel@vger.kernel.org>; Wed, 10 Jul 2013 10:43:19 -0700 (PDT)
In-Reply-To: <51DCC225.1050700@ubuntukylin.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Li Wang <liwang@ubuntukylin.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>

On Tue, Jul 9, 2013 at 7:08 PM, Li Wang <liwang@ubuntukylin.com> wrote:
> Hi,
>   We did a simple throughput test on Ceph with 2 OSD nodes configured
> with one replica policy. For each OSD node, the throughput measured by 'dd'
> run locally is 117MB/s. Therefore, in theory, the two OSDs could provide
> 200+MB/s throughput. However, using 'iozone' from clients we only get a peak
> throughput at around 40MB/s. Is that because a write will incur 2 replica *
> 2 journal write? That is, writing into journal
> and replica doubled the traffic, respectively, which results in a total
> 4x write amplification. Is that true, or our understanding is wrong,
> and some performance tuning hint?

Well, that write amplification is certainly happening. However, I'd
expect to get a better ratio out of the disk than that. Couple things
to check:
1) is your benchmark dispatching multiple requests at a time, or just
one? (the latency on a single request is going to make throughput
numbers come out badly.)
2) How do your disks handle two simultaneous write streams? (Most
disks should be fine, but sometimes they struggle.)
-Greg
Software Engineer #42 @ http://inktank.com | http://ceph.com
