From: Sage Weil <sage@inktank.com>
Subject: Re: RBD layering design draft
Date: Fri, 15 Jun 2012 17:46:27 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206151742380.28086@cobra.newdream.net>
References: <4FDB9FBB.9000807@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:60651 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758567Ab2FPAq3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Jun 2012 20:46:29 -0400
In-Reply-To: <4FDB9FBB.9000807@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

Looks good!  Couple small things:

On Fri, 15 Jun 2012, Josh Durgin wrote:
> Here's a draft of a patch to the docs outlining the rbd layering
> design. Is anything unclear? Any suggestions for improvement?
> 
> Josh
> 
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
> 
> Note: the terms `child` and `parent` below mean an rbd image created
> by cloning, and the rbd image snapshot a child was cloned from.
> 
> Command line interface
> ----------------------
> 
> Before cloning a snapshot, you must mark it as preserved, to prevent
> it from being deleted while child images refer to it:
> ::
> 
>     $ rbd preserve pool/image@snap
> 
> Then you can perform the clone:
> ::
> 
>     $ rbd clone --parent pool/parent@snap pool2/child1
> 
> You can create a clone with different object sizes from the parent:
> ::
> 
>     $ rbd clone --parent pool/parent@snap --order 25 pool2/child2
> 
> To delete the parent, you must first mark it unpreserved, which checks
> that there are no children left:
> ::
> 
>     $ rbd unpreserve pool/image@snap
>     Error unpreserving: child images rely on this image
>     $ rbd list_children pool/image@snap
>     pool2/child1
>     pool2/child2
>     $ rbd copyup pool2/child1
>     $ rbd rm pool2/child2
>     $ rbd unpreserve pool/image@snap

Is 'preserve' and 'unpreserve' the verbiage we want to use here?  Not sure 
I have a better suggestion, but preserve is unusual.  
 
> Then the snapshot can be deleted like normal:
> ::
> 
>     $ rbd snap rm pool/image@snap
> 
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
> 
> Before a write is performed, the object is checked for existence. If
> it doesn't exist, a copy-up operation is performed, which means
> reading the relevant range of data from the parent image and writing
> it (plus the original write) to the child image. To prevent races with
> multiple writes trying to copy-up the same object, this copy-up
> operation will include an atomic create. If the atomic create fails,
> the original write is done instead. This copy-up operation is
> implemented as a class method so that extra metadata can be stored by
> it in the future.
> 
> A future optimization could be storing a bitmap of which objects
> actually exist in a child. This would obviate the check for existence
> before each write, and let reads go directly to the parent if needed.
> 
> Parent/Child relationships
> ^^^^^^^^^^^^^^^^^^^^^^^^^^
> 
> Children store a reference to their parent in their header, as a tuple
> of (pool id, image id, snapshot id). This is enough information to
> open the parent and read from it.
> 
> In addition to knowing which parent a given image has, we want to be
> able to tell if a preserved image still has children. This is
> accomplished with a new per-pool object, `rbd_children`, which maps
> (parent pool, parent id, parent snapshot id) to a list of child
> image ids. This is stored in the same pool as the child image
> because the client creating a clone already has read/write access to
> everything in this pool. This lets a client with read-only access to
> one pool clone a snapshot from that pool into a pool they have full
> access to. It increases the cost of unpreserving an image, since this
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
> 
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
> 
> Note that all the image ids are strings instead of uint64_t to let us
> easily switch to uuids in the future.
> 
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

     set_parent(uint64_t pool_id, string image_id, uint64_t snap_id,
                uint64_t parent_size)

The actual overlap image stores will be the min of the parent_size and its 
size.

> 
>     /**
>      * Returns the parent pool id, image id, and snap id, or -ENOENT

and overlap

>      * if has_parent is false
>      */
>     get_parent(uint64_t snapid)
> 
>     /**
>      * Set has_parent to false.
>      */
>     remove_parent() // after all parent data is copied to the child
> 
>     /*************** methods on the rbd_children object *****************/
> 
>     add_child(uint64_t parent_pool_id, string parent_image_id,
>               uint64_t parent_snap_id, string image_id);
>     remove_child(uint64_t parent_pool_id, string parent_image_id,
>                  uint64_t parent_snap_id, string image_id);
>     /**
>      * List image ids of a given parent
>      */
>     get_children(uint64_t parent_pool_id, string parent_image_id,
>                  uint64_t parent_snap_id, uint64_t max_return,
>                  string start);
>     /**
>      * List parent images
>      */
>     get_parents(uint64_t max_return, uint64_t start_pool_id,
>                 string start_image_id, string start_snap_id);
> 
> 
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

Also

      set_size   - will adjust the parent overlap down as needed.

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
> 
