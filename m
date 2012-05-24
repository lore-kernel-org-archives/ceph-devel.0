From: Yehuda Sadeh <yehuda@inktank.com>
Subject: Re: RBD format changes and layering
Date: Thu, 24 May 2012 16:39:24 -0700
Message-ID: <CAC-hyiG2Fcv3VMEdUXj-ytorbVtPcAVygV-NC=9oM2rg7bid3w@mail.gmail.com>
References: <4FBEBECD.6040403@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:41451 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751836Ab2EXXj0 convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 May 2012 19:39:26 -0400
Received: by bkcji2 with SMTP id ji2so286625bkc.19
        for <ceph-devel@vger.kernel.org>; Thu, 24 May 2012 16:39:24 -0700 (PDT)
In-Reply-To: <4FBEBECD.6040403@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

On Thu, May 24, 2012 at 4:05 PM, Josh Durgin <josh.durgin@inktank.com> =
wrote:
> RBD object format changes
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D
>
> To enable us to add more features to rbd, including copy-on-write
> cloning via layering, we need to change to rbd header object
> format. Since this won't be backwards compatible, the old format will
> still be used by default. Once layering is implemented, the old forma=
t
> will be deprecated, but still usable with an extra option (something
> like rbd create --legacy ...). Clients will still be able to read the
> old format, and images can be converted by exporting and importing th=
em.
>
> While we're making these changes, we can clean up the way librbd and
> the rbd kernel module access the header, so that they don't have to
> change each time we change the header format. Instead of reading the
> header directly, they can use the OSD class mechanism to interact wit=
h
> it. librbd already does this for snapshots, but kernel rbd reads the
> entire header directly. Making them both use a well-defined api will
> make later format additions much simpler. I'll describe the changes
> needed in general, and then those that are needed for rbd layering.
>
> New format, pre-layering
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D
>
> Right now the header object is name $image_name.rbd, and the data
> objects are named rb.$image_id_lowbits.$image_id_highbits.$object_num=
ber.
> Since we're making other incompatible changes, we have a chance to
> rename these to be less likely to collide with other objects. Prefixi=
ng
> them with a more specific string will help, and will work well with
> a new security feature for layering discussed later. The new
> names are:
>
> rbd_header.$image_name
> rbd_data.$id.$object_number
>
> The new header will have the existing (used) fields of the old format=
 as
> key/value pairs in an omap (this is the rados interface that stores
> key/value pairs in leveldb). Specifically, the existing fields are:
>
> =A0* object_prefix // previously known as block_name
> =A0* order =A0 =A0 =A0 =A0 // bit shift to determine size of the data=
 objects
