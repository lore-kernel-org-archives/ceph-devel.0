From: Sage Weil <sweil@redhat.com>
Subject: Re: librados3
Date: Thu, 19 Oct 2017 12:13:21 +0000 (UTC)
Message-ID: <alpine.DEB.2.11.1710191212390.24806@piezo.us.to>
References: <CAJE9aOPhPFJdV2BQ4-9LhpzN5gucc4BOuU=0C27geK_d0P4r=A@mail.gmail.com> <CALe9h7fSc5QoNn49o9MewuLqKc1fST8dR2iq9c3LAPkTij6DJA@mail.gmail.com> <CA+aFP1B5TLKDkMEOE9AOLkuNoOq=_mD4jy_MUTo7x2CKXz9LYw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:40706 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1752540AbdJSMN1 (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 19 Oct 2017 08:13:27 -0400
In-Reply-To: <CA+aFP1B5TLKDkMEOE9AOLkuNoOq=_mD4jy_MUTo7x2CKXz9LYw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: dillaman@redhat.com
Cc: John Spray <jspray@redhat.com>, kefu chai <tchaikov@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Thu, 19 Oct 2017, Jason Dillaman wrote:
> As long as we plan to continue to ship librados2 side-by-side with
> librados3 for a while, I'm fine with starting down that path for
> mimic. There are a lot of applications linked against librados2
> floating in the wild.
> 
> For luminous, we could perhaps just drop the "_mempool" member
> variable from bufferlist and chance the semantics where the caller
> needs to add at least a single buffer::raw before the mempool can be
> assigned. That preserves the ABI since we aren't changing the size of
> bufferlist and preserves the mempool functionality (with a little
> extra work).  That tweak would only be needed for the first
> buffer::ptr appended to the bufferlist since subsequent appends can
> just copy the mempool value from the first buffer::ptr.

I think that will still be sufficient for bluestore (which relies on 
mempool accounting to make its cache trimming work).  I can give it a try 
today!

sage

> On Thu, Oct 19, 2017 at 6:43 AM, John Spray <jspray@redhat.com> wrote:
> > On Thu, Oct 19, 2017 at 10:25 AM, kefu chai <tchaikov@gmail.com> wrote:
> >> in luminous, we introduced a change not backward compatible with
> >> pre-luminous librados. see see http://tracker.ceph.com/issues/21573.
> >> and i cannot see an obvious solution without bumping up the so version
> >> of librados to 3.
> >>
> >> if we have the luxury to do it,  we will be able to give librados an
> >> overhaul. for a todo list, see http://pad.ceph.com/p/librados3.
> >>
> >> what do you think?
> >
> > I've added a couple of items to the pad for deprecated bits to remove
> > when we go up a version.
> >
> > I guess we would do the version bump for Mimic and for Luminous we
> > will just have to apologetically tell people they need to recompile?
> >
> > Or we could have a so.3 version (ABI change only) in Luminous that
> > just bumps the version to force a recompile, and a so.4 version in
> > Mimic that actually makes the API changes?
> >
> > John
> >
> >>
> >> --
> >> Regards
> >> Kefu Chai
> >> --
> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> >> the body of a message to majordomo@vger.kernel.org
> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
> 
> -- 
> Jason
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
