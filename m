From: "Cook, Nigel" <nigel.cook@intel.com>
Subject: RE: rados read ordering
Date: Wed, 10 Dec 2014 04:36:38 +0000
Message-ID: <88C3E003BB3649489ED4ECA6C80410476BD543@ORSMSX102.amr.corp.intel.com>
References: <alpine.DEB.2.00.1412080855300.5263@cobra.newdream.net>,
 <CABBk=J9iA=iwAqOBrQ3zDpUvEDH2JA17+WJLRU2gLz_fFdF55w@mail.gmail.com>
 <88C3E003BB3649489ED4ECA6C80410476BCEF6@ORSMSX102.amr.corp.intel.com>
 <alpine.DEB.2.00.1412091640140.22847@cobra.newdream.net>,<06E7D85B3BA36C4DB207FEDE871C5348968009@SHSMSX101.ccr.corp.intel.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mga11.intel.com ([192.55.52.93]:43727 "EHLO mga11.intel.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1755265AbaLJEhD convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 9 Dec 2014 23:37:03 -0500
In-Reply-To: <06E7D85B3BA36C4DB207FEDE871C5348968009@SHSMSX101.ccr.corp.intel.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Wang, Zhiqiang" <zhiqiang.wang@intel.com>
Cc: Josh Durgin <jdurgin@redhat.com>, Yehuda Sadeh <yehuda@redhat.com>, Samuel Just <sjust@redhat.com>, Sage Weil <sweil@redhat.com>, Jason Dillaman <dillaman@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>

On thinking of the following use cases and the rbd client..

The ordering scenario is that with client a and b, assuming a and b are messaging between them, then a read posted by client b after client a has successfully written will always read the client a content. Similarly, an ordered write by client a and then by client b followed by a read by a or b will return the client b write content in all cases.

Regards,
Nigel Cook +1 720 319 7508

Sent from a mobile device.
Please excuse both my brevity and sp3lling

On Dec 9, 2014 5:10 PM, "Wang, Zhiqiang" <zhiqiang.wang@intel.com> wrote:
For multiple clients accessing the same volume, same object, I guess the clients need to do some synchronization between them to guarantee what it reads is what it wrote. That is to say, if two clients, say A and B, A is doing write, B is doing read. If B wants to read what A writes, it needs to know A has completed the write before issuing the read. If A hasn't completed the write yet, it could be possible that the write fails, so you can't expect B reads what A writes. I think this makes sense from the client/application perspective.

-----Original Message-----
From: ceph-devel-owner@vger.kernel.org [mailto:ceph-devel-owner@vger.kernel.org] On Behalf Of Sage Weil
Sent: Wednesday, December 10, 2014 8:43 AM
To: Cook, Nigel
Cc: Yehuda Sadeh; Josh Durgin; Samuel Just; Wang, Zhiqiang; Jason Dillaman; ceph-devel
Subject: Re: rados read ordering

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

I don't think so.  This (non)change is about a single client submitting two reads to a single object (say, different blocks in the same disk) and whether the OSD is allowed to respond out of order (say, because some blocks are in cache and some aren't).

In the shared volume case, it is generally not important what happens with requests that are submitted in parallel.. they can take different amounts of time on the wire and which happens first (i.e., which arrives at the OSD first) depends on happenstance.  What does matter is that any read that happens after a complete write reflects that read, which is why the concern is around caching.

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
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
