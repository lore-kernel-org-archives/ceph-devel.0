From: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [Qemu-devel] Re: [PATCH] ceph/rbd block driver for qemu-kvm (v8)
Date: Mon, 29 Nov 2010 11:02:11 +0100
Message-ID: <4CF37A23.8010202@redhat.com>
References: <20101117214223.GA31321@sir.home>	<AANLkTikLu0OJ3b+Ch7b0nnkOnF9wUGiUqZRcQgGeog73@mail.gmail.com>	<AANLkTikpvEQXc5iz-ii74XBshGrt0nNk5bCrHgteNXyA@mail.gmail.com>	<AANLkTimwfxz3D+MZQ7TH_DktMNzyN-=Q3AaZVsi+4rdO@mail.gmail.com> <4CF36B79.4000008@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:63042 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752526Ab0K2KBN (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Mon, 29 Nov 2010 05:01:13 -0500
In-Reply-To: <4CF36B79.4000008@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Stefan Hajnoczi <stefanha@gmail.com>
Cc: Christian Brunner <c.m.brunner@gmail.com>, ceph-devel@vger.kernel.org, qemu-devel@nongnu.org, kvm@vger.kernel.org

Am 29.11.2010 09:59, schrieb Kevin Wolf:
> Am 27.11.2010 08:12, schrieb Stefan Hajnoczi:
>> On Fri, Nov 26, 2010 at 9:59 PM, Christian Brunner
>> <c.m.brunner@gmail.com> wrote:
>>> Thanks for the review. What am I supposed to do now?
>>
>> Kevin is the block maintainer.  His review is the next step, I have
>> CCed him.  After that rbd would be ready to merge.
> 
> If I don't find anything really obvious and it doesn't break the build,
> I'll merge it based on your review.

Which librados version is this supposed to require? My F12 one seems to
be too old, however configure still automatically enables it (so the
build fails in the default configuration for me). I think you need to
add some check there.

$ rpm -q ceph-devel
ceph-devel-0.20.2-1.fc12.x86_64

$ LANG=C make
  CC    block/rbd.o
block/rbd.c: In function 'rbd_register_image':
block/rbd.c:191: error: 'CEPH_OSD_TMAP_SET' undeclared (first use in
this function)
block/rbd.c:191: error: (Each undeclared identifier is reported only once
block/rbd.c:191: error: for each function it appears in.)
cc1: warnings being treated as errors
block/rbd.c: In function 'rbd_set_snapc':
block/rbd.c:468: error: implicit declaration of function
'rados_set_snap_context'
block/rbd.c:468: error: nested extern declaration of
'rados_set_snap_context'
block/rbd.c: In function 'rbd_snap_create':
block/rbd.c:844: error: implicit declaration of function
'rados_selfmanaged_snap_create'
block/rbd.c:844: error: nested extern declaration of
'rados_selfmanaged_snap_create'
make: *** [block/rbd.o] Error 1

Kevin