> =A0* size =A0 =A0 =A0 =A0 =A0// total size of the image in bytes
> =A0* snap_seq =A0 =A0 =A0// latest snapshot id used with the image
> =A0* snapshots =A0 =A0 // list of (snap_name, snap_id, image_size) tu=
ples
>
> To make adding new things easier, there will be an additional
> 'features' field, which is a mask of the features used by the image.
> Clients will know whether they can use an image by checking if they
> support all the features the image uses that the osd reports as being
> incompatible (see get_info() below).
>
> RBD class interface
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> Here's a proposed basic interface - new features will
> add more functions and data to existing ones.
>
> /**
> =A0* Initialize the header with basic metadata.
> =A0* Extra features may initialize more fields in the future.
> =A0* Everything is stored as key/value pairs as omaps in the header o=
bject.
> =A0*
> =A0* If features the OSD does not understand are requested, -ENOSYS i=
s
> =A0* returned.
> =A0*/
> create(__le64 size, __le32 order, __le64 features)
>
> /**
> =A0* Get the metadata about the image required to do I/O
> =A0* to it. In the future this may include extra information for
> =A0* features that require it, like encryption/compression type.
> =A0* This extra data will be added at the end of the response, so
> =A0* clients that don't support it don't interpret it.
> =A0*
> =A0* Features that would require clients to be updated to access
> =A0* the image correctly (such as image bitmaps) are set in
> =A0* the incompat_features field. A client that doesn't understand
> =A0* those features will return an error when they try to open
> =A0* the image.
> =A0*
> =A0* The size and any extra information is read from the appropriate
> =A0* snapshot metadata, if snapid is not CEPH_NOSNAP.
> =A0*
> =A0* Returns __le64 size, __le64 order, __le64 features,
> =A0* =A0 =A0 =A0 =A0 __le64 incompat_features, __le64 snapseq and
> =A0* =A0 =A0 =A0 =A0 list of __le64 snapids
> =A0*/
> get_info(__le64 snapid)
>
> /**
> =A0* Used when resizing the image. Sets the size in bytes.
> =A0*/
> set_size(__le64 size)
>
> /**
> =A0* The same as the existing snap_add/snap_remove methods, but using=
 the
> =A0* new format.
> =A0*/
> snapshot_add(string snap_name, __le64 snap_id)
> snapshot_remove(string snap_name)
>
> /**
> =A0* list snapshots - like the existing snap_list, but
> =A0* can return a subset of them.
> =A0*
> =A0* Returns __le64 snap_seq, __le64 snap_count, and a list of tuples
> =A0* (snap_id, snap_size) just like the current snap_list
> =A0*/
> snapshot_list(__le64 max_len)
>
> /**
> =A0* The same as the existing method. Should only be called
> =A0* on the rbd_info object.
> =A0* Returns an id number to use for a new image.
> =A0*/
> assign_bid()
>
>
> RBD layering
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The first step is to implement trivial layering, i.e.
> layering without bitmaps, as described at:
>
> http://marc.info/?l=3Dceph-devel&m=3D129867273303846&w=3D2
>
> There are a couple of things that complicate the implementation:
>
> 1) making sure parent images are not deleted when children still
> =A0 refer to them
>
> A simple way to solve this is to add a reference count to the parent
> image. This can cause issues with partially deleted images, if the
> reference count is decremented more than once because the child
> image's header was only deleted the second time 'rbd rm' was run.
>
> To prevent this, a full list of children can be used. When an image i=
s
> cloned, the new image is added to the list of children. When a child =
is
> deleted, it is removed from the list. Keeping this all in the parent
> image's header leads to the second issue:

I don't like the idea of writing anything to the parent. We can have
an orthogonal directory in a different location.

>
> 2) cloning an image into a different pool without giving the cloner
> =A0 write access to the parent image's pool
>
> The current capabilities implemented with cephx only allow you to
> restrict users to reading, writing or executing class methods on a
> per-pool basis.
>
> For the child image in rbd, we need to be able to read the data
> objects of the parent image, but only interact with the parent image
> header through certain class methods, namely add_child and
> remove_child during cloning and deletion.
>
> One way to do this is adding a whitelist of class methods to the
> capabilities system, but this would be hard to manage as more class
> methods are added. A more manageable way is to give classes some
> string they can interpret as permissions however they wish. Combined
> with allowing clients to access objects matching certain prefixes,
> this can restrict access to the image header to going through the rbd
> class, but still allow allow read-only access to the data objects.

That sounds useful feature, however, it also sounds like a much bigger
hammer than you need for that specific problem.
As I said, I don't think we should modify the parent. You can keep
that list on a different object that relates to the parent (e.g.,
rbd_ref.$image_name), or in a central place. You can put that object
in a different pool, where the client has write permissions.

