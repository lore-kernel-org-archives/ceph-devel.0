From: Mike Christie <mchristi@redhat.com>
Subject: Re: [PATCH 4/6] osd_client, rbd: update event interface for watch/notify2
Date: Tue, 16 Jun 2015 09:58:07 -0500
Message-ID: <5580397F.9060306@redhat.com>
References: <cover.1434124007.git.dfuller@redhat.com> <1e922f4d9ba0ea00be5a387247866f44cb0b6488.1434124007.git.dfuller@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:33826 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1754814AbbFPO6I (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Tue, 16 Jun 2015 10:58:08 -0400
Received: from int-mx14.intmail.prod.int.phx2.redhat.com (int-mx14.intmail.prod.int.phx2.redhat.com [10.5.11.27])
	by mx1.redhat.com (Postfix) with ESMTPS id 3CF71C1F6B
	for <ceph-devel@vger.kernel.org>; Tue, 16 Jun 2015 14:58:08 +0000 (UTC)
In-Reply-To: <1e922f4d9ba0ea00be5a387247866f44cb0b6488.1434124007.git.dfuller@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Douglas Fuller <dfuller@redhat.com>, ceph-devel@vger.kernel.org

On 06/12/2015 10:56 AM, Douglas Fuller wrote:
> +static void rbd_watch_error_cb(void *arg, u64 cookie, int err)
> +{
> +	struct rbd_device *rbd_dev = (struct rbd_device *)arg;
> +	int ret;
> +
> +	dout("%s: watch error %d on cookie %llu\n", rbd_dev->header_name,
> +		err, cookie);
> +	rbd_warn(rbd_dev, "%s: watch error %d on cookie %llu\n",
> +	         rbd_dev->header_name, err, cookie);
> +
> +	/* reset watch */
> +	rbd_dev_refresh(rbd_dev);
> +	rbd_dev_header_unwatch_sync(rbd_dev);
> +	ret = rbd_dev_header_watch_sync(rbd_dev);
> +	BUG_ON(ret); /* XXX: was the image deleted? can we be more graceful? */

Is this for debugging only? BUG()/BUG_ON() can kill the system. We
normally use it for cases where proceeding might cause something like
data corruption or where we want to catch programming bugs early on like
passing incorrect args to a function.

The other caller if this function does not escalate like this function.
Are you sure you need to here? The code below will not run if we BUG
above, so if you did want to BUG, you would want to move the rbd_warn
before it.

> +	rbd_dev_refresh(rbd_dev);
> +	if (ret)
> +		rbd_warn(rbd_dev, "refresh failed: %d", ret);
> +}
> +
>  /*



> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 74650e1..d435bf2 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -36,7 +36,13 @@ static void __unregister_linger_request(struct ceph_osd_client *osdc,
>  					struct ceph_osd_request *req);
>  static void __enqueue_request(struct ceph_osd_request *req);
>  static void __send_request(struct ceph_osd_client *osdc,
> -			   struct ceph_osd_request *req);
> +                           struct ceph_osd_request *req);
> +static struct ceph_osd_event *__find_event(struct ceph_osd_client *osdc,
> +                                           u64 cookie);
> +static void __do_event(struct ceph_osd_client *osdc, u8 opcode,
> +                       u64 cookie, u64 notify_id, u32 payload_len,
> +                       void *payload, s32 return_code, u64 notifier_gid,
> +                       struct ceph_msg_data *data);

We should not be adding these declarations if they are not needed.


> +}
> +
> +int ceph_osdc_create_watch_event (struct ceph_osd_client *osdc,

Not sure if it is my mailer, but there seem to be several places where
there are extra spaces between the function namd and initial "(" like above.

> +                         void (*watchcb)(void *, u64, u64, u64, void *, size_t),
> +                         void (*errcb)(void *, u64, int),
> +                         void *data, struct ceph_osd_event **pevent)
> +{
> +	struct ceph_osd_event *event;
> +	
> +	event = __alloc_event(osdc, data);
> +	if (!event)
> +		return -ENOMEM;
> +
> +	event->watch.watchcb = watchcb;
> +	event->watch.errcb = errcb;
> +
> +	spin_lock(&osdc->event_lock);
> +	event->cookie = ++osdc->event_count;
> +	__insert_event(osdc, event);
> +	spin_unlock(&osdc->event_lock);
> +	*pevent = event;
> +	return 0;
> +}
> +EXPORT_SYMBOL(ceph_osdc_create_watch_event);
> +
> +int ceph_osdc_create_notify_event(struct ceph_osd_client *osdc,
> +                                  struct ceph_osd_event **pevent)
> +{
> +	struct ceph_osd_event *event;
> +	
> +	event = __alloc_event(osdc, NULL);
> +	if (!event)
> +		return -ENOMEM;
> +
> +	init_completion(&event->notify.complete);
> +
>  	spin_lock(&osdc->event_lock);
>  	event->cookie = ++osdc->event_count;
>  	__insert_event(osdc, event);
> @@ -2356,7 +2397,15 @@ int ceph_osdc_create_event(struct ceph_osd_client *osdc,
>  	*pevent = event;
>  	return 0;
>  }
> -EXPORT_SYMBOL(ceph_osdc_create_event);
> +EXPORT_SYMBOL(ceph_osdc_create_notify_event);
> +
> +int ceph_osdc_wait_event (struct ceph_osd_client *osdc,
> +                          struct ceph_osd_event *event)
> +{
> +	wait_for_completion(&event->notify.complete);
> +	return 0;

If it's not a interruptible or timed wait then I think you can just kill
the return value.

> +}
> +EXPORT_SYMBOL(ceph_osdc_wait_event);
>  
>  void ceph_osdc_cancel_event(struct ceph_osd_event *event)
>  {
> @@ -2376,20 +2425,79 @@ static void do_event_work(struct work_struct *work)
>  	struct ceph_osd_event_work *event_work =
>  		container_of(work, struct ceph_osd_event_work, work);
>  	struct ceph_osd_event *event = event_work->event;
> -	u64 ver = event_work->ver;
>  	u64 notify_id = event_work->notify_id;
>  	u8 opcode = event_work->opcode;
>  	s32 return_code = event_work->return_code;
>  	u64 notifier_gid = event_work->notifier_gid;
>  
>  	dout("do_event_work completing %p\n", event);
> -	event->cb(ver, notify_id, opcode, return_code, notifier_gid,
> -		  event->data, event_work->payload, event_work->payload_len);
> +	if (opcode == CEPH_WATCH_EVENT_NOTIFY)
> +		event->watch.watchcb(event->data, notify_id,
> +		                     event->cookie, notifier_gid,
> +		                     event_work->payload,
> +		                     event_work->payload_len);
> +	else if (opcode == CEPH_WATCH_EVENT_DISCONNECT && event->watch.errcb)
> +		event->watch.errcb(event->data, event->cookie, return_code);
>  	dout("do_event_work completed %p\n", event);
>  	ceph_osdc_put_event(event);
>  	kfree(event_work);
>  }
>  
> +static void __do_event(struct ceph_osd_client *osdc, u8 opcode,
> +                       u64 cookie, u64 notify_id, u32 payload_len,
> +                       void *payload, s32 return_code, u64 notifier_gid,
> +                       struct ceph_msg_data *data)
> +{
> +	struct ceph_osd_event *event;
> +	struct ceph_osd_event_work *event_work;
> +
> +	spin_lock(&osdc->event_lock);
> +	event = __find_event(osdc, cookie);
> +	if (event)
> +		get_event(event);
> +	spin_unlock(&osdc->event_lock);
> +
> +	dout("handle_watch_notify cookie %lld event %p notify id %llu payload "
> +	     "len %u return code %d notifier gid %llu\n",
> +             cookie, event, notify_id, payload_len, return_code, notifier_gid);
> +	switch(opcode) {
> +		case CEPH_WATCH_EVENT_NOTIFY:
> +		case CEPH_WATCH_EVENT_DISCONNECT:
> +			if (event) {
> +				event_work = kmalloc(sizeof(*event_work),
> +				                     GFP_NOIO);
> +				if (!event_work) {
> +					pr_err("couldn't allocate event_work\n");
> +					ceph_osdc_put_event(event);
> +					return;
> +				}
> +				INIT_WORK(&event_work->work, do_event_work);
> +				event_work->event = event;
> +				event_work->notify_id = notify_id;
> +				event_work->opcode = opcode;
> +				event_work->return_code = return_code;
> +				event_work->notifier_gid = notifier_gid;
> +				event_work->payload = payload;
> +				event_work->payload_len = payload_len;
> +
> +				queue_work(osdc->notify_wq, &event_work->work);
> +			}
> +			break;
> +		case CEPH_WATCH_EVENT_NOTIFY_COMPLETE:
> +			if (event) {
> +				event->notify.notify_data = data;
> +				if (event->osd_req) {
> +					ceph_osdc_cancel_request(event->osd_req);
> +					event->osd_req = NULL;
> +				}
> +				complete_all(&event->notify.complete);
> +			}
> +			break;
> +		default:
> +			BUG();
> +			break;

No need to break after BUG()ing.
