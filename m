From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 4/5] libceph: validate blob_struct_v in
 process_one_ticket()
Date: Tue, 23 May 2017 12:44:16 -0500
Message-ID: <acf57851-8c0e-ca92-d7c4-13ae945983c0@ieee.org>
References: <1495557238-1077-1-git-send-email-idryomov@gmail.com>
 <1495557238-1077-5-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-it0-f50.google.com ([209.85.214.50]:35809 "EHLO
        mail-it0-f50.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S933210AbdEWRoT (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Tue, 23 May 2017 13:44:19 -0400
Received: by mail-it0-f50.google.com with SMTP id c15so24125754ith.0
        for <ceph-devel@vger.kernel.org>; Tue, 23 May 2017 10:44:18 -0700 (PDT)
In-Reply-To: <1495557238-1077-5-git-send-email-idryomov@gmail.com>
Content-Language: en-CA
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

On 05/23/2017 11:33 AM, Ilya Dryomov wrote:
> None of these are validated in userspace, but since we do validate
> reply_struct_v in ceph_x_proc_ticket_reply(), tkt_struct_v (first) and
> CephXServiceTicket struct_v (second) in process_one_ticket(), validate
> CephXTicketBlob struct_v as well.
> 
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

Looks good.  (I don't know what's valid but I know you do.)

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>  net/ceph/auth_x.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/net/ceph/auth_x.c b/net/ceph/auth_x.c
> index 2034fb926670..d0126df33f1f 100644
> --- a/net/ceph/auth_x.c
> +++ b/net/ceph/auth_x.c
> @@ -215,6 +215,9 @@ static int process_one_ticket(struct ceph_auth_client *ac,
>  	dout(" ticket blob is %d bytes\n", dlen);
>  	ceph_decode_need(ptp, tpend, 1 + sizeof(u64), bad);
>  	blob_struct_v = ceph_decode_8(ptp);
> +	if (blob_struct_v != 1)
> +		goto bad;
> +
>  	new_secret_id = ceph_decode_64(ptp);
>  	ret = ceph_decode_buffer(&new_ticket_blob, ptp, tpend);
>  	if (ret)
> 

