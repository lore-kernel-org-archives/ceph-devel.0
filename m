From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH v8 4/7] libceph: add an epoch_barrier field to struct ceph_osd_client
Date: Tue, 18 Apr 2017 15:09:48 +0200
Message-ID: <CAOi1vP_-uj3xAFqhQ_Lew5c=Ud6PtA02yxfND=rdXOit-48hZA@mail.gmail.com>
References: <20170417164258.31527-1-jlayton@redhat.com> <20170417164258.31527-5-jlayton@redhat.com>
 <1492517978.10210.3.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ua0-f195.google.com ([209.85.217.195]:35265 "EHLO
        mail-ua0-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751197AbdDRNJt (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 18 Apr 2017 09:09:49 -0400
Received: by mail-ua0-f195.google.com with SMTP id j59so445393uad.2
        for <ceph-devel@vger.kernel.org>; Tue, 18 Apr 2017 06:09:49 -0700 (PDT)
In-Reply-To: <1492517978.10210.3.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Tue, Apr 18, 2017 at 2:19 PM, Jeff Layton <jlayton@redhat.com> wrote:
> On Mon, 2017-04-17 at 12:42 -0400, Jeff Layton wrote:
>> Cephfs can get cap update requests that contain a new epoch barrier in
>> them. When that happens we want to pause all OSD traffic until the right
>> map epoch arrives.
>>
>> Add an epoch_barrier field to ceph_osd_client that is protected by the
>> osdc->lock rwsem. When the barrier is set, and the current OSD map
>> epoch is below that, pause the request target when submitting the
>> request or when revisiting it. Add a way for upper layers (cephfs)
>> to update the epoch_barrier as well.
>>
>> If we get a new map, compare the new epoch against the barrier before
>> kicking requests and request another map if the map epoch is still lower
>> than the one we want.
>>
>> If we get a map with a full pool, or at quota condition, then set the
>> barrier to the current epoch value.
>>
>> Reviewed-by: "Yan, Zheng=E2=80=9D <zyan@redhat.com>
>> Signed-off-by: Jeff Layton <jlayton@redhat.com>
>> Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
>> ---
>>  include/linux/ceph/osd_client.h |  2 ++
>>  net/ceph/debugfs.c              |  3 +-
>>  net/ceph/osd_client.c           | 76 ++++++++++++++++++++++++++++++++++=
++-----
>>  3 files changed, 72 insertions(+), 9 deletions(-)
>>
>> diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_cl=
ient.h
>> index 8cf644197b1a..85650b415e73 100644
>> --- a/include/linux/ceph/osd_client.h
>> +++ b/include/linux/ceph/osd_client.h
>> @@ -267,6 +267,7 @@ struct ceph_osd_client {
>>       struct rb_root         osds;          /* osds */
>>       struct list_head       osd_lru;       /* idle osds */
>>       spinlock_t             osd_lru_lock;
>> +     u32                    epoch_barrier;
>>       struct ceph_osd        homeless_osd;
>>       atomic64_t             last_tid;      /* tid of last request */
>>       u64                    last_linger_id;
>> @@ -305,6 +306,7 @@ extern void ceph_osdc_handle_reply(struct ceph_osd_c=
lient *osdc,
>>                                  struct ceph_msg *msg);
>>  extern void ceph_osdc_handle_map(struct ceph_osd_client *osdc,
>>                                struct ceph_msg *msg);
>> +void ceph_osdc_update_epoch_barrier(struct ceph_osd_client *osdc, u32 e=
b);
>>
>>  extern void osd_req_op_init(struct ceph_osd_request *osd_req,
>>                           unsigned int which, u16 opcode, u32 flags);
>> diff --git a/net/ceph/debugfs.c b/net/ceph/debugfs.c
>> index d7e63a4f5578..71ba13927b3d 100644
>> --- a/net/ceph/debugfs.c
>> +++ b/net/ceph/debugfs.c
>> @@ -62,7 +62,8 @@ static int osdmap_show(struct seq_file *s, void *p)
>>               return 0;
>>
>>       down_read(&osdc->lock);
>> -     seq_printf(s, "epoch %d flags 0x%x\n", map->epoch, map->flags);
>> +     seq_printf(s, "epoch %u barrier %u flags 0x%x\n", map->epoch,
>> +                     osdc->epoch_barrier, map->flags);
>>
>>       for (n =3D rb_first(&map->pg_pools); n; n =3D rb_next(n)) {
>>               struct ceph_pg_pool_info *pi =3D
>> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
>> index 55b7585ccefd..beeac4f39aa5 100644
>> --- a/net/ceph/osd_client.c
>> +++ b/net/ceph/osd_client.c
>> @@ -1298,8 +1298,9 @@ static bool target_should_be_paused(struct ceph_os=
d_client *osdc,
>>                      __pool_full(pi);
>>
>>       WARN_ON(pi->id !=3D t->base_oloc.pool);
>> -     return (t->flags & CEPH_OSD_FLAG_READ && pauserd) ||
>> -            (t->flags & CEPH_OSD_FLAG_WRITE && pausewr);
>> +     return ((t->flags & CEPH_OSD_FLAG_READ) && pauserd) ||
>> +            ((t->flags & CEPH_OSD_FLAG_WRITE) && pausewr) ||
>> +            (osdc->osdmap->epoch < osdc->epoch_barrier);
>>  }
>>
>>  enum calc_target_result {
>> @@ -1654,8 +1655,13 @@ static void __submit_request(struct ceph_osd_requ=
est *req, bool wrlocked)
>>               goto promote;
>>       }
>>
>> -     if ((req->r_flags & CEPH_OSD_FLAG_WRITE) &&
>> -         ceph_osdmap_flag(osdc, CEPH_OSDMAP_PAUSEWR)) {
>> +     if (osdc->osdmap->epoch < osdc->epoch_barrier) {
>> +             dout("req %p epoch %u barrier %u\n", req, osdc->osdmap->ep=
och,
>> +                  osdc->epoch_barrier);
>> +             req->r_t.paused =3D true;
>> +             maybe_request_map(osdc);
>> +     } else if ((req->r_flags & CEPH_OSD_FLAG_WRITE) &&
>> +                ceph_osdmap_flag(osdc, CEPH_OSDMAP_PAUSEWR)) {
>>               dout("req %p pausewr\n", req);
>>               req->r_t.paused =3D true;
>>               maybe_request_map(osdc);
>> @@ -1809,17 +1815,48 @@ static void abort_request(struct ceph_osd_reques=
t *req, int err)
>>
>>  /*
>>   * Drop all pending requests that are stalled waiting on a full conditi=
on to
>> - * clear, and complete them with ENOSPC as the return code.
>> + * clear, and complete them with ENOSPC as the return code. Set the
>> + * osdc->epoch_barrier to the latest map epoch that we've seen if any w=
ere
>> + * cancelled.
>>   */
>>  static void ceph_osdc_abort_on_full(struct ceph_osd_client *osdc)
>>  {
>>       struct rb_node *n;
>> +     bool victims =3D false;
>>
>>       dout("enter abort_on_full\n");
>>
>>       if (!ceph_osdmap_flag(osdc, CEPH_OSDMAP_FULL) && !have_pool_full(o=
sdc))
>>               goto out;
>>
>> +     /* Scan list and see if there is anything to abort */
>> +     for (n =3D rb_first(&osdc->osds); n; n =3D rb_next(n)) {
>> +             struct ceph_osd *osd =3D rb_entry(n, struct ceph_osd, o_no=
de);
>> +             struct rb_node *m;
>> +
>> +             m =3D rb_first(&osd->o_requests);
>> +             while (m) {
>> +                     struct ceph_osd_request *req =3D rb_entry(m,
>> +                                     struct ceph_osd_request, r_node);
>> +                     m =3D rb_next(m);
>> +
>> +                     if (req->r_abort_on_full) {
>> +                             victims =3D true;
>> +                             break;
>> +                     }
>> +             }
>> +             if (victims)
>> +                     break;
>> +     }
>> +
>> +     if (!victims)
>> +             goto out;
>> +
>> +     /*
>> +      * Update the barrier to current epoch since we know we have some
>> +      * calls to be aborted in the tree.
>> +      */
>> +     osdc->epoch_barrier =3D osdc->osdmap->epoch;
>
> Erm...now that I think about it even more...
>
> Is it possible we can end up with the eb going backward here? Suppose
> we get a MDS cap message with a later epoch barrier, and then a map
> update that is not quite to the barrier yet.
>
> I think we probably want to only set it if it's newer than what's
> there. So this should probably read something like:
>
>         if (osdc->osdmap->epoch > osdc->epoch_barrier)
>                 osdc->epoch_barrier =3D osdc->osdmap->epoch;
>
> If no one objects, I'll go ahead and make this change in the testing
> branch without a full re-post to the list.

I'd wrap

    if (likely(eb > osdc->epoch_barrier)) {
            dout("updating epoch_barrier from %u to %u\n",
                            osdc->epoch_barrier, eb);
            osdc->epoch_barrier =3D eb;
            /* Request map if we're not to the barrier yet */
            if (eb > osdc->osdmap->epoch)
                    maybe_request_map(osdc);
    }

from ceph_osdc_update_epoch_barrier() into update_epoch_barrier() and
call it from here.

Thanks,

                Ilya
