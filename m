From: Xiubo Li <xiubli@redhat.com>
Subject: Re: [PATCH v6 2/2] ceph: send client provided metric flags in client
 metadata
Date: Fri, 17 Jul 2020 21:12:35 +0800
Message-ID: <77770691-1323-7111-2cc5-d1fe1be42194@redhat.com>
References: <20200716140558.5185-1-xiubli@redhat.com>
 <20200716140558.5185-3-xiubli@redhat.com>
 <a41b163828ee08ba3ec3986057115ba19c1d17b8.camel@kernel.org>
 <e7a61b3eca43cc3e3d96d4300c316245113decd4.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52268 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726201AbgGQNMs (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 17 Jul 2020 09:12:48 -0400
In-Reply-To: <e7a61b3eca43cc3e3d96d4300c316245113decd4.camel@kernel.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>
Cc: idryomov@gmail.com, ceph-devel@vger.kernel.org, zyan@redhat.com, pdonnell@redhat.com, vshankar@redhat.com

On 2020/7/17 20:07, Jeff Layton wrote:
> On Fri, 2020-07-17 at 07:26 -0400, Jeff Layton wrote:
>> On Thu, 2020-07-16 at 10:05 -0400, xiubli@redhat.com wrote:
>>> From: Xiubo Li <xiubli@redhat.com>
>>>
>>> Will send the metric flags to MDS, currently it supports the cap,
>>> read latency, write latency and metadata latency.
>>>
>>> URL: https://tracker.ceph.com/issues/43435
>>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>>> ---
>>>   fs/ceph/mds_client.c | 60 ++++++++++++++++++++++++++++++++++++++++++--
>>>   fs/ceph/metric.h     | 13 ++++++++++
>>>   2 files changed, 71 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
>>> index cf4c2ba2311f..929778625ea5 100644
>>> --- a/fs/ceph/mds_client.c
>>> +++ b/fs/ceph/mds_client.c
>>> @@ -1194,6 +1194,48 @@ static int encode_supported_features(void **p, void *end)
>>>   	return 0;
>>>   }
>>>   
>>> +static const unsigned char metric_bits[] = CEPHFS_METRIC_SPEC_CLIENT_SUPPORTED;
>>> +#define METRIC_BYTES(cnt) (DIV_ROUND_UP((size_t)metric_bits[cnt - 1] + 1, 64) * 8)
>>> +static int encode_metric_spec(void **p, void *end)
>>> +{
>>> +	static const size_t count = ARRAY_SIZE(metric_bits);
>>> +
>>> +	/* header */
>>> +	if (WARN_ON_ONCE(*p + 2 > end))
>>> +		return -ERANGE;
>>> +
>>> +	ceph_encode_8(p, 1); /* version */
>>> +	ceph_encode_8(p, 1); /* compat */
>>> +
>>> +	if (count > 0) {
>>> +		size_t i;
>>> +		size_t size = METRIC_BYTES(count);
>>> +
>>> +		if (WARN_ON_ONCE(*p + 4 + 4 + size > end))
>>> +			return -ERANGE;
>>> +
>>> +		/* metric spec info length */
>>> +		ceph_encode_32(p, 4 + size);
>>> +
>>> +		/* metric spec */
>>> +		ceph_encode_32(p, size);
>>> +		memset(*p, 0, size);
>>> +		for (i = 0; i < count; i++)
>>> +			((unsigned char *)(*p))[i / 8] |= BIT(metric_bits[i] % 8);
>>> +		*p += size;
>>> +	} else {
>>> +		if (WARN_ON_ONCE(*p + 4 + 4 > end))
>>> +			return -ERANGE;
>>> +
>>> +		/* metric spec info length */
>>> +		ceph_encode_32(p, 4);
>>> +		/* metric spec */
>>> +		ceph_encode_32(p, 0);
>>> +	}
>>> +
>>> +	return 0;
>>> +}
>>> +
>>>   /*
>>>    * session message, specialization for CEPH_SESSION_REQUEST_OPEN
>>>    * to include additional client metadata fields.
>>> @@ -1234,6 +1276,13 @@ static struct ceph_msg *create_session_open_msg(struct ceph_mds_client *mdsc, u6
>>>   		size = FEATURE_BYTES(count);
>>>   	extra_bytes += 4 + size;
>>>   
>>> +	/* metric spec */
>>> +	size = 0;
>>> +	count = ARRAY_SIZE(metric_bits);
>>> +	if (count > 0)
>>> +		size = METRIC_BYTES(count);
>>> +	extra_bytes += 2 + 4 + 4 + size;
>>> +
>>>   	/* Allocate the message */
>>>   	msg = ceph_msg_new(CEPH_MSG_CLIENT_SESSION, sizeof(*h) + extra_bytes,
>>>   			   GFP_NOFS, false);
>>> @@ -1252,9 +1301,9 @@ static struct ceph_msg *create_session_open_msg(struct ceph_mds_client *mdsc, u6
>>>   	 * Serialize client metadata into waiting buffer space, using
>>>   	 * the format that userspace expects for map<string, string>
>>>   	 *
>>> -	 * ClientSession messages with metadata are v3
>>> +	 * ClientSession messages with metadata are v4
>>>   	 */
>>> -	msg->hdr.version = cpu_to_le16(3);
>>> +	msg->hdr.version = cpu_to_le16(4);
>>>   	msg->hdr.compat_version = cpu_to_le16(1);
>>>   
>>>   	/* The write pointer, following the session_head structure */
>>> @@ -1283,6 +1332,13 @@ static struct ceph_msg *create_session_open_msg(struct ceph_mds_client *mdsc, u6
>>>   		return ERR_PTR(ret);
>>>   	}
>>>   
>>> +	ret = encode_metric_spec(&p, end);
>>> +	if (ret) {
>>> +		pr_err("encode_metric_spec failed!\n");
>>> +		ceph_msg_put(msg);
>>> +		return ERR_PTR(ret);
>>> +	}
>>> +
>>>   	msg->front.iov_len = p - msg->front.iov_base;
>>>   	msg->hdr.front_len = cpu_to_le32(msg->front.iov_len);
>>>   
>>> diff --git a/fs/ceph/metric.h b/fs/ceph/metric.h
>>> index fe5d07d2e63a..1d0959d669d7 100644
>>> --- a/fs/ceph/metric.h
>>> +++ b/fs/ceph/metric.h
>>> @@ -18,6 +18,19 @@ enum ceph_metric_type {
>>>   	CLIENT_METRIC_TYPE_MAX = CLIENT_METRIC_TYPE_DENTRY_LEASE,
>>>   };
>>>   
>>> +/*
>>> + * This will always have the highest metric bit value
>>> + * as the last element of the array.
>>> + */
>>> +#define CEPHFS_METRIC_SPEC_CLIENT_SUPPORTED {	\
>>> +	CLIENT_METRIC_TYPE_CAP_INFO,		\
>>> +	CLIENT_METRIC_TYPE_READ_LATENCY,	\
>>> +	CLIENT_METRIC_TYPE_WRITE_LATENCY,	\
>>> +	CLIENT_METRIC_TYPE_METADATA_LATENCY,	\
>>> +						\
>>> +	CLIENT_METRIC_TYPE_MAX,			\
>> Not a huge problem now, but shouldn't this last line be?
>>
>> 	CLIENT_METRIC_TYPE_MAX = CLIENT_METRIC_TYPE_METADATA_LATENCY,
>>
>>
> Disregard my earlier mail here. I read this as if you were adding
> another enum. This patch looks fine.

Yeah, right. This will be like the FEATURE bits do before as we did.

Thanks

>>> +}
>>> +
>>>   /* metric caps header */
>>>   struct ceph_metric_cap {
>>>   	__le32 type;     /* ceph metric type */
