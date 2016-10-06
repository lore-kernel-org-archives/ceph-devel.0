From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: new naming convention for building repos and binaries from branches
Date: Thu, 6 Oct 2016 11:56:35 -0600
Message-ID: <CAJ4mKGbfTw+7y_XBkgDj6vzu65Z=VgfpMrBGNM5E+ZAVP3wC_w@mail.gmail.com>
References: <CAC-Np1wcBGRcFYtK8WsjfM-WR+H_S58XgH74D+dBiGxd=KwZUQ@mail.gmail.com>
 <CALe9h7da1Oz29q2pot1BZLNBcs1NJ51BRLE+Uj_3mVjnDGw6fQ@mail.gmail.com>
 <CAEPMp+7OJ+pX=mYbNGgm+HZMGOGDK3xiApw5OL03vsN9YApTGA@mail.gmail.com> <alpine.DEB.2.11.1610061633440.19850@piezo.us.to>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f41.google.com ([209.85.214.41]:38886 "EHLO
        mail-it0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751201AbcJFR4h (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Oct 2016 13:56:37 -0400
Received: by mail-it0-f41.google.com with SMTP id o19so37308877ito.1
        for <ceph-devel@vger.kernel.org>; Thu, 06 Oct 2016 10:56:37 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.11.1610061633440.19850@piezo.us.to>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: Andrew Schoen <aschoen@redhat.com>, John Spray <jspray@redhat.com>, Alfredo Deza <adeza@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Oct 6, 2016 at 10:34 AM, Sage Weil <sweil@redhat.com> wrote:
> On Thu, 6 Oct 2016, Andrew Schoen wrote:
>> >> We could keep the implicit convention for `wip-*` or maybe something similar?
>> >
>> > Building everything that starts with wip-* sounds fine to me.  But
>> > isn't that usually everything that we push to the ceph/ceph
>> > repository?  What is is that we're trying to avoid building?
>> >
>> > John
>>
>> I think the idea is that we only want to build branches that we plan
>> to run tests against. As we add more flavors, distros and
>> architectures to build for the workload increases exponentially. The
>> system is designed to scale, but let's not build things we don't
>> really need.
>
> I think we need a "do not build" prefix and a "build this asap" prefix.
> Maybe nobuild-* and asap-*?

I can't imagine anybody's going to remember to stick "nobuild" in
front of things. If we're really concerned about not building
everything, it needs to be proactive. I'd really like two interfaces:
1) append "-build" to the end of a branch. This would have to be a
postfix so we don't pick up every branch that fixes some build issue
or rearranges the makefiles.
2) Have a web page or github integration we can use to say "include
this branch in the builds".

In particular what I'm thinking is, we want a way to build stuff right
away from the push for quick turnaround times. But we'll want to push
branches for RFC etc before we really care if they're widely built,
and renaming them or trying to update two refs would be a hassle.
-Greg
