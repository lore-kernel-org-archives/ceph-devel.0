From: Ilya Dryomov <ilya.dryomov@inktank.com>
Subject: Re: [PATCH 3/7] ceph: add ceph_osdc_cancel_writes
Date: Tue, 4 Nov 2014 19:18:53 +0400
Message-ID: <CALFYKtA55Kpc=0C6juDumT3F98vyMhQjLtC2GTO=rsV0SZ83cw@mail.gmail.com>
References: <1415111669-26246-1-git-send-email-john.spray@redhat.com>
	<1415111669-26246-4-git-send-email-john.spray@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qa0-f44.google.com ([209.85.216.44]:37130 "EHLO
	mail-qa0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751794AbaKDPSy (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 4 Nov 2014 10:18:54 -0500
Received: by mail-qa0-f44.google.com with SMTP id w8so10168546qac.3
        for <ceph-devel@vger.kernel.org>; Tue, 04 Nov 2014 07:18:54 -0800 (PST)
In-Reply-To: <1415111669-26246-4-git-send-email-john.spray@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <john.spray@redhat.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Nov 4, 2014 at 5:34 PM, John Spray <john.spray@redhat.com> wrote:
> To allow us to abort writes in ENOSPC conditions, instead
> of having them block indefinitely.

I just saw the word "cancel", and as we've had trouble in this area in
libceph in the past, a couple nit-pickings.

First, in my mind at least, "cancel" is sort of reserved for the "get
rid of this request and don't call any completions or callbacks" kind
of thing - see ceph_osdc_cancel_request().  Here you do both of those,
so maybe rename to something like ceph_osdc_complete_writes() to keep
the distinction?

Second, you should go through Documentation/CodingStyle in the kernel
tree.  Mostly indentation is what's wrong, also don't indent dout()s,
drop braces around single-statement if and the two parameters of
ceph_osdc_cancel_writes() will fit on a single line.

Third, this patch should have a "libceph:" prefix.

Finally, this patch seems to also introduce a concept of a osdmap
callback.  Either it should be a separate libceph patch or you should
mention this somewhere in the description.

>
> Signed-off-by: John Spray <john.spray@redhat.com>
> ---
>  include/linux/ceph/osd_client.h |  8 +++++
>  net/ceph/osd_client.c           | 67 +++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 75 insertions(+)
>
> diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
> index 7cb5cea..f82000c 100644
> --- a/include/linux/ceph/osd_client.h
> +++ b/include/linux/ceph/osd_client.h
> @@ -21,6 +21,7 @@ struct ceph_authorizer;
>  /*
>   * completion callback for async writepages
>   */
> +typedef void (*ceph_osdc_full_callback_t)(struct ceph_osd_client *, void *);
>  typedef void (*ceph_osdc_callback_t)(struct ceph_osd_request *,
>                                      struct ceph_msg *);
>  typedef void (*ceph_osdc_unsafe_callback_t)(struct ceph_osd_request *, bool);
> @@ -226,6 +227,9 @@ struct ceph_osd_client {
>         u64                     event_count;
>
>         struct workqueue_struct *notify_wq;
> +
> +    ceph_osdc_full_callback_t map_cb;
> +    void                     *map_p;
>  };
>
>  extern int ceph_osdc_setup(void);
> @@ -331,6 +335,7 @@ extern void ceph_osdc_put_request(struct ceph_osd_request *req);
>  extern int ceph_osdc_start_request(struct ceph_osd_client *osdc,
>                                    struct ceph_osd_request *req,
>                                    bool nofail);
> +extern u32 ceph_osdc_cancel_writes(struct ceph_osd_client *osdc, int r);
>  extern void ceph_osdc_cancel_request(struct ceph_osd_request *req);
>  extern int ceph_osdc_wait_request(struct ceph_osd_client *osdc,
>                                   struct ceph_osd_request *req);
> @@ -361,5 +366,8 @@ extern int ceph_osdc_create_event(struct ceph_osd_client *osdc,
>                                   void *data, struct ceph_osd_event **pevent);
>  extern void ceph_osdc_cancel_event(struct ceph_osd_event *event);
>  extern void ceph_osdc_put_event(struct ceph_osd_event *event);
> +
> +extern void ceph_osdc_register_map_cb(struct ceph_osd_client *osdc,
> +                                 ceph_osdc_full_callback_t cb, void *data);
>  #endif
>
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 75ab07c..eb7e735 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -836,6 +836,59 @@ __lookup_request_ge(struct ceph_osd_client *osdc,
>         return NULL;
>  }
>
> +/*
> + * Drop all pending write/modify requests and complete
> + * them with the `r` as return code.
> + *
> + * Returns the highest OSD map epoch of a request that was
> + * cancelled, or 0 if none were cancelled.
> + */
> +u32 ceph_osdc_cancel_writes(
> +        struct ceph_osd_client *osdc,
> +        int r)
> +{
> +    struct ceph_osd_request *req;
> +    struct rb_node *n = osdc->requests.rb_node;
> +    u32 latest_epoch = 0;
> +
> +       dout("enter cancel_writes r=%d", r);
> +
> +    mutex_lock(&osdc->request_mutex);
> +
> +    while (n) {
> +        req = rb_entry(n, struct ceph_osd_request, r_node);
> +        n = rb_next(n);
> +
> +        ceph_osdc_get_request(req);
> +        if (req->r_flags && CEPH_OSD_FLAG_WRITE) {

req->r_flags & CEPH_OSD_FLAG_WRITE ?

> +            req->r_result = r;
> +            complete_all(&req->r_completion);
> +            complete_all(&req->r_safe_completion);
> +
> +            if (req->r_callback) {
> +                // Requires callbacks used for write ops are
> +                // amenable to being called with NULL msg
> +                // (e.g. writepages_finish)
> +                req->r_callback(req, NULL);
> +            }
> +
> +            __unregister_request(osdc, req);
> +
> +            if (*req->r_request_osdmap_epoch > latest_epoch) {
> +                latest_epoch = *req->r_request_osdmap_epoch;
> +            }
> +        }
> +        ceph_osdc_put_request(req);
> +    }
> +
> +    mutex_unlock(&osdc->request_mutex);
> +
> +       dout("complete cancel_writes latest_epoch=%ul", latest_epoch);
> +
> +    return latest_epoch;
> +}
> +EXPORT_SYMBOL(ceph_osdc_cancel_writes);
> +
>  static void __kick_linger_request(struct ceph_osd_request *req)
>  {
>         struct ceph_osd_client *osdc = req->r_osdc;
> @@ -2102,6 +2155,10 @@ done:
>         downgrade_write(&osdc->map_sem);
>         ceph_monc_got_osdmap(&osdc->client->monc, osdc->osdmap->epoch);
>
> +       if (osdc->map_cb) {
> +               osdc->map_cb(osdc, osdc->map_p);
> +       }
> +
>         /*
>          * subscribe to subsequent osdmap updates if full to ensure
>          * we find out when we are no longer full and stop returning
> @@ -2125,6 +2182,14 @@ bad:
>         up_write(&osdc->map_sem);
>  }
>
> +void ceph_osdc_register_map_cb(struct ceph_osd_client *osdc,
> +        ceph_osdc_full_callback_t cb, void *data)

ceph_osdc_map_callback_t?  It's called on the way out from handle map
and doesn't look specific to ENOSPC handling.

Thanks,

                Ilya

> +{
> +    osdc->map_cb = cb;
> +    osdc->map_p = data;
> +}
> +EXPORT_SYMBOL(ceph_osdc_register_map_cb);
> +
>  /*
>   * watch/notify callback event infrastructure
>   *
> @@ -2553,6 +2618,8 @@ int ceph_osdc_init(struct ceph_osd_client *osdc, struct ceph_client *client)
>         spin_lock_init(&osdc->event_lock);
>         osdc->event_tree = RB_ROOT;
>         osdc->event_count = 0;
> +       osdc->map_cb = NULL;
> +       osdc->map_p = NULL;
>
>         schedule_delayed_work(&osdc->osds_timeout_work,
>            round_jiffies_relative(osdc->client->options->osd_idle_ttl * HZ));
> --
> 1.9.3
>
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
