From: "Guan Jun He" <gjhe@suse.com>
Subject: Re: [PATCH] net/ceph/osd_client.c add sem to osdmap destroy
Date: Tue, 19 Jun 2012 03:44:06 -0600
Message-ID: <4FE0BA660200001600012837@soto.provo.novell.com>
References: <1339749120-7007-1-git-send-email-gjhe@suse.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 8BIT
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from soto.provo.novell.com ([137.65.250.214]:60922 "EHLO
	soto.provo.novell.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751246Ab2FSJoV convert rfc822-to-8bit (ORCPT
	<rfc822;groupwise-ceph-devel@vger.kernel.org:3:1>);
	Tue, 19 Jun 2012 05:44:21 -0400
In-Reply-To: <1339749120-7007-1-git-send-email-gjhe@suse.com>
Content-Disposition: inline
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Guanjun He <heguanbo@gmail.com>, sage@inktank.com, ceph-devel@vger.kernel.org

Hi,

  Do you think this is needed? 
The osdmap update need to hold this sem.As in function 
void ceph_osdc_handle_map(struct ceph_osd_client *osdc, struct ceph_msg *msg)
and 
function static int __map_request(), 
etc.

Thanks a lot for your reply!

thanks,
Guanjun

>>> On 6/15/2012 at 04:32 PM, in message
<1339749120-7007-1-git-send-email-gjhe@suse.com>, Guanjun He
<heguanbo@gmail.com> wrote: 
> From: Guanjun He <heguanbo@gmail.com>
> 
> 	I think the osdmap destroy code shoule be protected by map_sem.
> If I was wrong, please correct me, thanks!
> 
> Signed-off-by: Guanjun He <gjhe@suse.com>
> ---
>  net/ceph/osd_client.c |    2 ++
>  1 files changed, 2 insertions(+), 0 deletions(-)
> 
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 1ffebed..718b100 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -1872,11 +1872,13 @@ void ceph_osdc_stop(struct ceph_osd_client *osdc)
>  	destroy_workqueue(osdc->notify_wq);
>  	cancel_delayed_work_sync(&osdc->timeout_work);
>  	cancel_delayed_work_sync(&osdc->osds_timeout_work);
> +	down_write(&osdc->map_sem);
>  	if (osdc->osdmap) {
>  		ceph_osdmap_destroy(osdc->osdmap);
>  		osdc->osdmap = NULL;
>  	}
>  	remove_all_osds(osdc);
> +	up_write(&osdc->map_sem);
>  	mempool_destroy(osdc->req_mempool);
>  	ceph_msgpool_destroy(&osdc->msgpool_op);
>  	ceph_msgpool_destroy(&osdc->msgpool_op_reply);


