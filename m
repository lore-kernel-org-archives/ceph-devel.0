From: Sage Weil <sweil@redhat.com>
Subject: Re: rados read ordering
Date: Tue, 9 Dec 2014 16:43:27 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1412091640140.22847@cobra.newdream.net>
References: <alpine.DEB.2.00.1412080855300.5263@cobra.newdream.net>, <CABBk=J9iA=iwAqOBrQ3zDpUvEDH2JA17+WJLRU2gLz_fFdF55w@mail.gmail.com> <88C3E003BB3649489ED4ECA6C80410476BCEF6@ORSMSX102.amr.corp.intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:36672 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751963AbaLJAna (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 9 Dec 2014 19:43:30 -0500
In-Reply-To: <88C3E003BB3649489ED4ECA6C80410476BCEF6@ORSMSX102.amr.corp.intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Cook, Nigel" <nigel.cook@intel.com>
Cc: Yehuda Sadeh <yehuda@redhat.com>, Josh Durgin <jdurgin@redhat.com>, Samuel Just <sjust@redhat.com>, "Wang, Zhiqiang" <zhiqiang.wang@intel.com>, Jason Dillaman <dillaman@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Wed, 10 Dec 2014, Cook, Nigel wrote:
> Folks
> 
> I'm wondering if this is related to the question I posed a few days 
> ago..
> 
>  Can CEPH support 2 clients simultaneously accessing a single volume - 
> for example a database cluster - and honor read and write order of 
> blocks across the multiple clients?
> 
> Can you comment?

I don't think so.  This (non)change is about a single client submitting 
two reads to a single object (say, different blocks in the same disk) and 
whether the OSD is allowed to respond out of order (say, because some 
blocks are in cache and some aren't).

In the shared volume case, it is generally not important what happens with 
requests that are submitted in parallel.. they can take different amounts 
of time on the wire and which happens first (i.e., which arrives at the 
OSD first) depends on happenstance.  What does matter is that any read 
that happens after a complete write reflects that read, which is why the 
concern is around caching.

sage


> 
> Regards,
> Nigel Cook +1 720 319 7508
> 
> Sent from a mobile device.
> Please excuse both my brevity and sp3lling
> 
> On Dec 8, 2014 10:12 AM, Yehuda Sadeh <yehuda@redhat.com> wrote:
> On Mon, Dec 8, 2014 at 9:03 AM, Sage Weil <sweil@redhat.com> wrote:
> > The current RADOS behavior is that reads (on any given object) are always
> > processed in the order they are submitted by the client.  This causes a
> > few headaches for the cache tiering that it would be nice to avoid.  It
> > also occurs to me that there are likely cases where we could go a lot
> > faster by not strictly ordering things.  For example, a stat can respond
> > more quickly than a large read, and some reads may hit cache while others
> > go to disk.  This doesn't happen currently because of the (lame) way we do
> > reads synchronously, but hope that can change too.
> >
> > I propose we drop this semantic.  If a client wants reads to have a strict
> > ordering, they can set the existing RWORDERED flag (which also orders them
> > with respect to writes).  That's not the most general thing ever, but I'm
> > not sure we care about callers who want reads ordered with respect to each
> > other but not writes.
> >
> > The real question is whether there are any users that want/need this
> > currently.  I can't think of any offhand.  In several places we submit
> > multiple *writes* and expect them to be strictly ordered (e.g., we
> > set a completion on teh last write only).  I don't think we do this
> > anywhere for reads though...
> >
> > Josh, Yehuda, Jason--can you think of any in RBD or RGW that would depend
> > on this?
> >
> 
> None that I can think of. For objects data, we already stripe it
> across multiple objects, and the underlying assumption is that we're
> going to get responses out of order so we make sure we commit
> in-order. Guards are used on the head object, and the read is
> synchronous there anyway. I can't think of any other place where we'd
> have an issue.
> 
> Yehuda
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
