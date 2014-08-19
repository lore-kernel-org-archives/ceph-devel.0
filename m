From: Sage Weil <sweil@redhat.com>
Subject: Re: object versioning
Date: Mon, 18 Aug 2014 17:22:10 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1408181709260.28244@cobra.newdream.net>
References: <CABBk=J9yTxfXENN8X7VUaK_cbJZ71UCBxc4pnAsMHA7-XkJriw@mail.gmail.com> <alpine.DEB.2.00.1408140917300.32572@cobra.newdream.net> <CABBk=J-qoG6CJoQGCMmjJo0nXGCcWi8HcF4rN+S237vWzg-S5w@mail.gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:58712 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752182AbaHSAWL (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 18 Aug 2014 20:22:11 -0400
In-Reply-To: <CABBk=J-qoG6CJoQGCMmjJo0nXGCcWi8HcF4rN+S237vWzg-S5w@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh <yehuda@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Samuel Just <sam.just@inktank.com>

On Thu, 14 Aug 2014, Yehuda Sadeh wrote:
> >> The current scheme is that we update the bucket index using a 2 phase
> >> commit, and it follows up on the objects state. So when adding /
> >> removing an object, we first tell the bucket index to 'prepare' for
> >> the operation, then do the operation, and eventually we let the bucket
> >> index know about the completion. For ordering we rely on the pg
> >> versioning system that gives us insight into the timeline, so that
> >> when two concurrent operations happen on the same object the bucket
> >> index can figure out who won and who is dead.
> >> This system as it is doesn't really work with versioning as we have
> >> both the olh, and the object instances. This is one of the solutions
> >> that we came up with:
> >>
> >>  - The bucket index will be the source of the truth
> >>  - The bucket index will serve as an operational log for olh operations
> >>
> >> The bucket index will index every object instance in reverse order
> >> (from new to old). The bucket index will keep entries for deletion
> >> markers.
> >> The bucket index will also keep operations journal for olh
> >> modifications. Each operation in this journal will have an id that
> >> will be increased monotonically, and that will be tied into current
> >> olh version. The olh will be modified using idempotent operations that
> >> will be subject to having its current version smaller than the
> >> operation id.
> >> The journal will be used for keeping order, and the entries in the
> >> journal will serve as a blueprint that the gateways will need to
> >> follow when applying changes. In order to ensure that operations that
> >> needed to be complete were done, we'll mark the olh before going to
> >> the bucket index, so that if the gateway died before completing the
> >> operation, next time we try to access the object we'll know that we
> >> need to go to the bucket index and complete the operation.
> >>
> >> Things will then work like this:
> >
> > I take it there is also a:
> >
> > * object read
> >
> > 1. look at olh
> > 2. if marked as pending-modify,
> >    a. check index for current head version, and use that vaue
> >    b. if pending-modify is super old and no matching index entry exists,
> >       remove marker
> >    b. if index entry does exist, send async op to roll-forward the olh
> > 3. read referenced object version
> >
> > ...and the 'roll-forward' on the olh would be something like
> >
> >  cmpxattr pending-modify-$tag == 1
> 
> I'm not sure we need to this comparison. What really matters is the
> actual olh version.

Yeah
 
> >  cmpxattr olh_version == previous v
> 
> Maybe it should actually be cmpxattr olh_version < new v
> 
> >  setxattr olh_version = new v
> >  setxattr head_version = whatever
> >  rmxattr pending-modify-$tag

But then we also need to rmxattr pending-modify-$tag for all prior 
modifications that are in the index/journal at the time.

> >
> > This has the side-effect that a hot object will briefly pummel the index.
> > That is probably fine...
> >
> >> * object creation
> >>
> >> 1. Create object instance
> >
> >  is there a step 0 so that a failed rgw gets garbage collected?
> 
> What scenario are you worried about? Incomplete operations should be
> take care of by step (5)

If we fail before 2 then the (partial) object version should get garbage 
collected.

> >> 2. Mark olh that it's about to be modified
> >
> >  setxattr pending-modify-$tag=1
> >
> >> 3. Update bucket index about new object instance
> >
> >  omap_setkeys journal_$object_$olhversion_$tag = pending ?
> 
> Yeah, something along these lines.
> 
> >
> >> 4. Read bucket index object op journal
> >>
> >> Note that the journal should have at this point an entry that says
> >> 'point olh to specific object version, subject to olh is at version
> >> X'.
> >>
> >> 5. Apply journal ops
> >
> > same as roll-forward event above?  unmark olh in the same op:
> >
> >  cmpxattr pending-modify-$tag == 1
> >  cmpxattr olh_version == $olh_version_old
> >  setxattr olh_version = $olh_version_new
> >  setxattr head_version = whatever
> >  rmxattr pending-modify-$tag
> >
> >> 6. Trim journal, unmark olh
> >
> > Just trim the journal.
> >
> >  call rgw.trim_journal($object, $olh_version_new)
> >
> > ...which can remove all prior journal entries too, since the olh is now at
> > that version (or something higher).

Moving on to the others ops:

> >> * object removal (olh)
> >>
> >> 1. Mark olh that it's about to be modified

 setxattr pending-modify-$tagthing

> >> 2. Update bucket index about the new deletion marker

 omap_setkeys ...

> >> 3. Read bucket index object op journal
> >>
> >> The journal entry should say something like 'mark olh as removed,
> >> subject to olh is at version X'

 call rgw.describe_olh_op $bucket $object  ?

> >> 4. Apply ops

 cmpxattr olh_version == $olh_version_old
 setxattr olh_version = $olh_version_new
 setxattr head_version = whiteout
 rmxattr pending-modify-$tag (for all pending tags)

> >> 5. Trim journal, unmark olh
> >>
> >> Another option is to actually remove the olh, but in this case we'll
> >> lose the olh versioning. We can in that case use the object
> >> non-existent state as a check, but that will not be enough as there
> >> are some corner cases where we could end up with the olh pointing at
> >> the wrong object.

Yeah, it seems simplest to keep the olh as long as there are object 
versions.


> >> * object version removal
> >>
> >> 1. Mark olh as it will potentially be modified

 setxattr pending-modify-$tag

> >> 2. Update bucket index about object instance removal

 omap_setkeys ...

> >> 3. Read bucket index op journal

 call rgw.describe_olh_op $bucket $object $tag

> >> 4. apply ops journal ...
> >> Now the journal might just say something like 'remove object
> >> instance', which means that the olh was pointing at a different object
> >> version. The more interesting case is when the olh pointing at this
> >> specific object version. In this case the journal will say something
> >> like 'first point the olh at version V2, subject to olh is at version
> >> X. Now, remove object instance V1'.

 cmpxattr olh_version == $olh_version_old
 setxattr olh_version = $olh_version_new
 rmxattr pending-modify-$tag (for all pending tags)

It seems like one could get away with not touching the olh for removing 
old object versions, but I'm not sure it's worth it?

> >> 5. Trim journal, unmark olh
> >>
> >>
> >> Note about olh marking: The olh mark will create an attr on the olh
> >> that will have an id and a timestamp. There could be multiple marks on
> >> the olh, and the marks should have some expiration, so that operations
> >> that did not really start would be removed after a while.

Ah, yeah.  So it's really smoething like

 setxattr pending-modify-$tag = <timestamp>

There is another case here when when all versions get removed.  In that 
case, the final op would just remove the olh entirely.  Later, when we 
recreate the object, the object create would be

1. write object version
2. write to journal
3. describe olh op
4. create/update olh
5. trim journal

?

sage
