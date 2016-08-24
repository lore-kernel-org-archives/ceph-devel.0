From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH 02/16] libceph: support for CEPH_OSD_OP_LIST_WATCHERS
Date: Wed, 24 Aug 2016 22:43:16 +0200
Message-ID: <CAOi1vP96bJsckQUXv1u-yGoUvykVpVMcT0dVJJFz7rxXTDcnuQ@mail.gmail.com>
References: <1472044720-29116-1-git-send-email-idryomov@gmail.com>
 <1472044720-29116-3-git-send-email-idryomov@gmail.com> <1ca34767-935f-30d8-1da4-bd42d27855a8@ieee.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f195.google.com ([209.85.217.195]:36614 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S932864AbcHXUnR (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 24 Aug 2016 16:43:17 -0400
Received: by mail-ua0-f195.google.com with SMTP id 74so2231031uau.3
        for <ceph-devel@vger.kernel.org>; Wed, 24 Aug 2016 13:43:17 -0700 (PDT)
In-Reply-To: <1ca34767-935f-30d8-1da4-bd42d27855a8@ieee.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@ieee.org>
Cc: Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Aug 24, 2016 at 9:29 PM, Alex Elder <elder@ieee.org> wrote:
> On 08/24/2016 08:18 AM, Ilya Dryomov wrote:
>> From: Douglas Fuller <dfuller@redhat.com>
>>
>> Add support for this Ceph OSD op, needed to support the RBD exclusive
>> lock feature.
>
> It would be nice to provide a short description of the op, or
> maybe a reference to something that explains what it is for.

Well, it's kind of self-explanatory, especially if you look at the
signature of ceph_osdc_list_watchers(): it returns a list of watchers
(watchers, num_watchers) for a given RADOS object (oid, oloc).

>
> I have a couple comments below.  I'm continuing to review the
> code that I see without having a solid knowledge of how
> things are supposed to work and what the other end does.
>
> I do have suggestions, but I don't really see anything
> wrong with this code.
>
> Reviewed-by: Alex Elder <elder@linaro.org>
>
>> Signed-off-by: Douglas Fuller <dfuller@redhat.com>
>> [idryomov@gmail.com: refactor, misc fixes throughout]
>> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>
>> ---
>>  include/linux/ceph/osd_client.h |  15 +++++-
>>  net/ceph/osd_client.c           | 117 ++++++++++++++++++++++++++++++++++++++++
>>  2 files changed, 131 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
>> index 858932304260..19821a191732 100644
>> --- a/include/linux/ceph/osd_client.h
>> +++ b/include/linux/ceph/osd_client.h
>> @@ -121,6 +121,9 @@ struct ceph_osd_req_op {
>>                       struct ceph_osd_data response_data;
>>               } notify;
>>               struct {
>> +                     struct ceph_osd_data response_data;
>> +             } list_watchers;
>> +             struct {
>>                       u64 expected_object_size;
>>                       u64 expected_write_size;
>>               } alloc_hint;
>> @@ -249,6 +252,12 @@ struct ceph_osd_linger_request {
>>       size_t *preply_len;
>>  };
>>
>> +struct ceph_watch_item {
>> +     struct ceph_entity_name name;
>> +     u64 cookie;
>> +     struct ceph_entity_addr addr;
>> +};
>> +
>>  struct ceph_osd_client {
>>       struct ceph_client     *client;
>>
>> @@ -346,7 +355,6 @@ extern void osd_req_op_cls_response_data_pages(struct ceph_osd_request *,
>>                                       struct page **pages, u64 length,
>>                                       u32 alignment, bool pages_from_pool,
>>                                       bool own_pages);
>> -
>>  extern void osd_req_op_cls_init(struct ceph_osd_request *osd_req,
>>                                       unsigned int which, u16 opcode,
>>                                       const char *class, const char *method);
>> @@ -434,5 +442,10 @@ int ceph_osdc_notify(struct ceph_osd_client *osdc,
>>                    size_t *preply_len);
>>  int ceph_osdc_watch_check(struct ceph_osd_client *osdc,
>>                         struct ceph_osd_linger_request *lreq);
>> +int ceph_osdc_list_watchers(struct ceph_osd_client *osdc,
>> +                         struct ceph_object_id *oid,
>> +                         struct ceph_object_locator *oloc,
>> +                         struct ceph_watch_item **watchers,
>> +                         u32 *num_watchers);
>>  #endif
>>
>> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
>> index a97e7b506612..dd51ec8ce97f 100644
>> --- a/net/ceph/osd_client.c
>> +++ b/net/ceph/osd_client.c
>> @@ -338,6 +338,9 @@ static void osd_req_op_data_release(struct ceph_osd_request *osd_req,
>>               ceph_osd_data_release(&op->notify.request_data);
>>               ceph_osd_data_release(&op->notify.response_data);
>>               break;
>> +     case CEPH_OSD_OP_LIST_WATCHERS:
>> +             ceph_osd_data_release(&op->list_watchers.response_data);
>> +             break;
>>       default:
>>               break;
>>       }
>> @@ -863,6 +866,8 @@ static u32 osd_req_encode_op(struct ceph_osd_op *dst,
>>       case CEPH_OSD_OP_NOTIFY:
>>               dst->notify.cookie = cpu_to_le64(src->notify.cookie);
>>               break;
>> +     case CEPH_OSD_OP_LIST_WATCHERS:
>> +             break;
>>       case CEPH_OSD_OP_SETALLOCHINT:
>>               dst->alloc_hint.expected_object_size =
>>                   cpu_to_le64(src->alloc_hint.expected_object_size);
>> @@ -1445,6 +1450,10 @@ static void setup_request_data(struct ceph_osd_request *req,
>>                       ceph_osdc_msg_data_add(req->r_reply,
>>                                              &op->extent.osd_data);
>>                       break;
>> +             case CEPH_OSD_OP_LIST_WATCHERS:
>> +                     ceph_osdc_msg_data_add(req->r_reply,
>> +                                            &op->list_watchers.response_data);
>> +                     break;
>>
>>               /* both */
>>               case CEPH_OSD_OP_CALL:
>> @@ -3891,6 +3900,114 @@ int ceph_osdc_watch_check(struct ceph_osd_client *osdc,
>>       return ret;
>>  }
>>
>> +static int decode_watcher(void **p, void *end, struct ceph_watch_item *item)
>> +{
>> +     u8 struct_v;
>> +     u32 struct_len;
>> +     int ret;
>> +
>> +     ret = ceph_start_decoding(p, end, 2, "watch_item_t",
>> +                               &struct_v, &struct_len);
>> +     if (ret)
>> +             return ret;
>> +
>> +     ceph_decode_copy(p, &item->name, sizeof(item->name));
>> +     item->cookie = ceph_decode_64(p);
>> +     *p += 4; /* skip timeout_seconds */
>> +     if (struct_v >= 2) {
>> +             ceph_decode_copy(p, &item->addr, sizeof(item->addr));
>> +             ceph_decode_addr(&item->addr);
>
> ceph_decode_addr() is a little ugly in how it swaps between
> wire (little-endian) byte order and native byte order in the

It doesn't matter here, but wire is big-endian in this case.

> same underlying sockaddr_storage structure.  Why isn't
> ceph_decode_addr() more like, for example, ceph_decode_timespec()?

I suppose because only the address family field needs to be swapped.
It goes way back - you would need to ask Sage ;)

>
>
>> +     }
>> +
>> +     dout("%s %s%llu cookie %llu addr %s\n", __func__,
>> +          ENTITY_NAME(item->name), item->cookie,
>> +          ceph_pr_addr(&item->addr.in_addr));
>> +     return 0;
>> +}
>> +
>> +static int decode_watchers(void **p, void *end,
>> +                        struct ceph_watch_item **watchers,
>> +                        u32 *num_watchers)
>> +{
>> +     u8 struct_v;
>> +     u32 struct_len;
>> +     int i;
>> +     int ret;
>> +
>> +     ret = ceph_start_decoding(p, end, 1, "obj_list_watch_response_t",
>> +                               &struct_v, &struct_len);
>> +     if (ret)
>> +             return ret;
>> +
>> +     *num_watchers = ceph_decode_32(p);
>> +     *watchers = kcalloc(*num_watchers, sizeof(**watchers), GFP_NOIO);
>> +     if (!*watchers)
>> +             return -ENOMEM;
>> +
>> +     for (i = 0; i < *num_watchers; i++) {
>> +             ret = decode_watcher(p, end, *watchers + i);
>> +             if (ret) {
>> +                     kfree(*watchers);
>
>                         *watchers = NULL;
>
>> +                     return ret;
>> +             }
>> +     }
>> +
>> +     return 0;
>> +}
>> +
>> +/*
>> + * On success, the caller is responsible for:
>> + *
>> + *     kfree(watchers);
>> + */
>> +int ceph_osdc_list_watchers(struct ceph_osd_client *osdc,
>> +                         struct ceph_object_id *oid,
>> +                         struct ceph_object_locator *oloc,
>> +                         struct ceph_watch_item **watchers,
>> +                         u32 *num_watchers)
>> +{
>> +     struct ceph_osd_request *req;
>> +     struct page **pages;
>> +     int ret;
>> +
>> +     req = ceph_osdc_alloc_request(osdc, NULL, 1, false, GFP_NOIO);
>> +     if (!req)
>> +             return -ENOMEM;
>> +
>> +     ceph_oid_copy(&req->r_base_oid, oid);
>> +     ceph_oloc_copy(&req->r_base_oloc, oloc);
>> +     req->r_flags = CEPH_OSD_FLAG_READ;
>> +
>> +     ret = ceph_osdc_alloc_messages(req, GFP_NOIO);
>> +     if (ret)
>> +             goto out_put_req;
>> +
>> +     pages = ceph_alloc_page_vector(1, GFP_NOIO);
>
> Is there anything that guarantees that the number of watchers
> is such that the response will always fit in a single page?
> Will the response contain an error in that case?

The libceph messenger will drop the reply on the floor.  It's an
annoying problem with the current reply buffer preallocation scheme
that pops up all over the codebase, high on my list of things to fix.

On a practical note, I can't think of a use case with more than
a couple of watchers.  This is _exclusive_ lock, after all...

Thanks,

                Ilya
