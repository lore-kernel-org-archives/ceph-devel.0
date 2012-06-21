From: "Guan Jun He" <gjhe@suse.com>
Subject: Re: [PATCH] net/ceph/osd_client.c add sem to osdmap destroy
Date: Thu, 21 Jun 2012 02:29:51 -0600
Message-ID: <4FE34BFF0200001600012E2F@soto.provo.novell.com>
References: <1339749120-7007-1-git-send-email-gjhe@suse.com>
 <4FE0BA660200001600012837@soto.provo.novell.com>
 <Pine.LNX.4.64.1206190828510.21853@cobra.newdream.net>
 <4FE20C580200001600012B1E@soto.provo.novell.com>
 <Pine.LNX.4.64.1206200902110.14284@cobra.newdream.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from soto.provo.novell.com ([137.65.250.214]:45097 "EHLO
	soto.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758727Ab2FUIaF convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:3:1>);
	Thu, 21 Jun 2012 04:30:05 -0400
In-Reply-To: <Pine.LNX.4.64.1206200902110.14284@cobra.newdream.net>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Sage Weil <sage@inktank.com>
Cc: Guanjun He <heguanbo@gmail.com>, ceph-devel@vger.kernel.org



>>> On 6/21/2012 at 12:04 AM, in message
<Pine.LNX.4.64.1206200902110.14284@cobra.newdream.net>, Sage Weil
<sage@inktank.com> wrote: 
> On Wed, 20 Jun 2012, Guan Jun He wrote:
>> 
>> 
>> >>> On 6/19/2012 at 11:33 PM, in message
>> <Pine.LNX.4.64.1206190828510.21853@cobra.newdream.net>, Sage Weil
>> <sage@inktank.com> wrote: 
>> > [Sorry for not responding earlier!]
>> > 
>> > On Tue, 19 Jun 2012, Guan Jun He wrote:
>> >> Hi,
>> >> 
>> >>   Do you think this is needed? 
>> >> The osdmap update need to hold this sem.As in function 
>> >> void ceph_osdc_handle_map(struct ceph_osd_client *osdc, struct ceph_msg 
>> > *msg)
>> >> and 
>> >> function static int __map_request(), 
>> >> etc.
>> > 
>> > I'm skeptical that this is necessary.  At the point that we're tearing 
>> > down the osd_client there shouldn't be anybody else referencing us, or the 
>> > osdmap.
>> > 
>> > Actually, looking at the code a bit, I think the only kind of race we need 
>> > to worry about is an incoming message.  The correct fix is probably a call 
>> > to the messenger to drop all incoming traffic before we start to shut 
>> > everything else down.  Even with this, we might still end up with a new 
>> > osdmap that we leak, but stopping the msgr earlier would fix both issues.
>> 
>> Yes, stopping the msgr earlier is a better fix.
>> I will do some test and produce a new patch to this.
> 
> Ok.  The trick here is that I think we want to set a flag to discard 
> incoming messages and then flush the workqueue, do all this other 
> tear down for osd_client etc., and then tear down the messenger.  I don't 
> think we can tear down the msgr fully before that, though, because 
> osd_client etc have their fingers in it.  We just need to prevent the race 
> of incoming work during teardown...

Have produced a new patch and sent in another mail, and the title is 
'client: prevent the race of incoming work during teardown'


thanks,
Guanjun



> 
> Thanks for looking at this!
> sage
> 
>> thanks,
>> Guanjun
>> 
>> 
>> 
>> 
>> > 
>> > sage
>> > 
>> >> 
>> >> Thanks a lot for your reply!
>> >> 
>> >> thanks,
>> >> Guanjun
>> >> 
>> >> >>> On 6/15/2012 at 04:32 PM, in message
>> >> <1339749120-7007-1-git-send-email-gjhe@suse.com>, Guanjun He
>> >> <heguanbo@gmail.com> wrote: 
>> >> > From: Guanjun He <heguanbo@gmail.com>
>> >> > 
>> >> > 	I think the osdmap destroy code shoule be protected by map_sem.
>> >> > If I was wrong, please correct me, thanks!
>> >> > 
>> >> > Signed-off-by: Guanjun He <gjhe@suse.com>
>> >> > ---
>> >> >  net/ceph/osd_client.c |    2 ++
>> >> >  1 files changed, 2 insertions(+), 0 deletions(-)
>> >> > 
>> >> > diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
>> >> > index 1ffebed..718b100 100644
>> >> > --- a/net/ceph/osd_client.c
>> >> > +++ b/net/ceph/osd_client.c
>> >> > @@ -1872,11 +1872,13 @@ void ceph_osdc_stop(struct ceph_osd_client *osdc)
>> >> >  	destroy_workqueue(osdc->notify_wq);
>> >> >  	cancel_delayed_work_sync(&osdc->timeout_work);
>> >> >  	cancel_delayed_work_sync(&osdc->osds_timeout_work);
>> >> > +	down_write(&osdc->map_sem);
>> >> >  	if (osdc->osdmap) {
>> >> >  		ceph_osdmap_destroy(osdc->osdmap);
>> >> >  		osdc->osdmap = NULL;
>> >> >  	}
>> >> >  	remove_all_osds(osdc);
>> >> > +	up_write(&osdc->map_sem);
>> >> >  	mempool_destroy(osdc->req_mempool);
>> >> >  	ceph_msgpool_destroy(&osdc->msgpool_op);
>> >> >  	ceph_msgpool_destroy(&osdc->msgpool_op_reply);
>> >> 
>> >> 
>> >> 
>> 
>> 
>> --
>> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
>> the body of a message to majordomo@vger.kernel.org
>> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>> 
>> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

