From: Eduard Shishkin <edward6@linux.ibm.com>
Subject: Re: [PATCH] ceph: fix up endian bug in managing feature bits
Date: Wed, 29 Apr 2020 11:46:02 +0200
Message-ID: <d322ad5e-8409-7e5e-8d16-a2706223f26f@linux.ibm.com>
References: <1588023986-23672-1-git-send-email-edward6@linux.ibm.com>
 <f36451800e4656f99483f4d47487a40ea5f942cd.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45270 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726345AbgD2JqK (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Wed, 29 Apr 2020 05:46:10 -0400
In-Reply-To: <f36451800e4656f99483f4d47487a40ea5f942cd.camel@kernel.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org
Cc: Ulrich.Weigand@de.ibm.com, Tuan.Hoang1@ibm.com, "Yan, Zheng" <ukernel@gmail.com>

On 4/28/20 2:23 PM, Jeff Layton wrote:
> On Mon, 2020-04-27 at 23:46 +0200, edward6@linux.ibm.com wrote:
>> From: Eduard Shishkin <edward6@linux.ibm.com>
>>
>> In the function handle_session() variable @features always
>> contains little endian order of bytes. Just because the feature
>> bits are packed bytewise from left to right in
>> encode_supported_features().
>>
>> However, test_bit(), called to check features availability, assumes
>> the host order of bytes in that variable. This leads to problems on
>> big endian architectures. Specifically it is impossible to mount
>> ceph volume on s390.
>>
>> This patch adds conversion from little endian to the host order
>> of bytes, thus fixing the problem.
>>
>> Signed-off-by: Eduard Shishkin <edward6@linux.ibm.com>
>> ---
>>   fs/ceph/mds_client.c | 4 ++--
>>   1 file changed, 2 insertions(+), 2 deletions(-)
>>
>> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
>> index 486f91f..190598d 100644
>> --- a/fs/ceph/mds_client.c
>> +++ b/fs/ceph/mds_client.c
>> @@ -3252,7 +3252,7 @@ static void handle_session(struct ceph_mds_session *session,
>>   	struct ceph_mds_session_head *h;
>>   	u32 op;
>>   	u64 seq;
>> -	unsigned long features = 0;
>> +	__le64 features = 0;
>>   	int wake = 0;
>>   	bool blacklisted = false;
>>   
>> @@ -3301,7 +3301,7 @@ static void handle_session(struct ceph_mds_session *session,
>>   		if (session->s_state == CEPH_MDS_SESSION_RECONNECTING)
>>   			pr_info("mds%d reconnect success\n", session->s_mds);
>>   		session->s_state = CEPH_MDS_SESSION_OPEN;
>> -		session->s_features = features;
>> +		session->s_features = le64_to_cpu(features);
>>   		renewed_caps(mdsc, session, 0);
>>   		wake = 1;
>>   		if (mdsc->stopping)
> 
> (cc'ing Zheng since he did the original patches here)
> 
> Thanks Eduard. The problem is real, but I think we can just do the
> conversion during the decode.
> 
> The feature mask words sent by the MDS are 64 bits, so if it's smaller
> we can assume that it's malformed. So, I don't think we need to handle
> the case where it's smaller than 8 bytes.
> 
> How about this patch instead?


Hi Jeff,

This also works. Please, apply.

Thanks,
Eduard.

> 
> --------------------------8<-----------------------------
> 
> ceph: fix endianness bug when handling MDS session feature bits
> 
> Eduard reported a problem mounting cephfs on s390 arch. The feature
> mask sent by the MDS is little-endian, so we need to convert it
> before storing and testing against it.
> 
> Reported-by: Eduard Shishkin <edward6@linux.ibm.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>   fs/ceph/mds_client.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
> index a8a5b98148ec..6c283c52d401 100644
> --- a/fs/ceph/mds_client.c
> +++ b/fs/ceph/mds_client.c
> @@ -3260,8 +3260,7 @@ static void handle_session(struct ceph_mds_session *session,
>   	void *end = p + msg->front.iov_len;
>   	struct ceph_mds_session_head *h;
>   	u32 op;
> -	u64 seq;
> -	unsigned long features = 0;
> +	u64 seq, features = 0;
>   	int wake = 0;
>   	bool blacklisted = false;
>   
> @@ -3280,9 +3279,8 @@ static void handle_session(struct ceph_mds_session *session,
>   			goto bad;
>   		/* version >= 3, feature bits */
>   		ceph_decode_32_safe(&p, end, len, bad);
> -		ceph_decode_need(&p, end, len, bad);
> -		memcpy(&features, p, min_t(size_t, len, sizeof(features)));
> -		p += len;
> +		ceph_decode_64_safe(&p, end, features, bad);
> +		p += len - sizeof(features);
>   	}
>   
>   	mutex_lock(&mdsc->mutex);
> 
