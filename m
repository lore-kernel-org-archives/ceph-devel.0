From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 2/5] libceph: make ceph_msg_data_advance() return void
Date: Tue, 23 May 2017 12:41:43 -0500
Message-ID: <7488d46c-d984-3721-d545-59623388b009@ieee.org>
References: <1495557238-1077-1-git-send-email-idryomov@gmail.com>
 <1495557238-1077-3-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f178.google.com ([209.85.223.178]:33873 "EHLO
        mail-io0-f178.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1751426AbdEWRlq (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 23 May 2017 13:41:46 -0400
Received: by mail-io0-f178.google.com with SMTP id k91so102405197ioi.1
        for <ceph-devel@vger.kernel.org>; Tue, 23 May 2017 10:41:46 -0700 (PDT)
In-Reply-To: <1495557238-1077-3-git-send-email-idryomov@gmail.com>
Content-Language: en-CA
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

On 05/23/2017 11:33 AM, Ilya Dryomov wrote:
> Both callers ignore the returned bool.
> 
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

I think the return value may have been used at one time
(perhaps even before the original got committed), but since
it's not now, this is good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>  net/ceph/messenger.c | 11 ++++-------
>  1 file changed, 4 insertions(+), 7 deletions(-)
> 
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 5766a6c896c4..d7ab481b2508 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -1174,8 +1174,8 @@ static struct page *ceph_msg_data_next(struct ceph_msg_data_cursor *cursor,
>   * Returns true if the result moves the cursor on to the next piece
>   * of the data item.
>   */
> -static bool ceph_msg_data_advance(struct ceph_msg_data_cursor *cursor,
> -				size_t bytes)
> +static void ceph_msg_data_advance(struct ceph_msg_data_cursor *cursor,
> +				  size_t bytes)
>  {
>  	bool new_piece;
>  
> @@ -1207,8 +1207,6 @@ static bool ceph_msg_data_advance(struct ceph_msg_data_cursor *cursor,
>  		new_piece = true;
>  	}
>  	cursor->need_crc = new_piece;
> -
> -	return new_piece;
>  }
>  
>  static size_t sizeof_footer(struct ceph_connection *con)
> @@ -1577,7 +1575,6 @@ static int write_partial_message_data(struct ceph_connection *con)
>  		size_t page_offset;
>  		size_t length;
>  		bool last_piece;
> -		bool need_crc;
>  		int ret;
>  
>  		page = ceph_msg_data_next(cursor, &page_offset, &length,
> @@ -1592,7 +1589,7 @@ static int write_partial_message_data(struct ceph_connection *con)
>  		}
>  		if (do_datacrc && cursor->need_crc)
>  			crc = ceph_crc32c_page(crc, page, page_offset, length);
> -		need_crc = ceph_msg_data_advance(cursor, (size_t)ret);
> +		ceph_msg_data_advance(cursor, (size_t)ret);
>  	}
>  
>  	dout("%s %p msg %p done\n", __func__, con, msg);
> @@ -2299,7 +2296,7 @@ static int read_partial_msg_data(struct ceph_connection *con)
>  
>  		if (do_datacrc)
>  			crc = ceph_crc32c_page(crc, page, page_offset, ret);
> -		(void) ceph_msg_data_advance(cursor, (size_t)ret);
> +		ceph_msg_data_advance(cursor, (size_t)ret);
>  	}
>  	if (do_datacrc)
>  		con->in_data_crc = crc;
> 

