From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: About Adding eventfd support for LibRBD
Date: Tue, 07 Jul 2015 20:08:18 -0700
Message-ID: <559C9422.8010403@redhat.com>
References: <CACJqLyb5spgWuxAc-rLctp6RapKuWmmdNwg42CbRNOEcxW5XGw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:54417 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754091AbbGHDIR (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 7 Jul 2015 23:08:17 -0400
In-Reply-To: <CACJqLyb5spgWuxAc-rLctp6RapKuWmmdNwg42CbRNOEcxW5XGw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Haomai Wang <haomaiwang@gmail.com>, "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>
Cc: Jason Dillaman <dillaman@redhat.com>

On 07/07/2015 08:18 AM, Haomai Wang wrote:
> Hi All,
>
> Currently librbd support aio_read/write with specified
> callback(AioCompletion). It would be nice for simple caller logic, but
> it also has some problems:
>
> 1. Performance bottleneck: Create/Free AioCompletion and librbd
> internal finisher thread complete "callback" isn't a *very
> littleweight" job, especially when "callback" need to update some
> status with lock hold
>
> 2. Call logic: Usually like fio rbd engine, caller will maintain some
> status with io and rbd callback isn't enough to finish all the jobs
> related to io. For example, caller need to check each queued io
> stupidly again when rbd callback finished.
>
> So maybe we could add new api which support eventfd, so caller could
> add eventfd to its event loop and batch reap finished io event and
> update status or do more things.
>
> Any feedback is appreciated!

It seems like a good idea to me. I'm not sure how much overhead it
avoids, but letting the callers check status from their own threads
is much nicer in general.

I'd be curious how much overhead the callback + finisher add. If it's
significant, it might make sense to add similar eventfd interfaces
lower in the stack too.

Josh
