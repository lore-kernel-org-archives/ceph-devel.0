From: Xiubo Li <xiubli@redhat.com>
Subject: Re: [PATCH] ceph: eliminate unused "total" variable in
 ceph_mdsc_send_metrics
Date: Sat, 25 Jul 2020 06:39:27 +0800
Message-ID: <a938e6b6-7fdb-2030-deff-bda4ba0a438e@redhat.com>
References: <20200724194534.61016-1-jlayton@kernel.org>
 <c4268b969311a56f1411ac2e893b473d47662c22.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:52544 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726154AbgGXWjk (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 24 Jul 2020 18:39:40 -0400
In-Reply-To: <c4268b969311a56f1411ac2e893b473d47662c22.camel@kernel.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org
Cc: idryomov@gmail.com

On 2020/7/25 4:10, Jeff Layton wrote:
> On Fri, 2020-07-24 at 15:45 -0400, Jeff Layton wrote:
>> Cc: Xiubo Li <xiubli@redhat.com>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Signed-off-by: Jeff Layton <jlayton@kernel.org>
>> ---
>>   fs/ceph/metric.c | 5 +----
>>   1 file changed, 1 insertion(+), 4 deletions(-)
>>
> Xiubo, if this looks OK I can squash this into the original patch since
> it's not merged upstream yet.

Hi Jeff,

Yeah, this is okay. Thanks.

BRs


> Thanks,
> Jeff
>
>> diff --git a/fs/ceph/metric.c b/fs/ceph/metric.c
>> index 252d6a3f75d2..2466b261fba2 100644
>> --- a/fs/ceph/metric.c
>> +++ b/fs/ceph/metric.c
>> @@ -20,7 +20,7 @@ static bool ceph_mdsc_send_metrics(struct ceph_mds_client *mdsc,
>>   	u64 nr_caps = atomic64_read(&m->total_caps);
>>   	struct ceph_msg *msg;
>>   	struct timespec64 ts;
>> -	s64 sum, total;
>> +	s64 sum;
>>   	s32 items = 0;
>>   	s32 len;
>>   
>> @@ -53,7 +53,6 @@ static bool ceph_mdsc_send_metrics(struct ceph_mds_client *mdsc,
>>   	read->ver = 1;
>>   	read->compat = 1;
>>   	read->data_len = cpu_to_le32(sizeof(*read) - 10);
>> -	total = m->total_reads;
>>   	sum = m->read_latency_sum;
>>   	jiffies_to_timespec64(sum, &ts);
>>   	read->sec = cpu_to_le32(ts.tv_sec);
>> @@ -66,7 +65,6 @@ static bool ceph_mdsc_send_metrics(struct ceph_mds_client *mdsc,
>>   	write->ver = 1;
>>   	write->compat = 1;
>>   	write->data_len = cpu_to_le32(sizeof(*write) - 10);
>> -	total = m->total_writes;
>>   	sum = m->write_latency_sum;
>>   	jiffies_to_timespec64(sum, &ts);
>>   	write->sec = cpu_to_le32(ts.tv_sec);
>> @@ -79,7 +77,6 @@ static bool ceph_mdsc_send_metrics(struct ceph_mds_client *mdsc,
>>   	meta->ver = 1;
>>   	meta->compat = 1;
>>   	meta->data_len = cpu_to_le32(sizeof(*meta) - 10);
>> -	total = m->total_metadatas;
>>   	sum = m->metadata_latency_sum;
>>   	jiffies_to_timespec64(sum, &ts);
>>   	meta->sec = cpu_to_le32(ts.tv_sec);
