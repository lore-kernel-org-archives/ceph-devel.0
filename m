From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH 3/4] libceph: don't spam dmesg with stray reply warnings
Date: Sat, 20 Feb 2016 12:46:07 -0600
Message-ID: <56C8B46F.5020408@ieee.org>
References: <1455986729-12544-1-git-send-email-idryomov@gmail.com>
 <1455986729-12544-4-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-io0-f171.google.com ([209.85.223.171]:36094 "EHLO
	mail-io0-f171.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751666AbcBTSqJ (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Sat, 20 Feb 2016 13:46:09 -0500
Received: by mail-io0-f171.google.com with SMTP id l127so140761049iof.3
        for <ceph-devel@vger.kernel.org>; Sat, 20 Feb 2016 10:46:08 -0800 (PST)
In-Reply-To: <1455986729-12544-4-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org
Cc: Varada Kari <Varada.Kari@sandisk.com>

On 02/20/2016 10:45 AM, Ilya Dryomov wrote:
> Commit d15f9d694b77 ("libceph: check data_len in ->alloc_msg()")
> mistakenly bumped the log level on the "tid %llu unknown, skipping"
> message.  Turn it back into a dout() - stray replies are perfectly
> normal when OSDs flap, crash, get killed for testing purposes, etc.
> 
> Cc: stable@vger.kernel.org # 4.3+
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>  net/ceph/osd_client.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 7c1a5d1734c3..32355d9d0103 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -2890,8 +2890,8 @@ static struct ceph_msg *get_reply(struct ceph_connection *con,
>  	mutex_lock(&osdc->request_mutex);
>  	req = __lookup_request(osdc, tid);
>  	if (!req) {
> -		pr_warn("%s osd%d tid %llu unknown, skipping\n",
> -			__func__, osd->o_osd, tid);
> +		dout("%s osd%d tid %llu unknown, skipping\n", __func__,
> +		     osd->o_osd, tid);
>  		m = NULL;
>  		*skip = 1;
>  		goto out;
> 

