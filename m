From: Victor Denisov <vdenisov@mirantis.com>
Subject: Re: Snapshots of consistency groups
Date: Mon, 12 Sep 2016 16:09:29 -0700
Message-ID: <CA+hcxJROQ-xkxNpn5-SZo5abShntVu_mSUhX7ZwmCGuM+6PLVg@mail.gmail.com>
References: <CA+hcxJS8sbBUjYieM3+86XG5KX9ouP8dO+9iFwtsHoO+v=9KWA@mail.gmail.com>
 <CA+aFP1BAw7yzPYT5z6D6Wq6tPvd-Y9meDxfgqcVi0GBg0eR3+g@mail.gmail.com>
 <CA+aFP1BZPHhiBan4r5N7x0LfHofmkrUWgLPD0MrS-uV6WrF4Kg@mail.gmail.com>
 <CA+hcxJSO8TXSRV4bgTZVkrFsjX1wpW3DYFKqaDnWhA3+7gE_eg@mail.gmail.com>
 <CA+aFP1BMK1=daZpUFdNDJ+i8+nfQt42ahCXVaxy9fWdAY-kXwA@mail.gmail.com>
 <CA+hcxJT9JdVz-ZQz_SXwAPbbHoNegNSVfPk6h8kzmDo0xs0BJQ@mail.gmail.com>
 <20160819124813.GB17630@gmail.com> <CA+hcxJQs_t2u5PWiJNzJO1LPdH3HAh21VoB63w5pOdWk0+ih1Q@mail.gmail.com>
 <20160820162713.GA5997@gmail.com> <CA+hcxJTwVEJz5__s6pqivUN61X0xCccKHJ=0_o+1g8+Zu+wkDQ@mail.gmail.com>
 <CA+aFP1CqjyTVpzJNLiyuEg8ydOh_vXjF2ESFjwqESY6O7NhVfA@mail.gmail.com>
 <CA+hcxJQ1RBKbHam8tq2KL=pphLEmtvvacjD1qUvvpqs8NgkCcA@mail.gmail.com>
 <CA+hcxJQ80g_aROrb0+AVaXij1w_pqwRCxC+cHF7j+gXfGyW=Rw@mail.gmail.com>
 <CA+aFP1Dkv_vMMxfnyOE3MfaFP4CV=Z0atT-=bDTjSrRx-quNSw@mail.gmail.com>
 <CA+hcxJTxfT1BO5uuXARsUo8oyHwQxJgymzUTAM8KV1=ciJG20w@mail.gmail.com>
 <CA+aFP1BY67WbVWT-Wb3fHsS_-jUJBJ4FM3NO3VsqFO9+iRGNRg@mail.gmail.com>
 <CA+hcxJRbmnfUeZbnCkvZf52-0H_Du0tGeFb=h_GJryabv0Ng8A@mail.gmail.com> <CA+hcxJRptWbrh5R5v5s1YjD-1wuDLUmbGoF6+J=sv+BnrnAzWg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f180.google.com ([209.85.217.180]:33258 "EHLO
        mail-ua0-f180.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751317AbcILXJb (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 12 Sep 2016 19:09:31 -0400
Received: by mail-ua0-f180.google.com with SMTP id v13so1885775uav.0
        for <ceph-devel@vger.kernel.org>; Mon, 12 Sep 2016 16:09:31 -0700 (PDT)
In-Reply-To: <CA+hcxJRptWbrh5R5v5s1YjD-1wuDLUmbGoF6+J=sv+BnrnAzWg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jason Dillaman <dillaman@redhat.com>
Cc: Mykola Golub <mgolub@mirantis.com>, ceph-devel <ceph-devel@vger.kernel.org>, Josh Durgin <jdurgin@redhat.com>

I also think, probably, moving existing group api to Group.cc can be
done in a separate pull request.

On Mon, Sep 12, 2016 at 4:06 PM, Victor Denisov <vdenisov@mirantis.com> wrote:
> Another quick question.
> Do you think it makes sense to introduce snapshot namespaces in a pull
> request and review it first?
> It looks like a self sufficient change that we can merge before
> introducing snapshots.
>
> On Mon, Sep 12, 2016 at 3:52 PM, Victor Denisov <vdenisov@mirantis.com> wrote:
>> Understood. Thank you, Jason.
>>
>> On Mon, Sep 12, 2016 at 6:18 AM, Jason Dillaman <jdillama@redhat.com> wrote:
>>> On Sat, Sep 10, 2016 at 9:46 PM, Victor Denisov <vdenisov@mirantis.com> wrote:
>>>> Another question. Maybe not really a question, but I would like to
>>>> verify if I understood what you wrote in the ether pad.
>>>>
>>>> You suggest to create image snapshots simultaneously.
>>>> If everything shuts down when we are making those individual
>>>> snapshots, then we end up with a SnapshotRecord in incomplete state
>>>> and images either with snapshots or without them.
>>>> Do I understand correctly that if the user wants to remove this
>>>> unfinished group snapshot then we have to:
>>>>  - list all images in this group
>>>>  - look for snapshots in those images with the guid as their name.
>>>>  - delete those individual snapshots and ignore errors if those
>>>> snapshots don't exist.
>>>>  - delete then entry.
>>>
>>> It would be the standard remove state machine, which is basically the
>>> steps you have above. Note that you would always need to handle the
>>> "-ENOENT" case since I could always associate an image to a group
>>> after a group snap was created (i.e. so the new image doesn't have a
>>> matching image snapshot for a group snapshot).
>>>
>>>> One thing that I don't understand in this case is, what if the user
>>>> decides to delete one of the images when there are dangling group
>>>> snapshots. Let's call this image A.
>>>> This dangling group snapshot could have successfully created a
>>>> snapshot of this image A. Let's call this snapshot A_snap.
>>>> Now if we remove image A from this group then once we try to cleanup
>>>> dangling group snapshot then A_snap shapshot will be overlooked,
>>>> because image A is not a member of the group any more.
>>>> And I don't understand how we can prevent this from happening in this
>>>> approach, except by disallowing to remove images if there are dandling
>>>> group snapshots.
>>>
>>> How is the snapshot dangling for image A? If it successfully created
>>> the snapshot on image A, it has a snapshot record that associates it
>>> to the group. Therefore, when the image is removed from the group, I
>>> would think you would automatically delete the the group snapshots
>>> contained within the image.
>>>
>>>> You mentioned that we should call image's individual snapshots after
>>>> the groups guid. I assume we should name them something like
>>>> <guid>_<group_snap_id>.
>>>> If we named them only using guid, then we would be able to create only
>>>> one group snapshot.
>>>
>>> Yup -- that should be fine.
>>>
>>>> Thanks,
>>>> V.
>>>>
>>>>
>>>> On Sat, Sep 10, 2016 at 11:37 AM, Jason Dillaman <jdillama@redhat.com> wrote:
>>>>> Those are all internal classes -- the cls types are already
>>>>> dependencies within the librbd internals. Feel free to add the
>>>>> necessary include and use it directly from within librbd.
>>>>>
>>>>> On Fri, Sep 9, 2016 at 6:41 PM, Victor Denisov <vdenisov@mirantis.com> wrote:
>>>>>> I have a question about where SnapshotNamespace type should be placed.
>>>>>> I placed it in cls/rbd/cls_rbd_types.h because cls client and cls
>>>>>> backend components should have access to this type.
>>>>>> Also this type is required in librbd/Operations.cc - because we want
>>>>>> to specify in what namespace Operations::snap_create should create
>>>>>> snapshots.
>>>>>> However Operations.cc doesn't import cls_rbd_types.h right now. If the
>>>>>> question was about public interface of librbd/librbd.cc, then I would
>>>>>> create a duplicate of SnapshotNamespace type in librbd layer without
>>>>>> hesitation.
>>>>>> But these functions are internal, so, my question is whether it's
>>>>>> really feasible to create another type for SnapshotNamespace in librbd
>>>>>> layer.
>>>>>>
>>>>>>
>>>>>> On Mon, Aug 29, 2016 at 2:10 PM, Victor Denisov <vdenisov@mirantis.com> wrote:
>>>>>>> Right, I forgot about snaphot "namespaces". I'll add this part.
>>>>>>> I guess it makes sense to discuss the whole thing on the next CDM.
>>>>>>>
>>>>>>> On Sun, Aug 28, 2016 at 5:37 PM, Jason Dillaman <jdillama@redhat.com> wrote:
>>>>>>>> I think the first step is to implement the concept of snapshot "namespaces".
>>>>>>>>
>>>>>>>> This could be implemented as an optional variant structure associated
>>>>>>>> with each snapshot at creation (see the ImageWatcher RPC messages or
>>>>>>>> journaling event type encoding for examples of this). For consistency
>>>>>>>> group snapshots, this structure would identify the snapshot as
>>>>>>>> belonging to the consistency group and have a unique id back to the
>>>>>>>> specific group snapshot.
>>>>>>>>
>>>>>>>> When creating a snapshot, the state machine would (1) create the group
>>>>>>>> snapshot record, (2) set the state of the group to "creating snapshot"
>>>>>>>> (to prevent new images from being added/removed from the group while
>>>>>>>> the op is in-progress), (3) acquire the lock for all images in the
>>>>>>>> group, (4) create the individual image snapshots with the linkage back
>>>>>>>> to the group snapshot record (can be performed in parallel up to max
>>>>>>>> concurrent ops), (5) release the exclusive locks, and (6) reset the
>>>>>>>> group status to "ready".
>>>>>>>>
>>>>>>>> If you have a hard crash/failure anywhere, a "snap remove" operation
>>>>>>>> should be designed to get the group back into consistent state (i.e.
>>>>>>>> remove any snapshots linked to the group and reset the group state
>>>>>>>> back to ready).
>>>>>>>>
>>>>>>>> On Fri, Aug 26, 2016 at 5:05 PM, Victor Denisov <vdenisov@mirantis.com> wrote:
>>>>>>>>> Guys,
>>>>>>>>>
>>>>>>>>> I updated Snapshots section of this document:
>>>>>>>>> http://pad.ceph.com/p/consistency_groups, in accordance with my
>>>>>>>>> improved understanding of how it should be implemented.
>>>>>>>>> Please take a look and provide your comments. Some of my concerns
>>>>>>>>> regarding the implementation I highlighted in bold.
>>>>>>>>>
>>>>>>>>> Looking forward to your valuable remarks.
>>>>>>>>> Thanks in advance.
>>>>>>>>> V.
>>>>>>>>>
>>>>>>>>>
>>>>>>>>> On Sat, Aug 20, 2016 at 9:27 AM, Mykola Golub <mgolub@mirantis.com> wrote:
>>>>>>>>>> On Fri, Aug 19, 2016 at 05:36:56PM -0700, Victor Denisov wrote:
>>>>>>>>>>> What if I'm holding this lock and somebody else is trying to reacquire the lock.
>>>>>>>>>>> How do I get notified about it?
>>>>>>>>>>
>>>>>>>>>> The image watcher is notified, which triggers its handler:
>>>>>>>>>>
>>>>>>>>>>  ImageWatcher<I>::handle_payload(const RequestLockPayload, *ack_ctx)
>>>>>>>>>>
>>>>>>>>>> The handler calls the current lock policy method `lock_requested()`,
>>>>>>>>>> which will define what to do with the lock request. The StandartPolicy
>>>>>>>>>> is to release the lock, so it may ping-ponging between the
>>>>>>>>>> clients. You may define a different policy -- rbd-mirror is an example
>>>>>>>>>> where it is used.
>>>>>>>>>>
>>>>>>>>>> Everywhere where an operation needs the exclusive lock, it is always
>>>>>>>>>> checked if we currently are a lock owner, i.e:
>>>>>>>>>>
>>>>>>>>>>  ictx->exclusive_lock->is_lock_owner()
>>>>>>>>>>
>>>>>>>>>> and if it is false, the exlusive lock is requested. Before this check
>>>>>>>>>> you need to aquire ctx->owner_lock, and until you release owner_lock
>>>>>>>>>> you can be sure your exclusive lock will not leak to another
>>>>>>>>>> client. After releasing owner_lock, you will need to repeate the check
>>>>>>>>>> again when you need it.
>>>>>>>>>>
>>>>>>>>>> --
>>>>>>>>>> Mykola Golub
>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>>
>>>>>>>>>>> On Fri, Aug 19, 2016 at 5:48 AM, Mykola Golub <mgolub@mirantis.com> wrote:
>>>>>>>>>>> > On Thu, Aug 18, 2016 at 09:20:02PM -0700, Victor Denisov wrote:
>>>>>>>>>>> >> Could you please point me to the place in source code where writer
>>>>>>>>>>> >> acquires an exclusive lock on the image.
>>>>>>>>>>> >
>>>>>>>>>>> > Grep for 'exclusive_lock->request_lock'. Basically, what you need
>>>>>>>>>>> > (after opening the image) is:
>>>>>>>>>>> >
>>>>>>>>>>> > ```
>>>>>>>>>>> >   C_SaferCond lock_ctx;
>>>>>>>>>>> >   {
>>>>>>>>>>> >     RWLock::WLocker l(ictx->owner_lock);
>>>>>>>>>>> >
>>>>>>>>>>> >     if (ictx->exclusive_lock == nullptr) {
>>>>>>>>>>> >       // exclusive-lock feature is not enabled
>>>>>>>>>>> >       return -EINVAL;
>>>>>>>>>>> >     }
>>>>>>>>>>> >
>>>>>>>>>>> >     // Request the lock. If it is currently owned by another client,
>>>>>>>>>>> >     // RPC message will be sent to the client to release the lock.
>>>>>>>>>>> >     ictx->exclusive_lock->request_lock(&lock_ctx);
>>>>>>>>>>> >   } // release owner_lock before waiting to avoid potential deadlock
>>>>>>>>>>> >
>>>>>>>>>>> >   int r = lock_ctx.wait();
>>>>>>>>>>> >   if (r < 0) {
>>>>>>>>>>> >     return r;
>>>>>>>>>>> >   }
>>>>>>>>>>> >
>>>>>>>>>>> >   RWLock::RLocker l(ictx->owner_lock);
>>>>>>>>>>> >   if (ictx->exclusive_lock == nullptr || !ictx->exclusive_lock->is_lock_owner()) {
>>>>>>>>>>> >        // failed to acquire exclusive lock
>>>>>>>>>>> >        return -EROFS;
>>>>>>>>>>> >   }
>>>>>>>>>>> >
>>>>>>>>>>> >   // At this point lock is acquired
>>>>>>>>>>> >   ...
>>>>>>>>>>> >
>>>>>>>>>>> > ```
>>>>>>>>>>> >
>>>>>>>>>>> > You might want to look at this PR
>>>>>>>>>>> >
>>>>>>>>>>> >  https://github.com/ceph/ceph/pull/9592
>>>>>>>>>>> >
>>>>>>>>>>> > where we discuss adding API methods to directly acquire and release
>>>>>>>>>>> > the exclusive lock. You don't need the API, but will find examples in
>>>>>>>>>>> > the patch, and also useful comments from Jason.
>>>>>>>>>>> >
>>>>>>>>>>> > --
>>>>>>>>>>> > Mykola Golub
>>>>>>>>>>> >
>>>>>>>>>>> >> I presume you were talking about the feature:
>>>>>>>>>>> >> exclusive_lock, shared_lock which can be used from command line using
>>>>>>>>>>> >> commands lock list, lock break.
>>>>>>>>>>> >>
>>>>>>>>>>> >> On Thu, Aug 18, 2016 at 5:47 PM, Jason Dillaman <jdillama@redhat.com> wrote:
>>>>>>>>>>> >> > There is already a "request lock" RPC message and this is already handled
>>>>>>>>>>> >> > transparently within librbd when you attempt to acquire the lock and another
>>>>>>>>>>> >> > client owns it.
>>>>>>>>>>> >> >
>>>>>>>>>>> >> >
>>>>>>>>>>> >> > On Thursday, August 18, 2016, Victor Denisov <vdenisov@mirantis.com> wrote:
>>>>>>>>>>> >> >>
>>>>>>>>>>> >> >> If an image already has a writer who owns the lock,
>>>>>>>>>>> >> >> should I implement a notification that allows to ask the writer to
>>>>>>>>>>> >> >> release the lock,
>>>>>>>>>>> >> >> is there already a standard way to intercept the exclusive lock?
>>>>>>>>>>> >> >>
>>>>>>>>>>> >> >> On Tue, Aug 16, 2016 at 6:29 AM, Jason Dillaman <jdillama@redhat.com>
>>>>>>>>>>> >> >> wrote:
>>>>>>>>>>> >> >> > ... one more thing:
>>>>>>>>>>> >> >> >
>>>>>>>>>>> >> >> > I was also thinking that we need a new RBD feature bit to be used to
>>>>>>>>>>> >> >> > indicate that an image is part of a consistency group to prevent older
>>>>>>>>>>> >> >> > librbd clients from removing the image or group snapshots.  This could
>>>>>>>>>>> >> >> > be a RBD_FEATURES_RW_INCOMPATIBLE feature bit so older clients can
>>>>>>>>>>> >> >> > still open the image R/O while its part of a group.
>>>>>>>>>>> >> >> >
>>>>>>>>>>> >> >> > On Tue, Aug 16, 2016 at 9:26 AM, Jason Dillaman <jdillama@redhat.com>
>>>>>>>>>>> >> >> > wrote:
>>>>>>>>>>> >> >> >> Way back in April when we had the CDM, I was originally thinking we
>>>>>>>>>>> >> >> >> should implement option 3. Essentially, you have a prepare group
>>>>>>>>>>> >> >> >> snapshot RPC message that extends a "paused IO" lease to the caller.
>>>>>>>>>>> >> >> >> When that lease expires, IO would automatically be resumed even if the
>>>>>>>>>>> >> >> >> group snapshot hasn't been created yet.  This would also require
>>>>>>>>>>> >> >> >> commit/abort group snapshot RPC messages.
>>>>>>>>>>> >> >> >>
>>>>>>>>>>> >> >> >> However, thinking about this last night, here is another potential
>>>>>>>>>>> >> >> >> option:
>>>>>>>>>>> >> >> >>
>>>>>>>>>>> >> >> >> Option 4 - require images to have the exclusive lock feature before
>>>>>>>>>>> >> >> >> they can be added to a consistency group (and prevent disabling of
>>>>>>>>>>> >> >> >> exclusive-lock while they are part of a group). Then librbd, via the
>>>>>>>>>>> >> >> >> rbd CLI (or client application of the rbd consistency group snap
>>>>>>>>>>> >> >> >> create API), can co-operatively acquire the lock from all active image
>>>>>>>>>>> >> >> >> clients within the group (i.e. all IO has been flushed and paused) and
>>>>>>>>>>> >> >> >> can proceed with snapshot creation. If the rbd CLI dies, the normal
>>>>>>>>>>> >> >> >> exclusive lock handling process will automatically take care of
>>>>>>>>>>> >> >> >> re-acquiring the lock from the dead client and resuming IO.
>>>>>>>>>>> >> >> >>
>>>>>>>>>>> >> >> >> This option not only re-uses existing code, it would also eliminate
>>>>>>>>>>> >> >> >> the need to add/update the RPC messages for prepare/commit/abort
>>>>>>>>>>> >> >> >> snapshot creation to support group snapshots (since it could all be
>>>>>>>>>>> >> >> >> handled internally).
>>>>>>>>>>> >> >> >>
>>>>>>>>>>> >> >> >> On Mon, Aug 15, 2016 at 7:46 PM, Victor Denisov <vdenisov@mirantis.com>
>>>>>>>>>>> >> >> >> wrote:
>>>>>>>>>>> >> >> >>> Gentlemen,
>>>>>>>>>>> >> >> >>>
>>>>>>>>>>> >> >> >>> I'm writing to you to ask for your opinion regarding quiescing writes.
>>>>>>>>>>> >> >> >>>
>>>>>>>>>>> >> >> >>> Here is the situation. In order to take snapshots of all images in a
>>>>>>>>>>> >> >> >>> consistency group,
>>>>>>>>>>> >> >> >>> we first need to quiesce all the image writers in the consistency
>>>>>>>>>>> >> >> >>> group.
>>>>>>>>>>> >> >> >>> Let me call
>>>>>>>>>>> >> >> >>> group client - a client which requests a consistency group to take a
>>>>>>>>>>> >> >> >>> snapshot.
>>>>>>>>>>> >> >> >>> Image client - the client that writes to an image.
>>>>>>>>>>> >> >> >>> Let's say group client starts sending notify_quiesce to all image
>>>>>>>>>>> >> >> >>> clients that write to the images in the group. After quiescing half of
>>>>>>>>>>> >> >> >>> the image clients the group client can die.
>>>>>>>>>>> >> >> >>>
>>>>>>>>>>> >> >> >>> It presents us with a dilemma - what should we do with those quiesced
>>>>>>>>>>> >> >> >>> image clients.
>>>>>>>>>>> >> >> >>>
>>>>>>>>>>> >> >> >>> Option 1 - is to wait till someone manually runs recover for that
>>>>>>>>>>> >> >> >>> consistency group.
>>>>>>>>>>> >> >> >>> We can show warning next to those unfinished groups when user runs
>>>>>>>>>>> >> >> >>> group list command.
>>>>>>>>>>> >> >> >>> There will be a command like group recover, which allows users to
>>>>>>>>>>> >> >> >>> rollback unsuccessful snapshots
>>>>>>>>>>> >> >> >>> or continue them using create snapshot command.
>>>>>>>>>>> >> >> >>>
>>>>>>>>>>> >> >> >>> Option 2 - is to establish some heart beats between group client and
>>>>>>>>>>> >> >> >>> image client. If group client fails to heart beat then image client
>>>>>>>>>>> >> >> >>> unquiesces itself and continues normal operation.
>>>>>>>>>>> >> >> >>>
>>>>>>>>>>> >> >> >>> Option 3 - is to have a timeout for each image client. If group client
>>>>>>>>>>> >> >> >>> fails to make a group snapshot within this timeout then we resume our
>>>>>>>>>>> >> >> >>> normal operation informing group client of the fact.
>>>>>>>>>>> >> >> >>>
>>>>>>>>>>> >> >> >>> Which of these options do you prefer? Probably there are other options
>>>>>>>>>>> >> >> >>> that I miss.
>>>>>>>>>>> >> >> >>>
>>>>>>>>>>> >> >> >>> Thanks,
>>>>>>>>>>> >> >> >>> Victor.
>>>>>>>>>>> >> >> >>
>>>>>>>>>>> >> >> >>
>>>>>>>>>>> >> >> >>
>>>>>>>>>>> >> >> >> --
>>>>>>>>>>> >> >> >> Jason
>>>>>>>>>>> >> >> >
>>>>>>>>>>> >> >> >
>>>>>>>>>>> >> >> >
>>>>>>>>>>> >> >> > --
>>>>>>>>>>> >> >> > Jason
>>>>>>>>>>> >> >
>>>>>>>>>>> >> >
>>>>>>>>>>> >> >
>>>>>>>>>>> >> > --
>>>>>>>>>>> >> > Jason
>>>>>>>>>>> >> >
>>>>>>>>>>> >> --
>>>>>>>>>>> >> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>>>>>>>> >> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>>> >> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>>>>> --
>>>>>>>>>>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>>>>>>>>>>> the body of a message to majordomo@vger.kernel.org
>>>>>>>>>>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>>>>>>>
>>>>>>>>
>>>>>>>>
>>>>>>>> --
>>>>>>>> Jason
>>>>>
>>>>>
>>>>>
>>>>> --
>>>>> Jason
>>>
>>>
>>>
>>> --
>>> Jason
