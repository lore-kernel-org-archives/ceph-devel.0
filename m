From: Gregory Farnum <greg@gregs42.com>
Subject: Re: idempotent op (esp delete)
Date: Fri, 23 Jan 2015 15:20:52 -0800
Message-ID: <CAC6JEv9GKn45LdMFtD=kF9hZHbeR0nzmP+ToVMh9idysKZzzPw@mail.gmail.com>
References: <alpine.DEB.2.00.1501231327570.10173@cobra.newdream.net>
	<CAC6JEv8iKG=uBcojtZ-KwWVGjd75SdYm05YOwdtm_H2TZi1-2g@mail.gmail.com>
	<alpine.DEB.2.00.1501231415040.19192@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f170.google.com ([209.85.223.170]:44944 "EHLO
	mail-ie0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751632AbbAWXUx (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Jan 2015 18:20:53 -0500
Received: by mail-ie0-f170.google.com with SMTP id y20so233044ier.1
        for <ceph-devel@vger.kernel.org>; Fri, 23 Jan 2015 15:20:53 -0800 (PST)
Received: from mail-ig0-f182.google.com (mail-ig0-f182.google.com. [209.85.213.182])
        by mx.google.com with ESMTPSA id vk4sm1422492igc.11.2015.01.23.15.20.52
        for <ceph-devel@vger.kernel.org>
        (version=TLSv1 cipher=ECDHE-RSA-RC4-SHA bits=128/128);
        Fri, 23 Jan 2015 15:20:52 -0800 (PST)
Received: by mail-ig0-f182.google.com with SMTP id r10so210613igi.3
        for <ceph-devel@vger.kernel.org>; Fri, 23 Jan 2015 15:20:52 -0800 (PST)
In-Reply-To: <alpine.DEB.2.00.1501231415040.19192@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, sjust@redhat.com
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On Fri, Jan 23, 2015 at 2:18 PM, Sage Weil <sweil@redhat.com> wrote:
> On Fri, 23 Jan 2015, Gregory Farnum wrote:
>> On Fri, Jan 23, 2015 at 1:43 PM, Sage Weil <sweil@redhat.com> wrote:
>> > Background:
>> >
>> > 1) Way back when we made a task that would thrash the cache modes by
>> > adding and removing the cache tier while ceph_test_rados was running.
>> > This mostly worked, but would occasionally fail because we would
>> >
>> >  - delete an object from the cache tier
>> >  - a network failure injection would lose the reply
>> >  - we'd disable the cache
>> >  - the delete would resend to the base tier, not get recognized as a dup
>> > (different pool, different pg log)
>> >    -> -ENOENT instead of 0
>> >
>> > 2) The proxy write code hits a similar problem:
>> >
>> >  - delete gets proxied
>> >  - we initiate async promote
>> >  - a network failure injection loses the delete reply
>> >  - delete resends and blocks on promote (or arrives after it finishes)
>> >  - promote finishes
>> >  - delete is handled
>> >   -> -ENOENT instead of 0
>> >
>> > The ticket is http://tracker.ceph.com/issues/8935
>> >
>> > The problem is partially addressed by
>> >
>> >         https://github.com/ceph/ceph/pull/3447
>> >
>> > by logging a few request ids on every object_info_t and preserving that on
>> > promote and flush.
>> >
>> > However, it doesn't solve the problem for delete because we
>> > throw out object_info_t so that reqid_t is lost.
>> >
>> > I think we have two options, not necessarily mutually exclusive:
>> >
>> > 1) When promoting an object that doesn't exist (to create a whiteout),
>> > pull reqids out of the base tier's pg log so that the whiteout is primed
>> > with request ids.
>> >
>> > 1.5) When flushing... well, that is harder because we have nowhere to put
>> > the reqids.  Unless we make a way to cram a list of reqid's into a single
>> > PG log entry...?  In that case, we wouldn't strictly need the per-object
>> > list since we could pile the base tier's reqids into the promote log entry
>> > in the cache tier.
>> >
>> > 2) Make delete idempotent (0 instead of ENOENT if the object doesn't
>> > exist).  This will require a delicate compat transition (let's ignore that
>> > a moment) but you can preserve the old behavior for callers that care by
>> > preceding the delete with an assert_exists op.  Most callers don't care,
>> > but a handful do.  This simplifies the semantics we need to support going
>> > forward.
>> >
>> > Of course, it's all a bit delicate.  The idempotent op semantics have a
>> > time horizon so it's all a bit wishy-washy... :/
>> >
>> > Thoughts?
>>
>> Do we have other cases that we're worried about which would be
>> improved by maintaining reqids across pool cache transitions? I'm not
>> a big fan of maintaining those per-op lists (they sound really
>> expensive?), but if we need them for something else that's a point in
>> their favor.
>
> I don't think they're *too* expensive (say, vector of 20 per
> object_info_t?).  But the only thing I can think of beyond the cache
> tiering stuff would be cases where the pg log isnt long enough for a
> very laggy client.  In general ops will be distributed across ops so it
> will be catch the dup from another angle.
>
> However.. I just hacked up a patch that lets us cram lots of reqids into a
> single pg_log_entry_t and I think that may be a simpler solution.  We can
> cram all reqids (for the last N of them) for promote and flush into the
> single log entry and the delete is no longer special.. it'd work equally
> well for other dups and for class methods that do who knows what.  The
> patch is here:
>
>         https://github.com/liewegas/ceph/commit/wip-pg-reqids
>
> What do you think?

Maybe? I'm not super-familiar with the pg log code and the bit where
we actually fill in extra_reqids that I'm concerned about...*refreshes
page* wait, you just did that.

Yeah, that looks okay to me. Sam?
