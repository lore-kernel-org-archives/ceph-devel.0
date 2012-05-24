From: Josh Durgin <josh.durgin@inktank.com>
Subject: RBD format changes and layering
Date: Thu, 24 May 2012 16:05:49 -0700
Message-ID: <4FBEBECD.6040403@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f46.google.com ([209.85.160.46]:51866 "EHLO
	mail-pb0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753339Ab2EXXFw (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 May 2012 19:05:52 -0400
Received: by pbbrp8 with SMTP id rp8so923315pbb.19
        for <ceph-devel@vger.kernel.org>; Thu, 24 May 2012 16:05:51 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel <ceph-devel@vger.kernel.org>

RBD object format changes
=========================

To enable us to add more features to rbd, including copy-on-write
cloning via layering, we need to change to rbd header object
format. Since this won't be backwards compatible, the old format will
still be used by default. Once layering is implemented, the old format
will be deprecated, but still usable with an extra option (something
like rbd create --legacy ...). Clients will still be able to read the
old format, and images can be converted by exporting and importing them.

While we're making these changes, we can clean up the way librbd and
the rbd kernel module access the header, so that they don't have to
change each time we change the header format. Instead of reading the
header directly, they can use the OSD class mechanism to interact with
it. librbd already does this for snapshots, but kernel rbd reads the
entire header directly. Making them both use a well-defined api will
make later format additions much simpler. I'll describe the changes
needed in general, and then those that are needed for rbd layering.

New format, pre-layering
========================

Right now the header object is name $image_name.rbd, and the data
objects are named rb.$image_id_lowbits.$image_id_highbits.$object_number.
Since we're making other incompatible changes, we have a chance to
rename these to be less likely to collide with other objects. Prefixing
them with a more specific string will help, and will work well with
a new security feature for layering discussed later. The new
names are:

rbd_header.$image_name
rbd_data.$id.$object_number

The new header will have the existing (used) fields of the old format as
key/value pairs in an omap (this is the rados interface that stores
key/value pairs in leveldb). Specifically, the existing fields are:

  * object_prefix // previously known as block_name
  * order         // bit shift to determine size of the data objects
  * size          // total size of the image in bytes
  * snap_seq      // latest snapshot id used with the image
  * snapshots     // list of (snap_name, snap_id, image_size) tuples

To make adding new things easier, there will be an additional
'features' field, which is a mask of the features used by the image.
Clients will know whether they can use an image by checking if they
support all the features the image uses that the osd reports as being
incompatible (see get_info() below).

RBD class interface
===================

Here's a proposed basic interface - new features will
add more functions and data to existing ones.

/**
  * Initialize the header with basic metadata.
  * Extra features may initialize more fields in the future.
  * Everything is stored as key/value pairs as omaps in the header object.
  *
  * If features the OSD does not understand are requested, -ENOSYS is
  * returned.
  */
create(__le64 size, __le32 order, __le64 features)

/**
  * Get the metadata about the image required to do I/O
  * to it. In the future this may include extra information for
  * features that require it, like encryption/compression type.
  * This extra data will be added at the end of the response, so
  * clients that don't support it don't interpret it.
  *
  * Features that would require clients to be updated to access
  * the image correctly (such as image bitmaps) are set in
  * the incompat_features field. A client that doesn't understand
  * those features will return an error when they try to open
  * the image.
  *
  * The size and any extra information is read from the appropriate
  * snapshot metadata, if snapid is not CEPH_NOSNAP.
  *
  * Returns __le64 size, __le64 order, __le64 features,
  *         __le64 incompat_features, __le64 snapseq and
  *         list of __le64 snapids
  */
get_info(__le64 snapid)

/**
  * Used when resizing the image. Sets the size in bytes.
  */
set_size(__le64 size)

/**
  * The same as the existing snap_add/snap_remove methods, but using the
  * new format.
  */
snapshot_add(string snap_name, __le64 snap_id)
snapshot_remove(string snap_name)

/**
  * list snapshots - like the existing snap_list, but
  * can return a subset of them.
  *
  * Returns __le64 snap_seq, __le64 snap_count, and a list of tuples
  * (snap_id, snap_size) just like the current snap_list
  */
snapshot_list(__le64 max_len)

/**
  * The same as the existing method. Should only be called
  * on the rbd_info object.
  * Returns an id number to use for a new image.
  */
assign_bid()


RBD layering
============

The first step is to implement trivial layering, i.e.
layering without bitmaps, as described at:

http://marc.info/?l=ceph-devel&m=129867273303846&w=2

There are a couple of things that complicate the implementation:

1) making sure parent images are not deleted when children still
    refer to them

A simple way to solve this is to add a reference count to the parent
image. This can cause issues with partially deleted images, if the
reference count is decremented more than once because the child
image's header was only deleted the second time 'rbd rm' was run.

To prevent this, a full list of children can be used. When an image is
cloned, the new image is added to the list of children. When a child is
deleted, it is removed from the list. Keeping this all in the parent
image's header leads to the second issue:

2) cloning an image into a different pool without giving the cloner
    write access to the parent image's pool

