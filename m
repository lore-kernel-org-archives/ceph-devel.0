From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH] libceph: treat sockaddr_storage with uninitialized family
 as blank
Date: Thu, 9 Jul 2015 08:58:46 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1507090858360.29886@cobra.newdream.net>
References: <1436449754-34910-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:50548 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1752765AbbGIP6r (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 9 Jul 2015 11:58:47 -0400
In-Reply-To: <1436449754-34910-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: ceph-devel@vger.kernel.org

On Thu, 9 Jul 2015, Ilya Dryomov wrote:
> addr_is_blank() should return true if family is neither AF_INET nor
> AF_INET6.  This is what its counterpart entity_addr_t::is_blank_ip() is
> doing and it is the right thing to do: in process_banner() we check if
> our address is blank and if it is "learn" it from our peer.  As it is,
> we never learn our address and always send out a blank one.  This goes
> way back to ceph.git commit dd732cbfc1c9 ("use sockaddr_storage; and
> some ipv6 support groundwork") from 2009.
> 
> While at at, do not open-code ipv6_addr_any() and use INADDR_ANY
> constant instead of 0.
> 
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

Reviewed-by: Sage Weil <sage@redhat.com>



> ---
>  net/ceph/messenger.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 726a57af760f..101ab6285fba 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -1732,17 +1732,17 @@ static int verify_hello(struct ceph_connection *con)
>  
>  static bool addr_is_blank(struct sockaddr_storage *ss)
>  {
> +	struct in_addr *addr = &((struct sockaddr_in *)ss)->sin_addr;
> +	struct in6_addr *addr6 = &((struct sockaddr_in6 *)ss)->sin6_addr;
> +
>  	switch (ss->ss_family) {
>  	case AF_INET:
> -		return ((struct sockaddr_in *)ss)->sin_addr.s_addr == 0;
> +		return addr->s_addr == htonl(INADDR_ANY);
>  	case AF_INET6:
> -		return
> -		     ((struct sockaddr_in6 *)ss)->sin6_addr.s6_addr32[0] == 0 &&
> -		     ((struct sockaddr_in6 *)ss)->sin6_addr.s6_addr32[1] == 0 &&
> -		     ((struct sockaddr_in6 *)ss)->sin6_addr.s6_addr32[2] == 0 &&
> -		     ((struct sockaddr_in6 *)ss)->sin6_addr.s6_addr32[3] == 0;
> +		return ipv6_addr_any(addr6);
> +	default:
> +		return true;
>  	}
> -	return false;
>  }
>  
>  static int addr_port(struct sockaddr_storage *ss)
> -- 
> 1.9.3
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
