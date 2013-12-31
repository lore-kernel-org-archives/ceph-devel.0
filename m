From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] libceph: use CEPH_MON_PORT when the specified port is
 0
Date: Tue, 31 Dec 2013 08:14:47 -0800 (PST)
Message-ID: <alpine.DEB.2.00.1312310814410.3197@cobra.newdream.net>
References: <1388487284-4774-1-git-send-email-ilya.dryomov@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:40072 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1753740Ab3LaQOs (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Tue, 31 Dec 2013 11:14:48 -0500
In-Reply-To: <1388487284-4774-1-git-send-email-ilya.dryomov@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <ilya.dryomov@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Sage Weil <sage@inktank.com>

On Tue, 31 Dec 2013, Ilya Dryomov wrote:

> Similar to userspace, don't bail with "parse_ips bad ip ..." if the
> specified port is port 0, instead use port CEPH_MON_PORT (6789, the
> default monitor port).
> 
> Signed-off-by: Ilya Dryomov <ilya.dryomov@inktank.com>
> ---
>  net/ceph/messenger.c |    4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
> 
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index bd172e1ee0ae..d2cadb5b2b63 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -1866,7 +1866,9 @@ int ceph_parse_ips(const char *c, const char *end,
>  				port = (port * 10) + (*p - '0');
>  				p++;
>  			}
> -			if (port > 65535 || port == 0)
> +			if (port == 0)
> +				port = CEPH_MON_PORT;
> +			else if (port > 65535)
>  				goto bad;
>  		} else {
>  			port = CEPH_MON_PORT;
> -- 
> 1.7.10.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
