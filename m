From: Sage Weil <sage@newdream.net>
Subject: Re: [patch 2/2] ceph: unlock on error in ceph_osdc_start_request()
Date: Tue, 29 Mar 2011 08:56:47 -0700 (PDT)
Message-ID: <Pine.LNX.4.64.1103290856420.19819@cobra.newdream.net>
References: <20110329032559.GF9856@bicker>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50120 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751301Ab1C2Pxt (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 29 Mar 2011 11:53:49 -0400
In-Reply-To: <20110329032559.GF9856@bicker>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Dan Carpenter <error27@gmail.com>
Cc: ceph-devel@vger.kernel.org, kernel-janitors@vger.kernel.org

Thanks, applied this one!

sage


On Tue, 29 Mar 2011, Dan Carpenter wrote:

> There was a missing unlock on the error path if __map_request() failed.
> 
> Signed-off-by: Dan Carpenter <error27@gmail.com>
> 
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index b6776cb..03740e8 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -1672,7 +1672,7 @@ int ceph_osdc_start_request(struct ceph_osd_client *osdc,
>  	if (req->r_sent == 0) {
>  		rc = __map_request(osdc, req);
>  		if (rc < 0)
> -			return rc;
> +			goto out_unlock;
>  		if (req->r_osd == NULL) {
>  			dout("send_request %p no up osds in pg\n", req);
>  			ceph_monc_request_next_osdmap(&osdc->client->monc);
> @@ -1689,6 +1689,8 @@ int ceph_osdc_start_request(struct ceph_osd_client *osdc,
>  			}
>  		}
>  	}
> +
> +out_unlock:
>  	mutex_unlock(&osdc->request_mutex);
>  	up_read(&osdc->map_sem);
>  	return rc;
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
