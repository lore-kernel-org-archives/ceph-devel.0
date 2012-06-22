From: Tommi Virtanen <tv@inktank.com>
Subject: Re: RBD layering design draft
Date: Fri, 22 Jun 2012 09:27:11 -0700
Message-ID: <CADvuQRHhBA3i_deqYs4eVnA2NjDujnM7=n0GQ0j3FhU-uFn+EA@mail.gmail.com>
References: <4FDB9FBB.9000807@inktank.com> <4FE3976C.5000508@dreamhost.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:64935 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753565Ab2FVQ1c convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 22 Jun 2012 12:27:32 -0400
Received: by dady13 with SMTP id y13so2534909dad.19
        for <ceph-devel@vger.kernel.org>; Fri, 22 Jun 2012 09:27:32 -0700 (PDT)
In-Reply-To: <4FE3976C.5000508@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: elder@inktank.com
Cc: Josh Durgin <josh.durgin@inktank.com>, ceph-devel <ceph-devel@vger.kernel.org>

On Thu, Jun 21, 2012 at 2:51 PM, Alex Elder <elder@dreamhost.com> wrote=
:
>> Before cloning a snapshot, you must mark it as preserved, to prevent
>> it from being deleted while child images refer to it:
>> ::
>>
>> =C2=A0 =C2=A0 $ rbd preserve pool/image@snap
>
> Why is it necessary to do this? =C2=A0I think it may be desirable to

So the snapshot will not be removed.

See this: http://thread.gmane.org/gmane.comp.file-systems.ceph.devel/65=
95/focus=3D6675

>> =C2=A0 =C2=A0 $ rbd clone --parent pool/parent@snap pool2/child1
>
> Based on my comments above, if the parent had not been "preserved"
> it would automatically be at this point, by virtue of the fact it
> has a clone associated with it.

The client creating the child typically has no write access to the
parent, and cannot do anything to it.

>> To delete the parent, you must first mark it unpreserved, which chec=
ks
>> that there are no children left:
>> ::
>
> Please show what happens here if this is done at this point:
>
> =C2=A0 =C2=A0 =C2=A0$ rbd snap rm pool/image@snap

rbd: Cannot remove a preserved snapshot: pool/image@snap

or something like that.

> Note that the "preserve" and "unpreserve" operations are
> valid on snapshots, not RBD images or clones.

That's a very good point. Perhaps the command should be "rbd snap
preserve" and "rbd snap unpreserve".

>> In the initial implementation, called 'trivial layering', there will
>> be no tracking of which objects exist in a clone. A read that hits a
>> non-existent object will attempt to read from the parent object, and
>> this will continue recursively until an object exists or an image wi=
th
>> no parent is found.
>
> So a non-existent object in a clone is a bit like a hole in a file, b=
ut
> instead of implicitly backing it with zeroes it backs it with the dat=
a
> found at the same range as the snapshot the clone was based on?

Yes.

Continuation of that: will the clone store sparse objects, or always
copy all the data for that object from the parent? That is, what
happens if I write 1 byte to a fresh clone? (And remember that block
sizes can differ.)

> If a clone had snapshots, does this mean a snapshot can include
> non-existent objects in it?

I don't like the phrase "include non-existent objects", and find that
an overambitious topological exercise, but yes, a snapshot may be
sparse.

Reads fall through toward parents until they find something -- or run
out of parents, in which case they read zeros.

> Does this mean that an attempt to read beyond the end of an RBD snaps=
hot
> is not an error if the read is being done for a clone whose size has
> been increased from what it was originally? =C2=A0(In that case, the =
correct
> action would be to read the range as zeroes.)

This was discussed later in the email, and I see you responded to that =
part.

>> In addition to knowing which parent a given image has, we want to be
>> able to tell if a preserved image still has children. This is
>> accomplished with a new per-pool object, `rbd_children`, which maps
>> (parent pool, parent id, parent snapshot id) to a list of child
>
> My first thought was, why does the parent snapshot need to know the
> *identity* of its descendant clones? =C2=A0The main thing it seems to=
 need
> is a count of the number of clones it has.

Maintaining that count in a distributed system, without listing the
things that are in it, gets challenging. Idempotent counters are
challenging. Maintaining it as a set is easier, significantly more
debuggable, and unlikely to be too costly. Plus it lets us serve "rbd
children" faster.

> The other thing though is that you shouldn't store the mapping
> in the "rbd_children" object. =C2=A0Instead, you should only store
> the child object ids there, and consult those objects to identify
> their parents. =C2=A0Otherwise you end up with problems related to
> possible discrepancy between what a child points to and what the
> "rbd_children" mapping says.

The question we need to ask is "who here is a child of $FOO". Needing
an indirection for every member makes that cost a lot more.

>> image ids. This is stored in the same pool as the child image
>> because the client creating a clone already has read/write access to
>> everything in this pool. This lets a client with read-only access to
>> one pool clone a snapshot from that pool into a pool they have full
>> access to. It increases the cost of unpreserving an image, since thi=
s
>
> This is really a bad feature of this design because it doesn't scale.
> So we ought to be thinking about a better way to do it if possible.

That would be nice. Good luck! We await your email, though not holding
our breath ;)

>> To support resizing of layered images, we need to keep track of the
>> minimum size the image ever was, so that if a child image is shrunk
>
> We don't want the minimum size. =C2=A0We want to know the highest val=
id
> offset in the image:
> - Upon cloning, the last valid offset of the clone is set to the last
> =C2=A0valid offset of the snapshot.
> - If an image is resized larger, the last valid offset remains the sa=
me.
> - If an image is resized smaller, the last valid offset is reduced to
> =C2=A0the new, smaller size.
> - If data is written to an image at an offset between the last valid
> =C2=A0offset and the image size, the last valid offset is updated to =
the
> =C2=A0reflect the newly-written data.

If I resize the child down, then resize it up again, and write in the
middle of the resized range, will the non-written parts above your
valid_offset be zero? That sounds like a difference in your & Josh's
designs, and something you two need to sort out.

>> =C2=A0 =C2=A0 get_children(uint64_t parent_pool_id, string parent_im=
age_id,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0uint64=
_t parent_snap_id, uint64_t max_return,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0string=
 start);
>
> This is the one that requires an exhaustive query across all pools.
>
> This kind of interface implies there is a well-defined ordering of
> image ids. =C2=A0What does "start" look like? =C2=A0I guess this gene=
rally
> raises a lot of questions about whether this (or perhaps some other)
> interface can reliably produce an accurate list. =C2=A0(It's like the
> directory interfaces--opendir(), readdir(), seekdir(), etc.)

It's racy against concurrent changes, sure. But we only care about the
races when the parent is preserved, and that guarantees there won't be
new (relevant) children created.

>> =C2=A0 =C2=A0 get_parents(uint64_t max_return, uint64_t start_pool_i=
d,
>> =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 string start=
_image_id, string start_snap_id);
>
> This interface implies an ordering across pool ids, image ids,
> and snapshot ids that I'm not sure we want to rely on.

They're all either numbers or a strings, and have a clear correct
hierarchical order of (pool, image, snap).
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
