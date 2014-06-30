From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 08/14] libceph: fix linger request check in __unregister_request()
Date: Mon, 30 Jun 2014 08:07:51 -0500
Message-ID: <53B16127.7070000@ieee.org>
References: <1403716607-13535-1-git-send-email-ilya.dryomov@inktank.com> <1403716607-13535-9-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ie0-f172.google.com ([209.85.223.172]:56804 "EHLO
	mail-ie0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751398AbaF3NHp (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 30 Jun 2014 09:07:45 -0400
Received: by mail-ie0-f172.google.com with SMTP id lx4so6812724iec.17
        for <ceph-devel@vger.kernel.org>; Mon, 30 Jun 2014 06:07:44 -0700 (PDT)
In-Reply-To: <1403716607-13535-9-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>, ceph-devel@vger.kernel.org

On 06/25/2014 12:16 PM, Ilya Dryomov wrote:
> We should check if request is on the linger request list of any of the
> OSDs, not whether request is registered or not.
> 
> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>

That was a difficult to spot bug.  Very good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>  net/ceph/osd_client.c |    2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 12ec553a7e76..8104db24bc09 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -1221,7 +1221,7 @@ static void __unregister_request(struct ceph_osd_client *osdc,
>  
>  		list_del_init(&req->r_osd_item);
>  		maybe_move_osd_to_lru(osdc, req->r_osd);
> -		if (list_empty(&req->r_linger_item))
> +		if (list_empty(&req->r_linger_osd_item))
>  			req->r_osd = NULL;
>  	}
>  
> 