>
> If we change the names of the rbd header and data objects to start
> with rbd_header and rbd_data, respectively, we have something like:
>
> allow prefix rbd_header class rbd image-child pool=3Dtemplates
> allow prefix rbd_data r pool=3Dtemplates
>
> where 'image-child' is interpreted by the rbd class to mean 'only
> allow adding or removing a child'.
>
> The problem with this is that the restricted client can still remove
> any child, not just images it has access to. To get around this, we
> can give each image a randomly generated uuid, and store that in the
> child header and the parent's list of children. Then when someone
> calls remove_child, they must pass the uuid in addition to their pool=
,
> name, and snapshot, and it will only be processed if it matches the
> uuid in the parent header.
>
> One thing that's not addressed in the earlier design is how to make
> images read-only. The simplest way would be to only support layering
> on top of snapshots, which are read-only by definition.
>
> Another way would be to allow images to be set read-only or
> read-write, and disallow setting images with children read-write. Are
> there many use cases that would justify this second, more complicated
> way?

I think that explicitly setting a read-only flag on the parent (if not
set) is enough. No need to do other magic (see my above comments).

>
> Copy-up
> =3D=3D=3D=3D=3D=3D=3D
>
> Another feature we want to include with layering is the ability to
> copy all remaining data from the parent image to the child image, to
> break the dependency of the latter on the former. This does not chang=
e
> snapshots that were taken earlier though - they still rely on the
> parent image. Thus, the children of a parent image will need to
> include snapshots as well, and the reference to the parent image will
> be needed to interact with snapshots. Thus, we can't just remove the
> information pointing the parent. Instead, we can add a boolean
> has_parent field that is stored in the header and with each snapshot,
> since some snapshots may be taken when the parent was still used, and
> some after all the data has been copied to the child.

To generalize: a snapshot context would contain the source rbd image.

>
> Renaming
> =3D=3D=3D=3D=3D=3D=3D=3D
>
> In order to support renaming layered images, we can use the id
> assigned to each image in place of the name. We just need to store a
> mapping from ids to names in each pool. Eventually this can replace
> rbd_directory, when we stop supporting the old format. This can't
> happen right now because clients assume rbd_directory is a tmap.
>
> Thus, the parent and child image lists would contain (pool name, imag=
e
> id, snapshot name) tuples. Pools and snapshots can't be renamed, so
> they don't have this problem. Image ids are unique within a pool, so
> (pool name, image id) uniquely identifies an image.
>
> Resizing
> =3D=3D=3D=3D=3D=3D=3D=3D
>
> To support resizing of layered images, we need to keep track of the
> minimum size the image ever was, so that if a child image is shrunk
> and then expanded, the re-expanded space is treated as unused instead
> of being read from the parent image. Since this can change over time,
> we need to store this for each snapshot as well.
>
> In summary, the format changes specific to adding layering are:
>
> New object
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> rbd_images_names // stores a mapping from image ids to image names
>
> New header fields
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> * parent_pool, parent_image_id, parent_snapshot
> * uuid
> * children - tuples of (pool, image_id, snapshot)
> * min_size
> * has_parent
> * new fields in snapshots:
> =A0- min_size
> =A0- has_parent
>
> New rbd class methods
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> /**
> =A0* Sets the parent, min_size, and has_parent keys.
> =A0* Fails if any of these keys exist, since the image already
> =A0* had a parent.
> =A0*/
> set_parent(string pool_name, __le64 image_id, string snap_name)
>
> /**
> =A0* Sets has_parent to false.
> =A0*/
> remove_parent() // after all parent data is copied to the child
>
> /**
> =A0* uuid is required here to prevent malicious users from
> =A0* removing children they don't have access to.
> =A0*/
> add_child(string pool, __le64 image_id, string snapname, string uuid)
> remove_child(string pool_name, __le64 image_id, string snapname, stri=
ng
> uuid)
>
> /**
> =A0* to be run on the rbd_image_names object.
> =A0*/
> get_name(image_id)
> set_name(image_id)
>
> Changes to existing class methods
> =3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D
>
> The new snapshot fields will be added to the return value of snapshot=
_list.
> snapshot_add will need to fill them in.
>
> create will generate a uuid for the image.
>
> Does anyone have any thoughts on the design? Any ways to make it simp=
ler?
>
> Josh
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel"=
 in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at =A0http://vger.kernel.org/majordomo-info.html
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
