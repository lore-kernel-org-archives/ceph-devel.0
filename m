From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [RFD] how to save the status of object for the cloned image
Date: Wed, 17 Jun 2015 13:25:20 +0300
Message-ID: <CAOi1vP_-No7gfgs8m-7csCmKUXjNYv+iDTpS6XfcUK+N9SDpbg@mail.gmail.com>
References: <55813F87.7010106@unitedstack.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-wg0-f54.google.com ([74.125.82.54]:33096 "EHLO
	mail-wg0-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751819AbbFQKZW (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 17 Jun 2015 06:25:22 -0400
Received: by wgez8 with SMTP id z8so32947765wge.0
        for <ceph-devel@vger.kernel.org>; Wed, 17 Jun 2015 03:25:20 -0700 (PDT)
In-Reply-To: <55813F87.7010106@unitedstack.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: juncheng bai <baijuncheng@unitedstack.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Jun 17, 2015 at 12:36 PM, juncheng bai
<baijuncheng@unitedstack.com> wrote:
> Hi.
>
> For cloned image, it is stateless about the object. when the write
> offset is smaller than the parent_ovelap,it need to call
> rbd_img_obj_exists_submit to check the object status every time.
>
> I want to save the status of the object which it is within the scope
> of parent_overlap.
>
> The rbd client io unit is object, so i design that use idr to save
> the status. The id of object is equal to write_offset >> obj_order.
> In the idr, said object already exists. And the idr can provide a
> quick query.
>
> In this way, don't need the server do anything, but need query again
> when remap.
>
> Looking forward to your opinion.

This looks like a part of what object map is going to allow.  rbd
object map has been implemented in librbd in hammer and will be
implemented in the kernel client as well in the future (there are few
things that need to happen before that, namely exclusive locking
support, which Doug is working on).

https://wiki.ceph.com/Planning/Blueprints/Hammer/librbd%3A_shared_flag,_object_map

Thanks,

                Ilya
