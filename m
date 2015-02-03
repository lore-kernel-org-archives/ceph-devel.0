From: Chris Pacejo <cpacejo@clearskydata.com>
Subject: Re: [ceph-users] keyvaluestore backend metadata overhead
Date: Tue, 3 Feb 2015 10:13:05 -0500
Message-ID: <CAC8iE5gmiFFGikg0JatUs-7Jfv3sgFPd3ESx5+bOdkYSP6ByKg@mail.gmail.com>
References: <CAC8iE5iHTEfSQL978paWpu9hSfUbE65OVT_dKi2P=yvWSQ5JhA@mail.gmail.com>
	<alpine.DEB.2.00.1501291447290.3895@cobra.newdream.net>
	<CACJqLya-SNwudLTOqu2RPgr3_MZKzFWi9gXYH_xCg1WjxAx59w@mail.gmail.com>
	<CAC8iE5jrYquoQ+n+uwiiZ5uevXfipGsab9a_CgjtZoW9h1L0SQ@mail.gmail.com>
	<CACJqLyZnx28QEDU-Jy3KjzS6sumMG_ivqJQ9Ye_cg++Cj8WWQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:42876 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932332AbbBCPNG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Feb 2015 10:13:06 -0500
Received: by mail-ie0-f170.google.com with SMTP id y20so25872607ier.1
        for <ceph-devel@vger.kernel.org>; Tue, 03 Feb 2015 07:13:05 -0800 (PST)
In-Reply-To: <CACJqLyZnx28QEDU-Jy3KjzS6sumMG_ivqJQ9Ye_cg++Cj8WWQg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>
Cc: Sage Weil <sage@newdream.net>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Jan 30, 2015 at 10:52 AM, Haomai Wang <haomaiwang@gmail.com> wrote:
>>> As for active write, why do you think it there only one active write
>>> in keyvaluestore threads? I just check runtime perf data again, it
>>> looks fine that multi write can do concurrently submit transaction.
>
> You can simply calculate the sum of submit_transaction_sync consuming
> time, it would be the multiple of the op thread number.

I've instrumented submit_transaction to tick up/down an atomic
counter.  While in certain situations (resource-constrained VM; OSD
startup), I do see up to "keyvaluestore op threads" number of
concurrent transaction submits reported by this counter, on real
hardware, during `rados bench` with 2700-byte objects, I never see
more than 3 concurrent submits; on average, I see 2.  I don't know the
OSD's internals well enough to speculate on the cause, but it's worth
noting that the OSD processes consume a lot of CPU (170%+) during
these benchmarks (compared to 14% for 1 MiB objects).

We'll keep experimenting, but we're definitely excited of the
possibility of reducing metadata overhead
