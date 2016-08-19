From: Victor Denisov <vdenisov@mirantis.com>
Subject: Re: Snapshots of consistency groups
Date: Thu, 18 Aug 2016 21:20:02 -0700
Message-ID: <CA+hcxJT9JdVz-ZQz_SXwAPbbHoNegNSVfPk6h8kzmDo0xs0BJQ@mail.gmail.com>
References: <CA+hcxJS8sbBUjYieM3+86XG5KX9ouP8dO+9iFwtsHoO+v=9KWA@mail.gmail.com>
 <CA+aFP1BAw7yzPYT5z6D6Wq6tPvd-Y9meDxfgqcVi0GBg0eR3+g@mail.gmail.com>
 <CA+aFP1BZPHhiBan4r5N7x0LfHofmkrUWgLPD0MrS-uV6WrF4Kg@mail.gmail.com>
 <CA+hcxJSO8TXSRV4bgTZVkrFsjX1wpW3DYFKqaDnWhA3+7gE_eg@mail.gmail.com> <CA+aFP1BMK1=daZpUFdNDJ+i8+nfQt42ahCXVaxy9fWdAY-kXwA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f181.google.com ([209.85.217.181]:33657 "EHLO
        mail-ua0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1754021AbcHSEUE (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 19 Aug 2016 00:20:04 -0400
Received: by mail-ua0-f181.google.com with SMTP id 74so61792886uau.0
        for <ceph-devel@vger.kernel.org>; Thu, 18 Aug 2016 21:20:03 -0700 (PDT)
In-Reply-To: <CA+aFP1BMK1=daZpUFdNDJ+i8+nfQt42ahCXVaxy9fWdAY-kXwA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Josh Durgin <jdurgin@redhat.com>, Mykola Golub <mgolub@mirantis.com>

Could you please point me to the place in source code where writer
acquires an exclusive lock on the image.
I presume you were talking about the feature:
exclusive_lock, shared_lock which can be used from command line using
commands lock list, lock break.

On Thu, Aug 18, 2016 at 5:47 PM, Jason Dillaman <jdillama@redhat.com> wrote:
> There is already a "request lock" RPC message and this is already handled
> transparently within librbd when you attempt to acquire the lock and another
> client owns it.
>
>
> On Thursday, August 18, 2016, Victor Denisov <vdenisov@mirantis.com> wrote:
>>
>> If an image already has a writer who owns the lock,
>> should I implement a notification that allows to ask the writer to
>> release the lock,
>> is there already a standard way to intercept the exclusive lock?
>>
>> On Tue, Aug 16, 2016 at 6:29 AM, Jason Dillaman <jdillama@redhat.com>
>> wrote:
>> > ... one more thing:
>> >
>> > I was also thinking that we need a new RBD feature bit to be used to
>> > indicate that an image is part of a consistency group to prevent older
>> > librbd clients from removing the image or group snapshots.  This could
>> > be a RBD_FEATURES_RW_INCOMPATIBLE feature bit so older clients can
>> > still open the image R/O while its part of a group.
>> >
>> > On Tue, Aug 16, 2016 at 9:26 AM, Jason Dillaman <jdillama@redhat.com>
>> > wrote:
>> >> Way back in April when we had the CDM, I was originally thinking we
>> >> should implement option 3. Essentially, you have a prepare group
>> >> snapshot RPC message that extends a "paused IO" lease to the caller.
>> >> When that lease expires, IO would automatically be resumed even if the
>> >> group snapshot hasn't been created yet.  This would also require
>> >> commit/abort group snapshot RPC messages.
>> >>
>> >> However, thinking about this last night, here is another potential
>> >> option:
>> >>
>> >> Option 4 - require images to have the exclusive lock feature before
>> >> they can be added to a consistency group (and prevent disabling of
>> >> exclusive-lock while they are part of a group). Then librbd, via the
>> >> rbd CLI (or client application of the rbd consistency group snap
>> >> create API), can co-operatively acquire the lock from all active image
>> >> clients within the group (i.e. all IO has been flushed and paused) and
>> >> can proceed with snapshot creation. If the rbd CLI dies, the normal
>> >> exclusive lock handling process will automatically take care of
>> >> re-acquiring the lock from the dead client and resuming IO.
>> >>
>> >> This option not only re-uses existing code, it would also eliminate
>> >> the need to add/update the RPC messages for prepare/commit/abort
>> >> snapshot creation to support group snapshots (since it could all be
>> >> handled internally).
>> >>
>> >> On Mon, Aug 15, 2016 at 7:46 PM, Victor Denisov <vdenisov@mirantis.com>
>> >> wrote:
>> >>> Gentlemen,
>> >>>
>> >>> I'm writing to you to ask for your opinion regarding quiescing writes.
>> >>>
>> >>> Here is the situation. In order to take snapshots of all images in a
>> >>> consistency group,
>> >>> we first need to quiesce all the image writers in the consistency
>> >>> group.
>> >>> Let me call
>> >>> group client - a client which requests a consistency group to take a
>> >>> snapshot.
>> >>> Image client - the client that writes to an image.
>> >>> Let's say group client starts sending notify_quiesce to all image
>> >>> clients that write to the images in the group. After quiescing half of
>> >>> the image clients the group client can die.
>> >>>
>> >>> It presents us with a dilemma - what should we do with those quiesced
>> >>> image clients.
>> >>>
>> >>> Option 1 - is to wait till someone manually runs recover for that
>> >>> consistency group.
>> >>> We can show warning next to those unfinished groups when user runs
>> >>> group list command.
>> >>> There will be a command like group recover, which allows users to
>> >>> rollback unsuccessful snapshots
>> >>> or continue them using create snapshot command.
>> >>>
>> >>> Option 2 - is to establish some heart beats between group client and
>> >>> image client. If group client fails to heart beat then image client
>> >>> unquiesces itself and continues normal operation.
>> >>>
>> >>> Option 3 - is to have a timeout for each image client. If group client
>> >>> fails to make a group snapshot within this timeout then we resume our
>> >>> normal operation informing group client of the fact.
>> >>>
>> >>> Which of these options do you prefer? Probably there are other options
>> >>> that I miss.
>> >>>
>> >>> Thanks,
>> >>> Victor.
>> >>
>> >>
>> >>
>> >> --
>> >> Jason
>> >
>> >
>> >
>> > --
>> > Jason
>
>
>
> --
> Jason
>
