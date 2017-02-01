From: Jeff Layton <jlayton@redhat.com>
Subject: Re: [PATCH v1 4/7] ceph: handle new osdmap epoch updates in
 CLIENT_CAPS and WRITE codepaths
Date: Wed, 01 Feb 2017 15:55:29 -0500
Message-ID: <1485982529.2559.5.camel@redhat.com>
References: <20170120151738.9584-1-jlayton@redhat.com>
         <20170120151738.9584-5-jlayton@redhat.com>
         <1CA9B32B-E3EA-47A0-8803-A4CD969737B0@redhat.com>
         <1485978618.2559.3.camel@redhat.com>
         <CALe9h7cj_vqu-Kt2jauC0pA2Fpp-cjfg30fDQKeN7r55iXeL7A@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-qt0-f172.google.com ([209.85.216.172]:33791 "EHLO
        mail-qt0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1750862AbdBAUze (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 1 Feb 2017 15:55:34 -0500
Received: by mail-qt0-f172.google.com with SMTP id v23so285277124qtb.0
        for <ceph-devel@vger.kernel.org>; Wed, 01 Feb 2017 12:55:34 -0800 (PST)
In-Reply-To: <CALe9h7cj_vqu-Kt2jauC0pA2Fpp-cjfg30fDQKeN7r55iXeL7A@mail.gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: John Spray <jspray@redhat.com>
Cc: "Yan, Zheng" <zyan@redhat.com>, ceph-devel <ceph-devel@vger.kernel.org>, Ilya Dryomov <idryomov@gmail.com>, Sage Weil <sage@redhat.com>

On Wed, 2017-02-01 at 19:55 +0000, John Spray wrote:
> On Wed, Feb 1, 2017 at 7:50 PM, Jeff Layton <jlayton@redhat.com> wrote:
> > On Sun, 2017-01-22 at 17:40 +0800, Yan, Zheng wrote:
> > > > On 20 Jan 2017, at 23:17, Jeff Layton <jlayton@redhat.com> wrote:
> > > > 
> > > > This patch is heavily inspired by John Spray's earlier work, but
> > > > implemented in a different way.
> > > > 
> > > > Create and register a new map_cb for cephfs, to allow it to handle
> > > > changes to the osdmap.
> > > > 
> > > > In the version 5 of CLIENT_CAPS messages, the barrier field is added as an
> > > > instruction to clients that they may not use the attached capabilities
> > > > until they have a particular OSD map epoch.
> > > > 
> > > > When we get a message with such a field and don't have the requisite map
> > > > epoch yet, we put that message on a list in the session, to be run when
> > > > the map does come in.
> > > > 
> > > > When we get a new map update, the map_cb routine first checks to see
> > > > whether there may be an OSD or pool full condition. If so, then we walk
> > > > the list of OSD calls and kill off any writes to full OSDs or pools with
> > > > -ENOSPC.  While cancelling, we store the latest OSD epoch seen in each
> > > > request. This will be used later in the CAPRELEASE messages.
> > > > 
> > > > Then, it walks the session list and queues the workqueue job for each.
> > > > When the workqueue job runs, it walks the list of delayed caps and tries
> > > > to rerun each one. If the epoch is still not high enough, they just get
> > > > put back on the delay queue for when the map does come in.
> > > > 
> > > > Suggested-by: John Spray <john.spray@redhat.com>
> > > > Signed-off-by: Jeff Layton <jlayton@redhat.com>
> > > > ---
> > > > fs/ceph/caps.c       | 43 +++++++++++++++++++++++++++---
> > > > fs/ceph/debugfs.c    |  3 +++
> > > > fs/ceph/mds_client.c | 75 ++++++++++++++++++++++++++++++++++++++++++++++++++++
> > > > fs/ceph/mds_client.h |  3 +++
> > > > 4 files changed, 120 insertions(+), 4 deletions(-)
> > > > 
> > > > diff --git a/fs/ceph/caps.c b/fs/ceph/caps.c
> > > > index d941c48e8bff..f33d424b5e12 100644
> > > > --- a/fs/ceph/caps.c
> > > > +++ b/fs/ceph/caps.c
> > > > @@ -1077,7 +1077,7 @@ static int send_cap_msg(struct cap_msg_args *arg)
> > > >     /* inline data size */
> > > >     ceph_encode_32(&p, 0);
> > > >     /* osd_epoch_barrier (version 5) */
> > > > -   ceph_encode_32(&p, 0);
> > > > +   ceph_encode_32(&p, arg->session->s_mdsc->cap_epoch_barrier);
> > > >     /* oldest_flush_tid (version 6) */
> > > >     ceph_encode_64(&p, arg->oldest_flush_tid);
> > > > 
> > > > @@ -3577,9 +3577,12 @@ void ceph_handle_caps(struct ceph_mds_session *session,
> > > >     void *snaptrace;
> > > >     size_t snaptrace_len;
> > > >     void *p, *end;
> > > > +   u32 epoch_barrier = 0;
> > > > 
> > > >     dout("handle_caps from mds%d\n", mds);
> > > > 
> > > > +   WARN_ON_ONCE(!list_empty(&msg->list_head));
> > > > +
> > > >     /* decode */
> > > >     end = msg->front.iov_base + msg->front.iov_len;
> > > >     tid = le64_to_cpu(msg->hdr.tid);
> > > > @@ -3625,13 +3628,45 @@ void ceph_handle_caps(struct ceph_mds_session *session,
> > > >             p += inline_len;
> > > >     }
> > > > 
> > > > +   if (le16_to_cpu(msg->hdr.version) >= 5) {
> > > > +           struct ceph_osd_client *osdc = &mdsc->fsc->client->osdc;
> > > > +
> > > > +           ceph_decode_32_safe(&p, end, epoch_barrier, bad);
> > > > +
> > > > +           /* Do lockless check first to avoid mutex if we can */
> > > > +           if (epoch_barrier > mdsc->cap_epoch_barrier) {
> > > > +                   mutex_lock(&mdsc->mutex);
> > > > +                   if (epoch_barrier > mdsc->cap_epoch_barrier)
> > > > +                           mdsc->cap_epoch_barrier = epoch_barrier;
> > > > +                   mutex_unlock(&mdsc->mutex);
> > > > +           }
> > > > +
> > > > +           down_read(&osdc->lock);
> > > > +           if (osdc->osdmap->epoch < epoch_barrier) {
> > > > +                   dout("handle_caps delaying message until OSD epoch %d\n", epoch_barrier);
> > > > +                   ceph_msg_get(msg);
> > > > +                   spin_lock(&session->s_cap_lock);
> > > > +                   list_add(&msg->list_head, &session->s_delayed_caps);
> > > > +                   spin_unlock(&session->s_cap_lock);
> > > > +
> > > > +                   // Kick OSD client to get the latest map
> > > > +                   __ceph_osdc_maybe_request_map(osdc);
> > > > +
> > > > +                   up_read(&osdc->lock);
> > > > +                   return;
> > > > +           }
> > > 
> > > Cap messages need to be handled in the same order as they were sent. I’m worry if the delay breaks something or makes cap revoke slow. Why not use the use the same approach as user space client? pass the epoch_barrier to libceph and let libceph delay sending osd requests.
> > > 
> > > Regards
> > > Yan, Zheng
> > > 
> > 
> > Now that I've looked at this in more detail, I'm not sure I understand
> > what you're suggesting.
> > 
> > In this case, we have gotten a cap message from the MDS, and we can't
> > use any caps granted in there until the right map epoch comes in. Isn't
> > it wrong to do all of the stuff in handle_cap_grant (for instance)
> > before we've received that map epoch?
> > 
> > The userland client just seems to just idle OSD requests in the
> > objecter layer until the right map comes in. Is that really sufficient
> > here?
> 
> Yes -- the key thing is that the client sees the effects of *another*
> client's blacklisting (the client that might have previously held caps
> on the file we're about to write/read).  So the client receiving the
> barrier message is completely OK and entitled to the caps, he just
> needs to make sure his OSD ops don't go out until he's seen the epoch
> so that his operations are properly ordered with respect to the
> blacklisting of this notional other client.
> 

Ok, got it! I think that makes sense.

I notice that there is some plumbing in the kernel already for pausing
requests until certain flags in the osdmap, so we might be able to
reuse a lot of that to handle the barrier. I'll look and see what can
be done there.

Many thanks!
-- 
Jeff Layton <jlayton@redhat.com>
