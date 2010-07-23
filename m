From: Kevin Wolf <kwolf@redhat.com>
Subject: Re: [PATCH] qemu-kvm/rbd: add queueing delay based on queuesize
 (using use qemu_mutex_* and qemu_cond_*)
Date: Fri, 23 Jul 2010 10:56:17 +0200
Message-ID: <4C495931.2090705@redhat.com>
References: <20100714133545.GA21617@bambus>	<AANLkTimuA4w0o_jyDJPslhvl4S0wpqTq-cChL2fBs6GF@mail.gmail.com> <AANLkTikUykm7LOtlu1BWQwWr28w548tLI-gylJcJs8Mq@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:62807 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1751756Ab0GWI4W (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Fri, 23 Jul 2010 04:56:22 -0400
In-Reply-To: <AANLkTikUykm7LOtlu1BWQwWr28w548tLI-gylJcJs8Mq@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: Yehuda Sadeh Weinraub <yehudasa@gmail.com>, ceph-devel@vger.kernel.org

Am 21.07.2010 21:18, schrieb Christian Brunner:
> 2010/7/20 Yehuda Sadeh Weinraub <yehudasa@gmail.com>:
>>> +        while  (s->queuesize > MAX_QUEUE_SIZE) {
>>> +            qemu_mutex_lock(s->queue_mutex);
>>> +            qemu_cond_wait(s->queue_threshold, s->queue_mutex);
>>> +            qemu_mutex_unlock(s->queue_mutex);
>>> +        }
>>
>> Actually we shouldn't be waiting inside the aio handler. We should
>> probably be feeding the request into some wait queue and have a
>> separate thread that drains all those requests out. Though this
>> wouldn't help us in throttling the client memory, it's probably a more
>> correct way to handle the problem.
> 
> I agree with you, however I don't think that this is worth the effort.
> I've never seen this occur when running a virtual machine, only when
> running qemu-io.
> 
> @Kevin: Did you follow this thread? What is your opinion?

No, I'm not subscribed to your mailing list and qemu-devel isn't CCed.

I'm not entirely sure what kind of queue this is about, but are you sure
that it can only happen with large requests as issued by qemu-io? Can
many small requests cause the same, especially with a slow network
connection (or it might even go down for some reason?

If I understand correctly, waiting here could cause qemu to become
unresponsive, right?

Kevin
