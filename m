From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH 1/3] libceph: call r_unsafe_callback when unsafe reply
 is received
Date: Mon, 1 Jul 2013 12:46:00 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1307011245410.11177@cobra.newdream.net>
References: <1372056089-11603-1-git-send-email-zheng.z.yan@intel.com> <51D12FA7.1090605@intel.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40213 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1754867Ab3GATqA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 1 Jul 2013 15:46:00 -0400
In-Reply-To: <51D12FA7.1090605@intel.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: "Yan, Zheng" <zheng.z.yan@intel.com>
Cc: ceph-devel@vger.kernel.org, alex.elder@linaro.org

On Mon, 1 Jul 2013, Yan, Zheng wrote:
> ping
> 
> I think this patch should goes into 3.11 or fix the issue by other means

Applied this to the testing branch, thanks.  Let me know if there are any 
others I missed!

sage

> 
> 
> On 06/24/2013 02:41 PM, Yan, Zheng wrote:
> > From: "Yan, Zheng" <zheng.z.yan@intel.com>
> > 
> > We can't use !req->r_sent to check if OSD request is sent for the
> > first time, this is because __cancel_request() zeros req->r_sent
> > when OSD map changes. Rather than adding a new variable to struct
> > ceph_osd_request to indicate if it's sent for the first time, We
> > can call the unsafe callback only when unsafe OSD reply is received.
> > If OSD's first reply is safe, just skip calling the unsafe callback.
> > 
> > The purpose of unsafe callback is adding unsafe request to a list,
> > so that fsync(2) can wait for the safe reply. fsync(2) doesn't need
> > to wait for a write(2) that hasn't returned yet. So it's OK to add
> > request to the unsafe list when the first OSD reply is received.
> > (ceph_sync_write() returns after receiving the first OSD reply)
> > 
> > Signed-off-by: Yan, Zheng <zheng.z.yan@intel.com>
> > ---
> >  net/ceph/osd_client.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> > index 540dd29..dd47889 100644
> > --- a/net/ceph/osd_client.c
> > +++ b/net/ceph/osd_client.c
> > @@ -1337,10 +1337,6 @@ static void __send_request(struct ceph_osd_client *osdc,
> >  
> >  	ceph_msg_get(req->r_request); /* send consumes a ref */
> >  
> > -	/* Mark the request unsafe if this is the first timet's being sent. */
> > -
> > -	if (!req->r_sent && req->r_unsafe_callback)
> > -		req->r_unsafe_callback(req, true);
> >  	req->r_sent = req->r_osd->o_incarnation;
> >  
> >  	ceph_con_send(&req->r_osd->o_con, req->r_request);
> > @@ -1431,8 +1427,6 @@ static void handle_osds_timeout(struct work_struct *work)
> >  
> >  static void complete_request(struct ceph_osd_request *req)
> >  {
> > -	if (req->r_unsafe_callback)
> > -		req->r_unsafe_callback(req, false);
> >  	complete_all(&req->r_safe_completion);  /* fsync waiter */
> >  }
> >  
> > @@ -1559,14 +1553,20 @@ static void handle_reply(struct ceph_osd_client *osdc, struct ceph_msg *msg,
> >  	mutex_unlock(&osdc->request_mutex);
> >  
> >  	if (!already_completed) {
> > +		if (req->r_unsafe_callback &&
> > +		    result >= 0 && !(flags & CEPH_OSD_FLAG_ONDISK))
> > +			req->r_unsafe_callback(req, true);
> >  		if (req->r_callback)
> >  			req->r_callback(req, msg);
> >  		else
> >  			complete_all(&req->r_completion);
> >  	}
> >  
> > -	if (flags & CEPH_OSD_FLAG_ONDISK)
> > +	if (flags & CEPH_OSD_FLAG_ONDISK) {
> > +		if (req->r_unsafe_callback && already_completed)
> > +			req->r_unsafe_callback(req, false);
> >  		complete_request(req);
> > +	}
> >  
> >  done:
> >  	dout("req=%p req->r_linger=%d\n", req, req->r_linger);
> > 
> 
> 
