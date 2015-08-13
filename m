From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: infernalis feature freeze
Date: Thu, 13 Aug 2015 10:29:22 +0800
Message-ID: <CACJqLyauoGqtYAphrsT-=-=ud1+N5W02JaWB+8a7gOUxnZOGyw@mail.gmail.com>
References: <alpine.DEB.2.00.1508121411400.22099@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f175.google.com ([209.85.160.175]:32994 "EHLO
	mail-yk0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751205AbbHMC3X (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Aug 2015 22:29:23 -0400
Received: by ykaz130 with SMTP id z130so30615912yka.0
        for <ceph-devel@vger.kernel.org>; Wed, 12 Aug 2015 19:29:22 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1508121411400.22099@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Samuel Just <sjust@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I hope this PR could be pushed to I :-) It seemed waited so long.
https://github.com/ceph/ceph/pull/3595

On Thu, Aug 13, 2015 at 5:20 AM, Sage Weil <sweil@redhat.com> wrote:
> The infernalis feature freeze is coming up Real Soon Now.  I've marked
> some of the pull requests on github that I would like to see merged.
> Please take a look:
>
>         https://github.com/ceph/ceph/pulls?q=is%3Aopen+is%3Apr+milestone%3Ainfernalis
>
> Ideally we should focus our testing efforts on whatever is on this list.
>
> I didn't look at the bug fix PRs carefully since generally these go in
> once tested regardless of any feature freeze, but I suggest we mark things
> that need to make it into infernalis anyway so that we focus our efforts.
>
> The big items on my list that are pending testing are:
>
>         wip-newstore-sort (teuthology running now)
>         wip-newstore (will be marked experimental)
>         wip-osd-compat (enforces upgrades include hammer, needs qa)
>         wip-user (run daemons as user 'ceph')
>         proxy writes (Sam is testing this)
>         bufferlist tuning (performance)
>         MOSDOp staged decoding (performance)
>
> There's tons of other stuff pending that is not on this list.  As always,
> our ability to merge code is limited primarily on our ability to test
> it--we can't afford to destabilize core ceph by merging something that we
> aren't confident will work correctly and will not easily break down the
> line.  If you have something pending that you want to get in, the single
> biggest thing you can do to help that happen is to write more or better
> tests for it (e.g., things that run during 'make check') and to run the
> teuthology regression suite (see Loic's recent blogs about doing this with
> OpenStack[1]).
>
> Thanks!
> sage
>
> [1] http://dachary.org/?p=3852
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Best Regards,

Wheat
