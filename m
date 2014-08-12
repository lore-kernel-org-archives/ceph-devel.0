From: Haomai Wang <haomaiwang@gmail.com>
Subject: [RFC]About ImageIndex
Date: Tue, 12 Aug 2014 10:50:53 +0800
Message-ID: <CACJqLybDC95NH36mux9jQcA5abqSxa8k1eMgTXKdqDWG0yjD-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f45.google.com ([74.125.82.45]:59067 "EHLO
	mail-wg0-f45.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750763AbaHLCuz convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 11 Aug 2014 22:50:55 -0400
Received: by mail-wg0-f45.google.com with SMTP id x12so9211093wgg.28
        for <ceph-devel@vger.kernel.org>; Mon, 11 Aug 2014 19:50:54 -0700 (PDT)
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <josh.durgin@inktank.com>, Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Hi Sage, Josh:

ImageIndex is aimed to hold each object's location info which avoid
extra checking for none-existing object. It's only used when image flag=
s
exists LIBRBD_CREATE_NONSHARED. Otherwise, ImageIndex will become gawp =
and
has no effect.

Each object has three state:
1. UNKNOWN: default value, it will follow origin path
2. LOCAL: imply this object is local, don't need to lookup parent image
3. PARENT: imply this object is in the parent image, don't need to read
from local image

Note: ImageIndex isn't full sync to real data all the time. Because the
transformation {"unknown" -> "local", "unknown" -> "parent"} are safe.
So We only need to handle with the exception when ImageIndex implies
this object is "parent" but the real data is "local". There exists thre=
e
methods to solve it:
1. flush `state_map` every time when "parent" -> "local" happened
2. mark all objects from "parent" state to "unknown=E2=80=9C state when=
 loading
image index(not including snapshot which has frozen index).

Here choose to implement method 2. This method only allow 2 read ops
in one read request at max and without overhead. Usually, librbd will
open image for many days(months) for normal use case such as VM usage.
So the image index will be warmed up and became smart when processing
ops.

Except image state changed problem, another concern is size. Image
index only permit single client write, but resize/flatten/rollback ops
are allowed to happen concurrently. For simply, now these ops don't
change and save states into rados. Resize op will affect "size" and
current write client will be notified.

Below listing object state change scenes:
1. When clone from image, it will mark all objects as "parent"
2. When creating snapshot, image index will be freeze and save it as th=
e
index of the snapshot. All "parent" state objects will be marked as
"unknown" for safe
3. When write(including modified op) a object, it will mark this object
as "local"
4. When reading object, the current image object will be always read in
spite of the state. And the parent image's object will be checked and
trust the state. If exists parent image but read local object
successfully, the local object will be marked "local"

The principle is that only exists one client can operate and save the
ImageIndex changes into rados. Now the challenge is that how to decide
who is the owner of ImageIndex. Like VM usage, qemu will open image to
do IO ops and externally user also can do create snapshot for the
opened image(rbd snap create ...). So it will exists two client modify
the same image, one can be regarded as "owner client" another is
"management client". "management client" is expected to not change the
state of object.

I only come up with a idea that user need to call "set_owner_image"
when client want to become "owner client" and this client can operate
ImageIndex.

PR(https://github.com/ceph/ceph/pull/2212)
I have passed test_librbd and test_librbd_fsx tests. The IO logic
seemed worked as expected.


--=20
Best Regards,

Wheat
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
