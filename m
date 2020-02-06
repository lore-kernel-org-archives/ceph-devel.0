From: Xiubo Li <xiubli@redhat.com>
Subject: Re: [PATCH resend v5 04/11] ceph: add r_end_stamp for the osdc
 request
Date: Thu, 6 Feb 2020 08:57:29 +0800
Message-ID: <d8657812-f8d7-cc94-cdd0-ca495137032a@redhat.com>
References: <20200129082715.5285-1-xiubli@redhat.com>
 <20200129082715.5285-5-xiubli@redhat.com>
 <6edd0eca025a4e1f1da719406219f8770e6cef91.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:37220 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727149AbgBFA5n (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Feb 2020 19:57:43 -0500
In-Reply-To: <6edd0eca025a4e1f1da719406219f8770e6cef91.camel@kernel.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>, idryomov@gmail.com, zyan@redhat.com
Cc: sage@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org

On 2020/2/6 3:14, Jeff Layton wrote:
> On Wed, 2020-01-29 at 03:27 -0500, xiubli@redhat.com wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> Grab the osdc requests' end time stamp.
>>
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> ---
>>   include/linux/ceph/osd_client.h | 1 +
>>   net/ceph/osd_client.c           | 2 ++
>>   2 files changed, 3 insertions(+)
>>
>> diff --git a/include/linux/ceph/osd_client.h b/include/linux/ceph/osd_client.h
>> index 9d9f745b98a1..00a449cfc478 100644
>> --- a/include/linux/ceph/osd_client.h
>> +++ b/include/linux/ceph/osd_client.h
>> @@ -213,6 +213,7 @@ struct ceph_osd_request {
>>   	/* internal */
>>   	unsigned long r_stamp;                /* jiffies, send or check time */
>>   	unsigned long r_start_stamp;          /* jiffies */
>> +	unsigned long r_end_stamp;          /* jiffies */
>>   	int r_attempts;
>>   	u32 r_map_dne_bound;
>>   
>> diff --git a/net/ceph/osd_client.c b/net/ceph/osd_client.c
>> index 8ff2856e2d52..108c9457d629 100644
>> --- a/net/ceph/osd_client.c
>> +++ b/net/ceph/osd_client.c
>> @@ -2389,6 +2389,8 @@ static void finish_request(struct ceph_osd_request *req)
>>   	WARN_ON(lookup_request_mc(&osdc->map_checks, req->r_tid));
>>   	dout("%s req %p tid %llu\n", __func__, req, req->r_tid);
>>   
>> +	req->r_end_stamp = jiffies;
>> +
>>   	if (req->r_osd)
>>   		unlink_request(req->r_osd, req);
>>   	atomic_dec(&osdc->num_requests);
> Maybe fold this patch into #6 in this series? I'd prefer to add the new
> field along with its first user.

Sure, will merge it.

Thanks.
