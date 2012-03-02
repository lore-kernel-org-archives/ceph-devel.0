From: Sage Weil <sage@newdream.net>
Subject: Re: [PATCH 2/2] libceph: some simple changes
Date: Fri, 2 Mar 2012 13:49:27 -0800 (PST)
Message-ID: <Pine.LNX.4.64.1203021348530.6413@cobra.newdream.net>
References: <4F4DAF00.5020908@dreamhost.com> <4F4DAFD1.7000100@dreamhost.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:36791 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1758454Ab2CBVt3 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 2 Mar 2012 16:49:29 -0500
In-Reply-To: <4F4DAFD1.7000100@dreamhost.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@dreamhost.com>
Cc: ceph-devel@vger.kernel.org

Looks ok, as long as this isn't broken if the moving zero_page_address 
inside write_partial_msg_pages().

Reviewed-by: Sage Weil <sage@newdream.net>

On Tue, 28 Feb 2012, Alex Elder wrote:

> Nothing too big here.
>     - define the size of the buffer used for consuming ignored
>       incoming data using a symbolic constant
>     - simplify the condition determining whether to unmap the page
>       in write_partial_msg_pages(): do it for crc but not if the
>       page is the zero page
> 
> Signed-off-by: Alex Elder <elder@dreamhost.com>
> ---
>  net/ceph/messenger.c |   13 +++++++++----
>  1 files changed, 9 insertions(+), 4 deletions(-)
> 
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 63f281f..27a1364 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -38,6 +38,11 @@ static char tag_keepalive = CEPH_MSGR_TAG_KEEPALIVE;
>  static struct lock_class_key socket_class;
>  #endif
> 
> +/*
> + * When skipping (ignoring) a block of input we read it into a "skip
> + * buffer," which is this many bytes in size.
> + */
> +#define SKIP_BUF_SIZE	1024
> 
>  static void queue_con(struct ceph_connection *con);
>  static void con_work(struct work_struct *);
> @@ -889,8 +894,7 @@ static int write_partial_msg_pages(struct ceph_connection
> *con)
>  				      MSG_DONTWAIT | MSG_NOSIGNAL |
>  				      MSG_MORE);
> 
> -		if (do_crc &&
> -		    (msg->pages || msg->pagelist || msg->bio || in_trail))
> +		if (do_crc && kaddr != zero_page_address)
>  			kunmap(page);
> 
>  		if (ret == -EAGAIN)
> @@ -1979,8 +1983,9 @@ more:
>  		 *
>  		 * FIXME: there must be a better way to do this!
>  		 */
> -		static char buf[1024];
> -		int skip = min(1024, -con->in_base_pos);
> +		static char buf[SKIP_BUF_SIZE];
> +		int skip = min((int) sizeof buf, -con->in_base_pos);
> +
>  		dout("skipping %d / %d bytes\n", skip, -con->in_base_pos);
>  		ret = ceph_tcp_recvmsg(con->sock, buf, skip);
>  		if (ret <= 0)
> -- 
> 1.7.5.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
