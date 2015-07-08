From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: About Adding eventfd support for LibRBD
Date: Wed, 8 Jul 2015 11:46:42 +0800
Message-ID: <CACJqLyaj4sxmN9R+m8xY6v=isdh53qGDotKAn_2QW0SVkmOeQg@mail.gmail.com>
References: <CACJqLyb5spgWuxAc-rLctp6RapKuWmmdNwg42CbRNOEcxW5XGw@mail.gmail.com>
	<559C9422.8010403@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f178.google.com ([209.85.160.178]:33277 "EHLO
	mail-yk0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1757459AbbGHDqn (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 7 Jul 2015 23:46:43 -0400
Received: by ykeo3 with SMTP id o3so76168353yke.0
        for <ceph-devel@vger.kernel.org>; Tue, 07 Jul 2015 20:46:43 -0700 (PDT)
In-Reply-To: <559C9422.8010403@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Jason Dillaman <dillaman@redhat.com>

On Wed, Jul 8, 2015 at 11:08 AM, Josh Durgin <jdurgin@redhat.com> wrote:
> On 07/07/2015 08:18 AM, Haomai Wang wrote:
>>
>> Hi All,
>>
>> Currently librbd support aio_read/write with specified
>> callback(AioCompletion). It would be nice for simple caller logic, but
>> it also has some problems:
>>
>> 1. Performance bottleneck: Create/Free AioCompletion and librbd
>> internal finisher thread complete "callback" isn't a *very
>> littleweight" job, especially when "callback" need to update some
>> status with lock hold
>>
>> 2. Call logic: Usually like fio rbd engine, caller will maintain some
>> status with io and rbd callback isn't enough to finish all the jobs
>> related to io. For example, caller need to check each queued io
>> stupidly again when rbd callback finished.
>>
>> So maybe we could add new api which support eventfd, so caller could
>> add eventfd to its event loop and batch reap finished io event and
>> update status or do more things.
>>
>> Any feedback is appreciated!
>
>
> It seems like a good idea to me. I'm not sure how much overhead it
> avoids, but letting the callers check status from their own threads
> is much nicer in general.
>
> I'd be curious how much overhead the callback + finisher add. If it's
> significant, it might make sense to add similar eventfd interfaces
> lower in the stack too.

From intuition if we do high iodepth benchmark, noncallback way could
reduce lots of "extra callback latency" because new way could batch
them. Another performance benefit I think from caller side, new way
could let complexity io finished job avoid "callback lock" and reduce
extra logic. Finally, mostly callback need to wakeup caller thread to
do next thing, it would be great that with new way we can do it in
librbd via eventfd.

>
> Josh



-- 
Best Regards,

Wheat
