From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: rados cppool and Openstack Glance and Cinder
Date: Fri, 15 Mar 2013 15:11:17 -0700
Message-ID: <51439C85.7030601@inktank.com>
References: <26709654.147.1363384514684.JavaMail.dspano@it1>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f41.google.com ([209.85.160.41]:61439 "EHLO
	mail-pb0-f41.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932129Ab3COWMF (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 15 Mar 2013 18:12:05 -0400
Received: by mail-pb0-f41.google.com with SMTP id um15so4415568pbc.28
        for <ceph-devel@vger.kernel.org>; Fri, 15 Mar 2013 15:12:04 -0700 (PDT)
In-Reply-To: <26709654.147.1363384514684.JavaMail.dspano@it1>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dave Spano <dspano@optogenics.com>
Cc: Greg Farnum <greg@inktank.com>, =?UTF-8?B?U8OpYmFzdGllbiBIYW4=?= <han.sebastien@gmail.com>, ceph-devel <ceph-devel@vger.kernel.org>, Sage Weil <sage@inktank.com>, Wido den Hollander <wido@42on.com>, Sylvain Munaut <s.munaut@whatever-company.com>, Samuel Just <sam.just@inktank.com>, Vladislav Gorbunov <vadikgo@gmail.com>

On 03/15/2013 02:55 PM, Dave Spano wrote:
>
> During my journey of using rados cppool, which is an awesome feature by the way, I found an interesting behavior related to cephx. I wanted to share it for anyone else who may be using Openstack, that decides to rename, or copy a pool.
>
> My client.glance entry is currently set to this (with the exception of the key, of course):
>
> client.glance
> key: punkrawk
> caps: [mon] allow r
> caps: [osd] allow class-read object_prefix rbd_children, allow rwx
>
> It was limited to the images pool based on the following example listed at http://ceph.com/docs/master/rbd/rbd-openstack/ :
>
> ceph auth get-or-create client.glance mon 'allow r' osd 'allow class-read object_prefix rbd_children, allow rwx pool=images'
>
> client.glance
> key: punkrawk
> caps: [mon] allow r
> caps: [osd] allow class-read object_prefix rbd_children, allow rwx pool=images
>
>
>
> What I found was that when I would create my pool as images-new or anything but images, then rename it to images I would have a problem. I could not even upload an image to an empty pool.
>
> I could, however; upload to the pool if I renamed the original to images-old, then created a brand new pool called images.
>
> My first guess is that there's a reference to the old name which would interfere whenever my client would try to use it with the client.glance keyring. I have not looked in the code yet, so I don't have any other concrete idea.

Yeah, someone ran into this before, but apparently I hadn't finished
creating the bug, so now there's http://tracker.ceph.com/issues/4471.

Each pg includes its pool name in memory, and that isn't updated when
the pool is renamed. Restarting the osd would refresh it, and creating
a new pool creates entirely new pgs.

> As soon as I lifted the pool restriction, as if by the power greyskull, I could upload, delete and take snapshots in the renamed pool.
>
> I believe this would be rather easy for anyone to reproduce with a test install of Openstack.

No openstack needed, just any ceph client with a restriction based on
pool name.

> Just create pool named images-new. Rename it to images, then try to upload an image. It should fail. Remove the pool restriction, and it will work.

Thanks for the detailed report!
Josh