The current capabilities implemented with cephx only allow you to
restrict users to reading, writing or executing class methods on a
per-pool basis.

For the child image in rbd, we need to be able to read the data
objects of the parent image, but only interact with the parent image
header through certain class methods, namely add_child and
remove_child during cloning and deletion.

One way to do this is adding a whitelist of class methods to the
capabilities system, but this would be hard to manage as more class
methods are added. A more manageable way is to give classes some
string they can interpret as permissions however they wish. Combined
with allowing clients to access objects matching certain prefixes,
this can restrict access to the image header to going through the rbd
class, but still allow allow read-only access to the data objects.

If we change the names of the rbd header and data objects to start
with rbd_header and rbd_data, respectively, we have something like:

allow prefix rbd_header class rbd image-child pool=templates
allow prefix rbd_data r pool=templates

where 'image-child' is interpreted by the rbd class to mean 'only
allow adding or removing a child'.

The problem with this is that the restricted client can still remove
any child, not just images it has access to. To get around this, we
can give each image a randomly generated uuid, and store that in the
child header and the parent's list of children. Then when someone
calls remove_child, they must pass the uuid in addition to their pool,
name, and snapshot, and it will only be processed if it matches the
uuid in the parent header.

One thing that's not addressed in the earlier design is how to make
images read-only. The simplest way would be to only support layering
on top of snapshots, which are read-only by definition.

Another way would be to allow images to be set read-only or
read-write, and disallow setting images with children read-write. Are
there many use cases that would justify this second, more complicated
way?

Copy-up
=======

Another feature we want to include with layering is the ability to
copy all remaining data from the parent image to the child image, to
break the dependency of the latter on the former. This does not change
snapshots that were taken earlier though - they still rely on the
parent image. Thus, the children of a parent image will need to
include snapshots as well, and the reference to the parent image will
be needed to interact with snapshots. Thus, we can't just remove the
information pointing the parent. Instead, we can add a boolean
has_parent field that is stored in the header and with each snapshot,
since some snapshots may be taken when the parent was still used, and
some after all the data has been copied to the child.

Renaming
========

In order to support renaming layered images, we can use the id
assigned to each image in place of the name. We just need to store a
mapping from ids to names in each pool. Eventually this can replace
rbd_directory, when we stop supporting the old format. This can't
happen right now because clients assume rbd_directory is a tmap.

Thus, the parent and child image lists would contain (pool name, image
id, snapshot name) tuples. Pools and snapshots can't be renamed, so
they don't have this problem. Image ids are unique within a pool, so
(pool name, image id) uniquely identifies an image.

Resizing
========

To support resizing of layered images, we need to keep track of the
minimum size the image ever was, so that if a child image is shrunk
and then expanded, the re-expanded space is treated as unused instead
of being read from the parent image. Since this can change over time,
we need to store this for each snapshot as well.

In summary, the format changes specific to adding layering are:

New object
==========

rbd_images_names // stores a mapping from image ids to image names

New header fields
=================

* parent_pool, parent_image_id, parent_snapshot
* uuid
* children - tuples of (pool, image_id, snapshot)
* min_size
* has_parent
* new fields in snapshots:
   - min_size
   - has_parent

New rbd class methods
=====================

/**
  * Sets the parent, min_size, and has_parent keys.
  * Fails if any of these keys exist, since the image already
  * had a parent.
  */
set_parent(string pool_name, __le64 image_id, string snap_name)

/**
  * Sets has_parent to false.
  */
remove_parent() // after all parent data is copied to the child

/**
  * uuid is required here to prevent malicious users from
  * removing children they don't have access to.
  */
add_child(string pool, __le64 image_id, string snapname, string uuid)
remove_child(string pool_name, __le64 image_id, string snapname, string 
uuid)

/**
  * to be run on the rbd_image_names object.
  */
get_name(image_id)
set_name(image_id)

Changes to existing class methods
=================================

The new snapshot fields will be added to the return value of snapshot_list.
snapshot_add will need to fill them in.

create will generate a uuid for the image.

Does anyone have any thoughts on the design? Any ways to make it simpler?

Josh
