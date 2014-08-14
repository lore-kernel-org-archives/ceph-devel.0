From: Yehuda Sadeh <yehuda@redhat.com>
Subject: Re: object versioning
Date: Thu, 14 Aug 2014 13:16:48 -0700
Message-ID: <CABBk=J-qoG6CJoQGCMmjJo0nXGCcWi8HcF4rN+S237vWzg-S5w@mail.gmail.com>
References: <CABBk=J9yTxfXENN8X7VUaK_cbJZ71UCBxc4pnAsMHA7-XkJriw@mail.gmail.com>
	<alpine.DEB.2.00.1408140917300.32572@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f182.google.com ([209.85.213.182]:43755 "EHLO
	mail-ig0-f182.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754101AbaHNUQt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Aug 2014 16:16:49 -0400
Received: by mail-ig0-f182.google.com with SMTP id c1so3161igq.9
        for <ceph-devel@vger.kernel.org>; Thu, 14 Aug 2014 13:16:48 -0700 (PDT)
In-Reply-To: <alpine.DEB.2.00.1408140917300.32572@cobra.newdream.net>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Samuel Just <sam.just@inktank.com>

On Thu, Aug 14, 2014 at 11:51 AM, Sage Weil <sweil@redhat.com> wrote:
> On Wed, 13 Aug 2014, Yehuda Sadeh wrote:
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
>>  - ability to list objects and versions
>
> Is this actually two things?
>
>  1- The regular bucket list will include all versions of all objects.
>  2- A new operation will list all version of a given object.
>
> Or would you just specify the prefix to be the object name and do the
> bucket list to get all versions of object foo?

With S3 there's no request for a specific object's versions. There's a
request that works at the bucket level, similar to regular bucket
listing. So it's just one thing.

>
>>  - ability to read specific object version
>>  - ability to remove a specific object version (*)
>>  - object creation / overwrite creates a new object version, object
>> points at new instance
>>  - object removal does not remove object instance, creates a deletion marker
>>  - (*) removal of the current object version rolls back object to
>> point at previous object version
>>  - permissions affect the object version and can be set on the versions
>
> Throwing in a couple of goals here too:
>
>  - a GET can still be serviced by going directly to librados objects,
> without consulting an index (and breaking read-side bucket scalability)
>  - a bucket listing is still reasonably efficient (normally performed by
> consulting the index object only).
>
>> Now, considering this functionality, it seems that we need to deal
>> with 3 different entities:
>>  - bucket index
>>  - object instances (versions)
>>  - object logical head (olh)
>>
>> The first two can be mapped nicely into the already existing
>> structures. The existing bucket index will be extended to keep the
>> list of versions, and our current rgw objects will be used to handle
>> the object instances, as they serve the same function.
>
> I think there is one differnce, though: before the head would be
> addressible by the object name, whereas here it is object name +
> tag/version... right?  So that the heads don't collide with other
> object versions.

This is correct. The internal object mechanics will work the same, the
object naming scheme will be different.

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
>
> (those 3 entities being the index, the object version, and the olh
> pointer)
>
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
>>  - The bucket index will be the source of the truth
>>  - The bucket index will serve as an operational log for olh operations
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
>
> I take it there is also a:
>
> * object read
>
> 1. look at olh
> 2. if marked as pending-modify,
>    a. check index for current head version, and use that vaue
>    b. if pending-modify is super old and no matching index entry exists,
>       remove marker
>    b. if index entry does exist, send async op to roll-forward the olh
> 3. read referenced object version
>
> ...and the 'roll-forward' on the olh would be something like
>
>  cmpxattr pending-modify-$tag == 1

I'm not sure we need to this comparison. What really matters is the
actual olh version.

>  cmpxattr olh_version == previous v

Maybe it should actually be cmpxattr olh_version < new v

>  setxattr olh_version = new v
>  setxattr head_version = whatever
>  rmxattr pending-modify-$tag
>
> This has the side-effect that a hot object will briefly pummel the index.
> That is probably fine...
>
>> * object creation
>>
>> 1. Create object instance
>
>  is there a step 0 so that a failed rgw gets garbage collected?

What scenario are you worried about? Incomplete operations should be
take care of by step (5)

>
>> 2. Mark olh that it's about to be modified
>
>  setxattr pending-modify-$tag=1
>
>> 3. Update bucket index about new object instance
>
>  omap_setkeys journal_$object_$olhversion_$tag = pending ?

Yeah, something along these lines.

>
>> 4. Read bucket index object op journal
>>
>> Note that the journal should have at this point an entry that says
>> 'point olh to specific object version, subject to olh is at version
>> X'.
>>
>> 5. Apply journal ops
>
> same as roll-forward event above?  unmark olh in the same op:
>
>  cmpxattr pending-modify-$tag == 1
>  cmpxattr olh_version == $olh_version_old
>  setxattr olh_version = $olh_version_new
>  setxattr head_version = whatever
>  rmxattr pending-modify-$tag
>
>> 6. Trim journal, unmark olh
>
> Just trim the journal.
>
>  call rgw.trim_journal($object, $olh_version_new)
>
> ...which can remove all prior journal entries too, since the olh is now at
> that version (or something higher).
>
> Am I on the right track?

Yes.

Yehuda


>
> sage
>
>
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
>>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
