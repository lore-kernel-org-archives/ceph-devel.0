From: Josh Durgin <jdurgin@redhat.com>
Subject: Re: [PATCH] rbd: report unsupported features to syslog
Date: Wed, 27 Apr 2016 14:14:31 -0700
Message-ID: <57212BB7.4040901@redhat.com>
References: <1460748345-3717-1-git-send-email-idryomov@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx1.redhat.com ([209.132.183.28]:38401 "EHLO mx1.redhat.com"
	rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
	id S1752653AbcD0VOc (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
	Wed, 27 Apr 2016 17:14:32 -0400
In-Reply-To: <1460748345-3717-1-git-send-email-idryomov@gmail.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>, ceph-devel@vger.kernel.org

On 04/15/2016 12:25 PM, Ilya Dryomov wrote:
> ... instead of just returning an error.
>
> Signed-off-by: Ilya Dryomov <idryomov@gmail.com>

Reviewed-by: Josh Durgin <jdurgin@redhat.com>

> ---
>   drivers/block/rbd.c | 9 ++++++---
>   1 file changed, 6 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/block/rbd.c b/drivers/block/rbd.c
> index 9f1eb00b5e64..78aca585e7e5 100644
> --- a/drivers/block/rbd.c
> +++ b/drivers/block/rbd.c
> @@ -4184,7 +4184,7 @@ static int _rbd_dev_v2_snap_features(struct rbd_device *rbd_dev, u64 snap_id,
>   		__le64 features;
>   		__le64 incompat;
>   	} __attribute__ ((packed)) features_buf = { 0 };
> -	u64 incompat;
> +	u64 unsup;
>   	int ret;
>
>   	ret = rbd_obj_method_sync(rbd_dev, rbd_dev->header_name,
> @@ -4197,9 +4197,12 @@ static int _rbd_dev_v2_snap_features(struct rbd_device *rbd_dev, u64 snap_id,
>   	if (ret < sizeof (features_buf))
>   		return -ERANGE;
>
> -	incompat = le64_to_cpu(features_buf.incompat);
> -	if (incompat & ~RBD_FEATURES_SUPPORTED)
> +	unsup = le64_to_cpu(features_buf.incompat) & ~RBD_FEATURES_SUPPORTED;
> +	if (unsup) {
> +		rbd_warn(rbd_dev, "image uses unsupported features: 0x%llx",
> +			 unsup);
>   		return -ENXIO;
> +	}
>
>   	*snap_features = le64_to_cpu(features_buf.features);
>
>

