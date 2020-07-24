From: Jeff Layton <jlayton@kernel.org>
Subject: Re: [PATCH] ceph: eliminate unused "total" variable in
 ceph_mdsc_send_metrics
Date: Fri, 24 Jul 2020 16:10:34 -0400
Message-ID: <c4268b969311a56f1411ac2e893b473d47662c22.camel@kernel.org>
References: <20200724194534.61016-1-jlayton@kernel.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
Return-path: <ceph-devel-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:41170 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726455AbgGXUKg (ORCPT <rfc822;ceph-devel@vger.kernel.org>);
        Fri, 24 Jul 2020 16:10:36 -0400
In-Reply-To: <20200724194534.61016-1-jlayton@kernel.org>
Sender: ceph-devel-owner@vger.kernel.org
List-ID: <ceph-devel.vger.kernel.org>
To: ceph-devel@vger.kernel.org
Cc: Xiubo Li <xiubli@redhat.com>, idryomov@gmail.com

On Fri, 2020-07-24 at 15:45 -0400, Jeff Layton wrote:
> Cc: Xiubo Li <xiubli@redhat.com>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Jeff Layton <jlayton@kernel.org>
> ---
>  fs/ceph/metric.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 

Xiubo, if this looks OK I can squash this into the original patch since
it's not merged upstream yet.

Thanks,
Jeff

> diff --git a/fs/ceph/metric.c b/fs/ceph/metric.c
> index 252d6a3f75d2..2466b261fba2 100644
> --- a/fs/ceph/metric.c
> +++ b/fs/ceph/metric.c
> @@ -20,7 +20,7 @@ static bool ceph_mdsc_send_metrics(struct ceph_mds_client *mdsc,
>  	u64 nr_caps = atomic64_read(&m->total_caps);
>  	struct ceph_msg *msg;
>  	struct timespec64 ts;
> -	s64 sum, total;
> +	s64 sum;
>  	s32 items = 0;
>  	s32 len;
>  
> @@ -53,7 +53,6 @@ static bool ceph_mdsc_send_metrics(struct ceph_mds_client *mdsc,
>  	read->ver = 1;
>  	read->compat = 1;
>  	read->data_len = cpu_to_le32(sizeof(*read) - 10);
> -	total = m->total_reads;
>  	sum = m->read_latency_sum;
>  	jiffies_to_timespec64(sum, &ts);
>  	read->sec = cpu_to_le32(ts.tv_sec);
> @@ -66,7 +65,6 @@ static bool ceph_mdsc_send_metrics(struct ceph_mds_client *mdsc,
>  	write->ver = 1;
>  	write->compat = 1;
>  	write->data_len = cpu_to_le32(sizeof(*write) - 10);
> -	total = m->total_writes;
>  	sum = m->write_latency_sum;
>  	jiffies_to_timespec64(sum, &ts);
>  	write->sec = cpu_to_le32(ts.tv_sec);
> @@ -79,7 +77,6 @@ static bool ceph_mdsc_send_metrics(struct ceph_mds_client *mdsc,
>  	meta->ver = 1;
>  	meta->compat = 1;
>  	meta->data_len = cpu_to_le32(sizeof(*meta) - 10);
> -	total = m->total_metadatas;
>  	sum = m->metadata_latency_sum;
>  	jiffies_to_timespec64(sum, &ts);
>  	meta->sec = cpu_to_le32(ts.tv_sec);

-- 
Jeff Layton <jlayton@kernel.org>
