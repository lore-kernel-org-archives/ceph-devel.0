From: Christian Brunner <chb@muc.de>
Subject: Re: [Qemu-devel] [RFC PATCH 1/1] ceph/rbd block driver for qemu-kvm
Date: Thu, 20 May 2010 23:18:34 +0200
Message-ID: <AANLkTil-aogxdnMallKTDo1bKXj6QmaU0ojJuiZgXaqC@mail.gmail.com>
References: <20100519192222.GD61706@ncolin.muc.de>
	 <AANLkTimXqk7oa4mtcoHX1rKWzi_Nccb0FJu_QDtwJ-sP@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f46.google.com ([74.125.82.46]:36714 "EHLO
	mail-ww0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S932093Ab0ETVSg (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 20 May 2010 17:18:36 -0400
In-Reply-To: <AANLkTimXqk7oa4mtcoHX1rKWzi_Nccb0FJu_QDtwJ-sP@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Blue Swirl <blauwirbel@gmail.com>
Cc: kvm@vger.kernel.org, qemu-devel@nongnu.org, ceph-devel@vger.kernel.org

2010/5/20 Blue Swirl <blauwirbel@gmail.com>:
> On Wed, May 19, 2010 at 7:22 PM, Christian Brunner <chb@muc.de> wrote:
>> The attached patch is a block driver for the distributed file system
>> Ceph (http://ceph.newdream.net/). This driver uses librados (which
>> is part of the Ceph server) for direct access to the Ceph object
>> store and is running entirely in userspace. Therefore it is
>> called "rbd" - rados block device.
>>
>> To compile the driver a recent version of ceph (>= 0.20.1) is needed
>> and you have to "--enable-rbd" when running configure.
>>
>> Additional information is available on the Ceph-Wiki:
>>
>> http://ceph.newdream.net/wiki/Kvm-rbd
>
>
> I have no idea whether it makes sense to add Ceph (no objection
> either). I have some minor comments below.

Thanks for your comments. I'll send an updated patch in a few days.

Having a central storage system is quite essential in larger hosting
environments, it enables you to move your guest systems from one node
to another easily (live-migration or dynamic restart). Traditionally
this has been done using SAN, iSCSI or NFS. However most of these
systems don't scale very well and and the costs for high-availability
are quite high.

With new approaches like Sheepdog or Ceph, things are getting a lot
cheaper and you can scale your system without disrupting your service.
The concepts are quite similar to what Amazon is doing in their EC2
environment, but they certainly won't publish it as OpenSource anytime
soon.

Both projects have advantages and disadvantages. Ceph is a bit more
universal as it implements a whole filesystem. Sheepdog is more
feature complete in regards of managing images (e.g. snapshots). Both
projects require some additional work to become stable, but they are
on a good way.

I would really like to see both drivers in the qemu tree, as they are
the key to a design shift in how storage in the datacenter is being
built.

Christian
