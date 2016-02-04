From: Samuel Just <sjust@redhat.com>
Subject: Re: Reason of Recovery Work Queue not being a priority queue
Date: Thu, 4 Feb 2016 10:13:17 -0800
Message-ID: <CAN=+7FXkUtt7g06DOPnZ1RhyOoLzh=Y5GoAf72R1LEi02JD0TA@mail.gmail.com>
References: <CAPg135YuCk3my-O0Bb_jT1enKPoAhvP21Uqz2AgpvkvNH==mDA@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yw0-f172.google.com ([209.85.161.172]:35582 "EHLO
	mail-yw0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752803AbcBDSUG (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 4 Feb 2016 13:20:06 -0500
Received: by mail-yw0-f172.google.com with SMTP id g127so31778244ywf.2
        for <ceph-devel@vger.kernel.org>; Thu, 04 Feb 2016 10:20:05 -0800 (PST)
In-Reply-To: <CAPg135YuCk3my-O0Bb_jT1enKPoAhvP21Uqz2AgpvkvNH==mDA@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Gaurav Bafna <bafnag@gmail.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I've got a branch that will actually move that into the main wq.
https://github.com/athanatos/ceph/tree/wip-recovery-wq

More generally, PGs don't start recovering (and therefore are not in
that queue) until they have reservations locally and on recovery
targets -- those reservations *are* prioritized by amount degraded,
etc.
-Sam

On Wed, Feb 3, 2016 at 12:44 AM, Gaurav Bafna <bafnag@gmail.com> wrote:
> Hi Cephers,
>
> I am going through OSD Code flow. I noticed that the work queue for
> normal read write operations is Prioritized Queue (op_shardedwq in
> OSD.h), whereas the recovery work queue is FIFO with respect to PGs .
> The PG which was first discovered to be "need to be recovered"  will
> be recovered first. There might be a PG which has more recovery work
> to do , but was last in the queue. So in that case, it will lead to a
> higher recovery time.
>
> I think it is FIFO assuming that the PG which needs more recovery ,
> must have lost many OSDs and should be well ahead in the queue.
>
> Should we have a recovery queue implemented as priority queue for the PGs ?
>
> Please let me know whether I am right or there is some problem in my
> understanding.
>
>
> --
> Gaurav Bafna
> 9540631400
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>
>
