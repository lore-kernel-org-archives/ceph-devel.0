From: Milosz Tanski <milosz@adfin.com>
Subject: Re: Profiling with Perf
Date: Wed, 12 Nov 2014 15:59:38 -0500
Message-ID: <CANP1eJFi3AhK-7HYLm7n78=ygGK2d4_UXc2_EqOCc3tFUVvtOA@mail.gmail.com>
References: <5462C456.8070601@redhat.com>
	<5463C63B.2070502@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-lb0-f178.google.com ([209.85.217.178]:54820 "EHLO
	mail-lb0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753248AbaKLU7j (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 12 Nov 2014 15:59:39 -0500
Received: by mail-lb0-f178.google.com with SMTP id f15so11248121lbj.9
        for <ceph-devel@vger.kernel.org>; Wed, 12 Nov 2014 12:59:38 -0800 (PST)
In-Reply-To: <5463C63B.2070502@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Mark Nelson <mark.nelson@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Wed, Nov 12, 2014 at 3:42 PM, Mark Nelson <mark.nelson@inktank.com> wrote:
> Hi, there was a question on the performance call today about how to use
> dwarf symbols in perf.  Roughly:
>
> 1) Make sure during the kernel/perf compile that libunwind is used. This can
> be tricky depending on how you build the kernel, but theoretically should
> work.
>
> 2) invoke perf using something like:
>
> "perf record -g dwarf -F 100 -a"
>
> This tells perf to use dwarf symbols but limit the sampling rate.  perf can
> generate a *lot* of data with dwarf symbols and default sampling.
>
> 3) Look at results in perf report as normal.
>
> 4) Profit!
>
> Theoretically if you have frame pointers enabled when you compile ceph you
> should get good symbol resolution without dwarf but I've never gotten it to
> work well.  Perf+Dwarf seems to give much better symbol resolution than
> anything else I've tried with Ceph.  There's some new LBR functionality for
> profiling on Haswell in perf that might work too, but I haven't tried it:
>
> https://lkml.org/lkml/2014/10/19/166

Mark,

I personally would strong recommend using perf without the dwarf as it
seams writes very large trace files. It's not just file size, but it
also takes a very long time to load up profile in the other tools
(perf report). If you can help it rebuild the app with out the code
(eg the gcc -fno-omit-frame-pointer flag). When I say space savings
with call stack savings I mean like order of 2 magnitudes smaller
profile file (eg. you can log much longer / complicated runs).

Additionally, it seams to better handle splitting of inline functions
(where otherwise this would get folded into a large function). The
omit behavior is default on x86_64, which is what I assume most people
are building / testing on. There is a performance penalty for this as
the compiler will be generating an extra instruction to update EBP...
but for real world code this is less then 5% of a penalty.

I spend a lot of time using perf and looking at it's traces (runtime,
futex profiling, looking at bad branch points) every week. It took me
a little while to figure this out... I hope it help you guys.

- Milosz

>
> Mark
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Milosz Tanski
CTO
16 East 34th Street, 15th floor
New York, NY 10016

p: 646-253-9055
e: milosz@adfin.com
