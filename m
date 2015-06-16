From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: [PATCH 1/6] ceph/rbd: add support for watch notify payloads
Date: Tue, 16 Jun 2015 14:22:36 -0700
Message-ID: <5580939C.7090605@redhat.com>
References: <cover.1434124007.git.dfuller@redhat.com> <d6abc610deea16335ce674cbe473131e2577844f.1434124007.git.dfuller@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:48717 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1753060AbbFPVWc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 16 Jun 2015 17:22:32 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 971023582CA
	for <ceph-devel@vger.kernel.org>; Tue, 16 Jun 2015 21:22:32 +0000 (UTC)
In-Reply-To: <d6abc610deea16335ce674cbe473131e2577844f.1434124007.git.dfuller@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Douglas Fuller <dfuller@redhat.com>, ceph-devel@vger.kernel.org

On 06/12/2015 08:56 AM, Douglas Fuller wrote:
> From: Mike Christie <michaelc@cs.wisc.edu>
>
> This patch adds support for proto version 1 of watch-notify,
> so drivers like rbd can be sent a buffer with information like
> the notify operation being performed.
>
> Signed-off-by: Mike Christie <michaelc@cs.wisc.edu>

Reviewed-by: Josh Durgin <jdurgin@redhat.com>

> ---
>   drivers/block/rbd.c             |  3 ++-
>   include/linux/ceph/osd_client.h |  7 +++++--
>   net/ceph/osd_client.c           | 21 ++++++++++++++++-----
>   3 files changed, 23 insertions(+), 8 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 89fe8a4..4b9ba9f 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -3103,7 +3103,8 @@ out:
>   	return ret;
>   }
>
> -static void rbd_watch_cb(u64 ver, u64 notify_id, u8 opcode, void *data)
> +static void rbd_watch_cb(u64 ver, u64 notify_id, u8 opcode, void *data,
> +			 void *payload, int payload_len)
>   {
>   	struct rbd_device *rbd_dev = (struct rbd_device *)data;
>   	int ret;
> diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
> index 7506b48..eab96b5 100644
> --- a/include/linux/ceph/osd_client.h
> +++ b/include/linux/ceph/osd_client.h
> @@ -184,7 +184,7 @@ struct ceph_osd_event {
>   	u64 cookie;
>   	int one_shot;
>   	struct ceph_osd_client *osdc;
> -	void (*cb)(u64, u64, u8, void *);
> +	void (*cb)(u64, u64, u8, void *, void *, int);
>   	void *data;
>   	struct rb_node node;
>   	struct list_head osd_node;
> @@ -197,6 +197,8 @@ struct ceph_osd_event_work {
>           u64 ver;
>           u64 notify_id;
>           u8 opcode;
> +	void *payload;
> +	int payload_len;
>   };
>
>   struct ceph_osd_client {
> @@ -369,7 +371,8 @@ extern int ceph_osdc_writepages(struct ceph_osd_client *osdc,
>
>   /* watch/notify events */
>   extern int ceph_osdc_create_event(struct ceph_osd_client *osdc,
> -				  void (*event_cb)(u64, u64, u8, void *),
> +				  void (*event_cb)(u64, u64, u8, void *, void *,
> +						   int),
>   				  void *data, struct ceph_osd_event **pevent);
>   extern void ceph_osdc_cancel_event(struct ceph_osd_event *event);
>   extern void ceph_osdc_put_event(struct ceph_osd_event *event);
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 5003367..aa1c5c46 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -2277,7 +2277,7 @@ static void __remove_event(struct ceph_osd_event *event)
>   }
>
>   int ceph_osdc_create_event(struct ceph_osd_client *osdc,
> -			   void (*event_cb)(u64, u64, u8, void *),
> +			   void (*event_cb)(u64, u64, u8, void *, void *, int),
>   			   void *data, struct ceph_osd_event **pevent)
>   {
>   	struct ceph_osd_event *event;
> @@ -2329,7 +2329,8 @@ static void do_event_work(struct work_struct *work)
>   	u8 opcode = event_work->opcode;
>
>   	dout("do_event_work completing %p\n", event);
> -	event->cb(ver, notify_id, opcode, event->data);
> +	event->cb(ver, notify_id, opcode, event->data, event_work->payload,
> +		  event_work->payload_len);
>   	dout("do_event_work completed %p\n", event);
>   	ceph_osdc_put_event(event);
>   	kfree(event_work);
> @@ -2342,10 +2343,11 @@ static void do_event_work(struct work_struct *work)
>   static void handle_watch_notify(struct ceph_osd_client *osdc,
>   				struct ceph_msg *msg)
>   {
> -	void *p, *end;
> +	void *p, *end, *payload = NULL;
>   	u8 proto_ver;
>   	u64 cookie, ver, notify_id;
>   	u8 opcode;
> +	u32 payload_len = 0;
>   	struct ceph_osd_event *event;
>   	struct ceph_osd_event_work *event_work;
>
> @@ -2358,6 +2360,13 @@ static void handle_watch_notify(struct ceph_osd_client *osdc,
>   	ceph_decode_64_safe(&p, end, ver, bad);
>   	ceph_decode_64_safe(&p, end, notify_id, bad);
>
> +	if (proto_ver >= 1) {
> +		ceph_decode_32_safe(&p, end, payload_len, bad);
> +		if (end - p < payload_len)
> +			goto bad;
> +		payload = p;
> +	}
> +
>   	spin_lock(&osdc->event_lock);
>   	event = __find_event(osdc, cookie);
>   	if (event) {
> @@ -2365,8 +2374,8 @@ static void handle_watch_notify(struct ceph_osd_client *osdc,
>   		get_event(event);
>   	}
>   	spin_unlock(&osdc->event_lock);
> -	dout("handle_watch_notify cookie %lld ver %lld event %p\n",
> -	     cookie, ver, event);
> +	dout("handle_watch_notify cookie %lld ver %lld event %p notify id %llu payload len %u\n",
> +	     cookie, ver, event, notify_id, payload_len);
>   	if (event) {
>   		event_work = kmalloc(sizeof(*event_work), GFP_NOIO);
>   		if (!event_work) {
> @@ -2379,6 +2388,8 @@ static void handle_watch_notify(struct ceph_osd_client *osdc,
>   		event_work->ver = ver;
>   		event_work->notify_id = notify_id;
>   		event_work->opcode = opcode;
> +		event_work->payload = payload;
> +		event_work->payload_len = payload_len;
>
>   		queue_work(osdc->notify_wq, &event_work->work);
>   	}
>

