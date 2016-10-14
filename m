From: Sage Weil <sage@newdream.net>
Subject: Re: new naming convention for building repos and binaries from
 branches
Date: Fri, 14 Oct 2016 19:03:20 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1610141858350.23131@piezo.us.to>
References: <CAC-Np1wcBGRcFYtK8WsjfM-WR+H_S58XgH74D+dBiGxd=KwZUQ@mail.gmail.com> <CALe9h7da1Oz29q2pot1BZLNBcs1NJ51BRLE+Uj_3mVjnDGw6fQ@mail.gmail.com> <CAEPMp+7OJ+pX=mYbNGgm+HZMGOGDK3xiApw5OL03vsN9YApTGA@mail.gmail.com> <alpine.DEB.2.11.1610061633440.19850@piezo.us.to>
 <CAEPMp+7EyHBJSDoCZoTPvnd5bBKmsZ_D7UfZ5aYCvS6THLMqSg@mail.gmail.com> <26CBB0BA-AF47-40AB-BF35-B50F5A6501A3@Teradata.com> <CAC-Np1xnSoNth7rn-9Cu=ws_=6AwMQP7zKvgu2URi5-dTijndg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58033 "EHLO
        cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751537AbcJNTDY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 14 Oct 2016 15:03:24 -0400
In-Reply-To: <CAC-Np1xnSoNth7rn-9Cu=ws_=6AwMQP7zKvgu2URi5-dTijndg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alfredo Deza <adeza@redhat.com>
Cc: "Kamble, Nitin A" <Nitin.Kamble@teradata.com>, Andrew Schoen <aschoen@redhat.com>, John Spray <jspray@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, 13 Oct 2016, Alfredo Deza wrote:
> On Fri, Oct 7, 2016 at 3:16 PM, Kamble, Nitin A
> <Nitin.Kamble@teradata.com> wrote:
> >
> >> On Oct 7, 2016, at 7:27 AM, Andrew Schoen <aschoen@redhat.com> wrote:
> >>
> >>> I think we need a "do not build" prefix and a "build this asap" prefix.
> >>> Maybe nobuild-* and asap-*?
> 
> What we are going to start with *today* is to build every branch that
> is prefixed with "wip-" since
> that is the implicit/historical naming convention for branches.
> 
> We will include all the release branches (e.g. hammer, infernalis,
> jewel, kraken) as well
> as master.
> 
> This will allow the "do not build this" branches to just be anything
> not prefixed with "wip-" (there are already a few of those
> today, like dnm- and testing-)

That seems okay for now.  I think this might have gotten lost in the 
earlier thread, though:

Why don't we take this opportunity to create a ceph-ci.git and lock down 
ceph.git?

 - ceph.git would contain only official branches (master, jewel, etc.)
 - ceph-ci.git would have all the branches that need to get build for 
   ci purposes.
 - ci would build everything in ceph.git and ceph-ci.git that doesn't have 
   a / in it
 - if you don't want a branch built, don't push it to either one; push it 
   to your private clone (which is what you should be doing anyway!)
 - restrict access to ceph.git to core developers (and trusted robots)
 - grant access to ceph-ci to a broader set of developers (and robots)

Right now, I think this requires that

1) shaman and/or jenkins build branches in both ceph.git and ceph-ci.git

and then at our leisure,

2) we delete or move all non-official branches over to ceph-gi.git 
(prefixing historical branches with old/ or similar), and
3) we restrict ceph.git access.

?
sage
