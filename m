From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH] libceph: fix a memory leak in handle_watch_notify
Date: Thu, 11 Sep 2014 12:31:11 +0400
Message-ID: <CALFYKtBWjm69_zVUMKjiyAW6K+dE+nx4XzUce57gT1Sc_-Optw@mail.gmail.com>
References: <1410394821-13054-1-git-send-email-roy.qing.li@gmail.com>
	<5410FDE5.5090804@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f47.google.com ([209.85.216.47]:60278 "EHLO
	mail-qa0-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753605AbaIKIbM (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 11 Sep 2014 04:31:12 -0400
Received: by mail-qa0-f47.google.com with SMTP id x12so18494923qac.20
        for <ceph-devel@vger.kernel.org>; Thu, 11 Sep 2014 01:31:12 -0700 (PDT)
In-Reply-To: <5410FDE5.5090804@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: roy.qing.li@gmail.com, Sage Weil <sage@inktank.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Thu, Sep 11, 2014 at 5:41 AM, Alex Elder <elder@ieee.org> wrote:
> On 09/10/2014 07:20 PM, roy.qing.li@gmail.com wrote:
>>
>> From: Li RongQing <roy.qing.li@gmail.com>
>>
>> event_work should be freed when adding it to queue failed
>>
>> Signed-off-by: Li RongQing <roy.qing.li@gmail.com>
>
>
> Looks good.
>
> Reviewed-by: Alex Elder <elder@linaro.org>

Hmm, queue_work() returns %false if @work was already on a queue, %true
otherwise, so this seems bogus to me.  I'd go with something like this
(mangled).

From c0711eee447b199b1c2193460fce8c9d958f23f4 Mon Sep 17 00:00:00 2001
From: Ilya Dryomov <ilya.dryomov@inktank.com>
Date: Thu, 11 Sep 2014 12:18:53 +0400
Subject: [PATCH] libceph: don't try checking queue_work() return value

queue_work() doesn't "fail to queue", it returns false if work was
already on a queue, which can't happen here since we allocate
event_work right before we queue it.  So don't bother at all.

Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
---
 net/ceph/osd_client.c |   15 +++++----------
 1 file changed, 5 insertions(+), 10 deletions(-)

diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
index 0f569d322405..952e9c254cc7 100644
--- a/net/ceph/osd_client.c
+++ b/net/ceph/osd_client.c
@@ -2355,26 +2355,21 @@ static void handle_watch_notify(struct
ceph_osd_client *osdc,
        if (event) {
                event_work = kmalloc(sizeof(*event_work), GFP_NOIO);
                if (!event_work) {
-                       dout("ERROR: could not allocate event_work\n");
-                       goto done_err;
+                       pr_err("couldn't allocate event_work\n");
+                       ceph_osdc_put_event(event);
+                       return;
                }
                INIT_WORK(&event_work->work, do_event_work);
                event_work->event = event;
                event_work->ver = ver;
                event_work->notify_id = notify_id;
                event_work->opcode = opcode;
-               if (!queue_work(osdc->notify_wq, &event_work->work)) {
-                       dout("WARNING: failed to queue notify event work\n");
-                       goto done_err;
-               }
+
+               queue_work(osdc->notify_wq, &event_work->work);
        }

        return;

-done_err:
-       ceph_osdc_put_event(event);
-       return;
-
 bad:
        pr_err("osdc handle_watch_notify corrupt msg\n");
 }
-- 
1.7.10.4
