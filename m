From: Gregory Farnum <gfarnum@redhat.com>
Subject: Re: blueprint: consistency groups
Date: Thu, 24 Mar 2016 15:38:25 -0700
Message-ID: <CAJ4mKGYHno0u4z8PkUz0gL9voeBPQCPP+TSroEQRy2+26H+WHQ@mail.gmail.com>
References: <CA+hcxJQqbi_oCMF+0=fgQ6-=W1k-KPw6Y_3pZZnXKe01=Z-dhQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f50.google.com ([209.85.213.50]:35410 "EHLO
	mail-vk0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751087AbcCXWia (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 24 Mar 2016 18:38:30 -0400
Received: by mail-vk0-f50.google.com with SMTP id e6so75233993vkh.2
        for <ceph-devel@vger.kernel.org>; Thu, 24 Mar 2016 15:38:29 -0700 (PDT)
In-Reply-To: <CA+hcxJQqbi_oCMF+0=fgQ6-=W1k-KPw6Y_3pZZnXKe01=Z-dhQ@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Victor Denisov <vdenisov@mirantis.com>
Cc: ceph-devel <ceph-devel@vger.kernel.org>, Josh Durgin <jdurgin@redhat.com>, Jason Dillaman <dillaman@redhat.com>, Mykola Golub <mgolub@mirantis.com>

On Thu, Mar 24, 2016 at 8:50 AM, Victor Denisov <vdenisov@mirantis.com> wrote:
> Hi Ceph developers,
>
> With this email I would like to start a discussion about the design of
> the consistency groups feature.
>
> I created a wiki page for this blueprint:
> http://tracker.ceph.com/projects/ceph/wiki/consistency_groups
>
> So far it's only filled with what I know for sure about the
> consistency groups feature.
>
> First of all this feature is going to require a new entity in rbd -
> consistency group.
>
> This entity will be represented in the object storage in the way
> similar to how it's done for images.
>
> cg_id.<group name> object has the id of the consistency group.
>
> cg_header.<group id> object has the list of all images in the
> consistency group.
>
> Snapshot information will be stored in the omap attributes of
> cg_header.
>
> Every description of a snapshot will contain the list of snapshot ids
> of the images that comprise the cg's snapshot.
>
> Potentially, I assume, we want to allow images to be members of
> several consistency groups. However it can add complexity to the
> implementation, see the explanation down the text.

I think your design is going to be driven more by the needs and
choices of the rbd journaling, but given that, there's very little
reason you can't allow an image to be in more than one CG. Presumably
clients need to set a watch on each CG their image is part of, and to
apply every new snap to the image header. That's about it and not
terribly complicated?

<snip>

> The biggest question regarding the implementation comes from the live
> snapshot feature. We believe constistent snapshot is not possible
> without cooperation with rbd client (VM, application), because only
> application knows if it is in constistent state for snapshotting.  In
> the first iteration we would like to make it simple, so CG snapshot
> operation just creates snapshots for all images and stores the
> snapshot list in its metadata.

Just to be clear, you know that you can use the same snapid for all
the images, right? (...although not if you're trying to allow CGs
across pools. Those will be a little harder.)
-Greg
