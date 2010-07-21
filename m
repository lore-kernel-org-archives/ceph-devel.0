From: Christian Brunner <chb@muc.de>
Subject: Re: [PATCH] qemu-kvm/rbd: add queueing delay based on queuesize
	(using use qemu_mutex_* and qemu_cond_*)
Date: Wed, 21 Jul 2010 21:18:36 +0200
Message-ID: <AANLkTikUykm7LOtlu1BWQwWr28w548tLI-gylJcJs8Mq@mail.gmail.com>
References: <20100714133545.GA21617@bambus>
	<AANLkTimuA4w0o_jyDJPslhvl4S0wpqTq-cChL2fBs6GF@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ww0-f44.google.com ([74.125.82.44]:58057 "EHLO
	mail-ww0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756666Ab0GUTSi convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 21 Jul 2010 15:18:38 -0400
Received: by wwj40 with SMTP id 40so2734258wwj.1
        for <ceph-devel@vger.kernel.org>; Wed, 21 Jul 2010 12:18:37 -0700 (PDT)
In-Reply-To: <AANLkTimuA4w0o_jyDJPslhvl4S0wpqTq-cChL2fBs6GF@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Yehuda Sadeh Weinraub <yehudasa@gmail.com>, Kevin Wolf <kwolf@redhat.com>
Cc: ceph-devel@vger.kernel.org

2010/7/20 Yehuda Sadeh Weinraub <yehudasa@gmail.com>:
>> + =A0 =A0 =A0 =A0while =A0(s->queuesize > MAX_QUEUE_SIZE) {
>> + =A0 =A0 =A0 =A0 =A0 =A0qemu_mutex_lock(s->queue_mutex);
>> + =A0 =A0 =A0 =A0 =A0 =A0qemu_cond_wait(s->queue_threshold, s->queue=
_mutex);
>> + =A0 =A0 =A0 =A0 =A0 =A0qemu_mutex_unlock(s->queue_mutex);
>> + =A0 =A0 =A0 =A0}
>
> Actually we shouldn't be waiting inside the aio handler. We should
> probably be feeding the request into some wait queue and have a
> separate thread that drains all those requests out. Though this
> wouldn't help us in throttling the client memory, it's probably a mor=
e
> correct way to handle the problem.

I agree with you, however I don't think that this is worth the effort.
I've never seen this occur when running a virtual machine, only when
running qemu-io.

@Kevin: Did you follow this thread? What is your opinion?

Christian
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
