From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH] libceph: fix a memory leak in handle_watch_notify
Date: Thu, 11 Sep 2014 05:50:09 -0500
Message-ID: <54117E61.6080004@ieee.org>
References: <1410394821-13054-1-git-send-email-roy.qing.li@gmail.com>	<5410FDE5.5090804@ieee.org> <CALFYKtBWjm69_zVUMKjiyAW6K+dE+nx4XzUce57gT1Sc_-Optw@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f181.google.com ([209.85.223.181]:50194 "EHLO
	mail-ie0-f181.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751552AbaIKKuO (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Sep 2014 06:50:14 -0400
Received: by mail-ie0-f181.google.com with SMTP id lx4so2826269iec.40
        for <ceph-devel@vger.kernel.org>; Thu, 11 Sep 2014 03:50:13 -0700 (PDT)
In-Reply-To: <CALFYKtBWjm69_zVUMKjiyAW6K+dE+nx4XzUce57gT1Sc_-Optw@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: roy.qing.li@gmail.com, Sage Weil <sage@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 09/11/2014 03:31 AM, Ilya Dryomov wrote:
> On Thu, Sep 11, 2014 at 5:41 AM, Alex Elder <elder@ieee.org> wrote:
>> On 09/10/2014 07:20 PM, roy.qing.li@gmail.com wrote:
>>>
>>> From: Li RongQing <roy.qing.li@gmail.com>
>>>
>>> event_work should be freed when adding it to queue failed
>>>
>>> Signed-off-by: Li RongQing <roy.qing.li@gmail.com>
>>
>>
>> Looks good.
>>
>> Reviewed-by: Alex Elder <elder@linaro.org>
>
> Hmm, queue_work() returns %false if @work was already on a queue, %true
> otherwise, so this seems bogus to me.  I'd go with something like this
> (mangled).

The original change was fine.  Whether it matters is another question.
Your suggestion looks good as well, and on the assumption that if you
choose to use it instead your "real" fix is done correctly you can
use "Reviewed-by: <me>" if you like.

					-Alex

>
>  From c0711eee447b199b1c2193460fce8c9d958f23f4 Mon Sep 17 00:00:00 2001
> From: Ilya Dryomov <ilya.dryomov@inktank.com>
> Date: Thu, 11 Sep 2014 12:18:53 +0400
> Subject: [PATCH] libceph: don't try checking queue_work() return value
>
> queue_work() doesn't "fail to queue", it returns false if work was
> already on a queue, which can't happen here since we allocate
> event_work right before we queue it.  So don't bother at all.
>
> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>   net/ceph/osd_client.c |   15 +++++----------
>   1 file changed, 5 insertions(+), 10 deletions(-)
>
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 0f569d322405..952e9c254cc7 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -2355,26 +2355,21 @@ static void handle_watch_notify(struct
> ceph_osd_client *osdc,
>          if (event) {
>                  event_work = kmalloc(sizeof(*event_work), GFP_NOIO);
>                  if (!event_work) {
> -                       dout("ERROR: could not allocate event_work\n");
> -                       goto done_err;
> +                       pr_err("couldn't allocate event_work\n");
> +                       ceph_osdc_put_event(event);
> +                       return;
>                  }
>                  INIT_WORK(&event_work->work, do_event_work);
>                  event_work->event = event;
>                  event_work->ver = ver;
>                  event_work->notify_id = notify_id;
>                  event_work->opcode = opcode;
> -               if (!queue_work(osdc->notify_wq, &event_work->work)) {
> -                       dout("WARNING: failed to queue notify event work\n");
> -                       goto done_err;
> -               }
> +
> +               queue_work(osdc->notify_wq, &event_work->work);
>          }
>
>          return;
>
> -done_err:
> -       ceph_osdc_put_event(event);
> -       return;
> -
>   bad:
>          pr_err("osdc handle_watch_notify corrupt msg\n");
>   }
>

