From: Xiubo Li <xiubli@redhat.com>
Subject: Re: [PATCH resend v5 05/11] ceph: add global read latency metric
 support
Date: Thu, 6 Feb 2020 09:24:46 +0800
Message-ID: <54b8ba7d-fc5e-8bb3-5853-fd74c87cbf1f@redhat.com>
References: <20200129082715.5285-1-xiubli@redhat.com>
 <20200129082715.5285-6-xiubli@redhat.com>
 <e0bbe210d52c69458828f8245f1252434713f4a9.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25132 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727170AbgBFBZG (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Wed, 5 Feb 2020 20:25:06 -0500
In-Reply-To: <e0bbe210d52c69458828f8245f1252434713f4a9.camel@kernel.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>, idryomov@gmail.com, zyan@redhat.com
Cc: sage@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org

On 2020/2/6 4:15, Jeff Layton wrote:
> On Wed, 2020-01-29 at 03:27 -0500, xiubli@redhat.com wrote:
[...]
>> diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
>> index 20e5ebfff389..0435a694370b 100644
>> --- a/fs/ceph/addr.c
>> +++ b/fs/ceph/addr.c
>> @@ -195,6 +195,7 @@ static int ceph_sync_readpages(struct ceph_fs_client *fsc,
>>   			       int page_align)
>>   {
>>   	struct ceph_osd_client *osdc = &fsc->client->osdc;
>> +	struct ceph_client_metric *metric = &fsc->mdsc->metric;
> nit: I think you can drop this variable and just dereference the metric
> field directly below where it's used. Ditto in other places where
> "metric" is only used once in the function.

Will fix them all.

>> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
>> index 141c1c03636c..101b51f9f05d 100644
>> --- a/fs/ceph/mds_client.c
>> +++ b/fs/ceph/mds_client.c
>> @@ -4182,14 +4182,29 @@ static int ceph_mdsc_metric_init(struct ceph_client_metric *metric)
>>   	atomic64_set(&metric->total_dentries, 0);
>>   	ret = percpu_counter_init(&metric->d_lease_hit, 0, GFP_KERNEL);
>>   	if (ret)
>> -		return ret;
>> +		return ret;;
> drop this, please ^^^

Will fix it.

Thanks.
