From: Sage Weil <sweil@redhat.com>
Subject: Re: new naming convention for building repos and binaries from
 branches
Date: Thu, 6 Oct 2016 18:09:48 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1610061803380.19850@piezo.us.to>
References: <CAC-Np1wcBGRcFYtK8WsjfM-WR+H_S58XgH74D+dBiGxd=KwZUQ@mail.gmail.com> <CALe9h7da1Oz29q2pot1BZLNBcs1NJ51BRLE+Uj_3mVjnDGw6fQ@mail.gmail.com> <CAEPMp+7OJ+pX=mYbNGgm+HZMGOGDK3xiApw5OL03vsN9YApTGA@mail.gmail.com> <alpine.DEB.2.11.1610061633440.19850@piezo.us.to>
 <CAJ4mKGbfTw+7y_XBkgDj6vzu65Z=VgfpMrBGNM5E+ZAVP3wC_w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:56218 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1753113AbcJFSJv (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 6 Oct 2016 14:09:51 -0400
Received: from int-mx13.intmail.prod.int.phx2.redhat.com (int-mx13.intmail.prod.int.phx2.redhat.com [10.5.11.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 1CB4B6331E
        for <ceph-devel@vger.kernel.org>; Thu,  6 Oct 2016 18:09:51 +0000 (UTC)
In-Reply-To: <CAJ4mKGbfTw+7y_XBkgDj6vzu65Z=VgfpMrBGNM5E+ZAVP3wC_w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <gfarnum@redhat.com>
Cc: Andrew Schoen <aschoen@redhat.com>, John Spray <jspray@redhat.com>, Alfredo Deza <adeza@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 6 Oct 2016, Gregory Farnum wrote:
> On Thu, Oct 6, 2016 at 10:34 AM, Sage Weil <sweil@redhat.com> wrote:
> > On Thu, 6 Oct 2016, Andrew Schoen wrote:
> >> >> We could keep the implicit convention for `wip-*` or maybe something similar?
> >> >
> >> > Building everything that starts with wip-* sounds fine to me.  But
> >> > isn't that usually everything that we push to the ceph/ceph
> >> > repository?  What is is that we're trying to avoid building?
> >> >
> >> > John
> >>
> >> I think the idea is that we only want to build branches that we plan
> >> to run tests against. As we add more flavors, distros and
> >> architectures to build for the workload increases exponentially. The
> >> system is designed to scale, but let's not build things we don't
> >> really need.
> >
> > I think we need a "do not build" prefix and a "build this asap" prefix.
> > Maybe nobuild-* and asap-*?
> 
> I can't imagine anybody's going to remember to stick "nobuild" in
> front of things. If we're really concerned about not building
> everything, it needs to be proactive. I'd really like two interfaces:
> 1) append "-build" to the end of a branch. This would have to be a
> postfix so we don't pick up every branch that fixes some build issue
> or rearranges the makefiles.
> 2) Have a web page or github integration we can use to say "include
> this branch in the builds".
> 
> In particular what I'm thinking is, we want a way to build stuff right
> away from the push for quick turnaround times. But we'll want to push
> branches for RFC etc before we really care if they're widely built,
> and renaming them or trying to update two refs would be a hassle.

It might be simpler to just avoid pushing things to ceph.git that aren't 
meant to be built; that's what our personal github clone repos are usually 
for.  Which means (IMO) we only really need a "please build this branch 
before the others".  And that doesn't need to be done as part of the 
branch name.  In fact, it's probably better if it isn't, so that you can 
prioritize a branch even after it has been pushed.

But this reminds me... a while back I created a ceph-ci.git repo, the idea 
being that we could move *all* of the wip-* and random branches from 
ceph.git over there and have ceph.git only contain the "official" branches 
(like master, jewel, hammer, etc.).  CI would pull from both, and we could 
allow developers access to ceph-ci.git without giving them access to 
ceph.git.

We talked about this ages ago but never actually made any switch.  Maybe 
this is a good time to do it?

Original thread here: http://www.spinics.net/lists/ceph-devel/msg24251.html

sage
