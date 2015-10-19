From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH v2] Net: ceph: messenger: Use local variable cursor in
 read_partial_msg_data()
Date: Mon, 19 Oct 2015 07:22:08 -0500
Message-ID: <5624E070.5050109@ieee.org>
References: <1445222975-16086-1-git-send-email-shraddha.6596@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f172.google.com ([209.85.223.172]:36712 "EHLO
	mail-io0-f172.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1750814AbbJSMWK (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Mon, 19 Oct 2015 08:22:10 -0400
Received: by ioll68 with SMTP id l68so26916881iol.3
        for <ceph-devel@vger.kernel.org>; Mon, 19 Oct 2015 05:22:09 -0700 (PDT)
In-Reply-To: <1445222975-16086-1-git-send-email-shraddha.6596@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Shraddha Barke <shraddha.6596@gmail.com>, ceph-devel@vger.kernel.org

On 10/18/2015 09:49 PM, Shraddha Barke wrote:
> Use local variable cursor in place of &msg->cursor in
>  read_partial_msg_data()
> 
> Signed-off-by: Shraddha Barke <shraddha.6596@gmail.com>

This is a pretty minor comment, but the "Net" in your
subject line is probably better *not* capitalized.

					-Alex

> ---
> Changes in v2-
>  Drop incorrect use of cursor
> 
>  net/ceph/messenger.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index b9b0e3b..b087edd 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -2246,7 +2246,7 @@ static int read_partial_msg_data(struct ceph_connection *con)
>  	if (do_datacrc)
>  		crc = con->in_data_crc;
>  	while (cursor->resid) {
> -		page = ceph_msg_data_next(&msg->cursor, &page_offset, &length,
> +		page = ceph_msg_data_next(cursor, &page_offset, &length,
>  							NULL);
>  		ret = ceph_tcp_recvpage(con->sock, page, page_offset, length);
>  		if (ret <= 0) {
> @@ -2258,7 +2258,7 @@ static int read_partial_msg_data(struct ceph_connection *con)
>  
>  		if (do_datacrc)
>  			crc = ceph_crc32c_page(crc, page, page_offset, ret);
> -		(void) ceph_msg_data_advance(&msg->cursor, (size_t)ret);
> +		(void) ceph_msg_data_advance(cursor, (size_t)ret);
>  	}
>  	if (do_datacrc)
>  		con->in_data_crc = crc;
> 

