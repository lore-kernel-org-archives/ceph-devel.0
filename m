From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: RBD Async request: When / How are the call back called ?
Date: Wed, 29 Aug 2012 09:48:06 -0700
Message-ID: <503E47C6.2040200@inktank.com>
References: <CAF6-1L5JfGW-cw45gTbOX7+igu9WnG7=fp75aoTg1HL4AtsF-Q@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pz0-f46.google.com ([209.85.210.46]:32995 "EHLO
	mail-pz0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751149Ab2H2QsJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 29 Aug 2012 12:48:09 -0400
Received: by mail-pz0-f46.google.com with SMTP id y13so543802dad.19
        for <ceph-devel@vger.kernel.org>; Wed, 29 Aug 2012 09:48:09 -0700 (PDT)
In-Reply-To: <CAF6-1L5JfGW-cw45gTbOX7+igu9WnG7=fp75aoTg1HL4AtsF-Q@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sylvain Munaut <s.munaut@whatever-company.com>
Cc: ceph-devel@vger.kernel.org

On 08/29/2012 07:57 AM, Sylvain Munaut wrote:
> Hi,
>
>
> It might be obvious for people knowing the API but somehow I can't
> figure it out:
>
> How and when will the call back specified in a rbd_completion_t be called ?
>
> Imagine I do a rbd_aio_write and then do while (1); ... I don't see
> how the library could call my callback unless there is threads
> involved (and then my cb would be called in another thread context
> which is not great ...)

It's called from another thread. There are several threads for
messaging started when you connect with a rados_cluster_t. When a
request is complete, it's put into a queue inside librados, and a
'finisher' thread reads from the queue and calls callbacks as
appropriate.

In the case of rbd, a single rbd_aio_write may translate to many rados
requests, but when the last is complete, the callback you provided is
called by the librados finisher thread. At this point the data is on
disk on all replicas.

> (Of course the 'while (1)' here is just a stub, in reality it's a call
> to a library beyond my control)
>
>
> My problem here is that I need to integrate inside the main loop of
> another software and I can't block, but I still need to be able to
> 'notify' when the requests are over. I can ask the scheduler of that
> main loop to call me on some even on a file descriptor (but I don't
> see any fd here), or to call me periodically (but I don't see any call
> to test for completion without waiting for it).

The way this is done in the qemu block driver (since qemu I/O
must be completed from the original qemu thread context) is to have a
pipe that the qemu thread reads from. When an rbd I/O completes, the
callback (called by a librados thread) tells the qemu thread that it's
done via the pipe. Here's the original discussion about this:

http://lists.gnu.org/archive/html/qemu-devel/2010-10/msg00420.html

and the code:

http://git.qemu.org/?p=qemu.git;a=blob;f=block/rbd.c;h=5a0f79fc8f38e90c5c635a86b60db4c0f2f20c2f;hb=HEAD

> Cheers,
>
>       Sylvain

