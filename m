From: Xiubo Li <xiubli@redhat.com>
Subject: Re: [PATCH v8 5/5] ceph: add global metadata perf metric support
Date: Sat, 22 Feb 2020 09:09:05 +0800
Message-ID: <452a599e-56da-ff20-4435-9e03b4387876@redhat.com>
References: <20200221070556.18922-1-xiubli@redhat.com>
 <20200221070556.18922-6-xiubli@redhat.com>
 <68e496bca563ed6439c16f0de04d7daeb17f718a.camel@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:24125 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726777AbgBVBJY (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>); Fri, 21 Feb 2020 20:09:24 -0500
In-Reply-To: <68e496bca563ed6439c16f0de04d7daeb17f718a.camel@kernel.org>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Jeff Layton <jlayton@kernel.org>, idryomov@gmail.com
Cc: sage@redhat.com, zyan@redhat.com, pdonnell@redhat.com, ceph-devel@vger.kernel.org

On 2020/2/21 20:03, Jeff Layton wrote:
> On Fri, 2020-02-21 at 02:05 -0500, xiubli@redhat.com wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> It will calculate the latency for the metedata requests, which only
>> include the time cousumed by network and the ceph.
>>
> "and the ceph MDS" ?

Yeah, will fix the commit comment.


>
>> item          total       sum_lat(us)     avg_lat(us)
>> -----------------------------------------------------
>> metadata      113         220000          1946
>>
>> URL: https://tracker.ceph.com/issues/43215
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> ---
>>   fs/ceph/debugfs.c    |  6 ++++++
>>   fs/ceph/mds_client.c | 20 ++++++++++++++++++++
>>   fs/ceph/metric.h     | 13 +++++++++++++
>>   3 files changed, 39 insertions(+)
>>
>> diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
>> index 464bfbdb970d..60f3e307fca1 100644
>> --- a/fs/ceph/debugfs.c
>> +++ b/fs/ceph/debugfs.c
>> @@ -146,6 +146,12 @@ static int metric_show(struct seq_file *s, void *p)
>>   	avg = total ? sum / total : 0;
>>   	seq_printf(s, "%-14s%-12lld%-16lld%lld\n", "write", total, sum, avg);
>>   
>> +	total = percpu_counter_sum(&mdsc->metric.total_metadatas);
>> +	sum = percpu_counter_sum(&mdsc->metric.metadata_latency_sum);
>> +	sum = jiffies_to_usecs(sum);
>> +	avg = total ? sum / total : 0;
>> +	seq_printf(s, "%-14s%-12lld%-16lld%lld\n", "metadata", total, sum, avg);
>> +
>>   	seq_printf(s, "\n");
>>   	seq_printf(s, "item          total           miss            hit\n");
>>   	seq_printf(s, "-------------------------------------------------\n");
>> diff --git a/fs/ceph/mds_client.c b/fs/ceph/mds_client.c
>> index 0a3447966b26..3e792eca6af7 100644
>> --- a/fs/ceph/mds_client.c
>> +++ b/fs/ceph/mds_client.c
>> @@ -3017,6 +3017,12 @@ static void handle_reply(struct ceph_mds_session *session, struct ceph_msg *msg)
>>   
>>   	/* kick calling process */
>>   	complete_request(mdsc, req);
>> +
>> +	if (!result || result == -ENOENT) {
>> +		s64 latency = jiffies - req->r_started;
>> +
>> +		ceph_update_metadata_latency(&mdsc->metric, latency);
>> +	}
> Should we add an r_end_stamp field to the mds request struct and use
> that to calculate this? Many jiffies may have passed between the reply
> coming in and this point. If you really want to measure the latency that
> would be more accurate, I think.

Okay, will add it.

Thanks.

BRs

>>   out:
>>   	ceph_mdsc_put_request(req);
>>   	return;
>> @@ -4196,8 +4202,20 @@ static int ceph_mdsc_metric_init(struct ceph_client_metric *metric)
>>   	if (ret)
>>   		goto err_write_latency_sum;
>>   
>> +	ret = percpu_counter_init(&metric->total_metadatas, 0, GFP_KERNEL);
>> +	if (ret)
>> +		goto err_total_metadatas;
>> +
>> +	ret = percpu_counter_init(&metric->metadata_latency_sum, 0, GFP_KERNEL);
>> +	if (ret)
>> +		goto err_metadata_latency_sum;
>> +
>>   	return 0;
>>   
>> +err_metadata_latency_sum:
>> +	percpu_counter_destroy(&metric->total_metadatas);
>> +err_total_metadatas:
>> +	percpu_counter_destroy(&metric->write_latency_sum);
>>   err_write_latency_sum:
>>   	percpu_counter_destroy(&metric->total_writes);
>>   err_total_writes:
>> @@ -4553,6 +4571,8 @@ void ceph_mdsc_destroy(struct ceph_fs_client *fsc)
>>   
>>   	ceph_mdsc_stop(mdsc);
>>   
>> +	percpu_counter_destroy(&mdsc->metric.metadata_latency_sum);
>> +	percpu_counter_destroy(&mdsc->metric.total_metadatas);
>>   	percpu_counter_destroy(&mdsc->metric.write_latency_sum);
>>   	percpu_counter_destroy(&mdsc->metric.total_writes);
>>   	percpu_counter_destroy(&mdsc->metric.read_latency_sum);
>> diff --git a/fs/ceph/metric.h b/fs/ceph/metric.h
>> index a3d342f258e6..4c14b4ac089d 100644
>> --- a/fs/ceph/metric.h
>> +++ b/fs/ceph/metric.h
>> @@ -18,6 +18,9 @@ struct ceph_client_metric {
>>   
>>   	struct percpu_counter total_writes;
>>   	struct percpu_counter write_latency_sum;
>> +
>> +	struct percpu_counter total_metadatas;
>> +	struct percpu_counter metadata_latency_sum;
>>   };
>>   
>>   static inline void ceph_update_cap_hit(struct ceph_client_metric *m)
>> @@ -65,4 +68,14 @@ static inline void ceph_update_write_latency(struct ceph_client_metric *m,
>>   		percpu_counter_add(&m->write_latency_sum, latency);
>>   	}
>>   }
>> +
>> +static inline void ceph_update_metadata_latency(struct ceph_client_metric *m,
>> +						s64 latency)
>> +{
>> +	if (!m)
>> +		return;
>> +
>> +	percpu_counter_inc(&m->total_metadatas);
>> +	percpu_counter_add(&m->metadata_latency_sum, latency);
>> +}
>>   #endif /* _FS_CEPH_MDS_METRIC_H */
