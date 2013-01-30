From: Josh Durgin <joshd@hq.newdream.net>
Subject: Re: [PATCH 2/4] rbd: track object rather than osd request for watch
Date: Wed, 30 Jan 2013 11:30:32 -0800
Message-ID: <510974D8.3080900@hq.newdream.net>
References: <51043EF2.4070305@inktank.com> <51043F56.9070500@inktank.com>
Reply-To: joshd@hq.newdream.net
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.hq.newdream.net ([66.33.206.127]:43739 "EHLO
	mail.hq.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753697Ab3A3TiY (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 30 Jan 2013 14:38:24 -0500
In-Reply-To: <51043F56.9070500@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 01/26/2013 12:40 PM, Alex Elder wrote:
> Switch to keeping track of the object request pointer rather than
> the osd request used to watch the rbd image header object.
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   drivers/block/rbd.c |    8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 363a813..4e78402 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -270,7 +270,7 @@ struct rbd_device {
>   	struct ceph_file_layout	layout;
>
>   	struct ceph_osd_event   *watch_event;
> -	struct ceph_osd_request *watch_request;
> +	struct rbd_obj_request	*watch_request;
>
>   	struct rbd_spec		*parent_spec;
>   	u64			parent_overlap;
> @@ -1728,11 +1728,11 @@ static int rbd_dev_header_watch_sync(struct
> rbd_device *rbd_dev, int start)
>   		goto out_cancel;
>
>   	if (start) {
> -		rbd_dev->watch_request = obj_request->osd_req;
> -		ceph_osdc_set_request_linger(osdc, rbd_dev->watch_request);
> +		ceph_osdc_set_request_linger(osdc, obj_request->osd_req);
> +		rbd_dev->watch_request = obj_request;
>   	} else {
>   		ceph_osdc_unregister_linger_request(osdc,
> -						rbd_dev->watch_request);
> +					rbd_dev->watch_request->osd_req);
>   		rbd_dev->watch_request = NULL;
>   	}
>   	ret = rbd_obj_request_submit(osdc, obj_request);
>

