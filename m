From: Haomai Wang <haomaiwang@gmail.com>
Subject: Re: About Adding eventfd support for LibRBD
Date: Fri, 10 Jul 2015 11:16:14 +0800
Message-ID: <CACJqLyaNuS0=9r9kg0M5m67xVO6nrzs1Dz6xsDij-yvs8-e0mQ@mail.gmail.com>
References: <CACJqLyb5spgWuxAc-rLctp6RapKuWmmdNwg42CbRNOEcxW5XGw@mail.gmail.com>
	<559C9422.8010403@redhat.com>
	<CACJqLyaj4sxmN9R+m8xY6v=isdh53qGDotKAn_2QW0SVkmOeQg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-yk0-f170.google.com ([209.85.160.170]:34200 "EHLO
	mail-yk0-f170.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751293AbbGJDQO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Jul 2015 23:16:14 -0400
Received: by ykax123 with SMTP id x123so5418733yka.1
        for <ceph-devel@vger.kernel.org>; Thu, 09 Jul 2015 20:16:14 -0700 (PDT)
In-Reply-To: <CACJqLyaj4sxmN9R+m8xY6v=isdh53qGDotKAn_2QW0SVkmOeQg@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Josh Durgin <jdurgin@redhat.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>, Jason Dillaman <dillaman@redhat.com>

I made a simple draft about adding async event notification support for librbd:

The initial idea is try to avoid much change to existing apis. So we
could add a new api like:

struct {
  int result;
  void *userdata;
  ......
} rbd_aio_event;

int poll_io_events(ImageCtx *ictx, rbd_aio_event *events, int
numevents, struct timespec *timeout);

int set_image_notification(ImageCtx *ictx, void *handler, enum
notification_type);

It seemed a little tricky, if user call "set_image_notification"
successfully, user can call aio_write/read with specified
userdata(original callback argument pointer). Librbd internal thread
will post async event to the "eventfd" using the specified
way(notification_type) when io finished. For example, linux/bsd will
use [eventfd])(http://man7.org/linux/man-pages/man2/eventfd.2.html),
solaris could use
[port_send](http://docs.oracle.com/cd/E23823_01/html/816-5168/port-send-3c.html#scrolltoc),
windows could use iocp method
[PostQueuedCompletionStatus](https://msdn.microsoft.com/en-us/library/windows/desktop/aa365458(v=vs.85).aspx).

If client call rbd without "set_image_notification", user could call
"poll_io_events" will get -EOPNOTSUPP.



On Wed, Jul 8, 2015 at 11:46 AM, Haomai Wang <haomaiwang@gmail.com> wrote:
> On Wed, Jul 8, 2015 at 11:08 AM, Josh Durgin <jdurgin@redhat.com> wrote:
>> On 07/07/2015 08:18 AM, Haomai Wang wrote:
>>>
>>> Hi All,
>>>
>>> Currently librbd support aio_read/write with specified
>>> callback(AioCompletion). It would be nice for simple caller logic, but
>>> it also has some problems:
>>>
>>> 1. Performance bottleneck: Create/Free AioCompletion and librbd
>>> internal finisher thread complete "callback" isn't a *very
>>> littleweight" job, especially when "callback" need to update some
>>> status with lock hold
>>>
>>> 2. Call logic: Usually like fio rbd engine, caller will maintain some
>>> status with io and rbd callback isn't enough to finish all the jobs
>>> related to io. For example, caller need to check each queued io
>>> stupidly again when rbd callback finished.
>>>
>>> So maybe we could add new api which support eventfd, so caller could
>>> add eventfd to its event loop and batch reap finished io event and
>>> update status or do more things.
>>>
>>> Any feedback is appreciated!
>>
>>
>> It seems like a good idea to me. I'm not sure how much overhead it
>> avoids, but letting the callers check status from their own threads
>> is much nicer in general.
>>
>> I'd be curious how much overhead the callback + finisher add. If it's
>> significant, it might make sense to add similar eventfd interfaces
>> lower in the stack too.
>
> From intuition if we do high iodepth benchmark, noncallback way could
> reduce lots of "extra callback latency" because new way could batch
> them. Another performance benefit I think from caller side, new way
> could let complexity io finished job avoid "callback lock" and reduce
> extra logic. Finally, mostly callback need to wakeup caller thread to
> do next thing, it would be great that with new way we can do it in
> librbd via eventfd.
>
>>
>> Josh
>
>
>
> --
> Best Regards,
>
> Wheat



-- 
Best Regards,

Wheat
