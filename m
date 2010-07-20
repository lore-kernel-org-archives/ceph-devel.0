From: Yehuda Sadeh Weinraub <yehudasa@gmail.com>
Subject: Re: [PATCH] qemu-kvm/rbd: add queueing delay based on queuesize
	(using use qemu_mutex_* and qemu_cond_*)
Date: Tue, 20 Jul 2010 13:42:43 -0700
Message-ID: <AANLkTimuA4w0o_jyDJPslhvl4S0wpqTq-cChL2fBs6GF@mail.gmail.com>
References: <20100714133545.GA21617@bambus>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vw0-f46.google.com ([209.85.212.46]:50649 "EHLO
	mail-vw0-f46.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758636Ab0GTUmp convert rfc822-to-8bit (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 20 Jul 2010 16:42:45 -0400
Received: by vws14 with SMTP id 14so723234vws.19
        for <ceph-devel@vger.kernel.org>; Tue, 20 Jul 2010 13:42:44 -0700 (PDT)
In-Reply-To: <20100714133545.GA21617@bambus>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Christian Brunner <chb@muc.de>
Cc: ceph-devel@vger.kernel.org

On Wed, Jul 14, 2010 at 6:35 AM, Christian Brunner <chb@muc.de> wrote:
>
> Hi Yehuda,
>
> this is an updated version of the patch I've sent yesterday. It is no=
w based on the
> current rbd branch and it is using qemu_cond_* and qemu_mutex_*.

<snip>

>
> + =A0 =A0 =A0 =A0while =A0(s->queuesize > MAX_QUEUE_SIZE) {
> + =A0 =A0 =A0 =A0 =A0 =A0qemu_mutex_lock(s->queue_mutex);
> + =A0 =A0 =A0 =A0 =A0 =A0qemu_cond_wait(s->queue_threshold, s->queue_=
mutex);
> + =A0 =A0 =A0 =A0 =A0 =A0qemu_mutex_unlock(s->queue_mutex);
> + =A0 =A0 =A0 =A0}

Actually we shouldn't be waiting inside the aio handler. We should
probably be feeding the request into some wait queue and have a
separate thread that drains all those requests out. Though this
wouldn't help us in throttling the client memory, it's probably a more
correct way to handle the problem.

Yehuda
--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
