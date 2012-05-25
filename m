From: Alex Elder <elder@dreamhost.com>
Subject: Re: RBD format changes and layering
Date: Fri, 25 May 2012 09:57:06 -0500
Message-ID: <4FBF9DC2.8000508@dreamhost.com>
References: <4FBEBECD.6040403@inktank.com>
Reply-To: elder@inktank.com
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:35937 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751639Ab2EYO5C (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 25 May 2012 10:57:02 -0400
In-Reply-To: <4FBEBECD.6040403@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On 05/24/2012 06:05 PM, Josh Durgin wrote:
> RBD object format changes
> =========================

In this message I respond only to the first part of your message.
I'll look at the layering stuff separately.

> To enable us to add more features to rbd, including copy-on-write
> cloning via layering, we need to change to rbd header object
> format. Since this won't be backwards compatible, the old format will
> still be used by default. Once layering is implemented, the old format
> will be deprecated, but still usable with an extra option (something
> like rbd create --legacy ...). Clients will still be able to read the
> old format, and images can be converted by exporting and importing them.

Are you saying here that the clients will recognize both types and will
work with either?  Or will clients need to specify how to interpret it?
Is there a plan to deprecate clients' support for the old format?

> While we're making these changes, we can clean up the way librbd and
> the rbd kernel module access the header, so that they don't have to
> change each time we change the header format. Instead of reading the
> header directly, they can use the OSD class mechanism to interact with
> it. librbd already does this for snapshots, but kernel rbd reads the
> entire header directly. Making them both use a well-defined api will
> make later format additions much simpler. I'll describe the changes
> needed in general, and then those that are needed for rbd layering.
>
> New format, pre-layering
> ========================
>
> Right now the header object is name $image_name.rbd, and the data
> objects are named rb.$image_id_lowbits.$image_id_highbits.$object_number.
> Since we're making other incompatible changes, we have a chance to
> rename these to be less likely to collide with other objects. Prefixing
> them with a more specific string will help, and will work well with
> a new security feature for layering discussed later. The new
> names are:
>
> rbd_header.$image_name
> rbd_data.$id.$object_number

This is an improvement.

> The new header will have the existing (used) fields of the old format as
> key/value pairs in an omap (this is the rados interface that stores
> key/value pairs in leveldb). Specifically, the existing fields are:
>
> * object_prefix // previously known as block_name
> * order // bit shift to determine size of the data objects
> * size // total size of the image in bytes

Is the size restricted to be a multiple of (2 ^ (object order))?
If so I would like to see the size expressed in units of
object-order-sized blocks.

> * snap_seq // latest snapshot id used with the image
> * snapshots // list of (snap_name, snap_id, image_size) tuples

Can you remind me the distinction between the snap_name and the
snap_id?  Are they both unique identifiers?  Do both need to be
exposed, or just the snap_name?  Is the name a user-supplied name
and the id an indication of sequence?  (Sorry, haven't been looking
at this stuff in a while.)

> To make adding new things easier, there will be an additional
> 'features' field, which is a mask of the features used by the image.
> Clients will know whether they can use an image by checking if they
> support all the features the image uses that the osd reports as being
> incompatible (see get_info() below).

Does a feature vector of all zeroes (returned by the interface) indicate
old-style RBD?  Maybe the first feature bit should simply indicate that
the new format is in used, which allows the new interfaces to be used
with old images, and lets the old/new question to be determined using
the interfaces you define below.

> RBD class interface
> ===================
>
> Here's a proposed basic interface - new features will
> add more functions and data to existing ones.
>
> /**
> * Initialize the header with basic metadata.
> * Extra features may initialize more fields in the future.
> * Everything is stored as key/value pairs as omaps in the header object.
> *
> * If features the OSD does not understand are requested, -ENOSYS is
> * returned.
> */
> create(__le64 size, __le32 order, __le64 features)

Maybe I don't know where this interface lies in the software
stack.  But all integer parameters here and elsewhere should
be expressed in CPU order, not little-endian.  (And unless
there is a reason to make them signed, they should always
be unsigned.)

The only place the conversion between CPU and little-endian
byte order should occur is at the interface with the wire
or persistent storage.  This is not where these interfaces
sit (right?).  (There may be some internal code that keeps
things in little-endian for various reasons, but that should
not be specified in an external interface like this.)

The fact that everything sent over-the-wire and on-disk is
in little-endian format is significant, but just needs to
be stated in a single blanket statement.

> /**
> * Get the metadata about the image required to do I/O
> * to it. In the future this may include extra information for
> * features that require it, like encryption/compression type.
> * This extra data will be added at the end of the response, so
> * clients that don't support it don't interpret it.
> *
> * Features that would require clients to be updated to access
> * the image correctly (such as image bitmaps) are set in
> * the incompat_features field. A client that doesn't understand
> * those features will return an error when they try to open
> * the image.
> *
> * The size and any extra information is read from the appropriate
> * snapshot metadata, if snapid is not CEPH_NOSNAP.
> *
> * Returns __le64 size, __le64 order, __le64 features,
> * __le64 incompat_features, __le64 snapseq and
> * list of __le64 snapids
> */
> get_info(__le64 snapid)

I think I would prefer to see these bits of information broken
out into a few routines that group related information, or to
separate what's supplied based on the time or frequency it might
need to be accessed, or the "effort" involved in collecting it.

For example:

get_features() would supply the features and incompat_features.
It might not hurt to add "ible" to that second name too.  As I
understand it "features" would be things that allow additional
functionality but which neither affect nor are affected by the
way old code (that does not support it) might manipulate the
persistent state of the RBD storage.

Does it make sense for a snapshot to have features encoded in
it?  Can you envision a feature that might affect snapshots,
and if so, would one want to have snapshots in the same RBD
device that have different feature sets?  If the answer to
these is "no," then there's no need for a "snapid" to be
supplied for this interface, it would apply to an RBD device
itself.

get_size() might supply the block size order and the size in
blocks of the RBD device (or a snapshot of the device).

I don't remember what the snapshot sequence number is for
at the moment, but get_snapseq() might provide that, and
would (I think) apply to a device, not a snapshot.

get_snapids() would supply all the snapshot id's recorded for
a device.  This too is a device operation only, not a snapshot
operation.  Is there a need for this interface *and* the
list_snapshots() you specify below?

Rather than implicitly appending additional information to
the response, I think separate new entry points should be added
when features are added, extending the interface.  Old code,
or new code operating on old-format RBD devices, would not need
to access the new entry points.

> /**
> * Used when resizing the image. Sets the size in bytes.
> */
> set_size(__le64 size)

Maybe define the size in units of (order-dependent) blocks.

> /**
> * The same as the existing snap_add/snap_remove methods, but using the
> * new format.
> */
> snapshot_add(string snap_name, __le64 snap_id)

This probably reflects my ignorance, but does it make sense for
something "external" to the RBD implementation to specify the
snapshot id?

> snapshot_remove(string snap_name)

Can you remove by id?

> /**
> * list snapshots - like the existing snap_list, but
> * can return a subset of them.
> *
> * Returns __le64 snap_seq, __le64 snap_count, and a list of tuples
> * (snap_id, snap_size) just like the current snap_list
> */
> snapshot_list(__le64 max_len)
>
> /**
> * The same as the existing method. Should only be called
> * on the rbd_info object.
> * Returns an id number to use for a new image.
> */
> assign_bid()

Why bid?  I guess this is on the server side so I'm just not
familiar with it.

> RBD layering
> ============

I'll look at this part later.

					-Alex
