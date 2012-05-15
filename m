From: Yehuda Sadeh <yehuda@inktank.com>
Subject: rgw atomic operations, revisited
Date: Mon, 14 May 2012 23:09:49 -0700
Message-ID: <CAC-hyiG+ir26-T6-_+LiAELVxQU5y2fUn4awU=CO+3Qmvg4DVg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-bk0-f46.google.com ([209.85.214.46]:35255 "EHLO
	mail-bk0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751685Ab2EOGJu (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 15 May 2012 02:09:50 -0400
Received: by bkcji2 with SMTP id ji2so4447749bkc.19
        for <ceph-devel@vger.kernel.org>; Mon, 14 May 2012 23:09:49 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org

I was ask recently about how does RADOS gateway read and write its
objects. We revisited the way we handled atomic operations in rgw a
while ago, so here is a brief description of the new scheme.

The original scheme was that when an object had been uploaded it was
written to a temporary location, and once the upload had been
completed it was cloned in a single atomic operation to the final
location. This had a few issues:
 - on non-btrfs backends the clone operation translated to another
full write of the object, thus we ended up writing the object twice
 - in order to clone the object we needed to read it, which meant that
it had to be flushed to disk
 - the clone operation required the use of object locators that could
potentially affect the balancing

The new scheme

We now hold a manifest in the object header that describes where all
the object data is located. It is a map that contains the offset and
size of each object part, and the actual RADOS object and the offset
within it where it can be found. It is common now for objects to be
spread on more than one RADOS objects: the 'head' object, where the
object attributes (and usually the first object chunk) are located,
and one or more (or zero for small objects) tail objects. It is
guaranteed that the tail object names are unique for that specific
object instance.

One thing that hasn't changed with the new scheme is that when we read
an object, we read its first chunk and all its attributes in a single
atomic RADOS operation. This means that reading objects up to the size
of the read chunk (512k) requires only a single round trip.

In the old scheme we kept a tag for each object that represented the
name of the object once it has been overwritten. That is, if the
object was overwritten it was guaranteed that the old contents would
have been replicated to a new location. This required the writer to
clone the object it was running over. This does not exist in the new
scheme anymore, the manifest replaces that.

Reading an object

We access the object's head and read its attributes and the first data
chunk. We then continue reading the object by using the data locations
that are specified in the manifest. Note that the first chunk won't
necessarily reside in the head, an in such objects the first chunk of
data is part of the tail. Reading of the head is always atomic -- done
in a single RADOS operation. Reading the tail is not considered
atomic, however, since the tail resides in a unique RADOS object, we
don't need to access it atomically.

Writing an object (regular case)

We first generate a unique object name for the tail. The unique object
name is created by the original object name with a random string
appended to it. The object name is also created in a separate
namespace.
We skip writing the first chunk (512k) of data, and cache it in
memory. We then write the tail.
When we finish writing the tail we write the head object (the first
chunk and the object manifest and attributes) in a single RADOS
compound operation.

Writing an object (multipart upload)

Each chunk is uploaded separately to a unique location that is located
in the 'multipart' namespace. When the multipart upload completes we
generate a head object with a manifest that points to where all the
object parts reside. Note that in the multipart case the head object
only contains the object manifest and attributes but does not contain
any data.

HTH,
Yehuda
