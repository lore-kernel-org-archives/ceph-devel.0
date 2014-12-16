From: Yehuda Sadeh <yehuda@redhat.com>
Subject: rgw object versioning review
Date: Mon, 15 Dec 2014 23:26:11 -0800
Message-ID: <CABBk=J-8_1z0byHPE0=1fFVdMvKMsUrxUE+Rv80gXm_RY8E7cQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:34590 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751187AbaLPH0M (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 16 Dec 2014 02:26:12 -0500
Received: by mail-ie0-f181.google.com with SMTP id tp5so11983406ieb.26
        for <ceph-devel@vger.kernel.org>; Mon, 15 Dec 2014 23:26:12 -0800 (PST)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sweil@redhat.com>, Josh Durgin <jdurgin@redhat.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>

I squashed the commits that I originally marked for squashing, and
everything is pushed into wip-rgw-versioning-2.
Following is a rough breakdown of the different development phases,
and what I (think I) achieved in each one, hopefully it would give you
some hint of the direction when reviewing. Note that I'm still missing
some multi-zone related changes, and there are a couple of known
regressions, but that should stop you.

See http://wiki.ceph.com/Development/RGW_Object_Versioning for design doc.


1. Initial work

In this initial phase, the idea was to add a version (or instance)
identifier to objects. This allows creating multiple objects with the
same name, but different instance ids. Objects can be accessed
directly by using their names + version. The bucket index holds
entries by name + instance. Versioned objects here are just regular
objects that are named differently.

5a95240 - rgw: add versioning_enabled field to bucket info
d4aa2ae - rgw: get bucket versioning status op
4d7ffbd - rgw: restful op to set bucket versioning
38275cb - rgw: enable s3 get/set versioning ops
655ae55 - rgw, cls_rgw: add accounted_size for object metadata entry
ae13500 - rgw: remove unused code
727b9e8 - rgw: decouple object name from index representation
ef3982f - rgw: rename rgw_obj::key to rgw_obj::loc
d603ddf - rgw, cls_rgw: various datastructures use new rgw_obj_key
c44e574 - rgw: rename cls_rgw_obj::key to cls_rgw_obj::loc
e3dc560 - cls_rgw: change data structures to keep single object key structure
3e9177e - rgw: adapt to new objclass interface
ad9f460 - radosgw-admin: adapt to new interfaces
e81ef5f - test: cls_rgw fixes
3bfa127 - rgw: clean up some locator use
d242339 - radosgw-admin: some commands use object_version param
c97a05a - rgw: generate random instance id
162c53b - rgw: interface adjustment following a rebase
8ecef67 - rgw: remove old unused code

2. OLH

Started olh logic implementation. Adding new cls/rgw calls:
 - link olh
 - unlink instance
 - read olh log
 - trim olh log

New nucket index representation took a couple of iterations to settle.
Major issue that was discovered mid-process was that versioned objects
need to be sorted from newest to oldest when listing bucket.
We now have 3 different kind of entries in the bucket index:
 - plain
 - instance
 - olh

Plain entries are entries that repesent the objects' listing order.
These entries are named as follows (for versioned objects, non
versioned objects are treated as before):
<name> \0 <decreasing_str(olh_epoch)> \0 <instance id>

The instance entries reside in a different namespace, and objects are
indexed there by their name and their version id. Thus, in order to
get to the listing entries, we need to first read the instance entry.

The olh entry contains the olh log, and the current olh epoch.


Extra complexity: handling null-versioned objects (objects that are
created on buckets with suspended versioning). Main changes: added a
new entry to the bucket index for each versioned object to mark it as
versioned (indexed only by its name). Every regular object that is
overwritten is converted to a versioned object.
Also, needed to co-locate olh and data objects, since objects can be
versioned, but also have a 'null' version that needs to match the
non-versioned case. So, an olh can point at itself, and when removing
an object, we make sure that we don't remove the olh.



27a9408 - rgw: initial olh implementation
105c4e0 - rgw: gen rand lower alphanumberic string
f6a21cd - rgw: adjust return code when generating random strings
e65a1fa - rgw: gen rand lowercase string (stl string version)
cc55d9e - rgw: init olh tag
d01b4c7 - rgw: some code cleanup
8ae3c3c - rgw: obj_stat() follows on olh
932e3b1 - cls_rgw: prepare groundwork for olh
4211f28 - cls_rgw: encode / decode obj and list index keys
3ed6627 - cls_rgw: bucket index link olh
fc2f127 - cls_rgw: object instance olh linking
4ac79e5 - rgw: bucket index link olh interface
56185d6 - rgw: new api to retrieve olh log
9f8f158 - rgw: implement rgw_bucket_olh_log_entry::dump()
c92a332 - rgw-admin: add olh readlog command
717e7ec - cls_rgw: olh init op
946611c - rgw: apply olh log functionality
d6d2f58 - rgw, cls_rgw: trim olh log functionality
4f9afa7 - rgw: olh atomicity groundwork
701f65c - rgw: guard against racing writes
c1d57e3 - rgw: more atomicity fixes, set_olh()
4ffa2dd - rgw: tie set_olh() to object completion
019c226 - cls_rgw: olh trim op is read/write
fc35420 - rgw: follow olh if needed
b78481b - rgw: update json encoding for rgw_obj
88c2f1f - rgw: object manifest should reflect instance
a5fea1d - rgw: add 'versioning', and 'versions' to handled subresources
eadb243 - rgw: add get_type() to rgw ops
28ee25c - cls_rgw: revise the data model
f57cc4a - rgw: bucket listing gets extra param for versioning
7a010c5 - rgw, cls_rgw: list object versions is optional
1892aaf - cls_rgw: deletion marker needs to keep instance entry
677c6f9 - rgw: propagate dirent flags to rgw (from cls), other fixes
d123836 - rgw: restful api now dumps versions
64a66b5 - rgw: cleanup, get rid of req_state::object
77cdb69 - rgw: request state and various op functionality use rgw_obj_key
f9ae1e8 - rgw: fix rgw_obj initialization
c7cc445 - cls_rgw: update the appropriate prev key entry
b18d36e - rgw, cls_rgw: cls_bucket_list returns raw key in map
704425b - rgw: add support for version-id-marker
d5d4347 - rgw: bucket versioning status is tri-state
0fd49fe - rgw: initial versioned object removal implementation
3fb2177 - rgw, cls_rgw: don't remove olh objects
5962d5e - cls_rgw: allow olh linking to null instance objects
fed201f - rgw: set olh if object has been versioned

3. Cleanup!

At this point it was obvious that the code was in dire need of a
cleanup. Trying to limit the amount of different states. Moving
certain object operations to RGWRados subclasses. Separating data
objects and system objects.

0998856 - rgw: move RGWRadosCtx into RGWRados
f10469e - rgw: s/RGWRadosCtx/ObjectCtx
b0bcedf - rgw: start reorganizing RGWRados
46774c2 - rgw: remove plain object processor
900c89a - rgw: pass around object context refrences, remove unused code
bff2d83 - rgw: don't use put_system_obj() for data objects
2620bbe - rgw: get rid of put_obj_meta(), replace with put_system_obj()
172cceb - rgw: remove old index update calls
853c937 - rgw: remove unused code
ed0076f - rgw: switch RGWRados::delete_obj() to new interface
32142fd - rgw: fix missing state initalization
1dd190b - rgw: remove more unused code
54a426b - rgw: rework prepare_get_obj(), get_obj()
d485428 - rgw: change RGWRados::get_attr()
e1041ed - rgw: clean up system obj interfaces
8114787 - rgw: s/RGWRados::ObjectCtx/RGWObjectCtx
f0fa071 - rgw: adjust to new interfaces
0799f62 - rgw: purge intent log
d291c08 - rgw: remove unused code
ae33ad7 - rgw: switch get_obj_iterate() to new interface
8af2bcf - rgw: convert RGWRados::get_attr() to new interface

and some cls_rgw cleanups:

dd87374 - cls_rgw: reorganize rgw_bucket_link_olh()
956108d - cls_rgw: more cleanup
4302041 - cls_rgw: more cleanup

4. Back to versioning work

More internal work, as described in (2).

Also, we now have new radosgw-admin commands to list and set raw
bucket index entries. This is really helpful in debugging issues
related to bucket index versioning.


28e43ca - cls_rgw: update olh log when unlinking entry
7232a92 - cls_rgw: unlink object instance

518493b - rgw: unlink obj instance
136740c - rgw: follow olh where needed
56b0e6b - cls_rgw: keep null-versioned object as versioned object
6751908 - rgw-admin, cls_rgw: add bi_get objclass operation
061313d - common, rgw: json escaping gets input buf size
358fc98 - cls_rgw: add missing flags encoding to rgw_bucket_dir_entry::dump()
5d41b86 - cls_rgw, rgw-admin: move bi_get() entry encoding to cls
72fdef2 - cls_rgw, rgw-admin: create bi list operation
efa541f - rgw, cls_rgw: add bi put

5. Fixes, adjustments, complete missing implementation

misc stuff. Fixes, and other missing implementation.

16d5e06 - osd: fix filter_prefix scoping in omap_get_vals
04eeb7c - formatter: no need for dynamic allocation
662d805 - rgw: send "null" version id if needed
d03c562 - rgw, cls_rgw: multiple changes related to obj removal
3638bdb - rgw: propagate object owner and mtime for deletion marker
16f2bd3 - rgw: adjust versioning enable/suspend api
4d3b6e3 - rgw: fix access to object through the null instance
520b0c7 - cls_rgw: inc olh epoch when updating log
9c329cc - rgw, cls_rgw: fix update of olh to reflect non existing object
b6c0c12 - cls_rgw: add missing cls_cxx_create()
c127068 - rgw: add dump_string_header()
0eacb86 - rgw: send x-amz-version-id and x-amz-delete_marker header fields
2481439 - cls_rgw: remove instance entry when removing delete marker
21dd843 - rgw: encode timestamp in pending olh info
acec1c8 - rgw, cls_rgw: improve olh atomicity
2dae922 - cls_rgw: guard certain operations using olh tag
5d423c8 - cls_rgw: implement dump() and generate test instances
dff4cae - cls_rgw: clean up compilation warnings
82766fa - rgw: remove unused code
8acd45b - rgw: remove warning
2fed1f5 - rgw: read bucket owner when following olh if pending entries
3d0b506 - cls_rgw: revise null object instance handling, versioned epoch
6f4d924 - cls_rgw: don't write list entry when converting when deleting
f319b93 - rgw: time out pending olh entries
9e0f7a1 - rgw: Object::Read::read() returns total bytes read
20c61a8 - rgw: Object::Read operations should use state->obj
6be07f4 - rgw: reduce use of Object::get_obj()
14e1ec6 - rgw: parse copy location version id
750f4d7 - cls_rgw, rgw: pending_log can hold multiple entries per epoch
a3a45cb - cls_rgw: link, unlink olh ops can get epoch
1266c59 - rgw, cls_rgw: provide optional version id, versioned epoch to olh ops
31695db - rgw: cleaup RGWRados::copy_obj()
4e790b8 - rgw: propagate version id when putting obj
bd3738a - rgw: copy obj does versioning too
12dc4e1 - rgw: move versioning handling to Object::Write::write_meta()
d2e9d4e - rgw: fix a few regressions
