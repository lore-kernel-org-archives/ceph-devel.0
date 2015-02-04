From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: [ceph-users] keyvaluestore backend metadata overhead
Date: Wed, 4 Feb 2015 10:31:39 +0800
Message-ID: <CACJqLyZSDrCZKvC2REFzXvT+owV38de4ys+JmcENEL=zPtQGBg@mail.gmail.com>
References: <CAC8iE5iHTEfSQL978paWpu9hSfUbE65OVT_dKi2P=yvWSQ5JhA@mail.gmail.com>
	<alpine.DEB.2.00.1501291447290.3895@cobra.newdream.net>
	<CACJqLya-SNwudLTOqu2RPgr3_MZKzFWi9gXYH_xCg1WjxAx59w@mail.gmail.com>
	<CAC8iE5jrYquoQ+n+uwiiZ5uevXfipGsab9a_CgjtZoW9h1L0SQ@mail.gmail.com>
	<CACJqLyZnx28QEDU-Jy3KjzS6sumMG_ivqJQ9Ye_cg++Cj8WWQg@mail.gmail.com>
	<CAC8iE5gmiFFGikg0JatUs-7Jfv3sgFPd3ESx5+bOdkYSP6ByKg@mail.gmail.com>
	<CAC8iE5ggZme9BKz7noCynEpjd2yhCnoK5yd79pM2g7-237ZxkA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wi0-f182.google.com ([209.85.212.182]:63815 "EHLO
	mail-wi0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752544AbbBDCbk (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 3 Feb 2015 21:31:40 -0500
Received: by mail-wi0-f182.google.com with SMTP id n3so611042wiv.3
        for <ceph-devel@vger.kernel.org>; Tue, 03 Feb 2015 18:31:39 -0800 (PST)
In-Reply-To: <CAC8iE5ggZme9BKz7noCynEpjd2yhCnoK5yd79pM2g7-237ZxkA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Chris Pacejo <cpacejo@clearskydata.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Feb 4, 2015 at 4:25 AM, Chris Pacejo <cpacejo@clearskydata.com> wrote:
> The below observations (including high CPU usage by the OSDs) hold
> true when we (roughly) double the performance of the MySQL backend by
> pointing it to SSDs instead of rotary media.  This causes us to
> suspect that our current bottleneck is not the extra load placed on
> the backend by the metadata; but rather something in the OSD which
> causes it to be unable to saturate the backend.  Any thoughts?
>

Maybe more detail number can help us a bit.

>
> On Tue, Feb 3, 2015 at 10:13 AM, Chris Pacejo <cpacejo@clearskydata.com> wrote:
>> I've instrumented submit_transaction to tick up/down an atomic
>> counter.  While in certain situations (resource-constrained VM; OSD
>> startup), I do see up to "keyvaluestore op threads" number of
>> concurrent transaction submits reported by this counter, on real
>> hardware, during `rados bench` with 2700-byte objects, I never see
>> more than 3 concurrent submits; on average, I see 2.  I don't know the
>> OSD's internals well enough to speculate on the cause, but it's worth
>> noting that the OSD processes consume a lot of CPU (170%+) during
>> these benchmarks (compared to 14% for 1 MiB objects).
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards,

Wheat
