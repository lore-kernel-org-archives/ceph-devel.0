From: Alfredo Deza <adeza@redhat.com>
Subject: Re: new naming convention for building repos and binaries from branches
Date: Thu, 6 Oct 2016 14:55:42 -0400
Message-ID: <CAC-Np1wmFwEHV4WvN9d8tX_NenZ3wAfZE4XNgtW2O_Z_o29D_A@mail.gmail.com>
References: <CAC-Np1wcBGRcFYtK8WsjfM-WR+H_S58XgH74D+dBiGxd=KwZUQ@mail.gmail.com>
 <CALe9h7da1Oz29q2pot1BZLNBcs1NJ51BRLE+Uj_3mVjnDGw6fQ@mail.gmail.com>
 <CAEPMp+7OJ+pX=mYbNGgm+HZMGOGDK3xiApw5OL03vsN9YApTGA@mail.gmail.com>
 <alpine.DEB.2.11.1610061633440.19850@piezo.us.to> <CAJ4mKGbfTw+7y_XBkgDj6vzu65Z=VgfpMrBGNM5E+ZAVP3wC_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wm0-f51.google.com ([74.125.82.51]:35897 "EHLO
        mail-wm0-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932652AbcJFSzo (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Oct 2016 14:55:44 -0400
Received: by mail-wm0-f51.google.com with SMTP id k125so344582121wma.1
        for <ceph-devel@vger.kernel.org>; Thu, 06 Oct 2016 11:55:43 -0700 (PDT)
In-Reply-To: <CAJ4mKGbfTw+7y_XBkgDj6vzu65Z=VgfpMrBGNM5E+ZAVP3wC_w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Sage Weil <sweil@redhat.com>, Andrew Schoen <aschoen@redhat.com>, John Spray <jspray@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Oct 6, 2016 at 1:56 PM, Gregory Farnum <gfarnum@redhat.com> wrote:
> On Thu, Oct 6, 2016 at 10:34 AM, Sage Weil <sweil@redhat.com> wrote:
>> On Thu, 6 Oct 2016, Andrew Schoen wrote:
>>> >> We could keep the implicit convention for `wip-*` or maybe something similar?
>>> >
>>> > Building everything that starts with wip-* sounds fine to me.  But
>>> > isn't that usually everything that we push to the ceph/ceph
>>> > repository?

It isn't. There are a bunch of active branches that are not wip-*

>> What is is that we're trying to avoid building?

We should "build" (create binaries and repos for multiple distros) for
the branches that need to be tested out, either by
teuthology or by consuming the repo directly (e.g. ceph-deploy install
--dev=my-branch)

If you believe that every single active branch in
https://github.com/ceph/ceph/branches/active meets those requirements,
then
we should just not try to get a naming convention. I don't know if
that is the case.

>>> >
>>> > John
>>>
>>> I think the idea is that we only want to build branches that we plan
>>> to run tests against. As we add more flavors, distros and
>>> architectures to build for the workload increases exponentially. The
>>> system is designed to scale, but let's not build things we don't
>>> really need.
>>
>> I think we need a "do not build" prefix and a "build this asap" prefix.
>> Maybe nobuild-* and asap-*?
>
> I can't imagine anybody's going to remember to stick "nobuild" in
> front of things.

Yep, I agree, we can't do it that way.

>If we're really concerned about not building
> everything, it needs to be proactive. I'd really like two interfaces:
> 1) append "-build" to the end of a branch. This would have to be a
> postfix so we don't pick up every branch that fixes some build issue
> or rearranges the makefiles.
> 2) Have a web page or github integration we can use to say "include
> this branch in the builds".
>
> In particular what I'm thinking is, we want a way to build stuff right
> away from the push for quick turnaround times.

That is the case *today* and will not change later. A dev might
experience a slight delay but the whole idea
is that even under heavy load the waiting time will not be 12 hours
(unless everything is burning down?)

>But we'll want to push
> branches for RFC etc before we really care if they're widely built,
> and renaming them or trying to update two refs would be a hassle.
> -Greg

The current caveat we have today is that the machines that produce the
repos are at about 60% full (they use 500gb drives each, we have 4
currently). Turning on 1 extra flavor would get us
out of space on at least two pretty quickly.

*We can add more to the pool*. So this is not really a make-or-break
situation, we can scale. But if there is a way to be more efficient by
building stuff that we really care, then lets
at least try.
