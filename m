From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH 2/2] ceph: send client provided metric flags in client
 metadata
Date: Tue, 16 Jun 2020 10:11:03 -0400
Message-ID: <cfb258b6a013642a5ab511797e8fd46808be310c.camel@kernel.org>
References: <1592311950-17623-1-git-send-email-xiubli@redhat.com>
         <1592311950-17623-3-git-send-email-xiubli@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:43706 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728869AbgFPOLH (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Tue, 16 Jun 2020 10:11:07 -0400
In-Reply-To: <1592311950-17623-3-git-send-email-xiubli@redhat.com>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: xiubli@redhat.com, idryomov@gmail.com
Cc: zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org

On Tue, 2020-06-16 at 08:52 -0400, xiubli@redhat.com wrote:
> From: Xiubo Li <xiubli@redhat.com>
> 
> Will send the metric flags to MDS, currently it supports the cap,
> read latency, write latency and metadata latency.
> 
> URL: https://tracker.ceph.com/issues/43435
> Signed-off-by: Xiubo Li <xiubli@redhat.com>
> ---
>  fs/ceph/mds_client.c | 47 +++++++++++++++++++++++++++++++++++++++++++++--
>  fs/ceph/metric.h     | 13 +++++++++++++
>  2 files changed, 58 insertions(+), 2 deletions(-)
> 
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index f996363..8b7ff41 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -1188,6 +1188,41 @@ static void encode_supported_features(void **p, void *end)
>  	}
>  }
>  
> +static const unsigned char metric_bits[] = CEPHFS_METRIC_SPEC_CLIENT_SUPPORTED;
> +#define METRIC_BYTES(cnt) (DIV_ROUND_UP((size_t)metric_bits[cnt - 1] + 1, 64) * 8)
> +static void encode_metric_spec(void **p, void *end)
> +{
> +	static const size_t count = ARRAY_SIZE(metric_bits);
> +
> +	/* header */
> +	BUG_ON(*p + 2 > end);
> +	ceph_encode_8(p, 1); /* version */
> +	ceph_encode_8(p, 1); /* compat */
> +
> +	if (count > 0) {
> +		size_t i;
> +		size_t size = METRIC_BYTES(count);
> +
> +		BUG_ON(*p + 4 + 4 + size > end);
> +

I know it's unlikely to ever trip, but let's not BUG_ON here. Maybe just
WARN and return an error...

Of course, we'd probably want that error to bubble up to the callers of
__open_session() but none of its callers check the return value. Would
you mind fixing that while you're in there too?


> +		/* metric spec info length */
> +		ceph_encode_32(p, 4 + size);
> +
> +		/* metric spec */
> +		ceph_encode_32(p, size);
> +		memset(*p, 0, size);
> +		for (i = 0; i < count; i++)
> +			((unsigned char *)(*p))[i / 8] |= BIT(metric_bits[i] % 8);
> +		*p += size;
> +	} else {
> +		BUG_ON(*p + 4 + 4 > end);
> +		/* metric spec info length */
> +		ceph_encode_32(p, 4);
> +		/* metric spec */
> +		ceph_encode_32(p, 0);
> +	}
> +}
> +
>  /*
>   * session message, specialization for CEPH_SESSION_REQUEST_OPEN
>   * to include additional client metadata fields.
> @@ -1227,6 +1262,13 @@ static struct ceph_msg *create_session_open_msg(struct ceph_mds_client *mdsc, u6
>  		size = FEATURE_BYTES(count);
>  	extra_bytes += 4 + size;
>  
> +	/* metric spec */
> +	size = 0;
> +	count = ARRAY_SIZE(metric_bits);
> +	if (count > 0)
> +		size = METRIC_BYTES(count);
> +	extra_bytes += 2 + 4 + 4 + size;
> +
>  	/* Allocate the message */
>  	msg = ceph_msg_new(CEPH_MSG_CLIENT_SESSION, sizeof(*h) + extra_bytes,
>  			   GFP_NOFS, false);
> @@ -1245,9 +1287,9 @@ static struct ceph_msg *create_session_open_msg(struct ceph_mds_client *mdsc, u6
>  	 * Serialize client metadata into waiting buffer space, using
>  	 * the format that userspace expects for map<string, string>
>  	 *
> -	 * ClientSession messages with metadata are v3
> +	 * ClientSession messages with metadata are v4
>  	 */
> -	msg->hdr.version = cpu_to_le16(3);
> +	msg->hdr.version = cpu_to_le16(4);
>  	msg->hdr.compat_version = cpu_to_le16(1);
>  
>  	/* The write pointer, following the session_head structure */
> @@ -1270,6 +1312,7 @@ static struct ceph_msg *create_session_open_msg(struct ceph_mds_client *mdsc, u6
>  	}
>  
>  	encode_supported_features(&p, end);
> +	encode_metric_spec(&p, end);
>  	msg->front.iov_len = p - msg->front.iov_base;
>  	msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
>  
> diff --git a/fs/ceph/metric.h b/fs/ceph/metric.h
> index 2af9e0b..f34adf7 100644
> --- a/fs/ceph/metric.h
> +++ b/fs/ceph/metric.h
> @@ -18,6 +18,19 @@ enum ceph_metric_type {
>  	CLIENT_METRIC_TYPE_MAX = CLIENT_METRIC_TYPE_DENTRY_LEASE,
>  };
>  
> +/*
> + * This will always have the highest metric bit value
> + * as the last element of the array.
> + */
> +#define CEPHFS_METRIC_SPEC_CLIENT_SUPPORTED {	\
> +	CLIENT_METRIC_TYPE_CAP_INFO,		\
> +	CLIENT_METRIC_TYPE_READ_LATENCY,	\
> +	CLIENT_METRIC_TYPE_WRITE_LATENCY,	\
> +	CLIENT_METRIC_TYPE_METADATA_LATENCY,	\
> +						\
> +	CLIENT_METRIC_TYPE_MAX,			\
> +}
> +
>  /* metric caps header */
>  struct ceph_metric_cap {
>  	__le32 type;     /* ceph metric type */

-- 
Jeff Layton <jlayton@kernel.org>
