From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] libceph: Complete stuck requests to OSD with EIO
Date: Fri, 10 Feb 2017 13:25:00 +0100
Message-ID: <CAOi1vP_SJD7Vh97WBU2=EsYfWruXqQe06BND+uaq10=V7ZGH1g@mail.gmail.com>
References: <4e080919-2df5-1b75-3c8a-3ae95eb8f08d@synesis.ru> <1486726280.4233.1.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f67.google.com ([209.85.213.67]:36454 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751674AbdBJMdM (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 10 Feb 2017 07:33:12 -0500
Received: by mail-vk0-f67.google.com with SMTP id n125so2506010vke.3
        for <ceph-devel@vger.kernel.org>; Fri, 10 Feb 2017 04:31:45 -0800 (PST)
In-Reply-To: <1486726280.4233.1.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: Artur Molchanov <artur.molchanov@synesis.ru>, Ceph Development <ceph-devel@vger.kernel.org>

On Fri, Feb 10, 2017 at 12:31 PM, Jeff Layton <jlayton@redhat.com> wrote:
> On Thu, 2017-02-09 at 16:04 +0300, Artur Molchanov wrote:
>> From: Artur Molchanov <artur.molchanov@synesis.ru>
>>
>> Complete stuck requests to OSD with error EIO after osd_request_timeout expired.
>> If osd_request_timeout equals to 0 (default value) then do nothing with
>> hung requests (keep default behavior).
>>
>> Create RBD map option osd_request_timeout to set timeout in seconds. Set
>> osd_request_timeout to 0 by default.
>>
> Also, what exactly are the requests blocked on when this occurs? Is the
> ceph_osd_request_target ending up paused? I wonder if we might be better
> off with something that returns a hard error under the circumstances
> where you're hanging, rather than depending on timeouts.
>
>
>> Signed-off-by: Artur Molchanov <artur.molchanov@synesis.ru>
>> ---
>>   include/linux/ceph/libceph.h    |  8 +++--
>>   include/linux/ceph/osd_client.h |  1 +
>>   net/ceph/ceph_common.c          | 12 +++++++
>>   net/ceph/osd_client.c           | 72 +++++++++++++++++++++++++++++++++++++++++
>>   4 files changed, 90 insertions(+), 3 deletions(-)
>>
>> diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
>> index 1816c5e..10d8acb 100644
>> --- a/include/linux/ceph/libceph.h
>> +++ b/include/linux/ceph/libceph.h
>> @@ -48,6 +48,7 @@ struct ceph_options {
>>       unsigned long mount_timeout;            /* jiffies */
>>       unsigned long osd_idle_ttl;             /* jiffies */
>>       unsigned long osd_keepalive_timeout;    /* jiffies */
>> +     unsigned long osd_request_timeout;      /* jiffies */
>>
>>       /*
>>        * any type that can't be simply compared or doesn't need need
>> @@ -65,9 +66,10 @@ struct ceph_options {
>>   /*
>>    * defaults
>>    */
>> -#define CEPH_MOUNT_TIMEOUT_DEFAULT   msecs_to_jiffies(60 * 1000)
>> -#define CEPH_OSD_KEEPALIVE_DEFAULT   msecs_to_jiffies(5 * 1000)
>> -#define CEPH_OSD_IDLE_TTL_DEFAULT    msecs_to_jiffies(60 * 1000)
>> +#define CEPH_MOUNT_TIMEOUT_DEFAULT           msecs_to_jiffies(60 * 1000)
>> +#define CEPH_OSD_KEEPALIVE_DEFAULT           msecs_to_jiffies(5 * 1000)
>> +#define CEPH_OSD_IDLE_TTL_DEFAULT            msecs_to_jiffies(60 * 1000)
>> +#define CEPH_OSD_REQUEST_TIMEOUT_DEFAULT     msecs_to_jiffies(0 * 1000)
>>
>>   #define CEPH_MONC_HUNT_INTERVAL             msecs_to_jiffies(3 * 1000)
>>   #define CEPH_MONC_PING_INTERVAL             msecs_to_jiffies(10 * 1000)
>> diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
>> index 03a6653..e45cba0 100644
>> --- a/include/linux/ceph/osd_client.h
>> +++ b/include/linux/ceph/osd_client.h
>> @@ -279,6 +279,7 @@ struct ceph_osd_client {
>>       atomic_t               num_homeless;
>>       struct delayed_work    timeout_work;
>>       struct delayed_work    osds_timeout_work;
>> +     struct delayed_work    osd_request_timeout_work;
>>   #ifdef CONFIG_DEBUG_FS
>>       struct dentry          *debugfs_file;
>>   #endif
>> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
>> index 464e885..81876c8 100644
>> --- a/net/ceph/ceph_common.c
>> +++ b/net/ceph/ceph_common.c
>> @@ -230,6 +230,7 @@ enum {
>>       Opt_osdkeepalivetimeout,
>>       Opt_mount_timeout,
>>       Opt_osd_idle_ttl,
>> +     Opt_osd_request_timeout,
>>       Opt_last_int,
>>       /* int args above */
>>       Opt_fsid,
>> @@ -256,6 +257,7 @@ static match_table_t opt_tokens = {
>>       {Opt_osdkeepalivetimeout, "osdkeepalive=%d"},
>>       {Opt_mount_timeout, "mount_timeout=%d"},
>>       {Opt_osd_idle_ttl, "osd_idle_ttl=%d"},
>> +     {Opt_osd_request_timeout, "osd_request_timeout=%d"},
>>       /* int args above */
>>       {Opt_fsid, "fsid=%s"},
>>       {Opt_name, "name=%s"},
>> @@ -361,6 +363,7 @@ ceph_parse_options(char *options, const char *dev_name,
>>       opt->osd_keepalive_timeout = CEPH_OSD_KEEPALIVE_DEFAULT;
>>       opt->mount_timeout = CEPH_MOUNT_TIMEOUT_DEFAULT;
>>       opt->osd_idle_ttl = CEPH_OSD_IDLE_TTL_DEFAULT;
>> +     opt->osd_request_timeout = CEPH_OSD_REQUEST_TIMEOUT_DEFAULT;
>>
>>       /* get mon ip(s) */
>>       /* ip1[:port1][,ip2[:port2]...] */
>> @@ -473,6 +476,15 @@ ceph_parse_options(char *options, const char *dev_name,
>>                       }
>>                       opt->mount_timeout = msecs_to_jiffies(intval * 1000);
>>                       break;
>> +             case Opt_osd_request_timeout:
>> +                     /* 0 is "wait forever" (i.e. infinite timeout) */
>> +                     if (intval < 0 || intval > INT_MAX / 1000) {
>> +                             pr_err("osd_request_timeout out of range\n");
>> +                             err = -EINVAL;
>> +                             goto out;
>> +                     }
>> +                     opt->osd_request_timeout = msecs_to_jiffies(intval * 1000);
>> +                     break;
>>
>>               case Opt_share:
>>                       opt->flags &= ~CEPH_OPT_NOSHARE;
>> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
>> index 842f049..2f5a024 100644
>> --- a/net/ceph/osd_client.c
>> +++ b/net/ceph/osd_client.c
>> @@ -2554,6 +2554,75 @@ static void handle_timeout(struct work_struct *work)
>>                             osdc->client->options->osd_keepalive_timeout);
>>   }
>>
>> +/*
>> + * Complete request to OSD with error err if it started before cutoff.
>> + */
>> +static void complete_osd_stuck_request(struct ceph_osd_request *req,
>> +                                    unsigned long cutoff,
>> +                                    int err)
>> +{
>> +     if (!time_before(req->r_stamp, cutoff))
>> +             return;
>> +
>> +     pr_warn_ratelimited("osd req on osd%d timeout expired\n",
>> +                         req->r_osd->o_osd);
>> +
>> +     complete_request(req, err);
>> +}
>> +
>> +/*
>> + * Complete all requests to OSD that has been active for more than timeout.
>> + */
>> +static void complete_osd_stuck_requests(struct ceph_osd *osd,
>> +                                     unsigned long timeout,
>> +                                     int err)
>> +{
>> +     struct ceph_osd_request *req, *n;
>> +     const unsigned long cutoff = jiffies - timeout;
>> +
>> +     rbtree_postorder_for_each_entry_safe(req, n, &osd->o_requests, r_node) {
>> +             complete_osd_stuck_request(req, cutoff, -EIO);
>> +     }
>> +}
>> +
>> +/*
>> + * Timeout callback, called every N seconds. When 1 or more OSD
>> + * requests that has been active for more than N seconds,
>> + * we complete it with error EIO.
>> + */
>> +static void handle_osd_request_timeout(struct work_struct *work)
>> +{
>> +     struct ceph_osd_client *osdc =
>> +             container_of(work, struct ceph_osd_client,
>> +                          osd_request_timeout_work.work);
>> +     struct ceph_osd *osd, *n;
>> +     struct ceph_options *opts = osdc->client->options;
>> +     const unsigned long timeout = opts->osd_request_timeout;
>> +
>> +     dout("%s osdc %p\n", __func__, osdc);
>> +
>> +     if (!timeout)
>> +             return;
>> +
>> +     down_write(&osdc->lock);
>> +
>> +     rbtree_postorder_for_each_entry_safe(osd, n, &osdc->osds, o_node) {
>> +             complete_osd_stuck_requests(osd, timeout, -EIO);
>> +     }
>> +
>> +     up_write(&osdc->lock);
>> +
>> +     if (!atomic_read(&osdc->num_homeless))
>> +             goto out;
>> +
>> +     down_write(&osdc->lock);
>> +     complete_osd_stuck_requests(&osdc->homeless_osd, timeout, -EIO);
>> +     up_write(&osdc->lock);
>> +
>> +out:
>> +     schedule_delayed_work(&osdc->osd_request_timeout_work, timeout);
>> +}
>> +
>>   static void handle_osds_timeout(struct work_struct *work)
>>   {
>>       struct ceph_osd_client *osdc =
>> @@ -4091,6 +4160,7 @@ int ceph_osdc_init(struct ceph_osd_client *osdc, struct
>> ceph_client *client)
>>       osdc->linger_map_checks = RB_ROOT;
>>       INIT_DELAYED_WORK(&osdc->timeout_work, handle_timeout);
>>       INIT_DELAYED_WORK(&osdc->osds_timeout_work, handle_osds_timeout);
>> +     INIT_DELAYED_WORK(&osdc->osd_request_timeout_work, handle_osd_request_timeout);
>>
>>       err = -ENOMEM;
>>       osdc->osdmap = ceph_osdmap_alloc();
>> @@ -4120,6 +4190,8 @@ int ceph_osdc_init(struct ceph_osd_client *osdc, struct
>> ceph_client *client)
>>                             osdc->client->options->osd_keepalive_timeout);
>>       schedule_delayed_work(&osdc->osds_timeout_work,
>>           round_jiffies_relative(osdc->client->options->osd_idle_ttl));
>> +     schedule_delayed_work(&osdc->osd_request_timeout_work,
>> +         round_jiffies_relative(osdc->client->options->osd_request_timeout));
>>
>>       return 0;
>>
>
> Having a job that has to wake up every second or so isn't ideal. Perhaps
> you would be better off scheduling the delayed work in the request
> submission codepath, and only rearm it when the tree isn't empty after
> calling complete_osd_stuck_requests?
>
> Also, I don't see where this job is ever cancelled when the osdc is torn
> down. That needs to occur or you'll cause a use-after-free oops...

Yeah, there are other bugs here: rbtree_postorder_for_each_entry_safe()
can't be used because complete_request() calls erase(), etc.  The patch
I had just piggy-backed on handle_timeout(), which is called every five
seconds anyway.

Given that there is interest, I think it's worth adding.

Thanks,

                Ilya
