From: Alex Elder <elder@dreamhost.com>
Subject: Re: RBD layering design draft
Date: Thu, 21 Jun 2012 16:51:40 -0500
Message-ID: <4FE3976C.5000508@dreamhost.com>
References: <4FDB9FBB.9000807@inktank.com>
Reply-To: elder@inktank.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:58266 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932759Ab2FUVvl (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 21 Jun 2012 17:51:41 -0400
In-Reply-To: <4FDB9FBB.9000807@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 06/15/2012 03:48 PM, Josh Durgin wrote:
> Here's a draft of a patch to the docs outlining the rbd layering
> design. Is anything unclear? Any suggestions for improvement?
> 
> Josh

I'm going to try to take into account the comments others have made
but I may end up duplicating--and if so, I apologize in advance.  I
also have a lot of questions and suggestions.  They may just show
my ignorance more than anything, so I just may need to get better
educated about this...

> ============
> RBD Layering
> ============
> 
> RBD layering refers to the creation of copy-on-write clones of block
> devices. This allows for fast image creation, for example to clone a
> golden master image of a virtual machine into a new instance. To
> simplify the semantics, you can only create a clone of a snapshot -
> snapshots are always read-only, so the rest of the image is
> unaffected, and there's no possibility of writing to them
> accidentally.

I think this is a good restriction.  However the rest of your
description doesn't seem to be very clear about that.  In
particular, if there can be a chain of "parents" that suggests
that maybe a parent could be something other than a (read-only)
snapshot of a top-level RBD image.

I just learned though that a clone can itself be treated as if
it were a top-level RBD image.  (So some of my comments may
show that I didn't get that before.)

> Note: the terms `child` and `parent` below mean an rbd image created
> by cloning, and the rbd image snapshot a child was cloned from.

I went through this with the following understanding, and I'll
lay it out here because it may inform some of the comments that
follow.

RBD Image
    Top-level RBD image.  Uniquely defined by (pool id, rbd id).
    All storage for an RBD image comes from a single pool.  An
    RBD image has a fixed order, which defines the power-of-two
    size of the segments the RBD's storage is broken into.

RBD Snapshot
    Read-only snapshot of the state/content of a (parent) RBD image
    at a particular instant in time.  Uniquely defined by either
    (pool id, rbd id, snapshot id) or, because each snapshot also
    optionally has a unique user-provided name, (pool id, rbd id, name).
    Storage for a snapshot always comes from the same pool as its
    associated RBD image, and it segment size (object order) also
    matches that of its image.

RBD Clone Image
    Read/write, copy-on-write version of a particular RBD snapshot.
    Uniquely defined by (pool id, image id); its content is also
    permanently tied to the RBD snapshot on which it's based.
    Initial contents are identical to its snapshot, but any write
    to the content will result in a making a copy of an affected
    range from the snapshot's content, updating it based on the
    write operation, saving the new copy and associating the updated
    portion with the clone.  A clone must have read access to the
    snapshot it is based on, but can itself use a different pool to
    which it has read/write access to store its updated data.  A
    clone can have a different object order from the snapshot it's
    based on.

    Note that a clone can itself be snapshotted, and those snapshots
    can then have their own clones.  This leads to the possibility of
    chains of parents, mentioned elsewhere.

OK, based on that understanding, I'd recommend using terminology
more like what I use above rather than "parent" and "child."  That
is, an image, a snapshot, and a clone all play different roles and
have different semantics.

(Even though a clone can be treated as if it were a top-level RBD
image I think it's useful to have a term that distinguishes it as
dependent on another image for its data.)

> Command line interface
> ----------------------
> 
> Before cloning a snapshot, you must mark it as preserved, to prevent
> it from being deleted while child images refer to it:
> ::
> 
>     $ rbd preserve pool/image@snap

Why is it necessary to do this?  I think it may be desirable to
(i.e., to mark a particular snapshot as having some significance).
But I think this ought to be an optional feature, and one in
which you might even give it name, rather than something that's
required.  The name would be distinct from the snapshot name, to
allow snapshot "Tuesday_4pm" be preserved as "Ubuntu_12.04-image".

> Then you can perform the clone:
> ::
> 
>     $ rbd clone --parent pool/parent@snap pool2/child1

Based on my comments above, if the parent had not been "preserved"
it would automatically be at this point, by virtue of the fact it
has a clone associated with it.

Since there is always exactly one parent and one child, I'd say
drop the "--parent" and just have the parent and child be
defined by their position.  If the parent could be optionally
skipped for some reason, then make *it* be the second one.

> You can create a clone with different object sizes from the parent:
> ::
> 
>     $ rbd clone --parent pool/parent@snap --order 25 pool2/child2

Are there any restrictions on the relationship between the orders
of the parent and child?  (I don't think there has to be, and this
is actually a very interesting feature.)

> To delete the parent, you must first mark it unpreserved, which checks
> that there are no children left:
> ::
> 

Please show what happens here if this is done at this point:

      $ rbd snap rm pool/image@snap

>     $ rbd unpreserve pool/image@snap
>     Error unpreserving: child images rely on this image
>     $ rbd list_children pool/image@snap
>     pool2/child1
>     pool2/child2
>     $ rbd copyup pool2/child1

The term "copyup" does not resonate with me at all--I find it
offers no clues about what it does (and I can think of a few
contradictory interpretations).

My best guess is that you mean to be promoting a clone to be
a free-standing RBD image, re-writing the entire content of
the parent snapshot (recursively) into the clone.  And in
doing so it disassociates itself from the original.  So I
assume that from here forward.

What happens to snapshots of clones that have been the
subject of this operation?  Do they all need to be rewritten
to reflect the new objects backing the top-level image?  Do
they remain dependent on the previous parent snapshot?

>     $ rbd rm pool2/child2
>     $ rbd unpreserve pool/image@snap
> 
> Then the snapshot can be deleted like normal:
> ::
> 
>     $ rbd snap rm pool/image@snap

Note that the "preserve" and "unpreserve" operations are
valid on snapshots, not RBD images or clones.

> Implementation
> --------------
> 
> Data Flow
> ^^^^^^^^^
> 
> In the initial implementation, called 'trivial layering', there will
> be no tracking of which objects exist in a clone. A read that hits a
> non-existent object will attempt to read from the parent object, and
> this will continue recursively until an object exists or an image with
> no parent is found.

So a non-existent object in a clone is a bit like a hole in a file, but
instead of implicitly backing it with zeroes it backs it with the data
found at the same range as the snapshot the clone was based on?

If a clone had snapshots, does this mean a snapshot can include
non-existent objects in it?

Does this mean that an attempt to read beyond the end of an RBD snapshot
is not an error if the read is being done for a clone whose size has
been increased from what it was originally?  (In that case, the correct
action would be to read the range as zeroes.)

> Before a write is performed, the object is checked for existence. If
> it doesn't exist, a copy-up operation is performed, which means
> reading the relevant range of data from the parent image and writing
> it (plus the original write) to the child image. To prevent races with
> multiple writes trying to copy-up the same object, this copy-up
> operation will include an atomic create. If the atomic create fails,
> the original write is done instead. This copy-up operation is
> implemented as a class method so that extra metadata can be stored by
> it in the future.

I think we need to expand on this existence check/atomic create/copy
up business.  I'm not sure I know what "the original write is done"
means in this context.

> A future optimization could be storing a bitmap of which objects
> actually exist in a child. This would obviate the check for existence
> before each write, and let reads go directly to the parent if needed.

This may not be very difficult to do.

> Parent/Child relationships
> ^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Children store a reference to their parent in their header, as a tuple
> of (pool id, image id, snapshot id). This is enough information to
> open the parent and read from it.

Do we have an abstract entity that uniquely defines a snapshot?  I mean,
can we define a "snapshot name" which basically encapsulates the
(pool id, image id, snapshot id) tuple?  Maybe that doesn't matter, but
I think the abstraction might help clarify the interface a bit.  I.e.,
you can't just pass arbitrary combinations of the three components,
a snapshot name is very well defined as a unit.

> In addition to knowing which parent a given image has, we want to be
> able to tell if a preserved image still has children. This is
> accomplished with a new per-pool object, `rbd_children`, which maps
> (parent pool, parent id, parent snapshot id) to a list of child

My first thought was, why does the parent snapshot need to know the
*identity* of its descendant clones?  The main thing it seems to need
is a count of the number of clones it has.

The other thing though is that you shouldn't store the mapping
in the "rbd_children" object.  Instead, you should only store
the child object ids there, and consult those objects to identify
their parents.  Otherwise you end up with problems related to
possible discrepancy between what a child points to and what the
"rbd_children" mapping says.

> image ids. This is stored in the same pool as the child image
> because the client creating a clone already has read/write access to
> everything in this pool. This lets a client with read-only access to
> one pool clone a snapshot from that pool into a pool they have full
> access to. It increases the cost of unpreserving an image, since this

This is really a bad feature of this design because it doesn't scale.
So we ought to be thinking about a better way to do it if possible.

> needs to check for children in every pool, but this is a rare
> operation. It would likely only be done before removing old images,
> which is already much more expensive because it involves deleting
> every data object in the image.
> 
> Preservation
> ^^^^^^^^^^^^
> 
> Internally, preservation_state is a field in the header object that
> can be in three states. "preserved", "unpreserved", and
> "unpreserving". The first two are set as the result of "rbd
> preserve/unpreserve". The "unpreserving" state is set while the "rbd

The "unpreserved" state is the initial state of any snapshot.  The
"preserved" state is set immediately as a result of "rbd preserve".
The "unpreserving" state is set immediately to avoid a race; after
it is verified there are no child images, an image in "unpreserving"
state is converted to "unpreserved".

> unpreserve" command checks for any child images. Only snapshots in the
> "preserved" state may be cloned, so the "unpreserving" state prevents
> a race like:
> 
> 1. A: walk through all pools, look for clones, find none
> 2. B: create a clone
> 3. A: unpreserve parent
> 4. A: rbd snap rm pool/parent@snap
> 
> Resizing
> ^^^^^^^^
> 
> To support resizing of layered images, we need to keep track of the
> minimum size the image ever was, so that if a child image is shrunk

We don't want the minimum size.  We want to know the highest valid
offset in the image:
- Upon cloning, the last valid offset of the clone is set to the last
  valid offset of the snapshot.
- If an image is resized larger, the last valid offset remains the same.
- If an image is resized smaller, the last valid offset is reduced to
  the new, smaller size.
- If data is written to an image at an offset between the last valid
  offset and the image size, the last valid offset is updated to the
  reflect the newly-written data.

> and then expanded, the re-expanded space is treated as unused instead
> of being read from the parent image. Since this can change over time,
> we need to store this for each snapshot as well.
> 
> Renaming
> ^^^^^^^^
> 
> Currently the rbd header object (that stores all the metadata about an
> image) is named after the name of the image. This makes renaming
> disrupt clients who have the image open (such as children reading from
> a parent image). To avoid this, we can name the header object by the
> id of the image, which does not change. That is, the name of the
> header object could be `rbd_header.$id`, where $id is a unique id for
> the image in the pool.

This is very good.

> When a client opens an image, all it knows is the name. There is
> already a per-pool `rbd_directory` object that maps image names to
> ids, but if we relied on it to get the id, we could not open any
> images in that pool if that single object was unavailable. To avoid
> this dependency, we can store the id of an image in an object called
> `rbd_id.$image_name`, where $image_name is the name of the image. The
> per-pool `rbd_directory` object is still useful for listing all images
> in a pool, however.
> 
> Header changes
> --------------
> 
> The header needs a few new fields:
> 
> * uint64_t parent_pool_id
> * string parent_image_id
> * uint64_t parent_snap_id
> * uint64_t min_size (smallest size the image ever was in bytes)
> * bool has_parent

Can't we avoid the Boolean here and just designate some sort of
well-known parent image id to be used to indicate "no parent"?

> Note that all the image ids are strings instead of uint64_t to let us
> easily switch to uuids in the future.

Are we planning to begin this sort of conversion any time soon?

> cls_rbd
> ^^^^^^^
> 
> Some new methods are needed:
> ::
> 
>     /***************** methods on the rbd header *********************/
>     /**
>      * Sets the parent, min_size, and has_parent keys.
>      * Fails if any of these keys exist, since the image already
>      * had a parent.
>      */
>     set_parent(uint64_t pool_id, string image_id, uint64_t snap_id)

    set_parent(string snap_name)  (if we had a snap_name abstraction)

>     /**
>      * Returns the parent pool id, image id, and snap id, or -ENOENT
>      * if has_parent is false
>      */
>     get_parent(uint64_t snapid)
> 
>     /**
>      * Set has_parent to false.
>      */
>     remove_parent() // after all parent data is copied to the child

Is this saying that the image has no parent once the asynchronous
copying of parent data to child has completed?  (Or would it be
synchronous?)  Or is this saying that the caller has to be sure
the data is copied before calling remove_parent()?

>     /*************** methods on the rbd_children object *****************/
> 
>     add_child(uint64_t parent_pool_id, string parent_image_id,
>               uint64_t parent_snap_id, string image_id);

    add_child(string snap_name, string image_id) (?)

>     remove_child(uint64_t parent_pool_id, string parent_image_id,
>                  uint64_t parent_snap_id, string image_id);
>     /**
>      * List image ids of a given parent
>      */
>     get_children(uint64_t parent_pool_id, string parent_image_id,
>                  uint64_t parent_snap_id, uint64_t max_return,
>                  string start);

This is the one that requires an exhaustive query across all pools.

This kind of interface implies there is a well-defined ordering of
image ids.  What does "start" look like?  I guess this generally
raises a lot of questions about whether this (or perhaps some other)
interface can reliably produce an accurate list.  (It's like the
directory interfaces--opendir(), readdir(), seekdir(), etc.)

>     /**
>      * List parent images
>      */
>     get_parents(uint64_t max_return, uint64_t start_pool_id,
>                 string start_image_id, string start_snap_id);

This interface implies an ordering across pool ids, image ids,
and snapshot ids that I'm not sure we want to rely on.


>     /************ methods on the rbd_id.$image_name object **************/
>     /**
>      * Create the object and set the id. Fail and return -EEXIST if
>      * the object exists.
>      */
>     create_id(string id)
>     get_id()
> 
>     /***************** methods on the rbd_data objects ******************/
>     /**
>      * Create an object with parent_data as its contents,
>      * then write child_data to it. If the exclusive create fails,
>      * just write the child_data.
>      */
>      copy_up(char *parent_data, uint64_t parent_data_len,
>              char *child_data, uint64_t child_data_offset,
>              uint64_t child_data_length)
> 
> One existing method will change if the image supports
> layering:
> ::
> 
>     snapshot_add - stores current min_size and has_parent with
>                    other snapshot metadata (images that don't have
>                    layering enabled aren't affected)

OK, that's all I've got.

					-Alex
> 
> librbd
> ^^^^^^
> 
> Opening a child image opens its parent (and this will continue
> recursively as needed). This means that an ImageCtx will contain a
> pointer to the parent image context. Differing object sizes won't
> matter, since reading from the parent will go through the parent
> image context.
> 
> Discard will need to change for layered images so that it only
> truncates objects, and does not remove them. If we removed objects, we
> could not tell if we needed to read them from the parent.
> 
> A new clone method will be added, which takes the same arguments as
> create except size (size of the parent image is used).
> -- 
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 

