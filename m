From: Sage Weil <sweil@redhat.com>
Subject: Re: new boost
Date: Mon, 29 Aug 2016 16:00:28 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1608291556290.24244@piezo.us.to>
References: <alpine.DEB.2.11.1608261829420.24244@piezo.us.to> <CALqRxCzuD+uD4pw=E4Ds1gQh84hxHResMNkuoz7E7fYB9x1BJg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40166 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1751195AbcH2QBU (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Mon, 29 Aug 2016 12:01:20 -0400
Received: from int-mx10.intmail.prod.int.phx2.redhat.com (int-mx10.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mx1.redhat.com (Postfix) with ESMTPS id 7EBEE80082
        for <ceph-devel@vger.kernel.org>; Mon, 29 Aug 2016 16:00:30 +0000 (UTC)
In-Reply-To: <CALqRxCzuD+uD4pw=E4Ds1gQh84hxHResMNkuoz7E7fYB9x1BJg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ken Dreyer <kdreyer@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Mon, 29 Aug 2016, Ken Dreyer wrote:
> On Fri, Aug 26, 2016 at 12:42 PM, Sage Weil <sweil@redhat.com> wrote:
> > Now that we've transitioned to cmake, I'd like to resurrect the discussion
> > about moving to a new version of boost.  I'm dying to use small_vector and
> > flat_map.
> >
> > IIRC, we have a few options:
> >
> > 1) boost as a submodule.  compile and link statically.
> >  - easy to maintain
> >  - no packaging impact
> >  - dev/build environment is not dependent on system install boost
> 
> The end-to-end build time is going to get even longer, and there is a
> maintenance cost when we stop paying that tech debt a little bit at a
> time when the distros release new boost packages. GitHub says Ceph's
> civetweb is "This branch is 26 commits ahead, 1551 commits behind
> civetweb:master". How do we keep that same thing from happening over
> the years with a bundled boost?

civetweb is a bit of a special case because (1) we have to fork because we 
have functionality that isn't necessarily suitable for upstream and (2) 
it's mean to be linked statically anyway.  But yes, it is a maintenance 
burden.

> Can we have a middle ground, where we use an up-to-date bundled
> version of boost on distros without the features you want, and then
> use the system boost if it's new enough (ie Fedora and presumably
> Xenial or Yakkety)?

I think this is #4:

> 4) #1, with cmake smarts to let you choose the submodule or installed 
> boost (and possibly autoselect system boost if it's new enough).

The goal should be to eventually drop the submodule as supported distros 
are brought up to date.  I suspect, though, that we'll find other shiny 
new features we'll want to start using so this may never happen...

sage

