From: Sage Weil <sage@inktank.com>
Subject: Re: [PATCH] libceph: don't add to crc unless data sent
Date: Fri, 29 Mar 2013 10:57:20 -0700 (PDT)
Message-ID: <alpine.DEB.2.00.1303291056490.4190@cobra.newdream.net>
References: <5155D51C.5010109@inktank.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from cobra.newdream.net ([66.33.216.30]:54603 "EHLO
	cobra.newdream.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1756310Ab3C2R5V (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Fri, 29 Mar 2013 13:57:21 -0400
In-Reply-To: <5155D51C.5010109@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: "ceph-devel@vger.kernel.org" <ceph-devel@vger.kernel.org>

I like sticking this right next to the cursor update as it avoids any 
similar bugs.  Looks good!

Reviewed-by: Sage Weil <sage@inktank.com>

On Fri, 29 Mar 2013, Alex Elder wrote:

> (This patch is available in branch "review/wip-4450" of the
> ceph-client git repository.  It corrects a problem that arose
> in the commit before it.  It is not the topmost commit because
> the one before and two after were three patches that had been
> previously reviewed.  Rather than change the reviewed patch,
> I'm keeping this fix separate and have just rebased the two
> that follow it.)
> 
> 
> In write_partial_message_data() we aggregate the crc for the data
> portion of the message as each new piece of the data item is
> encountered.  Because it was computed *before* sending the data, if
> an attempt to send a new piece resulted in 0 bytes being sent, the
> crc crc across that piece would erroneously get computed again and
> added to the aggregate result.  This would occasionally happen in
> the evnet of a connection failure.
> 
> The crc value isn't really needed until the complete value is known
> after sending all data, so there's no need to compute it before
> sending.
> 
> So don't calculate the crc for a piece until *after* we know at
> least one byte of it has been sent.  That will avoid this problem.
> 
> This resolves:
>     http://tracker.ceph.com/issues/4450
> 
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>  net/ceph/messenger.c |    4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 02a37a5..3f5137c 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -1467,8 +1467,6 @@ static int write_partial_message_data(struct
> ceph_connection *con)
> 
>  		page = ceph_msg_data_next(&msg->data, &page_offset, &length,
>  							&last_piece);
> -		if (do_datacrc && cursor->need_crc)
> -			crc = ceph_crc32c_page(crc, page, page_offset, length);
>  		ret = ceph_tcp_sendpage(con->sock, page, page_offset,
>  				      length, last_piece);
>  		if (ret <= 0) {
> @@ -1477,6 +1475,8 @@ static int write_partial_message_data(struct
> ceph_connection *con)
> 
>  			return ret;
>  		}
> +		if (do_datacrc && cursor->need_crc)
> +			crc = ceph_crc32c_page(crc, page, page_offset, length);
>  		out_msg_pos_next(con, page, length, (size_t) ret);
>  	}
> 
> -- 
> 1.7.9.5
> 
> --
> To unsubscribe from this list: send the line "unsubscribe ceph-devel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
> 
