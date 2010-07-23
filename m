From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] qemu-kvm/rbd: add queueing delay based on queuesize
 (using use qemu_mutex_* and qemu_cond_*)
Date: Fri, 23 Jul 2010 09:46:04 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1007230941500.6095@cobra.newdream.net>
References: <20100714133545.GA21617@bambus> <AANLkTimuA4w0o_jyDJPslhvl4S0wpqTq-cChL2fBs6GF@mail.gmail.com>
 <AANLkTikUykm7LOtlu1BWQwWr28w548tLI-gylJcJs8Mq@mail.gmail.com>
 <4C495931.2090705@redhat.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:48916 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753106Ab0GWQnq (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 23 Jul 2010 12:43:46 -0400
In-Reply-To: <4C495931.2090705@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Kevin Wolf <kwolf@redhat.com>
Cc: Christian Brunner <chb@muc.de>, Yehuda Sadeh Weinraub <yehudasa@gmail.com>, ceph-devel@vger.kernel.org

On Fri, 23 Jul 2010, Kevin Wolf wrote:

> Am 21.07.2010 21:18, schrieb Christian Brunner:
> > 2010/7/20 Yehuda Sadeh Weinraub <yehudasa@gmail.com>:
> >>> +        while  (s->queuesize > MAX_QUEUE_SIZE) {
> >>> +            qemu_mutex_lock(s->queue_mutex);
> >>> +            qemu_cond_wait(s->queue_threshold, s->queue_mutex);
> >>> +            qemu_mutex_unlock(s->queue_mutex);
> >>> +        }
> >>
> >> Actually we shouldn't be waiting inside the aio handler. We should
> >> probably be feeding the request into some wait queue and have a
> >> separate thread that drains all those requests out. Though this
> >> wouldn't help us in throttling the client memory, it's probably a more
> >> correct way to handle the problem.
> > 
> > I agree with you, however I don't think that this is worth the effort.
> > I've never seen this occur when running a virtual machine, only when
> > running qemu-io.
> > 
> > @Kevin: Did you follow this thread? What is your opinion?
> 
> No, I'm not subscribed to your mailing list and qemu-devel isn't CCed.
> 
> I'm not entirely sure what kind of queue this is about, but are you sure
> that it can only happen with large requests as issued by qemu-io? Can
> many small requests cause the same, especially with a slow network
> connection (or it might even go down for some reason?

In theory, small requests can, yes.  We haven't seen it in practice, I 
don't think.

In any case, I think any waiting/throttling just needs to happen inside 
the librados library, as that is the only place that may have any 
knowledge of the cluster size, throughput, and so forth.  This code should 
be dropped from the qemu-kvm/rbd side.

sage
