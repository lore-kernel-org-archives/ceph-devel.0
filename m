From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] net/ceph/osd_client.c add sem to osdmap destroy
Date: Tue, 19 Jun 2012 08:33:31 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1206190828510.21853@cobra.newdream.net>
References: <1339749120-7007-1-git-send-email-gjhe@suse.com>
 <4FE0BA660200001600012837@soto.provo.novell.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:56068 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413Ab2FSPde (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 19 Jun 2012 11:33:34 -0400
In-Reply-To: <4FE0BA660200001600012837@soto.provo.novell.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guan Jun He <gjhe@suse.com>
Cc: Guanjun He <heguanbo@gmail.com>, ceph-devel@vger.kernel.org

[Sorry for not responding earlier!]

On Tue, 19 Jun 2012, Guan Jun He wrote:
> Hi,
> 
>   Do you think this is needed? 
> The osdmap update need to hold this sem.As in function 
> void ceph_osdc_handle_map(struct ceph_osd_client *osdc, struct ceph_msg *msg)
> and 
> function static int __map_request(), 
> etc.

I'm skeptical that this is necessary.  At the point that we're tearing 
down the osd_client there shouldn't be anybody else referencing us, or the 
osdmap.

Actually, looking at the code a bit, I think the only kind of race we need 
to worry about is an incoming message.  The correct fix is probably a call 
to the messenger to drop all incoming traffic before we start to shut 
everything else down.  Even with this, we might still end up with a new 
osdmap that we leak, but stopping the msgr earlier would fix both issues.

sage

> 
> Thanks a lot for your reply!
> 
> thanks,
> Guanjun
> 
> >>> On 6/15/2012 at 04:32 PM, in message
> <1339749120-7007-1-git-send-email-gjhe@suse.com>, Guanjun He
> <heguanbo@gmail.com> wrote: 
> > From: Guanjun He <heguanbo@gmail.com>
> > 
> > 	I think the osdmap destroy code shoule be protected by map_sem.
> > If I was wrong, please correct me, thanks!
> > 
> > Signed-off-by: Guanjun He <gjhe@suse.com>
> > ---
> >  net/ceph/osd_client.c |    2 ++
> >  1 files changed, 2 insertions(+), 0 deletions(-)
> > 
> > diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> > index 1ffebed..718b100 100644
> > --- a/net/ceph/osd_client.c
> > +++ b/net/ceph/osd_client.c
> > @@ -1872,11 +1872,13 @@ void ceph_osdc_stop(struct ceph_osd_client *osdc)
> >  	destroy_workqueue(osdc->notify_wq);
> >  	cancel_delayed_work_sync(&osdc->timeout_work);
> >  	cancel_delayed_work_sync(&osdc->osds_timeout_work);
> > +	down_write(&osdc->map_sem);
> >  	if (osdc->osdmap) {
> >  		ceph_osdmap_destroy(osdc->osdmap);
> >  		osdc->osdmap = NULL;
> >  	}
> >  	remove_all_osds(osdc);
> > +	up_write(&osdc->map_sem);
> >  	mempool_destroy(osdc->req_mempool);
> >  	ceph_msgpool_destroy(&osdc->msgpool_op);
> >  	ceph_msgpool_destroy(&osdc->msgpool_op_reply);
> 
> 
> 
