From: Wei Jin <wjin.cn@gmail.com>
Subject: Re: Does mon skew really matters?
Date: Sat, 4 Jun 2016 18:17:46 +0800
Message-ID: <CAPpSHbW_bz9b-+BUmX+hJJodh-hF428-2KA9UZ3mcNOUR303gQ@mail.gmail.com>
References: <CALZt5jypeXGhVhhjur8dpC5KPDqFN-HRC+HbUzOEmVtzO6N1vQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qg0-f45.google.com ([209.85.192.45]:35940 "EHLO
	mail-qg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750809AbcFDKRs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 4 Jun 2016 06:17:48 -0400
Received: by mail-qg0-f45.google.com with SMTP id q32so22793585qgq.3
        for <ceph-devel@vger.kernel.org>; Sat, 04 Jun 2016 03:17:47 -0700 (PDT)
In-Reply-To: <CALZt5jypeXGhVhhjur8dpC5KPDqFN-HRC+HbUzOEmVtzO6N1vQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ning Yao <zay11022@gmail.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

In my opinion, if clock drift is too heavy, the lease protocol inside
paxos won't work. Lease may be timeout and then triggers monitor to
bootstrap.

You could try to shift clock back on the leader node to see what will happen.

Time check mechanism gives us warning message so that we may take
actions if possible before things getting worse.

On Sat, Jun 4, 2016 at 12:06 PM, Ning Yao <zay11022@gmail.com> wrote:
> Hi, all
>
> I find that even if I have mon clock skew warning, under most cases,
> my cluster still can work properly as expected.
>
> I go through the code in mon but do not find any related issue without
> time_check() to update whether clock skew periodically.
>
> can any one tell what is the design purpose of the clock skew between
> mon and when it will really matter the cluster?
>
> Thanks a lots!
>
> Regards
> Ning Yao
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
