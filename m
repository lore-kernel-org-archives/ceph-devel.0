From: Colin McCabe <cmccabe@alumni.cmu.edu>
Subject: Re: [ceph-commit] ceph.git branch unstable updated. v0.24.1-327-gae47f3c
Date: Tue, 18 Jan 2011 00:41:47 -0800
Message-ID: <AANLkTi=12WSg3DZto8TZHDQOFNO5Vv_F_TgqxUL3tPB2@mail.gmail.com>
References: <20110115001637.37E824366724@ceph-tracker.dreamhostps.com>
	<AANLkTi=mKKJOnARspw+qUa8Zt0ZLO+0=HS8+DeNa8iRE@mail.gmail.com>
	<AANLkTikN-sd=QLZCWYeL=YAz7+2xZFTZCYTy2Oz6te8N@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-fx0-f46.google.com ([209.85.161.46]:40633 "EHLO
	mail-fx0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751433Ab1ARIls (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Jan 2011 03:41:48 -0500
Received: by fxm20 with SMTP id 20so6934076fxm.19
        for <ceph-devel@vger.kernel.org>; Tue, 18 Jan 2011 00:41:47 -0800 (PST)
In-Reply-To: <AANLkTikN-sd=QLZCWYeL=YAz7+2xZFTZCYTy2Oz6te8N@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gregf@hq.newdream.net>
Cc: Tommi Virtanen <tv42@ceph-tracker.dreamhostps.com>, Sage Weil <sage@newdream.net>, Yehuda Sadeh <yehuda@newdream.net>, Josh Durgin <joshd@newdream.net>, Samuel Just <samuelj@newdream.net>, Tommi Virtanen <tv@hq.newdream.net>, ceph-devel@vger.kernel.org

Moving to list.

On Mon, Jan 17, 2011 at 10:21 PM, Gregory Farnum <gregf@hq.newdream.net> wrote:
> On Mon, Jan 17, 2011 at 9:42 PM, Colin McCabe <cmccabe@alumni.cmu.edu> wrote:
>> I guess the first question is a philosophical one. Do we want to allow
>> people to use things like the heap checker or valgrind on unit tests?
>> I think we should, since it will be add to the usefulness of unit
>> tests in general. The second question is, if we do want to do that,
>> how should we go about it? I think you have the right idea with making
>> common_init more granular, so that we can initialize just the heap
>> checker or signal handler without pulling in the whole thing. If you
>> agree, let's open a bug to get this taken care of, since you
>> apparently didn't like my "just call common_init" solution.
>
> Unit tests probably ought to be simple enough that you don't need a
> full backtrace handler. Certainly it doesn't need tcmalloc's heap
> checker.

Well, nobody needs a backtrace handler until his or her code has a
bug. Then everyone needs one, whether the code is simple or not.

I'm trying to think ahead to the future here, where we might see
scenarios like "make check got a segfault on the continuous build
server, but it runs just fine locally. Gee, I wonder what the problem
is?" Unfortunately, stuff like this happens a lot. Uninitialized
memory is often 0, and things may work "accidentally." malloc(<large
random number>) may work-- if your computer is beefy enough.

> If we do want some of our other advanced features, I think we
> should add them in individually as otherwise it becomes too easy to
> pollute our unit tests with unexpected setup bits.

I agree completely. That's why I talked about "making common_init more
granular."

regards,
Colin
