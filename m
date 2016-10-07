From: Andrew Schoen <aschoen@redhat.com>
Subject: Re: new naming convention for building repos and binaries from branches
Date: Fri, 7 Oct 2016 09:19:26 -0500
Message-ID: <CAEPMp+5530vF0PvhcVsq0L5zPVJh0zH+EnNFV+5JB7ycU5sB4Q@mail.gmail.com>
References: <CAC-Np1wcBGRcFYtK8WsjfM-WR+H_S58XgH74D+dBiGxd=KwZUQ@mail.gmail.com>
 <CALe9h7da1Oz29q2pot1BZLNBcs1NJ51BRLE+Uj_3mVjnDGw6fQ@mail.gmail.com>
 <CAEPMp+7OJ+pX=mYbNGgm+HZMGOGDK3xiApw5OL03vsN9YApTGA@mail.gmail.com>
 <alpine.DEB.2.11.1610061633440.19850@piezo.us.to> <CAJ4mKGbfTw+7y_XBkgDj6vzu65Z=VgfpMrBGNM5E+ZAVP3wC_w@mail.gmail.com>
 <CAC-Np1wmFwEHV4WvN9d8tX_NenZ3wAfZE4XNgtW2O_Z_o29D_A@mail.gmail.com> <20161007033214.GB23519@degu.eng.arb.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f172.google.com ([209.85.217.172]:35318 "EHLO
        mail-ua0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752865AbcJGOUK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 7 Oct 2016 10:20:10 -0400
Received: by mail-ua0-f172.google.com with SMTP id u68so46047471uau.2
        for <ceph-devel@vger.kernel.org>; Fri, 07 Oct 2016 07:19:27 -0700 (PDT)
In-Reply-To: <20161007033214.GB23519@degu.eng.arb.redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marcus Watts <mwatts@redhat.com>
Cc: Alfredo Deza <adeza@redhat.com>, Gregory Farnum <gfarnum@redhat.com>, Sage Weil <sweil@redhat.com>, John Spray <jspray@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

>
> I think the natural progression of things is:
>
> stage 1.        coded up, ready to share, not ready to build or test.
>                 (might be being built out of stream,  etc.)
>                 early stage of collaboration, code review, etc.
>                 [ I think people currently do this in various
>                 different ways... ]
> stage 2.        ready to test / build / for a LIMITED set of
>                 architectures (often just one.)
>                 start of testing, don't need all architectures yet.
>                 OR, failed on one architecture, want to just test *that*
>                 architecture.  [ We don't currently have a way to
>                 do this, but I bet at least half of our builds could
>                 work this way. ]
> stage 3.        ready to test / build / for ALL architectures.
>                 about to commit fix to master / general distribution,
>                 known to work on one architecture, but want to actually
>                 do the thorough test on everything.
>

Stage 1 and 2 could be accomplished by started a build with kraken in
IRC or by using the jenkins web UI (I'd recommend kraken though). By
default we are currently building for xenial, trusty and centos7 on
x86_64 for every push to ceph.git. That's look something like this:

!ci build ceph-dev BRANCH=$branch

You could also limit the distros:

!ci build ceph-dev BRANCH=$branch DISTROS="xenial"

It's stage 3 that I think we need the naming convention for.
