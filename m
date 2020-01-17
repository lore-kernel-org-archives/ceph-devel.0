From: Xiubo Li <xiubli@redhat.com>
Subject: Re: [PATCH v4 7/8] ceph: add reset metrics support
Date: Fri, 17 Jan 2020 09:57:31 +0800
Message-ID: <08f82096-ae3b-5dc0-baf9-d839c8cd7bc6@redhat.com>
References: <20200116103830.13591-1-xiubli@redhat.com>
 <20200116103830.13591-8-xiubli@redhat.com>
 <CAOi1vP8iASjyLoTFo2CgiA4C-8u4nYKpEpyC91wAho=2_9hBuQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:30543 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388682AbgAQB5o (ORCPT
        <rfc822;ceph-devel@vger.kernel.org>);
        Thu, 16 Jan 2020 20:57:44 -0500
In-Reply-To: <CAOi1vP8iASjyLoTFo2CgiA4C-8u4nYKpEpyC91wAho=2_9hBuQ@mail.gmail.com>
Content-Language: en-US
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: Ilya Dryomov <idryomov@gmail.com>
Cc: Jeff Layton <jlayton@kernel.org>, "Yan, Zheng" <zyan@redhat.com>, Sage Weil <sage@redhat.com>, Patrick Donnelly <pdonnell@redhat.com>, Ceph Development <ceph-devel@vger.kernel.org>

On 2020/1/16 23:02, Ilya Dryomov wrote:
> On Thu, Jan 16, 2020 at 11:39 AM <xiubli@redhat.com> wrote:
>> From: Xiubo Li <xiubli@redhat.com>
>>
>> This will reset the most metric counters, except the cap and dentry
>> total numbers.
>>
>> Sometimes we need to discard the old metrics and start to get new
>> metrics.
>>
>> URL: https://tracker.ceph.com/issues/43215
>> Signed-off-by: Xiubo Li <xiubli@redhat.com>
>> ---
>>   fs/ceph/debugfs.c | 57 +++++++++++++++++++++++++++++++++++++++++++++++
>>   fs/ceph/super.h   |  1 +
>>   2 files changed, 58 insertions(+)
>>
>> diff --git a/fs/ceph/debugfs.c b/fs/ceph/debugfs.c
>> index bb96fb4d04c4..c24a704d4e99 100644
>> --- a/fs/ceph/debugfs.c
>> +++ b/fs/ceph/debugfs.c
>> @@ -158,6 +158,55 @@ static int sending_metrics_get(void *data, u64 *val)
>>   DEFINE_SIMPLE_ATTRIBUTE(sending_metrics_fops, sending_metrics_get,
>>                          sending_metrics_set, "%llu\n");
>>
>> +static int reset_metrics_set(void *data, u64 val)
>> +{
>> +       struct ceph_fs_client *fsc = (struct ceph_fs_client *)data;
>> +       struct ceph_mds_client *mdsc = fsc->mdsc;
>> +       struct ceph_client_metric *metric = &mdsc->metric;
>> +       int i;
>> +
>> +       if (val != 1) {
>> +               pr_err("Invalid reset metrics set value %llu\n", val);
>> +               return -EINVAL;
>> +       }
>> +
>> +       percpu_counter_set(&metric->d_lease_hit, 0);
>> +       percpu_counter_set(&metric->d_lease_mis, 0);
>> +
>> +       spin_lock(&metric->read_lock);
>> +       memset(&metric->read_latency_sum, 0, sizeof(struct timespec64));
>> +       atomic64_set(&metric->total_reads, 0),
>> +       spin_unlock(&metric->read_lock);
>> +
>> +       spin_lock(&metric->write_lock);
>> +       memset(&metric->write_latency_sum, 0, sizeof(struct timespec64));
>> +       atomic64_set(&metric->total_writes, 0),
>> +       spin_unlock(&metric->write_lock);
>> +
>> +       spin_lock(&metric->metadata_lock);
>> +       memset(&metric->metadata_latency_sum, 0, sizeof(struct timespec64));
>> +       atomic64_set(&metric->total_metadatas, 0),
>> +       spin_unlock(&metric->metadata_lock);
>> +
>> +       mutex_lock(&mdsc->mutex);
>> +       for (i = 0; i < mdsc->max_sessions; i++) {
>> +               struct ceph_mds_session *session;
>> +
>> +               session = __ceph_lookup_mds_session(mdsc, i);
>> +               if (!session)
>> +                       continue;
>> +               percpu_counter_set(&session->i_caps_hit, 0);
>> +               percpu_counter_set(&session->i_caps_mis, 0);
>> +               ceph_put_mds_session(session);
>> +       }
>> +
>> +       mutex_unlock(&mdsc->mutex);
>> +
>> +       return 0;
>> +}
>> +
>> +DEFINE_SIMPLE_ATTRIBUTE(reset_metrics_fops, NULL, reset_metrics_set, "%llu\n");
>> +
>>   static int metric_show(struct seq_file *s, void *p)
>>   {
>>          struct ceph_fs_client *fsc = s->private;
>> @@ -355,6 +404,7 @@ void ceph_fs_debugfs_cleanup(struct ceph_fs_client *fsc)
>>          debugfs_remove(fsc->debugfs_caps);
>>          debugfs_remove(fsc->debugfs_metric);
>>          debugfs_remove(fsc->debugfs_sending_metrics);
>> +       debugfs_remove(fsc->debugfs_reset_metrics);
>>          debugfs_remove(fsc->debugfs_mdsc);
>>   }
>>
>> @@ -402,6 +452,13 @@ void ceph_fs_debugfs_init(struct ceph_fs_client *fsc)
>>                                              fsc,
>>                                              &sending_metrics_fops);
>>
>> +       fsc->debugfs_reset_metrics =
>> +                       debugfs_create_file("reset_metrics",
>> +                                           0600,
>> +                                           fsc->client->debugfs_dir,
>> +                                           fsc,
>> +                                           &reset_metrics_fops);
>> +
>>          fsc->debugfs_metric = debugfs_create_file("metrics",
>>                                                    0400,
>>                                                    fsc->client->debugfs_dir,
>> diff --git a/fs/ceph/super.h b/fs/ceph/super.h
>> index a91431e9bdf7..d24929f1c4bf 100644
>> --- a/fs/ceph/super.h
>> +++ b/fs/ceph/super.h
>> @@ -129,6 +129,7 @@ struct ceph_fs_client {
>>          struct dentry *debugfs_bdi;
>>          struct dentry *debugfs_mdsc, *debugfs_mdsmap;
>>          struct dentry *debugfs_sending_metrics;
>> +       struct dentry *debugfs_reset_metrics;
>>          struct dentry *debugfs_metric;
>>          struct dentry *debugfs_mds_sessions;
>>   #endif
> Do we need a separate attribute for this?  Did you think about making
> metrics attribute writeable and accepting some string, e.g. "reset"?

Let's make the "metrics" writeable, which will means reset.

Thanks.



> Thanks,
>
>                  Ilya
>
