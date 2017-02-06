From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH v2 6/6] libceph: allow requests to return immediately on
 full conditions if caller wishes
Date: Mon, 06 Feb 2017 16:46:17 -0500
Message-ID: <1486417577.18829.3.camel@redhat.com>
References: <20170206132927.9219-1-jlayton@redhat.com>
         <20170206132927.9219-7-jlayton@redhat.com>
         <CAOi1vP_k0q0ff-BjTWYk8faJvRs4TNFgJO+XeovebvAM9Wtxfg@mail.gmail.com>
         <1486396192.2712.4.camel@redhat.com>
         <CAOi1vP8UaS8z7-zX+Wkaifc24tp0yACdNompj93BQTiau7ekgw@mail.gmail.com>
         <1486398961.2712.7.camel@redhat.com>
         <CAOi1vP89_m95T-NSknJckKjnhv6V6CKnTcr3K4=pyFkKO9H_aQ@mail.gmail.com>
         <1486405820.18829.1.camel@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f178.google.com ([209.85.216.178]:36618 "EHLO
        mail-qt0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1752506AbdBFVqV (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Mon, 6 Feb 2017 16:46:21 -0500
Received: by mail-qt0-f178.google.com with SMTP id k15so118168879qtg.3
        for <ceph-devel@vger.kernel.org>; Mon, 06 Feb 2017 13:46:21 -0800 (PST)
In-Reply-To: <1486405820.18829.1.camel@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Ceph Development <ceph-devel@vger.kernel.org>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, John Spray <jspray@redhat.com>

On Mon, 2017-02-06 at 13:30 -0500, Jeff Layton wrote:
> On Mon, 2017-02-06 at 18:05 +0100, Ilya Dryomov wrote:
> > On Mon, Feb 6, 2017 at 5:36 PM, Jeff Layton <jlayton@redhat.com> wrote:
> > > On Mon, 2017-02-06 at 17:27 +0100, Ilya Dryomov wrote:
> > > > On Mon, Feb 6, 2017 at 4:49 PM, Jeff Layton <jlayton@redhat.com> wrote:
> > > > > On Mon, 2017-02-06 at 15:09 +0100, Ilya Dryomov wrote:
> > > > > 
> > > > > [...]
> > > > > 
> > > > > > > diff --git a/include/linux/ceph/rados.h b/include/linux/ceph/rados.h
> > > > > > > index 5c0da61cb763..def43570a85a 100644
> > > > > > > --- a/include/linux/ceph/rados.h
> > > > > > > +++ b/include/linux/ceph/rados.h
> > > > > > > @@ -401,6 +401,7 @@ enum {
> > > > > > >         CEPH_OSD_FLAG_KNOWN_REDIR = 0x400000,  /* redirect bit is authoritative */
> > > > > > >         CEPH_OSD_FLAG_FULL_TRY =    0x800000,  /* try op despite full flag */
> > > > > > >         CEPH_OSD_FLAG_FULL_FORCE = 0x1000000,  /* force op despite full flag */
> > > > > > > +       CEPH_OSD_FLAG_FULL_CANCEL = 0x2000000, /* cancel operation on full flag */
> > > > > > 
> > > > > > Is this a new flag?  This is the wire protocol and I don't see it in
> > > > > > ceph.git.
> > > > > > 
> > > > > > I'll look at epoch_barrier and callback stuff later.
> > > > > > 
> > > > > > Thanks,
> > > > > > 
> > > > > >                 Ilya
> > > > > 
> > > > > Here's a respun version of the last patch in the set. This should avoid
> > > > > adding an on the wire flag. I just added a new bool and changed the
> > > > > code to set and look at that to indicate the desire for an immediate
> > > > > error return in this case. Compiles but is otherwise untested. I'll give
> > > > > it a go in a bit.
> > > > > 
> > > > > -----------------------------8<------------------------------
> > > > > 
> > > > > libceph: allow requests to return immediately on full
> > > > >  conditions if caller wishes
> > > > > 
> > > > > Right now, cephfs will cancel any in-flight OSD write operations when a
> > > > > new map comes in that shows the OSD or pool as full, but nothing
> > > > > prevents new requests from stalling out after that point.
> > > > > 
> > > > > If the caller knows that it will want an immediate error return instead
> > > > > of blocking on a full or at-quota error condition then allow it to set a
> > > > > flag to request that behavior. Cephfs write requests will always set
> > > > > that flag.
> > > > > 
> > > > > Signed-off-by: Jeff Layton <jlayton@redhat.com>
> > > > > ---
> > > > >  fs/ceph/addr.c                  | 4 ++++
> > > > >  fs/ceph/file.c                  | 4 ++++
> > > > >  include/linux/ceph/osd_client.h | 1 +
> > > > >  net/ceph/osd_client.c           | 6 ++++++
> > > > >  4 files changed, 15 insertions(+)
> > > > > 
> > > > > diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
> > > > > index 4547bbf80e4f..ef9c9bae7460 100644
> > > > > --- a/fs/ceph/addr.c
> > > > > +++ b/fs/ceph/addr.c
> > > > > @@ -1040,6 +1040,7 @@ static int ceph_writepages_start(struct address_space *mapping,
> > > > > 
> > > > >                 req->r_callback = writepages_finish;
> > > > >                 req->r_inode = inode;
> > > > > +               req->r_enospc_on_full = true;
> > > > > 
> > > > >                 /* Format the osd request message and submit the write */
> > > > >                 len = 0;
> > > > > @@ -1689,6 +1690,7 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
> > > > >         }
> > > > > 
> > > > >         req->r_mtime = inode->i_mtime;
> > > > > +       req->r_enospc_on_full = true;
> > > > >         err = ceph_osdc_start_request(&fsc->client->osdc, req, false);
> > > > >         if (!err)
> > > > >                 err = ceph_osdc_wait_request(&fsc->client->osdc, req);
> > > > > @@ -1732,6 +1734,7 @@ int ceph_uninline_data(struct file *filp, struct page *locked_page)
> > > > >         }
> > > > > 
> > > > >         req->r_mtime = inode->i_mtime;
> > > > > +       req->r_enospc_on_full = true;
> > > > >         err = ceph_osdc_start_request(&fsc->client->osdc, req, false);
> > > > >         if (!err)
> > > > >                 err = ceph_osdc_wait_request(&fsc->client->osdc, req);
> > > > > @@ -1893,6 +1896,7 @@ static int __ceph_pool_perm_get(struct ceph_inode_info *ci,
> > > > >         err = ceph_osdc_start_request(&fsc->client->osdc, rd_req, false);
> > > > > 
> > > > >         wr_req->r_mtime = ci->vfs_inode.i_mtime;
> > > > > +       wr_req->r_enospc_on_full = true;
> > > > >         err2 = ceph_osdc_start_request(&fsc->client->osdc, wr_req, false);
> > > > > 
> > > > >         if (!err)
> > > > > diff --git a/fs/ceph/file.c b/fs/ceph/file.c
> > > > > index a91a4f1fc837..eaed17f90d5f 100644
> > > > > --- a/fs/ceph/file.c
> > > > > +++ b/fs/ceph/file.c
> > > > > @@ -714,6 +714,7 @@ static void ceph_aio_retry_work(struct work_struct *work)
> > > > >         req->r_callback = ceph_aio_complete_req;
> > > > >         req->r_inode = inode;
> > > > >         req->r_priv = aio_req;
> > > > > +       req->r_enospc_on_full = true;
> > > > > 
> > > > >         ret = ceph_osdc_start_request(req->r_osdc, req, false);
> > > > >  out:
> > > > > @@ -912,6 +913,7 @@ ceph_direct_read_write(struct kiocb *iocb, struct iov_iter *iter,
> > > > > 
> > > > >                         osd_req_op_init(req, 1, CEPH_OSD_OP_STARTSYNC, 0);
> > > > >                         req->r_mtime = mtime;
> > > > > +                       req->r_enospc_on_full = true;
> > > > >                 }
> > > > > 
> > > > >                 osd_req_op_extent_osd_data_pages(req, 0, pages, len, start,
> > > > > @@ -1105,6 +1107,7 @@ ceph_sync_write(struct kiocb *iocb, struct iov_iter *from, loff_t pos,
> > > > >                                                 false, true);
> > > > > 
> > > > >                 req->r_mtime = mtime;
> > > > > +               req->r_enospc_on_full = true;
> > > > >                 ret = ceph_osdc_start_request(&fsc->client->osdc, req, false);
> > > > >                 if (!ret)
> > > > >                         ret = ceph_osdc_wait_request(&fsc->client->osdc, req);
> > > > > @@ -1557,6 +1560,7 @@ static int ceph_zero_partial_object(struct inode *inode,
> > > > >         }
> > > > > 
> > > > >         req->r_mtime = inode->i_mtime;
> > > > > +       req->r_enospc_on_full = true;
> > > > >         ret = ceph_osdc_start_request(&fsc->client->osdc, req, false);
> > > > >         if (!ret) {
> > > > >                 ret = ceph_osdc_wait_request(&fsc->client->osdc, req);
> > > > > diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
> > > > > index 17bf1873bb01..f01e93ff03d5 100644
> > > > > --- a/include/linux/ceph/osd_client.h
> > > > > +++ b/include/linux/ceph/osd_client.h
> > > > > @@ -172,6 +172,7 @@ struct ceph_osd_request {
> > > > > 
> > > > >         int               r_result;
> > > > >         bool              r_got_reply;
> > > > > +       bool              r_enospc_on_full; /* return ENOSPC when full */
> > > > > 
> > > > >         struct ceph_osd_client *r_osdc;
> > > > >         struct kref       r_kref;
> > > > > diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> > > > > index d61d7a79fdb3..9f40d11b3c68 100644
> > > > > --- a/net/ceph/osd_client.c
> > > > > +++ b/net/ceph/osd_client.c
> > > > > @@ -50,6 +50,7 @@ static void link_linger(struct ceph_osd *osd,
> > > > >                         struct ceph_osd_linger_request *lreq);
> > > > >  static void unlink_linger(struct ceph_osd *osd,
> > > > >                           struct ceph_osd_linger_request *lreq);
> > > > > +static void complete_request(struct ceph_osd_request *req, int err);
> > > > > 
> > > > >  #if 1
> > > > >  static inline bool rwsem_is_wrlocked(struct rw_semaphore *sem)
> > > > > @@ -1643,6 +1644,7 @@ static void __submit_request(struct ceph_osd_request *req, bool wrlocked)
> > > > >         enum calc_target_result ct_res;
> > > > >         bool need_send = false;
> > > > >         bool promoted = false;
> > > > > +       int ret = 0;
> > > > > 
> > > > >         WARN_ON(req->r_tid || req->r_got_reply);
> > > > >         dout("%s req %p wrlocked %d\n", __func__, req, wrlocked);
> > > > > @@ -1683,6 +1685,8 @@ static void __submit_request(struct ceph_osd_request *req, bool wrlocked)
> > > > >                 pr_warn_ratelimited("FULL or reached pool quota\n");
> > > > >                 req->r_t.paused = true;
> > > > >                 maybe_request_map(osdc);
> > > > > +               if (req->r_enospc_on_full)
> > > > > +                       ret = -ENOSPC;
> > > > >         } else if (!osd_homeless(osd)) {
> > > > >                 need_send = true;
> > > > >         } else {
> > > > > @@ -1699,6 +1703,8 @@ static void __submit_request(struct ceph_osd_request *req, bool wrlocked)
> > > > >         link_request(osd, req);
> > > > >         if (need_send)
> > > > >                 send_request(req);
> > > > > +       else if (ret)
> > > > > +               complete_request(req, ret);
> > > > 
> > > > How is this handled in the userspace client?  I don't see a similar
> > > > check in Objecter.
> > > > 
> > > > Thanks,
> > > > 
> > > >                 Ilya
> > > 
> > > It seems to be handled at a much higher layer in libcephfs. In _write(),
> > > for instance, we have:
> > > 
> > >   if (objecter->osdmap_pool_full(in->layout.pool_id)) {
> > >     return -ENOSPC;
> > >   }
> > > 
> > > ...and there's also some EDQUOT handling a little below there as well.
> > > 
> > > I don't think we can reasonably follow that model in the kernel client
> > > though. The way it's done in userland seems to require the big client
> > > mutex be held over large swaths of the code, and that's not the case in
> > > the kernel client (thankfully).
> > 
> > All it's doing is checking a flag under a lock; the same lock is taken
> > in ceph_osdc_start_request().  Why would exporting
> > 
> > bool ceph_osdc_pool_full(osdc, pool_id)
> > {
> >     bool ret;
> > 
> >     down_read(&osdc->lock);
> >     ret = ceph_osdmap_flag(osdc, CEPH_OSDMAP_FULL) ||
> >                                    pool_full(osdc, pool_id);
> >     up_read(&osdc->lock);
> >     return ret;
> > }
> > 
> > not work?  IOW why special case request handling code if you know in
> > advance that the request is a goner?
> > 
> 
> 
> You can't just call that before calling submit_request because once you
> call up_read there, the map could have changed and the map_cb already
> run. At that point we can't rely on the callback cancelling the now
> hung request.
> 
> You could call that function after ceph_osdc_start_request, but before
> we end up waiting on it (or whatever), but then we'd need to export
> complete_request as well so we could cancel it. The other downside
> there is that we end up with even more rwsem thrashing. We already end
> up taking it for write in order to submit the thing, so having to take
> it for read again afterward is not ideal.
> 
> We could remedy that by pushing the rwsem handling up into cephfs
> (basically, export submit_request too), but that smells more like a
> layering violation to me. The full flag is part of the osdmap, so it
> doesn't seem wrong to have libcephfs handle it, and that's quite a bit
> simpler and more efficient than trying to manage that from the cephfs
> layer.

That said...I think it is better to use this new flag in a more
coherent fashion in the complete_writes callback. I've done some
cleanup and slimdown of the set today, so you may want to hold off
reviewing this just yet, and wait until I repost.

Thanks,
-- 
Jeff Layton <jlayton@redhat.com>
