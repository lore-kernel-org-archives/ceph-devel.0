From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH] libceph: Complete stuck requests to OSD with EIO
Date: Mon, 13 Feb 2017 10:11:38 +0100
Message-ID: <CAOi1vP-1EPasYZUPoqwh1Ykgq59xEAf1oeGZH5Y8Kpo9ooQMow@mail.gmail.com>
References: <4e080919-2df5-1b75-3c8a-3ae95eb8f08d@synesis.ru>
 <1486726280.4233.1.camel@redhat.com> <CAOi1vP_SJD7Vh97WBU2=EsYfWruXqQe06BND+uaq10=V7ZGH1g@mail.gmail.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=f40304361f38c3844a054865d5cf
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f193.google.com ([209.85.217.193]:36514 "EHLO
        mail-ua0-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751849AbdBMJLj (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 13 Feb 2017 04:11:39 -0500
Received: by mail-ua0-f193.google.com with SMTP id f2so7936426uaf.3
        for <ceph-devel@vger.kernel.org>; Mon, 13 Feb 2017 01:11:39 -0800 (PST)
In-Reply-To: <CAOi1vP_SJD7Vh97WBU2=EsYfWruXqQe06BND+uaq10=V7ZGH1g@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: Artur Molchanov <artur.molchanov@synesis.ru>, Ceph Development <ceph-devel@vger.kernel.org>

--f40304361f38c3844a054865d5cf
Content-Type: text/plain; charset=UTF-8

On Fri, Feb 10, 2017 at 1:25 PM, Ilya Dryomov <idryomov@gmail.com> wrote:
> On Fri, Feb 10, 2017 at 12:31 PM, Jeff Layton <jlayton@redhat.com> wrote:
>> On Thu, 2017-02-09 at 16:04 +0300, Artur Molchanov wrote:
>>> From: Artur Molchanov <artur.molchanov@synesis.ru>
>>>
>>> Complete stuck requests to OSD with error EIO after osd_request_timeout expired.
>>> If osd_request_timeout equals to 0 (default value) then do nothing with
>>> hung requests (keep default behavior).
>>>
>>> Create RBD map option osd_request_timeout to set timeout in seconds. Set
>>> osd_request_timeout to 0 by default.
>>>
>> Also, what exactly are the requests blocked on when this occurs? Is the
>> ceph_osd_request_target ending up paused? I wonder if we might be better
>> off with something that returns a hard error under the circumstances
>> where you're hanging, rather than depending on timeouts.
>>
>>
>>> Signed-off-by: Artur Molchanov <artur.molchanov@synesis.ru>
>>> ---
>>>   include/linux/ceph/libceph.h    |  8 +++--
>>>   include/linux/ceph/osd_client.h |  1 +
>>>   net/ceph/ceph_common.c          | 12 +++++++
>>>   net/ceph/osd_client.c           | 72 +++++++++++++++++++++++++++++++++++++++++
>>>   4 files changed, 90 insertions(+), 3 deletions(-)
>>>
>>> diff --git a/include/linux/ceph/libceph.h b/include/linux/ceph/libceph.h
>>> index 1816c5e..10d8acb 100644
>>> --- a/include/linux/ceph/libceph.h
>>> +++ b/include/linux/ceph/libceph.h
>>> @@ -48,6 +48,7 @@ struct ceph_options {
>>>       unsigned long mount_timeout;            /* jiffies */
>>>       unsigned long osd_idle_ttl;             /* jiffies */
>>>       unsigned long osd_keepalive_timeout;    /* jiffies */
>>> +     unsigned long osd_request_timeout;      /* jiffies */
>>>
>>>       /*
>>>        * any type that can't be simply compared or doesn't need need
>>> @@ -65,9 +66,10 @@ struct ceph_options {
>>>   /*
>>>    * defaults
>>>    */
>>> -#define CEPH_MOUNT_TIMEOUT_DEFAULT   msecs_to_jiffies(60 * 1000)
>>> -#define CEPH_OSD_KEEPALIVE_DEFAULT   msecs_to_jiffies(5 * 1000)
>>> -#define CEPH_OSD_IDLE_TTL_DEFAULT    msecs_to_jiffies(60 * 1000)
>>> +#define CEPH_MOUNT_TIMEOUT_DEFAULT           msecs_to_jiffies(60 * 1000)
>>> +#define CEPH_OSD_KEEPALIVE_DEFAULT           msecs_to_jiffies(5 * 1000)
>>> +#define CEPH_OSD_IDLE_TTL_DEFAULT            msecs_to_jiffies(60 * 1000)
>>> +#define CEPH_OSD_REQUEST_TIMEOUT_DEFAULT     msecs_to_jiffies(0 * 1000)
>>>
>>>   #define CEPH_MONC_HUNT_INTERVAL             msecs_to_jiffies(3 * 1000)
>>>   #define CEPH_MONC_PING_INTERVAL             msecs_to_jiffies(10 * 1000)
>>> diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
>>> index 03a6653..e45cba0 100644
>>> --- a/include/linux/ceph/osd_client.h
>>> +++ b/include/linux/ceph/osd_client.h
>>> @@ -279,6 +279,7 @@ struct ceph_osd_client {
>>>       atomic_t               num_homeless;
>>>       struct delayed_work    timeout_work;
>>>       struct delayed_work    osds_timeout_work;
>>> +     struct delayed_work    osd_request_timeout_work;
>>>   #ifdef CONFIG_DEBUG_FS
>>>       struct dentry          *debugfs_file;
>>>   #endif
>>> diff --git a/net/ceph/ceph_common.c b/net/ceph/ceph_common.c
>>> index 464e885..81876c8 100644
>>> --- a/net/ceph/ceph_common.c
>>> +++ b/net/ceph/ceph_common.c
>>> @@ -230,6 +230,7 @@ enum {
>>>       Opt_osdkeepalivetimeout,
>>>       Opt_mount_timeout,
>>>       Opt_osd_idle_ttl,
>>> +     Opt_osd_request_timeout,
>>>       Opt_last_int,
>>>       /* int args above */
>>>       Opt_fsid,
>>> @@ -256,6 +257,7 @@ static match_table_t opt_tokens = {
>>>       {Opt_osdkeepalivetimeout, "osdkeepalive=%d"},
>>>       {Opt_mount_timeout, "mount_timeout=%d"},
>>>       {Opt_osd_idle_ttl, "osd_idle_ttl=%d"},
>>> +     {Opt_osd_request_timeout, "osd_request_timeout=%d"},
>>>       /* int args above */
>>>       {Opt_fsid, "fsid=%s"},
>>>       {Opt_name, "name=%s"},
>>> @@ -361,6 +363,7 @@ ceph_parse_options(char *options, const char *dev_name,
>>>       opt->osd_keepalive_timeout = CEPH_OSD_KEEPALIVE_DEFAULT;
>>>       opt->mount_timeout = CEPH_MOUNT_TIMEOUT_DEFAULT;
>>>       opt->osd_idle_ttl = CEPH_OSD_IDLE_TTL_DEFAULT;
>>> +     opt->osd_request_timeout = CEPH_OSD_REQUEST_TIMEOUT_DEFAULT;
>>>
>>>       /* get mon ip(s) */
>>>       /* ip1[:port1][,ip2[:port2]...] */
>>> @@ -473,6 +476,15 @@ ceph_parse_options(char *options, const char *dev_name,
>>>                       }
>>>                       opt->mount_timeout = msecs_to_jiffies(intval * 1000);
>>>                       break;
>>> +             case Opt_osd_request_timeout:
>>> +                     /* 0 is "wait forever" (i.e. infinite timeout) */
>>> +                     if (intval < 0 || intval > INT_MAX / 1000) {
>>> +                             pr_err("osd_request_timeout out of range\n");
>>> +                             err = -EINVAL;
>>> +                             goto out;
>>> +                     }
>>> +                     opt->osd_request_timeout = msecs_to_jiffies(intval * 1000);
>>> +                     break;
>>>
>>>               case Opt_share:
>>>                       opt->flags &= ~CEPH_OPT_NOSHARE;
>>> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
>>> index 842f049..2f5a024 100644
>>> --- a/net/ceph/osd_client.c
>>> +++ b/net/ceph/osd_client.c
>>> @@ -2554,6 +2554,75 @@ static void handle_timeout(struct work_struct *work)
>>>                             osdc->client->options->osd_keepalive_timeout);
>>>   }
>>>
>>> +/*
>>> + * Complete request to OSD with error err if it started before cutoff.
>>> + */
>>> +static void complete_osd_stuck_request(struct ceph_osd_request *req,
>>> +                                    unsigned long cutoff,
>>> +                                    int err)
>>> +{
>>> +     if (!time_before(req->r_stamp, cutoff))
>>> +             return;
>>> +
>>> +     pr_warn_ratelimited("osd req on osd%d timeout expired\n",
>>> +                         req->r_osd->o_osd);
>>> +
>>> +     complete_request(req, err);
>>> +}
>>> +
>>> +/*
>>> + * Complete all requests to OSD that has been active for more than timeout.
>>> + */
>>> +static void complete_osd_stuck_requests(struct ceph_osd *osd,
>>> +                                     unsigned long timeout,
>>> +                                     int err)
>>> +{
>>> +     struct ceph_osd_request *req, *n;
>>> +     const unsigned long cutoff = jiffies - timeout;
>>> +
>>> +     rbtree_postorder_for_each_entry_safe(req, n, &osd->o_requests, r_node) {
>>> +             complete_osd_stuck_request(req, cutoff, -EIO);
>>> +     }
>>> +}
>>> +
>>> +/*
>>> + * Timeout callback, called every N seconds. When 1 or more OSD
>>> + * requests that has been active for more than N seconds,
>>> + * we complete it with error EIO.
>>> + */
>>> +static void handle_osd_request_timeout(struct work_struct *work)
>>> +{
>>> +     struct ceph_osd_client *osdc =
>>> +             container_of(work, struct ceph_osd_client,
>>> +                          osd_request_timeout_work.work);
>>> +     struct ceph_osd *osd, *n;
>>> +     struct ceph_options *opts = osdc->client->options;
>>> +     const unsigned long timeout = opts->osd_request_timeout;
>>> +
>>> +     dout("%s osdc %p\n", __func__, osdc);
>>> +
>>> +     if (!timeout)
>>> +             return;
>>> +
>>> +     down_write(&osdc->lock);
>>> +
>>> +     rbtree_postorder_for_each_entry_safe(osd, n, &osdc->osds, o_node) {
>>> +             complete_osd_stuck_requests(osd, timeout, -EIO);
>>> +     }
>>> +
>>> +     up_write(&osdc->lock);
>>> +
>>> +     if (!atomic_read(&osdc->num_homeless))
>>> +             goto out;
>>> +
>>> +     down_write(&osdc->lock);
>>> +     complete_osd_stuck_requests(&osdc->homeless_osd, timeout, -EIO);
>>> +     up_write(&osdc->lock);
>>> +
>>> +out:
>>> +     schedule_delayed_work(&osdc->osd_request_timeout_work, timeout);
>>> +}
>>> +
>>>   static void handle_osds_timeout(struct work_struct *work)
>>>   {
>>>       struct ceph_osd_client *osdc =
>>> @@ -4091,6 +4160,7 @@ int ceph_osdc_init(struct ceph_osd_client *osdc, struct
>>> ceph_client *client)
>>>       osdc->linger_map_checks = RB_ROOT;
>>>       INIT_DELAYED_WORK(&osdc->timeout_work, handle_timeout);
>>>       INIT_DELAYED_WORK(&osdc->osds_timeout_work, handle_osds_timeout);
>>> +     INIT_DELAYED_WORK(&osdc->osd_request_timeout_work, handle_osd_request_timeout);
>>>
>>>       err = -ENOMEM;
>>>       osdc->osdmap = ceph_osdmap_alloc();
>>> @@ -4120,6 +4190,8 @@ int ceph_osdc_init(struct ceph_osd_client *osdc, struct
>>> ceph_client *client)
>>>                             osdc->client->options->osd_keepalive_timeout);
>>>       schedule_delayed_work(&osdc->osds_timeout_work,
>>>           round_jiffies_relative(osdc->client->options->osd_idle_ttl));
>>> +     schedule_delayed_work(&osdc->osd_request_timeout_work,
>>> +         round_jiffies_relative(osdc->client->options->osd_request_timeout));
>>>
>>>       return 0;
>>>
>>
>> Having a job that has to wake up every second or so isn't ideal. Perhaps
>> you would be better off scheduling the delayed work in the request
>> submission codepath, and only rearm it when the tree isn't empty after
>> calling complete_osd_stuck_requests?
>>
>> Also, I don't see where this job is ever cancelled when the osdc is torn
>> down. That needs to occur or you'll cause a use-after-free oops...
>
> Yeah, there are other bugs here: rbtree_postorder_for_each_entry_safe()
> can't be used because complete_request() calls erase(), etc.  The patch
> I had just piggy-backed on handle_timeout(), which is called every five
> seconds anyway.
>
> Given that there is interest, I think it's worth adding.

Hi Artur,

How about the attached patch?  handle_timeout() is going to iterate
over all but the homeless OSD anyway; all it costs us is a couple of
tests, so I don't think a separate work is needed.

abort_request() is a simple wrapper around complete_request(), making
it safe to call at any time -- replace it with complete_request() for
now if you want to try this out.

Thanks,

                Ilya

--f40304361f38c3844a054865d5cf
Content-Type: text/plain; charset=US-ASCII; name="osd-request-timeout.diff"
Content-Disposition: attachment; filename="osd-request-timeout.diff"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_iz3vpe5j0

ZGlmZiAtLWdpdCBhL2luY2x1ZGUvbGludXgvY2VwaC9saWJjZXBoLmggYi9pbmNsdWRlL2xpbnV4
L2NlcGgvbGliY2VwaC5oCmluZGV4IDE4MTZjNWUyNjU4MS4uODhjZDVkYzhlMjM4IDEwMDY0NAot
LS0gYS9pbmNsdWRlL2xpbnV4L2NlcGgvbGliY2VwaC5oCisrKyBiL2luY2x1ZGUvbGludXgvY2Vw
aC9saWJjZXBoLmgKQEAgLTQ4LDYgKzQ4LDcgQEAgc3RydWN0IGNlcGhfb3B0aW9ucyB7CiAJdW5z
aWduZWQgbG9uZyBtb3VudF90aW1lb3V0OwkJLyogamlmZmllcyAqLwogCXVuc2lnbmVkIGxvbmcg
b3NkX2lkbGVfdHRsOwkJLyogamlmZmllcyAqLwogCXVuc2lnbmVkIGxvbmcgb3NkX2tlZXBhbGl2
ZV90aW1lb3V0OwkvKiBqaWZmaWVzICovCisJdW5zaWduZWQgbG9uZyBvc2RfcmVxdWVzdF90aW1l
b3V0OwkvKiBqaWZmaWVzICovCiAKIAkvKgogCSAqIGFueSB0eXBlIHRoYXQgY2FuJ3QgYmUgc2lt
cGx5IGNvbXBhcmVkIG9yIGRvZXNuJ3QgbmVlZCBuZWVkCkBAIC02OCw2ICs2OSw3IEBAIHN0cnVj
dCBjZXBoX29wdGlvbnMgewogI2RlZmluZSBDRVBIX01PVU5UX1RJTUVPVVRfREVGQVVMVAltc2Vj
c190b19qaWZmaWVzKDYwICogMTAwMCkKICNkZWZpbmUgQ0VQSF9PU0RfS0VFUEFMSVZFX0RFRkFV
TFQJbXNlY3NfdG9famlmZmllcyg1ICogMTAwMCkKICNkZWZpbmUgQ0VQSF9PU0RfSURMRV9UVExf
REVGQVVMVAltc2Vjc190b19qaWZmaWVzKDYwICogMTAwMCkKKyNkZWZpbmUgQ0VQSF9PU0RfUkVR
VUVTVF9USU1FT1VUX0RFRkFVTFQgMCAgLyogbm8gdGltZW91dCAqLwogCiAjZGVmaW5lIENFUEhf
TU9OQ19IVU5UX0lOVEVSVkFMCQltc2Vjc190b19qaWZmaWVzKDMgKiAxMDAwKQogI2RlZmluZSBD
RVBIX01PTkNfUElOR19JTlRFUlZBTAkJbXNlY3NfdG9famlmZmllcygxMCAqIDEwMDApCmRpZmYg
LS1naXQgYS9pbmNsdWRlL2xpbnV4L2NlcGgvb3NkX2NsaWVudC5oIGIvaW5jbHVkZS9saW51eC9j
ZXBoL29zZF9jbGllbnQuaAppbmRleCAwM2E2NjUzZDMyOWEuLjRkYjAzMWRkNzQ4ZCAxMDA2NDQK
LS0tIGEvaW5jbHVkZS9saW51eC9jZXBoL29zZF9jbGllbnQuaAorKysgYi9pbmNsdWRlL2xpbnV4
L2NlcGgvb3NkX2NsaWVudC5oCkBAIC0xOTMsNiArMTkzLDcgQEAgc3RydWN0IGNlcGhfb3NkX3Jl
cXVlc3QgewogCiAJLyogaW50ZXJuYWwgKi8KIAl1bnNpZ25lZCBsb25nIHJfc3RhbXA7ICAgICAg
ICAgICAgICAgIC8qIGppZmZpZXMsIHNlbmQgb3IgY2hlY2sgdGltZSAqLworCXVuc2lnbmVkIGxv
bmcgcl9zdGFydF9zdGFtcDsgICAgICAgICAgLyogamlmZmllcyAqLwogCWludCByX2F0dGVtcHRz
OwogCXN0cnVjdCBjZXBoX2V2ZXJzaW9uIHJfcmVwbGF5X3ZlcnNpb247IC8qIGFrYSByZWFzc2Vy
dF92ZXJzaW9uICovCiAJdTMyIHJfbGFzdF9mb3JjZV9yZXNlbmQ7CmRpZmYgLS1naXQgYS9uZXQv
Y2VwaC9jZXBoX2NvbW1vbi5jIGIvbmV0L2NlcGgvY2VwaF9jb21tb24uYwppbmRleCA0NjRlODg1
OTliOWQuLjEwODUzMzg1OWE1MyAxMDA2NDQKLS0tIGEvbmV0L2NlcGgvY2VwaF9jb21tb24uYwor
KysgYi9uZXQvY2VwaC9jZXBoX2NvbW1vbi5jCkBAIC0yMzAsNiArMjMwLDcgQEAgZW51bSB7CiAJ
T3B0X29zZGtlZXBhbGl2ZXRpbWVvdXQsCiAJT3B0X21vdW50X3RpbWVvdXQsCiAJT3B0X29zZF9p
ZGxlX3R0bCwKKwlPcHRfb3NkX3JlcXVlc3RfdGltZW91dCwKIAlPcHRfbGFzdF9pbnQsCiAJLyog
aW50IGFyZ3MgYWJvdmUgKi8KIAlPcHRfZnNpZCwKQEAgLTI1Niw2ICsyNTcsNyBAQCBzdGF0aWMg
bWF0Y2hfdGFibGVfdCBvcHRfdG9rZW5zID0gewogCXtPcHRfb3Nka2VlcGFsaXZldGltZW91dCwg
Im9zZGtlZXBhbGl2ZT0lZCJ9LAogCXtPcHRfbW91bnRfdGltZW91dCwgIm1vdW50X3RpbWVvdXQ9
JWQifSwKIAl7T3B0X29zZF9pZGxlX3R0bCwgIm9zZF9pZGxlX3R0bD0lZCJ9LAorCXtPcHRfb3Nk
X3JlcXVlc3RfdGltZW91dCwgIm9zZF9yZXF1ZXN0X3RpbWVvdXQ9JWQifSwKIAkvKiBpbnQgYXJn
cyBhYm92ZSAqLwogCXtPcHRfZnNpZCwgImZzaWQ9JXMifSwKIAl7T3B0X25hbWUsICJuYW1lPSVz
In0sCkBAIC0zNjEsNiArMzYzLDcgQEAgY2VwaF9wYXJzZV9vcHRpb25zKGNoYXIgKm9wdGlvbnMs
IGNvbnN0IGNoYXIgKmRldl9uYW1lLAogCW9wdC0+b3NkX2tlZXBhbGl2ZV90aW1lb3V0ID0gQ0VQ
SF9PU0RfS0VFUEFMSVZFX0RFRkFVTFQ7CiAJb3B0LT5tb3VudF90aW1lb3V0ID0gQ0VQSF9NT1VO
VF9USU1FT1VUX0RFRkFVTFQ7CiAJb3B0LT5vc2RfaWRsZV90dGwgPSBDRVBIX09TRF9JRExFX1RU
TF9ERUZBVUxUOworCW9wdC0+b3NkX3JlcXVlc3RfdGltZW91dCA9IENFUEhfT1NEX1JFUVVFU1Rf
VElNRU9VVF9ERUZBVUxUOwogCiAJLyogZ2V0IG1vbiBpcChzKSAqLwogCS8qIGlwMVs6cG9ydDFd
WyxpcDJbOnBvcnQyXS4uLl0gKi8KQEAgLTQ3Myw2ICs0NzYsMTUgQEAgY2VwaF9wYXJzZV9vcHRp
b25zKGNoYXIgKm9wdGlvbnMsIGNvbnN0IGNoYXIgKmRldl9uYW1lLAogCQkJfQogCQkJb3B0LT5t
b3VudF90aW1lb3V0ID0gbXNlY3NfdG9famlmZmllcyhpbnR2YWwgKiAxMDAwKTsKIAkJCWJyZWFr
OworCQljYXNlIE9wdF9vc2RfcmVxdWVzdF90aW1lb3V0OgorCQkJLyogMCBpcyAid2FpdCBmb3Jl
dmVyIiAoaS5lLiBpbmZpbml0ZSB0aW1lb3V0KSAqLworCQkJaWYgKGludHZhbCA8IDAgfHwgaW50
dmFsID4gSU5UX01BWCAvIDEwMDApIHsKKwkJCQlwcl9lcnIoIm9zZF9yZXF1ZXN0X3RpbWVvdXQg
b3V0IG9mIHJhbmdlXG4iKTsKKwkJCQllcnIgPSAtRUlOVkFMOworCQkJCWdvdG8gb3V0OworCQkJ
fQorCQkJb3B0LT5vc2RfcmVxdWVzdF90aW1lb3V0ID0gbXNlY3NfdG9famlmZmllcyhpbnR2YWwg
KiAxMDAwKTsKKwkJCWJyZWFrOwogCiAJCWNhc2UgT3B0X3NoYXJlOgogCQkJb3B0LT5mbGFncyAm
PSB+Q0VQSF9PUFRfTk9TSEFSRTsKQEAgLTU1Nyw2ICs1NjksOSBAQCBpbnQgY2VwaF9wcmludF9j
bGllbnRfb3B0aW9ucyhzdHJ1Y3Qgc2VxX2ZpbGUgKm0sIHN0cnVjdCBjZXBoX2NsaWVudCAqY2xp
ZW50KQogCWlmIChvcHQtPm9zZF9rZWVwYWxpdmVfdGltZW91dCAhPSBDRVBIX09TRF9LRUVQQUxJ
VkVfREVGQVVMVCkKIAkJc2VxX3ByaW50ZihtLCAib3Nka2VlcGFsaXZldGltZW91dD0lZCwiLAog
CQkgICAgamlmZmllc190b19tc2VjcyhvcHQtPm9zZF9rZWVwYWxpdmVfdGltZW91dCkgLyAxMDAw
KTsKKwlpZiAob3B0LT5vc2RfcmVxdWVzdF90aW1lb3V0ICE9IENFUEhfT1NEX1JFUVVFU1RfVElN
RU9VVF9ERUZBVUxUKQorCQlzZXFfcHJpbnRmKG0sICJvc2RfcmVxdWVzdF90aW1lb3V0PSVkLCIs
CisJCQkgICBqaWZmaWVzX3RvX21zZWNzKG9wdC0+b3NkX3JlcXVlc3RfdGltZW91dCkgLyAxMDAw
KTsKIAogCS8qIGRyb3AgcmVkdW5kYW50IGNvbW1hICovCiAJaWYgKG0tPmNvdW50ICE9IHBvcykK
ZGlmZiAtLWdpdCBhL25ldC9jZXBoL29zZF9jbGllbnQuYyBiL25ldC9jZXBoL29zZF9jbGllbnQu
YwppbmRleCBiOGRhNDI3OWU3NDUuLjFkNTgwNTMwYzcwMCAxMDA2NDQKLS0tIGEvbmV0L2NlcGgv
b3NkX2NsaWVudC5jCisrKyBiL25ldC9jZXBoL29zZF9jbGllbnQuYwpAQCAtMTcxNyw2ICsxNzE3
LDggQEAgc3RhdGljIHZvaWQgYWNjb3VudF9yZXF1ZXN0KHN0cnVjdCBjZXBoX29zZF9yZXF1ZXN0
ICpyZXEpCiAKIAlXQVJOX09OKHJlcS0+cl91bnNhZmVfY2FsbGJhY2sgJiYgKHJlcS0+cl9mbGFn
cyAmIG1hc2spICE9IG1hc2spOwogCWF0b21pY19pbmMoJnJlcS0+cl9vc2RjLT5udW1fcmVxdWVz
dHMpOworCisJcmVxLT5yX3N0YXJ0X3N0YW1wID0gamlmZmllczsKIH0KIAogc3RhdGljIHZvaWQg
c3VibWl0X3JlcXVlc3Qoc3RydWN0IGNlcGhfb3NkX3JlcXVlc3QgKnJlcSwgYm9vbCB3cmxvY2tl
ZCkKQEAgLTI1MDQsNiArMjUwNiw3IEBAIHN0YXRpYyB2b2lkIGhhbmRsZV90aW1lb3V0KHN0cnVj
dCB3b3JrX3N0cnVjdCAqd29yaykKIAkJY29udGFpbmVyX29mKHdvcmssIHN0cnVjdCBjZXBoX29z
ZF9jbGllbnQsIHRpbWVvdXRfd29yay53b3JrKTsKIAlzdHJ1Y3QgY2VwaF9vcHRpb25zICpvcHRz
ID0gb3NkYy0+Y2xpZW50LT5vcHRpb25zOwogCXVuc2lnbmVkIGxvbmcgY3V0b2ZmID0gamlmZmll
cyAtIG9wdHMtPm9zZF9rZWVwYWxpdmVfdGltZW91dDsKKwl1bnNpZ25lZCBsb25nIGV4cGlyeV9j
dXRvZmYgPSBqaWZmaWVzIC0gb3B0cy0+b3NkX3JlcXVlc3RfdGltZW91dDsKIAlMSVNUX0hFQUQo
c2xvd19vc2RzKTsKIAlzdHJ1Y3QgcmJfbm9kZSAqbiwgKnA7CiAKQEAgLTI1MTksMTUgKzI1MjIs
MjMgQEAgc3RhdGljIHZvaWQgaGFuZGxlX3RpbWVvdXQoc3RydWN0IHdvcmtfc3RydWN0ICp3b3Jr
KQogCQlzdHJ1Y3QgY2VwaF9vc2QgKm9zZCA9IHJiX2VudHJ5KG4sIHN0cnVjdCBjZXBoX29zZCwg
b19ub2RlKTsKIAkJYm9vbCBmb3VuZCA9IGZhbHNlOwogCi0JCWZvciAocCA9IHJiX2ZpcnN0KCZv
c2QtPm9fcmVxdWVzdHMpOyBwOyBwID0gcmJfbmV4dChwKSkgeworCQlmb3IgKHAgPSByYl9maXJz
dCgmb3NkLT5vX3JlcXVlc3RzKTsgcDsgKSB7CiAJCQlzdHJ1Y3QgY2VwaF9vc2RfcmVxdWVzdCAq
cmVxID0KIAkJCSAgICByYl9lbnRyeShwLCBzdHJ1Y3QgY2VwaF9vc2RfcmVxdWVzdCwgcl9ub2Rl
KTsKIAorCQkJcCA9IHJiX25leHQocCk7IC8qIGFib3J0X3JlcXVlc3QoKSAqLworCiAJCQlpZiAo
dGltZV9iZWZvcmUocmVxLT5yX3N0YW1wLCBjdXRvZmYpKSB7CiAJCQkJZG91dCgiIHJlcSAlcCB0
aWQgJWxsdSBvbiBvc2QlZCBpcyBsYWdneVxuIiwKIAkJCQkgICAgIHJlcSwgcmVxLT5yX3RpZCwg
b3NkLT5vX29zZCk7CiAJCQkJZm91bmQgPSB0cnVlOwogCQkJfQorCQkJaWYgKG9wdHMtPm9zZF9y
ZXF1ZXN0X3RpbWVvdXQgJiYKKwkJCSAgICB0aW1lX2JlZm9yZShyZXEtPnJfc3RhcnRfc3RhbXAs
IGV4cGlyeV9jdXRvZmYpKSB7CisJCQkJcHJfZXJyX3JhdGVsaW1pdGVkKCJ0aWQgJWxsdSBvbiBv
c2QlZCB0aW1lb3V0XG4iLAorCQkJCSAgICAgICByZXEtPnJfdGlkLCBvc2QtPm9fb3NkKTsKKwkJ
CQlhYm9ydF9yZXF1ZXN0KHJlcSwgLUVUSU1FRE9VVCk7CisJCQl9CiAJCX0KIAkJZm9yIChwID0g
cmJfZmlyc3QoJm9zZC0+b19saW5nZXJfcmVxdWVzdHMpOyBwOyBwID0gcmJfbmV4dChwKSkgewog
CQkJc3RydWN0IGNlcGhfb3NkX2xpbmdlcl9yZXF1ZXN0ICpscmVxID0KQEAgLTI1NDcsNiArMjU1
OCwyMSBAQCBzdGF0aWMgdm9pZCBoYW5kbGVfdGltZW91dChzdHJ1Y3Qgd29ya19zdHJ1Y3QgKndv
cmspCiAJCQlsaXN0X21vdmVfdGFpbCgmb3NkLT5vX2tlZXBhbGl2ZV9pdGVtLCAmc2xvd19vc2Rz
KTsKIAl9CiAKKwlpZiAob3B0cy0+b3NkX3JlcXVlc3RfdGltZW91dCkgeworCQlmb3IgKHAgPSBy
Yl9maXJzdCgmb3NkYy0+aG9tZWxlc3Nfb3NkLm9fcmVxdWVzdHMpOyBwOyApIHsKKwkJCXN0cnVj
dCBjZXBoX29zZF9yZXF1ZXN0ICpyZXEgPQorCQkJICAgIHJiX2VudHJ5KHAsIHN0cnVjdCBjZXBo
X29zZF9yZXF1ZXN0LCByX25vZGUpOworCisJCQlwID0gcmJfbmV4dChwKTsgLyogYWJvcnRfcmVx
dWVzdCgpICovCisKKwkJCWlmICh0aW1lX2JlZm9yZShyZXEtPnJfc3RhcnRfc3RhbXAsIGV4cGly
eV9jdXRvZmYpKSB7CisJCQkJcHJfZXJyX3JhdGVsaW1pdGVkKCJ0aWQgJWxsdSBvbiBvc2QlZCB0
aW1lb3V0XG4iLAorCQkJCSAgICAgICByZXEtPnJfdGlkLCBvc2RjLT5ob21lbGVzc19vc2Qub19v
c2QpOworCQkJCWFib3J0X3JlcXVlc3QocmVxLCAtRVRJTUVET1VUKTsKKwkJCX0KKwkJfQorCX0K
KwogCWlmIChhdG9taWNfcmVhZCgmb3NkYy0+bnVtX2hvbWVsZXNzKSB8fCAhbGlzdF9lbXB0eSgm
c2xvd19vc2RzKSkKIAkJbWF5YmVfcmVxdWVzdF9tYXAob3NkYyk7CiAK
--f40304361f38c3844a054865d5cf--
