From: Ilya Dryomov <idryomov@gmail.com>
Subject: Re: [PATCH v6 4/7] libceph: add an epoch_barrier field to struct ceph_osd_client
Date: Thu, 6 Apr 2017 11:17:36 +0200
Message-ID: <CAOi1vP-=w1XCDPTVRKfZ=cuqW+RRF+JpLkBiaiMk0B0zDqDYEQ@mail.gmail.com>
References: <20170330180546.11021-1-jlayton@redhat.com> <20170330180707.11137-1-jlayton@redhat.com>
 <20170330180707.11137-4-jlayton@redhat.com> <CAOi1vP-ReH9vVktm=ZhegLouhrxV0qYy=mgt6tYGhUZ=p11i=g@mail.gmail.com>
 <1491323678.309.3.camel@redhat.com> <CAOi1vP_mk7XojSNu7Jmp1uW7RvfrhN+Y=94xUD1D6z8S1stmkA@mail.gmail.com>
 <1491340330.11822.3.camel@redhat.com> <CAOi1vP-kyYP5sv6rCe=wnxWjHd+AXNY76WBZ8He1tdwXa8gEhQ@mail.gmail.com>
 <1491398979.18658.3.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-vk0-f67.google.com ([209.85.213.67]:34851 "EHLO
        mail-vk0-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1756795AbdDFJR7 (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Thu, 6 Apr 2017 05:17:59 -0400
Received: by mail-vk0-f67.google.com with SMTP id z204so4251181vkd.2
        for <ceph-devel@vger.kernel.org>; Thu, 06 Apr 2017 02:17:58 -0700 (PDT)
In-Reply-To: <1491398979.18658.3.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@redhat.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, John Spray <jspray@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On Wed, Apr 5, 2017 at 3:29 PM, Jeff Layton <jlayton@redhat.com> wrote:
> On Wed, 2017-04-05 at 11:22 +0200, Ilya Dryomov wrote:
>> On Tue, Apr 4, 2017 at 11:12 PM, Jeff Layton <jlayton@redhat.com> wrote:
>> > On Tue, 2017-04-04 at 21:47 +0200, Ilya Dryomov wrote:
>> > > On Tue, Apr 4, 2017 at 6:34 PM, Jeff Layton <jlayton@redhat.com> wro=
te:
>> > > > On Tue, 2017-04-04 at 17:00 +0200, Ilya Dryomov wrote:
>> > > > > On Thu, Mar 30, 2017 at 8:07 PM, Jeff Layton <jlayton@redhat.com=
> wrote:
>> > > > > > Cephfs can get cap update requests that contain a new epoch ba=
rrier in
>> > > > > > them. When that happens we want to pause all OSD traffic until=
 the right
>> > > > > > map epoch arrives.
>> > > > > >
>> > > > > > Add an epoch_barrier field to ceph_osd_client that is protecte=
d by the
>> > > > > > osdc->lock rwsem. When the barrier is set, and the current OSD=
 map
>> > > > > > epoch is below that, pause the request target when submitting =
the
>> > > > > > request or when revisiting it. Add a way for upper layers (cep=
hfs)
>> > > > > > to update the epoch_barrier as well.
>> > > > > >
>> > > > > > If we get a new map, compare the new epoch against the barrier=
 before
>> > > > > > kicking requests and request another map if the map epoch is s=
till lower
>> > > > > > than the one we want.
>> > > > > >
>> > > > > > If we get a map with a full pool, or at quota condition, then =
set the
>> > > > > > barrier to the current epoch value.
>> > > > > >
>> > > > > > Reviewed-by: "Yan, Zheng=E2=80=9D <zyan@redhat.com>
>> > > > > > Signed-off-by: Jeff Layton <jlayton@redhat.com>
>> > > > > > ---
>> > > > > >  include/linux/ceph/osd_client.h |  2 ++
>> > > > > >  net/ceph/debugfs.c              |  3 ++-
>> > > > > >  net/ceph/osd_client.c           | 48 ++++++++++++++++++++++++=
+++++++++--------
>> > > > > >  3 files changed, 43 insertions(+), 10 deletions(-)
>> > > > > >
>> > > > > > diff --git a/include/linux/ceph/osd_client.h b/include/linux/c=
eph/osd_client.h
>> > > > > > index 8cf644197b1a..85650b415e73 100644
>> > > > > > --- a/include/linux/ceph/osd_client.h
>> > > > > > +++ b/include/linux/ceph/osd_client.h
>> > > > > > @@ -267,6 +267,7 @@ struct ceph_osd_client {
>> > > > > >         struct rb_root         osds;          /* osds */
>> > > > > >         struct list_head       osd_lru;       /* idle osds */
>> > > > > >         spinlock_t             osd_lru_lock;
>> > > > > > +       u32                    epoch_barrier;
>> > > > > >         struct ceph_osd        homeless_osd;
>> > > > > >         atomic64_t             last_tid;      /* tid of last r=
equest */
>> > > > > >         u64                    last_linger_id;
>> > > > > > @@ -305,6 +306,7 @@ extern void ceph_osdc_handle_reply(struct =
ceph_osd_client *osdc,
>> > > > > >                                    struct ceph_msg *msg);
>> > > > > >  extern void ceph_osdc_handle_map(struct ceph_osd_client *osdc=
,
>> > > > > >                                  struct ceph_msg *msg);
>> > > > > > +void ceph_osdc_update_epoch_barrier(struct ceph_osd_client *o=
sdc, u32 eb);
>> > > > > >
>> > > > > >  extern void osd_req_op_init(struct ceph_osd_request *osd_req,
>> > > > > >                             unsigned int which, u16 opcode, u3=
2 flags);
>> > > > > > diff --git a/net/ceph/debugfs.c b/net/ceph/debugfs.c
>> > > > > > index d7e63a4f5578..71ba13927b3d 100644
>> > > > > > --- a/net/ceph/debugfs.c
>> > > > > > +++ b/net/ceph/debugfs.c
>> > > > > > @@ -62,7 +62,8 @@ static int osdmap_show(struct seq_file *s, v=
oid *p)
>> > > > > >                 return 0;
>> > > > > >
>> > > > > >         down_read(&osdc->lock);
>> > > > > > -       seq_printf(s, "epoch %d flags 0x%x\n", map->epoch, map=
->flags);
>> > > > > > +       seq_printf(s, "epoch %u barrier %u flags 0x%x\n", map-=
>epoch,
>> > > > > > +                       osdc->epoch_barrier, map->flags);
>> > > > > >
>> > > > > >         for (n =3D rb_first(&map->pg_pools); n; n =3D rb_next(=
n)) {
>> > > > > >                 struct ceph_pg_pool_info *pi =3D
>> > > > > > diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
>> > > > > > index 4e56cd1ec265..3a94e8a1c7ff 100644
>> > > > > > --- a/net/ceph/osd_client.c
>> > > > > > +++ b/net/ceph/osd_client.c
>> > > > > > @@ -1298,8 +1298,9 @@ static bool target_should_be_paused(stru=
ct ceph_osd_client *osdc,
>> > > > > >                        __pool_full(pi);
>> > > > > >
>> > > > > >         WARN_ON(pi->id !=3D t->base_oloc.pool);
>> > > > > > -       return (t->flags & CEPH_OSD_FLAG_READ && pauserd) ||
>> > > > > > -              (t->flags & CEPH_OSD_FLAG_WRITE && pausewr);
>> > > > > > +       return ((t->flags & CEPH_OSD_FLAG_READ) && pauserd) ||
>> > > > > > +              ((t->flags & CEPH_OSD_FLAG_WRITE) && pausewr) |=
|
>> > > > > > +              (osdc->osdmap->epoch < osdc->epoch_barrier);
>> > > > > >  }
>> > > > > >
>> > > > > >  enum calc_target_result {
>> > > > > > @@ -1609,13 +1610,15 @@ static void send_request(struct ceph_o=
sd_request *req)
>> > > > > >  static void maybe_request_map(struct ceph_osd_client *osdc)
>> > > > > >  {
>> > > > > >         bool continuous =3D false;
>> > > > > > +       u32 epoch =3D osdc->osdmap->epoch;
>> > > > > >
>> > > > > >         verify_osdc_locked(osdc);
>> > > > > > -       WARN_ON(!osdc->osdmap->epoch);
>> > > > > > +       WARN_ON_ONCE(epoch =3D=3D 0);
>> > > > > >
>> > > > > >         if (ceph_osdmap_flag(osdc, CEPH_OSDMAP_FULL) ||
>> > > > > >             ceph_osdmap_flag(osdc, CEPH_OSDMAP_PAUSERD) ||
>> > > > > > -           ceph_osdmap_flag(osdc, CEPH_OSDMAP_PAUSEWR)) {
>> > > > > > +           ceph_osdmap_flag(osdc, CEPH_OSDMAP_PAUSEWR) ||
>> > > > > > +           epoch < osdc->epoch_barrier) {
>> > > > > >                 dout("%s osdc %p continuous\n", __func__, osdc=
);
>> > > > > >                 continuous =3D true;
>> > > > > >         } else {
>> > > > >
>> > > > > Looks like this hunk is smaller now, but I thought we agreed to =
drop it
>> > > > > entirely?  "epoch < osdc->epoch_barrier" isn't there in Objecter=
.
>> > > > >
>> > > >
>> > > > I still think if the current map is behind the current barrier val=
ue,
>> > > > then you really do want to request a map. I'm not sure that the ot=
her
>> > > > flags will necessarily be set in that case, will they?
>> > >
>> > > We do that from ceph_osdc_handle_map(), on every new map.  That shou=
ld
>> > > be good enough -- I'm not sure if that continuous sub in FULL, PAUSE=
RD
>> > > and PAUSEWR cases buys us anything at all.
>> > >
>> >
>> > Ahh ok, I see what you're saying now. Fair enough, we probably don't
>> > need a continuous sub to handle an epoch_barrier that we don't have th=
e
>> > map for yet.
>> >
>> > That said...should maybe_request_map be calling ceph_monc_want_map wit=
h
>> >   this as the epoch argument?
>> >
>> >      max(epoch+1, osdc->epoch_barrier)
>> >
>> > It seems like if the barrier is more than one greater than the one we
>> > currently have then we should request enough to get us to the barrier.
>>
>> No.  If the osdc->epoch_barrier is more than one greater, that would
>> request maps with epochs >=3D osdc->epoch_barrier, leaving the [epoch + =
1,
>> osdc->epoch_barrier) gap.
>>
>> We are checking osdc->epoch_barrier in ceph_osdc_handle_map() on every
>> incoming map and requesting more maps if needed, so eventually we will
>> get to the barrier.
>>
>
> Ok, got it...does this patch look OK?
>
> --------------------------8<----------------------------------
>
> [PATCH] libceph: add an epoch_barrier field to struct ceph_osd_client
>
> Cephfs can get cap update requests that contain a new epoch barrier in
> them. When that happens we want to pause all OSD traffic until the right
> map epoch arrives.
>
> Add an epoch_barrier field to ceph_osd_client that is protected by the
> osdc->lock rwsem. When the barrier is set, and the current OSD map
> epoch is below that, pause the request target when submitting the
> request or when revisiting it. Add a way for upper layers (cephfs)
> to update the epoch_barrier as well.
>
> If we get a new map, compare the new epoch against the barrier before
> kicking requests and request another map if the map epoch is still lower
> than the one we want.
>
> If we get a map with a full pool, or at quota condition, then set the
> barrier to the current epoch value.
>
> Reviewed-by: "Yan, Zheng=E2=80=9D <zyan@redhat.com>
> Signed-off-by: Jeff Layton <jlayton@redhat.com>
> Reviewed-by: Ilya Dryomov <idryomov@gmail.com>
> ---
>  include/linux/ceph/osd_client.h |  2 ++
>  net/ceph/debugfs.c              |  3 ++-
>  net/ceph/osd_client.c           | 50 ++++++++++++++++++++++++++++++++++-=
------
>  3 files changed, 46 insertions(+), 9 deletions(-)
>
> diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_cli=
ent.h
> index 8cf644197b1a..85650b415e73 100644
> --- a/include/linux/ceph/osd_client.h
> +++ b/include/linux/ceph/osd_client.h
> @@ -267,6 +267,7 @@ struct ceph_osd_client {
>         struct rb_root         osds;          /* osds */
>         struct list_head       osd_lru;       /* idle osds */
>         spinlock_t             osd_lru_lock;
> +       u32                    epoch_barrier;
>         struct ceph_osd        homeless_osd;
>         atomic64_t             last_tid;      /* tid of last request */
>         u64                    last_linger_id;
> @@ -305,6 +306,7 @@ extern void ceph_osdc_handle_reply(struct ceph_osd_cl=
ient *osdc,
>                                    struct ceph_msg *msg);
>  extern void ceph_osdc_handle_map(struct ceph_osd_client *osdc,
>                                  struct ceph_msg *msg);
> +void ceph_osdc_update_epoch_barrier(struct ceph_osd_client *osdc, u32 eb=
);
>
>  extern void osd_req_op_init(struct ceph_osd_request *osd_req,
>                             unsigned int which, u16 opcode, u32 flags);
> diff --git a/net/ceph/debugfs.c b/net/ceph/debugfs.c
> index d7e63a4f5578..71ba13927b3d 100644
> --- a/net/ceph/debugfs.c
> +++ b/net/ceph/debugfs.c
> @@ -62,7 +62,8 @@ static int osdmap_show(struct seq_file *s, void *p)
>                 return 0;
>
>         down_read(&osdc->lock);
> -       seq_printf(s, "epoch %d flags 0x%x\n", map->epoch, map->flags);
> +       seq_printf(s, "epoch %u barrier %u flags 0x%x\n", map->epoch,
> +                       osdc->epoch_barrier, map->flags);
>
>         for (n =3D rb_first(&map->pg_pools); n; n =3D rb_next(n)) {
>                 struct ceph_pg_pool_info *pi =3D
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 55b7585ccefd..fb35adae7fbf 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -1298,8 +1298,9 @@ static bool target_should_be_paused(struct ceph_osd=
_client *osdc,
>                        __pool_full(pi);
>
>         WARN_ON(pi->id !=3D t->base_oloc.pool);
> -       return (t->flags & CEPH_OSD_FLAG_READ && pauserd) ||
> -              (t->flags & CEPH_OSD_FLAG_WRITE && pausewr);
> +       return ((t->flags & CEPH_OSD_FLAG_READ) && pauserd) ||
> +              ((t->flags & CEPH_OSD_FLAG_WRITE) && pausewr) ||
> +              (osdc->osdmap->epoch < osdc->epoch_barrier);
>  }
>
>  enum calc_target_result {
> @@ -1654,8 +1655,13 @@ static void __submit_request(struct ceph_osd_reque=
st *req, bool wrlocked)
>                 goto promote;
>         }
>
> -       if ((req->r_flags & CEPH_OSD_FLAG_WRITE) &&
> -           ceph_osdmap_flag(osdc, CEPH_OSDMAP_PAUSEWR)) {
> +       if (osdc->osdmap->epoch < osdc->epoch_barrier) {
> +               dout("req %p epoch %u barrier %u\n", req, osdc->osdmap->e=
poch,
> +                    osdc->epoch_barrier);
> +               req->r_t.paused =3D true;
> +               maybe_request_map(osdc);
> +       } else if ((req->r_flags & CEPH_OSD_FLAG_WRITE) &&
> +                  ceph_osdmap_flag(osdc, CEPH_OSDMAP_PAUSEWR)) {
>                 dout("req %p pausewr\n", req);
>                 req->r_t.paused =3D true;
>                 maybe_request_map(osdc);
> @@ -1809,11 +1815,14 @@ static void abort_request(struct ceph_osd_request=
 *req, int err)
>
>  /*
>   * Drop all pending requests that are stalled waiting on a full conditio=
n to
> - * clear, and complete them with ENOSPC as the return code.
> + * clear, and complete them with ENOSPC as the return code. Set the
> + * osdc->epoch_barrier to the latest map epoch that we've seen if any we=
re
> + * cancelled.
>   */
>  static void ceph_osdc_abort_on_full(struct ceph_osd_client *osdc)
>  {
>         struct rb_node *n;
> +       bool set_barrier =3D false;
>
>         dout("enter abort_on_full\n");
>
> @@ -1832,12 +1841,18 @@ static void ceph_osdc_abort_on_full(struct ceph_o=
sd_client *osdc)
>
>                         if (req->r_abort_on_full &&
>                             (ceph_osdmap_flag(osdc, CEPH_OSDMAP_FULL) ||
> -                            pool_full(osdc, req->r_t.target_oloc.pool)))
> +                            pool_full(osdc, req->r_t.target_oloc.pool)))=
 {
>                                 abort_request(req, -ENOSPC);
> +                               set_barrier =3D true;
> +                       }
>                 }
>         }
> +
> +       /* Update the epoch barrier to current epoch if a call was aborte=
d */
> +       if (set_barrier)
> +               osdc->epoch_barrier =3D osdc->osdmap->epoch;
>  out:
> -       dout("return abort_on_full\n");
> +       dout("return abort_on_full barrier=3D%u\n", osdc->epoch_barrier);
>  }
>
>  static void check_pool_dne(struct ceph_osd_request *req)
> @@ -3293,7 +3308,8 @@ void ceph_osdc_handle_map(struct ceph_osd_client *o=
sdc, struct ceph_msg *msg)
>         pausewr =3D ceph_osdmap_flag(osdc, CEPH_OSDMAP_PAUSEWR) ||
>                   ceph_osdmap_flag(osdc, CEPH_OSDMAP_FULL) ||
>                   have_pool_full(osdc);
> -       if (was_pauserd || was_pausewr || pauserd || pausewr)
> +       if (was_pauserd || was_pausewr || pauserd || pausewr ||
> +           osdc->osdmap->epoch < osdc->epoch_barrier)
>                 maybe_request_map(osdc);
>
>         kick_requests(osdc, &need_resend, &need_resend_linger);
> @@ -3311,6 +3327,24 @@ void ceph_osdc_handle_map(struct ceph_osd_client *=
osdc, struct ceph_msg *msg)
>         up_write(&osdc->lock);
>  }
>
> +void ceph_osdc_update_epoch_barrier(struct ceph_osd_client *osdc, u32 eb=
)
> +{
> +       down_read(&osdc->lock);
> +       if (unlikely(eb > osdc->epoch_barrier)) {
> +               up_read(&osdc->lock);
> +               down_write(&osdc->lock);
> +               if (likely(eb > osdc->epoch_barrier)) {
> +                       dout("updating epoch_barrier from %u to %u\n",
> +                                       osdc->epoch_barrier, eb);
> +                       osdc->epoch_barrier =3D eb;
> +               }
> +               up_write(&osdc->lock);
> +       } else {
> +               up_read(&osdc->lock);
> +       }
> +}
> +EXPORT_SYMBOL(ceph_osdc_update_epoch_barrier);
> +
>  /*
>   * Resubmit requests pending on the given osd.
>   */

LGTM

Thanks,

                Ilya
