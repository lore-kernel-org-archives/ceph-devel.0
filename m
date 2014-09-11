From: Alex Elder <elder@ieee.org>
Subject: Re: [PATCH] libceph: fix a memory leak in handle_watch_notify
Date: Wed, 10 Sep 2014 20:41:57 -0500
Message-ID: <5410FDE5.5090804@ieee.org>
References: <1410394821-13054-1-git-send-email-roy.qing.li@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail-ig0-f173.google.com ([209.85.213.173]:65026 "EHLO
	mail-ig0-f173.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
	with ESMTP id S1751413AbaIKBmA (ORCPT
	<rfc822;ceph-devel@vger.kernel.org>); Wed, 10 Sep 2014 21:42:00 -0400
Received: by mail-ig0-f173.google.com with SMTP id l13so176559iga.0
        for <ceph-devel@vger.kernel.org>; Wed, 10 Sep 2014 18:42:00 -0700 (PDT)
In-Reply-To: <1410394821-13054-1-git-send-email-roy.qing.li@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: roy.qing.li@gmail.com, sage@inktank.com, ceph-devel@vger.kernel.org

On 09/10/2014 07:20 PM, roy.qing.li@gmail.com wrote:
> From: Li RongQing <roy.qing.li@gmail.com>
>
> event_work should be freed when adding it to queue failed
>
> Signed-off-by: Li RongQing <roy.qing.li@gmail.com>

Looks good.

Reviewed-by: Alex Elder <elder@linaro.org>

> ---
>   net/ceph/osd_client.c |    1 +
>   1 file changed, 1 insertion(+)
>
> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
> index 30f6faf..1e1b4f1 100644
> --- a/net/ceph/osd_client.c
> +++ b/net/ceph/osd_client.c
> @@ -2323,6 +2323,7 @@ static void handle_watch_notify(struct ceph_osd_client *osdc,
>   		event_work->opcode = opcode;
>   		if (!queue_work(osdc->notify_wq, &event_work->work)) {
>   			dout("WARNING: failed to queue notify event work\n");
> +			kfree(event_work);
>   			goto done_err;
>   		}
>   	}
>

