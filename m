From: Yehuda Sadeh <yehuda@redhat.com>
Subject: Re: object versioning
Date: Thu, 14 Aug 2014 08:15:11 -0700
Message-ID: <CABBk=J8HdCo1-bWtCFPbnL+bQgTrpMMy55uBVHmrnuSxa3zr-w@mail.gmail.com>
References: <CABBk=J9yTxfXENN8X7VUaK_cbJZ71UCBxc4pnAsMHA7-XkJriw@mail.gmail.com>
	<53EC84E9.1080607@42on.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f175.google.com ([209.85.213.175]:65420 "EHLO
	mail-ig0-f175.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754563AbaHNPPM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Aug 2014 11:15:12 -0400
Received: by mail-ig0-f175.google.com with SMTP id uq10so13880306igb.2
        for <ceph-devel@vger.kernel.org>; Thu, 14 Aug 2014 08:15:11 -0700 (PDT)
In-Reply-To: <53EC84E9.1080607@42on.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Wido den Hollander <wido@42on.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@redhat.com>, Samuel Just <sam.just@inktank.com>

On Thu, Aug 14, 2014 at 2:44 AM, Wido den Hollander <wido@42on.com> wrote:
> On 08/14/2014 02:00 AM, Yehuda Sadeh wrote:
>>
>> One of the next features that we're working on is the long due object
>> versioning. This basically allows keeping old versions of objects
>> inside buckets, even if user has removed or overwritten them. Any
>> object instance is immutable. and object can then be fetched by the
>> version (instance) id of that object.
>> When removing the object without specifying a version, a new deletion
>> marker is created. It is, however, possible to remove a specific
>> object version, and in this case the version is not accessible
>> anymore. What complicates things is that if the current object's
>> version (the one that is accessed when accessing the object without
>> specifying a version) is removed, then the object will then point at
>> its previous version. Permissions are set on the object version level.
>>
>
> Does it really work at Amazon? Shouldn't you get a 404 if you remove the
> current version of the object? A auto rollback to the previous version seems
> pretty weird to me.

If you remove the object without specifying the version id, then yes,
you'll get 404. In that case the underlying object instance is not
removed, and instead a new deletion marker is created. The object
logical head then moves to point at the marker. If, however, you
remove the object version itself (by specifying the version id), then
the object logical head will move to the previous version.

>
>
>> Another requirement is the ability to list all objects and versions of
>> the objects. This means that when listing objects we either need to
>> list only the current objects, or both the current objects and their
>> respective versions.
>> One thing to note is that object versioning needs to be switched on
>> for the bucket for the feature to be activated, and once it's switched
>> on it can only be suspended. This means that newly created objects
>> will not be versioned, but old versions will still be accessible.
>>
>> Let's sum up the functionality:
>>   - ability to list objects and versions
>>   - ability to read specific object version
>>   - ability to remove a specific object version (*)
>>   - object creation / overwrite creates a new object version, object
>> points at new instance
>>   - object removal does not remove object instance, creates a deletion
>> marker
>>   - (*) removal of the current object version rolls back object to
>> point at previous object version
>>   - permissions affect the object version and can be set on the versions
>>
>> Now, considering this functionality, it seems that we need to deal
>> with 3 different entities:
>>   - bucket index
>>   - object instances (versions)
>>   - object logical head (olh)
>>
>> The first two can be mapped nicely into the already existing
>> structures. The existing bucket index will be extended to keep the
>> list of versions, and our current rgw objects will be used to handle
>> the object instances, as they serve the same function.
>
>
> Keeping the version of ALL objects in the same index? Does that scale?
> Imagine a process overwriting a object over and over and the end-user is not
> aware of the versioning being turned on or performance implications.

That's all versions of the same object in the same index. Note that
versioning needs to be turned on explicitly on the bucket for it to
work. In the future we'll have bucket sharding, but with this design,
we'll still keep the same object at the same shard. We can revisit it
later, maybe in the future we'll have cross object transactions in
rados which will make it possible to shard that.

>
> Shouldn't there be a auto purge for older then version X / time?

We've discussed this, and it can certainly be done. To cap the number
of entries, the bucket index op journal will specify which extra
versions to trim. Object version expiration could be implemented with
the object expiration feature. Another option would be to send the
versions into a secondary storage (e.g., different buckets that reside
on different pools).

>
>> One of the options that we can consider for the object logical head is
>> also to use a regular object that will just have a copy of the
>> appropriate instance manifest. It doesn't seem that this will function
>> as needed, as it doesn't satisfy the last requirement (permissions are
>> set at the version level). What we do need to have is some sort of a
>> soft link that will be used to point at the appropriate object
>> instance.
>>
>> We had internal discussions on how to make everything work together.
>> There are a few things that we need to be careful about. We need to
>> make sure that the bucket index listing reflects the status of the
>> actual objects. When the olh points at a specific version, we
>> shouldn't show a different view when listing the objects. This gets
>> even more complicated when removing an object version that requires
>> olh change, as we have 3 different entities that we need to sync. Note
>> that rados does not have multi-object transactions (for now), and we
>> traditionally avoided locking for rgw object operations.
>>
>> The current scheme is that we update the bucket index using a 2 phase
>> commit, and it follows up on the objects state. So when adding /
>> removing an object, we first tell the bucket index to 'prepare' for
>> the operation, then do the operation, and eventually we let the bucket
>> index know about the completion. For ordering we rely on the pg
>> versioning system that gives us insight into the timeline, so that
>> when two concurrent operations happen on the same object the bucket
>> index can figure out who won and who is dead.
>> This system as it is doesn't really work with versioning as we have
>> both the olh, and the object instances. This is one of the solutions
>> that we came up with:
>>
>>   - The bucket index will be the source of the truth
>>   - The bucket index will serve as an operational log for olh operations
>>
>> The bucket index will index every object instance in reverse order
>> (from new to old). The bucket index will keep entries for deletion
>> markers.
>> The bucket index will also keep operations journal for olh
>> modifications. Each operation in this journal will have an id that
>> will be increased monotonically, and that will be tied into current
>> olh version. The olh will be modified using idempotent operations that
>> will be subject to having its current version smaller than the
>> operation id.
>> The journal will be used for keeping order, and the entries in the
>> journal will serve as a blueprint that the gateways will need to
>> follow when applying changes. In order to ensure that operations that
>> needed to be complete were done, we'll mark the olh before going to
>> the bucket index, so that if the gateway died before completing the
>> operation, next time we try to access the object we'll know that we
>> need to go to the bucket index and complete the operation.
>>
>> Things will then work like this:
>>
>> * object creation
>>
>> 1. Create object instance
>> 2. Mark olh that it's about to be modified
>> 3. Update bucket index about new object instance
>> 4. Read bucket index object op journal
>>
>> Note that the journal should have at this point an entry that says
>> 'point olh to specific object version, subject to olh is at version
>> X'.
>>
>> 5. Apply journal ops
>> 6. Trim journal, unmark olh
>>
>> * object removal (olh)
>>
>> 1. Mark olh that it's about to be modified
>> 2. Update bucket index about the new deletion marker
>> 3. Read bucket index object op journal
>>
>> The journal entry should say something like 'mark olh as removed,
>> subject to olh is at version X'
>>
>> 4. Apply ops
>> 5. Trim journal, unmark olh
>>
>> Another option is to actually remove the olh, but in this case we'll
>> lose the olh versioning. We can in that case use the object
>> non-existent state as a check, but that will not be enough as there
>> are some corner cases where we could end up with the olh pointing at
>> the wrong object.
>>
>> * object version removal
>>
>> 1. Mark olh as it will potentially be modified
>> 2. Update bucket index about object instance removal
>> 3. Read bucket index op journal
>> 4. apply ops journal ...
>> Now the journal might just say something like 'remove object
>> instance', which means that the olh was pointing at a different object
>> version. The more interesting case is when the olh pointing at this
>> specific object version. In this case the journal will say something
>> like 'first point the olh at version V2, subject to olh is at version
>> X. Now, remove object instance V1'.
>>
>> 5. Trim journal, unmark olh
>>
>>
>> Note about olh marking: The olh mark will create an attr on the olh
>> that will have an id and a timestamp. There could be multiple marks on
>> the olh, and the marks should have some expiration, so that operations
>> that did not really start would be removed after a while.
>>
>>
>> Let me know if that makes sense, or if you have any questions.
>>
>> Thanks,
>> Yehuda
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>>
>
>
> --
> Wido den Hollander
> 42on B.V.
> Ceph trainer and consultant
>
> Phone: +31 (0)20 700 9902
> Skype: contact42on
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
