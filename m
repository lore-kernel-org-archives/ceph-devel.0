From: Gregory Farnum <greg@gregs42.com>
Subject: Re: OSD-Based Object Stubs
Date: Tue, 23 Jun 2015 13:38:41 +0100
Message-ID: <CAC6JEv9ePMbZH4K58ibxr+nzAW3HufQGU=-DSuCNnB=HG5+N8A@mail.gmail.com>
References: <87a8wqct38.fsf@irq0.org>
	<CAC6JEv8KPsi1w37-XvNg00s4gC6hv=N5p5NWty56dFv3=e3eQA@mail.gmail.com>
	<87617dc965.fsf@irq0.org>
	<CAC6JEv_oZ2x6AbQSJzJ5==R+8KSZMbpfqk=WZnd-HGcMRYzSoA@mail.gmail.com>
	<871th665un.fsf@irq0.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-la0-f48.google.com ([209.85.215.48]:36210 "EHLO
	mail-la0-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753371AbbFWMiq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 23 Jun 2015 08:38:46 -0400
Received: by lacny3 with SMTP id ny3so5616900lac.3
        for <ceph-devel@vger.kernel.org>; Tue, 23 Jun 2015 05:38:44 -0700 (PDT)
Received: from mail-la0-f50.google.com (mail-la0-f50.google.com. [209.85.215.50])
        by mx.google.com with ESMTPSA id jr6sm4698708lab.12.2015.06.23.05.38.42
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 23 Jun 2015 05:38:42 -0700 (PDT)
Received: by lagi2 with SMTP id i2so5657202lag.2
        for <ceph-devel@vger.kernel.org>; Tue, 23 Jun 2015 05:38:41 -0700 (PDT)
In-Reply-To: <871th665un.fsf@irq0.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Marcel Lauhoff <ml@irq0.org>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Sat, Jun 20, 2015 at 11:18 AM, Marcel Lauhoff <ml@irq0.org> wrote:
>
> Hi,
>
> thanks for the comments!
>
> Gregory Farnum <greg@gregs42.com> writes:
>
>> On Thu, May 28, 2015 at 3:01 AM, Marcel Lauhoff <ml@irq0.org> wrote:
>>>
>>> Gregory Farnum <greg@gregs42.com> writes:
>>>
>>>> Do you have a shorter summary than the code of how these stub and
>>>> unstub operations relate to the object redirects? We didn't make a
>>>> great deal of use of them but the basic data structures are mostly
>>>> present in the codebase, are interpreted in at least some of the right
>>>> places, and were definitely intended to cover this kind of use case.
>>>> :)
>>>> -Greg
>>>
>>> As far as I understood the redirect feature it is about pointing to
>>> other objects inside the Ceph cluster. The stubs feature allows
>>> pointing to anything. An HTTP server in concept code.
>>>
>>> Then stubs use an IMHO simpler approach to getting objects back: It's
>>> the task of the OSD. Stubbed objects just take longer to access, due to
>>> unstubbing it first.
>>> Redirects on the other hand leave this to the client: Object redirected
>>> -> Tell client to retrieve it elsewhere.
>>
>> Ah, of course.
>>
>> I got a chance to look at this briefly today. Some notes:
>>
>> * You're using synchronous reads. That will prevent use of stubbing on
>> EC pools (which only do async reads, as they might need to hit another
>> OSD for the data), which seems sad.
> Good point. I didn't look at how EC pools work, yet. I assumed that
> a stub feature would be quite different for both pool types and tried
> the replicated first.

I'm not sure that will be necessary, actually. The advantage of only
doing GET/PUT (unstub/stub) is that you're doing only full-object
reads and writes; it doesn't require any of the features EC pools
don't provide.

>> * There seems to be a race if you need to unstub an op for two
>> separate requests that come in simultaneously, with nothing preventing
>> both of them from initiating the unstub.
> Right. I should probably add some "in flight" states there.
>
>> * You can inject an unstub for read ops, but that turns them into a
>> write. That will cause problems in various cases where the object
>> isn't writeable yet.
> I thought I fixed that by doing "ctx->op->set_write()" in the implicit
> unstub code.

No, the implicit unstub will have to be more involved than that. :(
RADOS writes aren't allowed to return any data to the user except for
a return code, and I believe that's enforced at the end by clearing
out/ignoring any of the return bufferlists we would otherwise pack up.
This is because we have to be able to return the exact same stuff on
replayed ops, in case the acting set of OSDs changes without the
client getting a response. Now, the unstub is a bit different in that
the data doesn't change in response to the user requiring an unstub,
but I think it still has some parallelism issues in that scenario.

>
>> * Why does a delete need the object data?
> That was just a short cut: In the quite simplistic Remote API there is
> only put and get. A unstub before delete also deletes the remote object.
>
>> * You definitely wouldn't want to unstub data for scrubbing.
> What's the alternative? The remote should do scrubbing or just skip the
> stubbed object?

I think you'd want to scrub both the "full" and "stub" metadata for
the object, but rely on the stub target to keep the actual bundle of
bytes safe.

>
>> * There's a CEPH_OSD_OP_STAT which looks at what's in the object info;
>> that is broken here because you're using the normal truncation path.
>> There probably needs to be more cleverness or machinery distinguishing
>> between the "local" size used and the size of the object represented.
> Of course.
>
>> * I think snapshots are probably busted with this; did you check how
>> they interact?
> With this implementation I think they really are. Stubs+Snapshouts could
> be a nice thing for backups. Just stub a read only snapshot.

Right, so all of these things will need to be worked out well before
we contemplate merging, and some of them are complicated enough that
they might require changing the core implementation to handle. You
probably don't want to delay it. :)
-Greg
