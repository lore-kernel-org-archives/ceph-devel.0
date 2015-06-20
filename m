From: Marcel Lauhoff <ml@irq0.org>
Subject: Re: OSD-Based Object Stubs
Date: Sat, 20 Jun 2015 12:18:08 +0200
Message-ID: <871th665un.fsf@irq0.org>
References: <87a8wqct38.fsf@irq0.org> <CAC6JEv8KPsi1w37-XvNg00s4gC6hv=N5p5NWty56dFv3=e3eQA@mail.gmail.com> <87617dc965.fsf@irq0.org> <CAC6JEv_oZ2x6AbQSJzJ5==R+8KSZMbpfqk=WZnd-HGcMRYzSoA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cpu0.net ([37.187.2.217]:46795 "EHLO cpu0.net"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752403AbbFTKSJ (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Sat, 20 Jun 2015 06:18:09 -0400
Received: from simstim.irq0.org (x5d82451a.dyn.telefonica.de [93.130.69.26])
	by ks3366964.kimsufi.com (Postfix) with ESMTPSA id 9082B80399
	for <ceph-devel@vger.kernel.org>; Sat, 20 Jun 2015 10:18:07 +0000 (UTC)
In-reply-to: <CAC6JEv_oZ2x6AbQSJzJ5==R+8KSZMbpfqk=WZnd-HGcMRYzSoA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gregory Farnum <greg@gregs42.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>


Hi,

thanks for the comments!

Gregory Farnum <greg@gregs42.com> writes:

> On Thu, May 28, 2015 at 3:01 AM, Marcel Lauhoff <ml@irq0.org> wrote:
>>
>> Gregory Farnum <greg@gregs42.com> writes:
>>
>>> Do you have a shorter summary than the code of how these stub and
>>> unstub operations relate to the object redirects? We didn't make a
>>> great deal of use of them but the basic data structures are mostly
>>> present in the codebase, are interpreted in at least some of the right
>>> places, and were definitely intended to cover this kind of use case.
>>> :)
>>> -Greg
>>
>> As far as I understood the redirect feature it is about pointing to
>> other objects inside the Ceph cluster. The stubs feature allows
>> pointing to anything. An HTTP server in concept code.
>>
>> Then stubs use an IMHO simpler approach to getting objects back: It's
>> the task of the OSD. Stubbed objects just take longer to access, due to
>> unstubbing it first.
>> Redirects on the other hand leave this to the client: Object redirected
>> -> Tell client to retrieve it elsewhere.
>
> Ah, of course.
>
> I got a chance to look at this briefly today. Some notes:
>
> * You're using synchronous reads. That will prevent use of stubbing on
> EC pools (which only do async reads, as they might need to hit another
> OSD for the data), which seems sad.
Good point. I didn't look at how EC pools work, yet. I assumed that
a stub feature would be quite different for both pool types and tried
the replicated first.

> * There seems to be a race if you need to unstub an op for two
> separate requests that come in simultaneously, with nothing preventing
> both of them from initiating the unstub.
Right. I should probably add some "in flight" states there.

> * You can inject an unstub for read ops, but that turns them into a
> write. That will cause problems in various cases where the object
> isn't writeable yet.
I thought I fixed that by doing "ctx->op->set_write()" in the implicit
unstub code.

> * Why does a delete need the object data?
That was just a short cut: In the quite simplistic Remote API there is
only put and get. A unstub before delete also deletes the remote object.

> * You definitely wouldn't want to unstub data for scrubbing.
What's the alternative? The remote should do scrubbing or just skip the
stubbed object?

> * There's a CEPH_OSD_OP_STAT which looks at what's in the object info;
> that is broken here because you're using the normal truncation path.
> There probably needs to be more cleverness or machinery distinguishing
> between the "local" size used and the size of the object represented.
Of course.

> * I think snapshots are probably busted with this; did you check how
> they interact?
With this implementation I think they really are. Stubs+Snapshouts could
be a nice thing for backups. Just stub a read only snapshot.

> -Greg

~marcel

--
Marcel Lauhoff
Mail/XMPP: ml@irq0.org
http://irq0.org
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
