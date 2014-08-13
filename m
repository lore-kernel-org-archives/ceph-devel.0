From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [RFC]About ImageIndex
Date: Tue, 12 Aug 2014 19:14:38 -0700
Message-ID: <53EACA0E.5050506@inktank.com>
References: <CACJqLybDC95NH36mux9jQcA5abqSxa8k1eMgTXKdqDWG0yjD-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:42104 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753071AbaHMCOG convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 12 Aug 2014 22:14:06 -0400
In-Reply-To: <CACJqLybDC95NH36mux9jQcA5abqSxa8k1eMgTXKdqDWG0yjD-Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>, Sage Weil <sweil@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

On 08/11/2014 07:50 PM, Haomai Wang wrote:
> Hi Sage, Josh:
>
> ImageIndex is aimed to hold each object's location info which avoid
> extra checking for none-existing object. It's only used when image fl=
ags
> exists LIBRBD_CREATE_NONSHARED. Otherwise, ImageIndex will become gaw=
p and
> has no effect.

I like the general structure of the code, and it's great to hear you've
been testing it with test_librbd_fsx. Some thoughts on the design:

> Each object has three state:
> 1. UNKNOWN: default value, it will follow origin path
> 2. LOCAL: imply this object is local, don't need to lookup parent ima=
ge
> 3. PARENT: imply this object is in the parent image, don't need to re=
ad
> from local image

What about calling these unknown, exists, and nonexistent instead?
This information can be used for non-clone use cases too. Internally
there's another ImageCtx for each parent, which can have its own
index, so I don't think there's a need to keep track of any objects
from different images in one ImageCtx.

> Note: ImageIndex isn't full sync to real data all the time. Because t=
he
> transformation {"unknown" -> "local", "unknown" -> "parent"} are safe=
=2E
> So We only need to handle with the exception when ImageIndex implies
> this object is "parent" but the real data is "local". There exists th=
ree
> methods to solve it:
> 1. flush `state_map` every time when "parent" -> "local" happened
> 2. mark all objects from "parent" state to "unknown=E2=80=9C state wh=
en loading
> image index(not including snapshot which has frozen index).

At the end of the CDS session I was thinking that implementing it
strictly would be better, so that you could always trust the on-disk=20
copy of the index. In particular we were worried about the complexity o=
f
handling a non-strict index during things like live migration, and
being able to use it to speed up management operations more reliably.

Since creating new objects (or discarding entire existing objects) is
pretty rare, it seems worth the extra I/Os to update the index
synchronously in these cases. To be fully safe I think any write to
a new object or discard of a full object would need to change index
state to unknown, do the write/discard, and finally change the index
state to exists/nonexistent. There might be some ways to optimize that
though.

> Here choose to implement method 2. This method only allow 2 read ops
> in one read request at max and without overhead. Usually, librbd will
> open image for many days(months) for normal use case such as VM usage=
=2E
> So the image index will be warmed up and became smart when processing
> ops.
>
> Except image state changed problem, another concern is size. Image
> index only permit single client write, but resize/flatten/rollback op=
s
> are allowed to happen concurrently. For simply, now these ops don't
> change and save states into rados. Resize op will affect "size" and
> current write client will be notified.
>
> Below listing object state change scenes:
> 1. When clone from image, it will mark all objects as "parent"

We can do this for any new image (mark all objects non-existent
initially), not just clones.

> 2. When creating snapshot, image index will be freeze and save it as =
the
> index of the snapshot. All "parent" state objects will be marked as
> "unknown" for safe

One implementation detail here - I think it'd be good to store snapshot
indexes in separate objects so that having many snapshots does not caus=
e
the header object to become too large.

To recover from a partial snapshot, where the header was updated but
the index wasn't saved, it would be useful to have a rbd cli command to
repair (or optionally just check) the index for a snapshot.

> 3. When write(including modified op) a object, it will mark this obje=
ct
> as "local"
> 4. When reading object, the current image object will be always read =
in
> spite of the state. And the parent image's object will be checked and
> trust the state. If exists parent image but read local object
> successfully, the local object will be marked "local"
>
> The principle is that only exists one client can operate and save the
> ImageIndex changes into rados. Now the challenge is that how to decid=
e
> who is the owner of ImageIndex. Like VM usage, qemu will open image t=
o
> do IO ops and externally user also can do create snapshot for the
> opened image(rbd snap create ...). So it will exists two client modif=
y
> the same image, one can be regarded as "owner client" another is
> "management client". "management client" is expected to not change th=
e
> state of object.
>
> I only come up with a idea that user need to call "set_owner_image"
> when client want to become "owner client" and this client can operate
> ImageIndex.

This is a great idea for all header updates. I've been thinking about
the same thing for rbd mirroring, and Sage started working on some
watch/notify changes that will help make this robust:

http://pad.ceph.com/p/watch-notify

> PR(https://github.com/ceph/ceph/pull/2212)
> I have passed test_librbd and test_librbd_fsx tests. The IO logic
> seemed worked as expected.

I haven't had time to look at the code in a lot of detail yet, but
it'd be nice to use just 2 bits per object on disk. I'm on vacation
the next couple weeks, but Sage may have more feedback.

Josh
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
