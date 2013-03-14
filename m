From: Josh Durgin <josh.durgin@inktank.com>
Subject: Re: [PATCH] libceph: no outbound zero data
Date: Thu, 14 Mar 2013 12:49:00 -0700
Message-ID: <514229AC.7090703@inktank.com>
References: <513FD043.30707@inktank.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-pb0-f44.google.com ([209.85.160.44]:35863 "EHLO
	mail-pb0-f44.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751214Ab3CNTto (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Thu, 14 Mar 2013 15:49:44 -0400
Received: by mail-pb0-f44.google.com with SMTP id wz12so2711645pbc.3
        for <ceph-devel@vger.kernel.org>; Thu, 14 Mar 2013 12:49:44 -0700 (PDT)
In-Reply-To: <513FD043.30707@inktank.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Alex Elder <elder@inktank.com>
Cc: ceph-devel@vger.kernel.org

Reviewed-by: Josh Durgin <josh.durgin@inktank.com>

On 03/12/2013 06:02 PM, Alex Elder wrote:
> There is handling in write_partial_message_data() for the case where
> only the length of--and no other information about--the data to be
> sent has been specified.  It uses the zero page as the source of
> data to send in this case.
>
> This case doesn't occur.  All message senders set up a page array,
> pagelist, or bio describing the data to be sent.  So eliminate the
> block of code that handles this (but check and issue a warning for
> now, just in case it happens for some reason).
>
> This resolves:
>      http://tracker.ceph.com/issues/4426
>
> Signed-off-by: Alex Elder <elder@inktank.com>
> ---
>   net/ceph/messenger.c |   11 ++++-------
>   1 file changed, 4 insertions(+), 7 deletions(-)
>
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index 0d54ca4..c3f2fa1 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -1506,13 +1506,10 @@ static int write_partial_message_data(struct
> ceph_connection *con)
>   							&length, &last_piece);
>   #endif
>   		} else {
> -			size_t resid = data_len - msg_pos->data_pos;
> -
> -			page = zero_page;
> -			page_offset = msg_pos->page_pos;
> -			length = PAGE_SIZE - page_offset;
> -			length = min(resid, length);
> -			last_piece = length == resid;
> +			WARN(1, "con %p data_len %u but no outbound data\n",
> +				con, data_len);
> +			ret = -EINVAL;
> +			goto out;
>   		}
>   		if (do_datacrc && !msg_pos->did_page_crc) {
>   			u32 crc = le32_to_cpu(msg->footer.data_crc);
>

