From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: killing onreadable completions
Date: Mon, 15 Jan 2018 18:12:25 -0800
Message-ID: <CAJ4mKGYTbO73xuYdbYmjewVQa=eZ=yKztJWjkO==EmBp5QvDYg@mail.gmail.com>
References: <alpine.DEB.2.11.1801122137190.8186@piezo.novalocal>
 <CAJ4mKGaWH-shsF-VNqPo89d25-k_5dsgNv7E085BPciu9XUdUQ@mail.gmail.com> <alpine.DEB.2.11.1801122342020.24931@piezo.novalocal>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f169.google.com ([209.85.223.169]:44976 "EHLO
        mail-io0-f169.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750812AbeAPCM0 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 15 Jan 2018 21:12:26 -0500
Received: by mail-io0-f169.google.com with SMTP id k18so15111231ioc.11
        for <ceph-devel@vger.kernel.org>; Mon, 15 Jan 2018 18:12:26 -0800 (PST)
In-Reply-To: <alpine.DEB.2.11.1801122342020.24931@piezo.novalocal>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Josh Durgin <jdurgin@redhat.com>

On Fri, Jan 12, 2018 at 3:48 PM, Sage Weil <sweil@redhat.com> wrote:
> On Fri, 12 Jan 2018, Gregory Farnum wrote:
>> On Fri, Jan 12, 2018 at 1:37 PM, Sage Weil <sweil@redhat.com> wrote:
>> > A dream of mine is to kill off the onreadable callback in ObjectStore
>> > completely.  This is *mostly* a non-issue with BlueStore with a few
>> > exceptions (creates/deletes still need a flush before they are visible to
>> > collection_list()), but because FileStore has no in-memory cache/state
>> > about it's changes it is a long way from being possible.
>> >
>> > My thinking recently has been that at some point we'll reach a point where
>> > we care more about OSD code simplicity than FileStore performance
>> > (presumably at some point after we move a bunch of users over to
>> > BlueStore) and then we implement some kludge in FileStore to hide
>> > this.
>> >
>> > Today I was looking at a weird ECBackend issue and it looks like there
>> > we're still doing dual acks for commit and readable... all in order to
>> > make sure that a read that follows a write will order properly (even on
>> > replicas).  That means double the messages over the wire to track
>> > something that can be done with a simple map of in-filght objects in
>> > memory.  But instead of implementing that just in ECBackend, implementing
>> > the same thing in FileStore would kill 100 birds with one stone.
>>
>> Can you elucidate on what's happening with ECBackend? I'd assume part
>> of the complexity is about maintaining the cache that lets us pipeline
>> writes that overlap, and I don't quite see how what you're discussing
>> would work with that.
>> ...and, actually, now that I think about it I'm not entirely sure the
>> bluestore semantics would work for ec overwrite pools without this
>> overlay? What are the rules again?
>
> ECBackend is sending messages for both commit and onreadable on sub
> writes, and not completing the write until both are done.  I come up with
> any reason why it would be doing that... except to make sure that on a
> read the previous writes have first applied.  I don't think this is
> related to the cache per se; it's just that any read needs to wait for
> prior writes to apply before proceeding.
>
> (The bug I'm fixing is only peripherally related to this; I just noticed
> that it would go away if we didn't have the onreadable callbacks at all
> and got off on this tangent...)

I looked at this briefly today and you're definitely correct; we don't
need the double acks for ECBackend internals except due to
read-after-write ordering. It devotes a lot more code to correctly
invoking any callbacks that might have been sent in as part of
submit_transaction() than it does to worrying about whether an op's
result is visible yet (the one place it does so is key, of course, but
easily dropped if we know our local storage backend will just give us
back an up-to-date look at whatever we ask for).
-Greg
