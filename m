From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH] libceph: Fix ceph_tcp_sendpage()'s more boolean usage
Date: Thu, 25 Jun 2015 15:28:25 -0500
Message-ID: <558C6469.6010600@ieee.org>
References: <1435251386-25108-1-git-send-email-benoit.canet@nodalink.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8;
	format=flowed
Content-Transfer-Encoding: QUOTED-PRINTABLE
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pa0-f52.google.com ([209.85.220.52]:32943 "EHLO
	mail-pa0-f52.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751136AbbFYU21 (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 25 Jun 2015 16:28:27 -0400
Received: by padev16 with SMTP id ev16so55764240pad.0
        for <ceph-devel@vger.kernel.org>; Thu, 25 Jun 2015 13:28:26 -0700 (PDT)
In-Reply-To: <1435251386-25108-1-git-send-email-benoit.canet@nodalink.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: =?UTF-8?B?QmVub8OudCBDYW5ldA==?= <benoit.canet@nodalink.com>, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com

On 06/25/2015 11:56 AM, Beno=C3=AEt Canet wrote:
> Spotted while hunting http://tracker.ceph.com/issues/10905.
>
>  From struct ceph_msg_data_cursor in include/linux/ceph/messenger.h:
>
> bool	last_piece;	/* current is last piece */
>
> In ceph_msg_data_next():
>
> *last_piece =3D cursor->last_piece;
>
> A call to ceph_msg_data_next() is followed by:
>
> ret =3D ceph_tcp_sendpage(con->sock, page, page_offset,
> 			length, last_piece);
>
> while ceph_tcp_sendpage() is:
>
> static int ceph_tcp_sendpage(struct socket *sock, struct page *page,i
> 			     int offset, size_t size, bool more)
>
> The logic is inverted: correct it.

Whoops.  I'm surprised we haven't had more trouble from this.
This should go to stable too.

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

>
> Signed-off-by: Beno=C3=AEt Canet <benoit.canet@nodalink.com>
> ---
>   net/ceph/messenger.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index ec68cd3..eda06fd 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -1544,7 +1544,7 @@ static int write_partial_message_data(struct ce=
ph_connection *con)
>   		page =3D ceph_msg_data_next(&msg->cursor, &page_offset, &length,
>   							&last_piece);
>   		ret =3D ceph_tcp_sendpage(con->sock, page, page_offset,
> -				      length, last_piece);
> +				      length, !last_piece);
>   		if (ret <=3D 0) {
>   			if (do_datacrc)
>   				msg->footer.data_crc =3D cpu_to_le32(crc);
>

--
To unsubscribe from this list: send the line "unsubscribe ceph-devel" i=
n
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html
